if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

local bagCache = {}
local itemInstanceIdLookup = {}

function RbI.ClearBagCache()
	--d("bagCache cleared")
	bagCache = {}
	itemInstanceIdLookup = {}
end

-- if instanceOld is nil -> insert new
-- if instanceOld and instanceNew -> delete old, insert new
-- if instanceNew is nil -> delete old
-- noNewEntry prevents the lookup to be updated with a new record
local function InsertOrUpdateItemInstanceId(cacheId, rowIndex, instanceIdOld, instanceIdNew, noNewEntry)

	instanceIdOld = instanceIdOld or ""
	instanceIdNew = instanceIdNew or ""

	-- if new = nil -> unset from free, if different set new and get rid of old one first
	if(itemInstanceIdLookup[cacheId][instanceIdOld] ~= nil) then
		for i, lookupIndex in pairs(itemInstanceIdLookup[cacheId][instanceIdOld]) do
			if(lookupIndex == rowIndex) then
				table.remove(itemInstanceIdLookup[cacheId][instanceIdOld], i)
				break
			end
		end
	end
	
	-- enter new one
	if(noNewEntry == false) then
		if(not itemInstanceIdLookup[cacheId][instanceIdNew]) then 
			itemInstanceIdLookup[cacheId][instanceIdNew] = {} 
		end
		table.insert(itemInstanceIdLookup[cacheId][instanceIdNew], rowIndex)
	end
end

-- takes an row from any bagCache 
-- and updates all other rows of this items type in it's bagCache
-- to match the item.counts for BAG_BACKPACK and BAG_BANK
function RbI.UpdateItemCounts(cacheId, row)

	local _, instanceIdLookup = RbI.GetBagCache(cacheId)
	
	for i, rowIndex in pairs(instanceIdLookup[row.instanceId]) do
		--d("update " .. cacheId .. " / " .. rowIndex .. " with " .. row.count[BAG_BACKPACK] .. " / " .. row.count[BAG_BANK])
		-- directly on bagCache, not on copy of bagCache via GetBagCache
		bagCache[cacheId][rowIndex].count[BAG_BACKPACK] = row.count[BAG_BACKPACK]
		bagCache[cacheId][rowIndex].count[BAG_BANK] = row.count[BAG_BANK]
	end
	
end


-- http://lua-users.org/wiki/CopyTable
function RbI.DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[RbI.DeepCopy(orig_key)] = RbI.DeepCopy(orig_value)
        end
        setmetatable(copy, RbI.DeepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end



-- inserts an newItem (may be nil) into a bagCache slot and overwrites the existing data
-- itemInstanceIdLookup is updated accordingly 
function RbI.SetBagCacheSlot(cacheId, rowIndex, rowNew)
	
	local row = bagCache[cacheId][rowIndex]

	local instanceIdOld
	local instanceIdNew
	if(row.link ~= "") then
		instanceIdOld = row.instanceId
	end
	if(rowNew ~= nil) then
		instanceIdNew = rowNew.instanceId
	else
		rowNew = {}
		rowNew.link = "" -- if nil (row freed) link needs to be empty
		rowNew.count = {} -- and count table needs to exist to prevent errors
	end
	
	-- hinder empty rows of subscriberbank to be noted if user has no subscribtion
	if(rowNew.link ~= "" or row.bagId ~= BAG_SUBSCRIBER_BANK or RbI.isESOPlusSubscriber) then
		InsertOrUpdateItemInstanceId(cacheId, rowIndex, instanceIdOld, instanceIdNew, false)
	else
		InsertOrUpdateItemInstanceId(cacheId, rowIndex, instanceIdOld, instanceIdNew, true)
	end
	bagCache[cacheId][rowIndex] = RbI.DeepCopy(rowNew)
	-- a row in a bag always stays at its bagId and slotIndex
	bagCache[cacheId][rowIndex].bagId = row.bagId
	bagCache[cacheId][rowIndex].slotIndex = row.slotIndex
	-- a row always has its on position saved
	bagCache[cacheId][rowIndex].cacheId = cacheId
	bagCache[cacheId][rowIndex].rowIndex = rowIndex
end


local function CreateCacheRows(index, bagId)
	-- wrapper for CreateCacheRow

	local cacheId
	if(bagId == BAG_SUBSCRIBER_BANK) then
		cacheId = BAG_BANK
	else
		cacheId = bagId
	end
		
	--d("taking slots from " .. bagId .. " cacheId " .. cacheId)
	local function CreateCacheRow(slotIndex)
		-- create empty row in bagCache
		-- row holds position even if no item is slotted
		
		local rowIndex = #bagCache[cacheId]
		if(bagCache[cacheId][0] ~= nil) then
			rowIndex = rowIndex + 1
		end
		bagCache[cacheId][rowIndex] = {}
		bagCache[cacheId][rowIndex].link = ""
		bagCache[cacheId][rowIndex].bagId = bagId
		bagCache[cacheId][rowIndex].slotIndex = slotIndex
		bagCache[cacheId][rowIndex].cacheId = cacheId
		bagCache[cacheId][rowIndex].rowIndex = rowIndex
		
		local row = RbI.GetItemData(bagId, slotIndex)
		--d(row.bagId .. " = " .. bagId .. " , " .. row.slotIndex .. " = " .. slotIndex)
		RbI.SetBagCacheSlot(cacheId, rowIndex, row)
	end
	RbI.asyncTask:For(0, GetBagSize(bagId)-1):Do(CreateCacheRow)
	--for index = 0, GetBagSize(bagId)-1 do
	--	CreateCacheRow(index)
	--end
end	

function RbI.CreateBagCaches()
	
	local bagIds = {}
	
	for _, cacheId in pairs({BAG_BACKPACK, BAG_BANK}) do
		if(not bagCache[cacheId]) then
			bagCache[cacheId] = {}
			itemInstanceIdLookup[cacheId] = {}
			--d("creating bagCache for " .. cacheId)
			if(cacheId == BAG_BANK) then
				table.insert(bagIds, BAG_SUBSCRIBER_BANK)
			end
			table.insert(bagIds, cacheId)
		end
	end
	
	if(#bagIds > 0) then		
		RbI.asyncTask:For(ipairs(bagIds)):Do(CreateCacheRows)--:Then(function() d("bagCache creation done") end)
	end
	
end

-- returns a copy of the requested bagCache and its itemInstanceIdLookup
-- BAG_BANK generates an combined cache for both BAG_BANK and BAG_SUBSCRIBER_BANK
function RbI.GetBagCache(cacheId)
	--d("bagCache given out")
	return RbI.DeepCopy(bagCache[cacheId]), RbI.DeepCopy(itemInstanceIdLookup[cacheId])
end

-- returns rowTrgt and count if row can't take all
local function GetFittingRow(cacheId, row, stackable)
	
	local bagCache, lookup = RbI.GetBagCache(cacheId)
	
	local stackRow
	local moveCount
	
	if(stackable and lookup[row.instanceId] ~= nil and lookup[row.instanceId][1] ~= nil) then
		for _, rowIndex in ipairs(lookup[row.instanceId]) do
			local rowTrgt = bagCache[rowIndex]
			if(rowTrgt.count["STACK"] < rowTrgt.count["MAX"] and rowTrgt.crownCrate == row.crownCrate and rowTrgt.crownStore == row.crownStore) then 
				stackRow = rowTrgt
				moveCount = rowTrgt.count["MAX"] - rowTrgt.count["STACK"]
			end
		end
	end
	
	return (stackRow or (lookup[""] and lookup[""][1] and bagCache[lookup[""][1]])), (moveCount or row.count["STACK"])
	
end

-- moves both cache rows and actual item
function RbI.MoveItem(src, cacheIdTo, split)

	local bagCache = RbI.GetBagCache(src.cacheId)
	local rowSrc = bagCache[src.rowIndex]
	if(rowSrc.link == "" or src.link ~= rowSrc.link) then
		--item is not at its position anymore, abort action
		return false, false, false -- success, remain action, output
	end
	-- (rowSrc.stackable and not split) if split = true we don't want the slot to hold an item to stack on
	local rowTrgt, moveCount = GetFittingRow(cacheIdTo, rowSrc, (rowSrc.stackable and not split))
	
	if(rowTrgt ~= nil) then
		
		if(moveCount ~= nil) then
			moveCount = math.min(moveCount, src.moveCount)
		else
			moveCount = src.moveCount
		end
		
		--d("bagCacheItem: " .. rowSrc.cacheId .. " / " .. rowSrc.rowIndex .. " with " .. rowSrc.count[BAG_BACKPACK] .. " / " .. rowSrc.count[BAG_BANK])
		
		-- set new counts (this is valid for both source and target cache)
		rowSrc.count["STACK"] = rowSrc.count["STACK"] - moveCount
		rowSrc.count[rowSrc.cacheId] = rowSrc.count[rowSrc.cacheId] - moveCount
		rowSrc.count[cacheIdTo] = rowSrc.count[cacheIdTo] + moveCount
		
		-- apply new counts to given row
		src.count["STACK"] = rowSrc.count["STACK"]
		src.count[rowSrc.cacheId] = rowSrc.count[rowSrc.cacheId]
		src.count[cacheIdTo] = rowSrc.count[cacheIdTo]
		
		if(rowSrc.count["STACK"] > 0) then
			-- update row which remains at source cache
			RbI.SetBagCacheSlot(rowSrc.cacheId, rowSrc.rowIndex, rowSrc)
		else 
			-- "remove" row if nothing remains (will still hold bagId and slotIndex)
			RbI.SetBagCacheSlot(rowSrc.cacheId, rowSrc.rowIndex, nil)
		end
		
		-- update counts of this rows item in source cache
		RbI.UpdateItemCounts(rowSrc.cacheId, rowSrc)
		
		-- set new row for target cache
		rowSrc.count["STACK"] = (rowTrgt.count["STACK"] or 0) + moveCount
		
		-- update row in target cache
		RbI.SetBagCacheSlot(rowTrgt.cacheId, rowTrgt.rowIndex, rowSrc)
		
		-- update counts of this rows item in target cache
		RbI.UpdateItemCounts(rowTrgt.cacheId, rowSrc)
		
		-- move actual item
		if IsProtectedFunction("RequestMoveItem") then
			CallSecureProtected("RequestMoveItem", rowSrc.bagId, rowSrc.slotIndex, rowTrgt.bagId, rowTrgt.slotIndex, moveCount)
		else
			RequestMoveItem(rowSrc.bagId, rowSrc.slotIndex, rowTrgt.bagId, rowTrgt.slotIndex, moveCount)
		end
		
	else
		return false, true, false -- success, remain action, output
	end
	
	-- set row for check in actionStack
	src.moveCount = src.moveCount - moveCount
	if(src.moveCount > 0) then
		return true, true, true -- success, remain action, output
	else
		return true, false, true -- success, remain action, output
	end
end

-- set junked in both cache and at actual item
function RbI.Junk(src)

	local bagCache = RbI.GetBagCache(src.cacheId)
	local row = bagCache[src.rowIndex]

	if(row.link == "" or src.link ~= row.link) then
		--item is not at its position anymore, abort action
		return false, false, false -- success, remain action, output
	end
	
	-- not counts to update
	
	row.junked = true
	RbI.SetBagCacheSlot(row.cacheId, row.rowIndex, row)

	SetItemIsJunk(row.bagId, row.slotIndex, row.junked)
	
	src.moveCount = 0
	return true, false, true -- success, remain action, output
end

-- set unJunked in both cache and at actual item
function RbI.UnJunk(src)

	local bagCache = RbI.GetBagCache(src.cacheId)
	local row = bagCache[src.rowIndex]

	if(row.link == "" or src.link ~= row.link) then
		--item is not at its position anymore, abort action
		return false, false, false -- success, remain action, output
	end
	
	-- no counts to update
	
	row.junked = false
	RbI.SetBagCacheSlot(row.cacheId, row.rowIndex, row)

	SetItemIsJunk(row.bagId, row.slotIndex, row.junked)
	
	src.moveCount = 0
	return true, false, true -- success, remain action, output
end

-- sell items and remove from cache
function RbI.SellItem(src)

	local bagCache = RbI.GetBagCache(src.cacheId)
	local row = bagCache[src.rowIndex]
	
	if(row.link == "" or src.link ~= row.link) then
		--item is not at its position anymore, abort action
		return false, false -- success, remain action
	end
	
	-- set new counts
	-- countBank and countCraftbag not to update
	row.count["STACK"] = row.count["STACK"] - src.moveCount
	row.count[row.cacheId] = row.count[row.cacheId] - src.moveCount
	
	RbI.UpdateItemCounts(row.cacheId, row)

	if(row.count["STACK"] > 0) then
		RbI.SetBagCacheSlot(row.cacheId, row.rowIndex, row)
	else
		RbI.SetBagCacheSlot(row.cacheId, row.rowIndex, nil)
	end
	
	SellInventoryItem(row.bagId, row.slotIndex, src.moveCount)
	
	src.moveCount = 0
	return true, false, true -- success, remain action, output
end

-- launder items and update in cache
function RbI.LaunderItem(src)

	local bagCache, lookup = RbI.GetBagCache(src.cacheId)
	local rowSrc = bagCache[src.rowIndex]

	if(rowSrc.link == "" or src.link ~= rowSrc.link) then
		--item is not at its position anymore, abort action
		return false, false, false -- success, remain action, output
	end
	
	-- this may not be the actual slot the laundered item will be inserted by the game
	-- but it makes an guess so we can update the bagcache and catch on a full bag
	local rowTrgt, moveCount = GetFittingRow(BAG_BACKPACK, rowSrc, (rowSrc.stackable and not split))
	
	if(rowTrgt ~= nil) then
		
		if(moveCount ~= nil) then
			moveCount = math.min(moveCount, src.moveCount)
		else
			moveCount = src.moveCount
		end
		
		--d("bagCacheItem: " .. rowSrc.cacheId .. " / " .. rowSrc.rowIndex .. " with " .. rowSrc.count[BAG_BACKPACK] .. " / " .. rowSrc.count[BAG_BANK])
		
		-- set new counts
		rowSrc.count["STACK"] = rowSrc.count["STACK"] - moveCount
		
		-- apply new counts to given row
		src.count["STACK"] = rowSrc.count["STACK"]
		
		if(rowSrc.count["STACK"] > 0) then
			-- update row which remains at source cache
			RbI.SetBagCacheSlot(rowSrc.cacheId, rowSrc.rowIndex, rowSrc)
		else 
			-- "remove" row if nothing remains (will still hold bagId and slotIndex)
			RbI.SetBagCacheSlot(rowSrc.cacheId, rowSrc.rowIndex, nil)
		end
		
		-- no counts to update
		
		-- set new row for target cache
		rowSrc.count["STACK"] = (rowTrgt.count["STACK"] or 0) + moveCount
		
		-- update row in target cache
		RbI.SetBagCacheSlot(rowTrgt.cacheId, rowTrgt.rowIndex, rowSrc)
		
		-- launder actual item
		LaunderItem(rowSrc.bagId, rowSrc.slotIndex, src.moveCount)
		
	else
		return false, true, false -- success, remain action, output
	end

	src.moveCount = 0
	return true, false, true -- success, remain action, output
end

-- destroy actual item and update in cache
function RbI.DestroyItem(src)
	
	local bagCache = RbI.GetBagCache(src.cacheId)
	local row = bagCache[src.rowIndex]
	local moveCount = src.moveCount
	local stackCount = row.count["STACK"]
	
	if(row.link == "" or src.link ~= row.link) then
		--item is not at its position anymore, abort action
		return false, false, false -- success, remain action, output
	end
	
	if(moveCount < stackCount) then
		-- split item, delete with next event
		local status, remainAction, output = RbI.MoveItem(src, src.cacheId, true)
		if(not status) then
			RbI.ReportStatus(true, RBI_STATUS_SPLITFAILURE)
		end
		-- suppress success notification of action if only a split was made
		return status, remainAction, false -- success, remain action, output
		
		-- only events destroy things
	elseif(src.moveCount == row.count["STACK"] and src.event) then
		-- destroy item if count of stack is exactly moveCount
		-- set new counts
		-- countBank and countCraftbag not to update
		row.count["STACK"] = row.count["STACK"] - src.moveCount
		row.count[row.cacheId] = row.count[row.cacheId] - src.moveCount
		
		RbI.UpdateItemCounts(row.cacheId, row)

		if(row.count["STACK"] > 0) then
			RbI.SetBagCacheSlot(row.cacheId, row.rowIndex, row)
		else
			RbI.SetBagCacheSlot(row.cacheId, row.rowIndex, nil)
		end
		
		DestroyItem(row.bagId, row.slotIndex)
		
		src.moveCount = 0
		return true, false, true -- success, remain action, output
	else
		return true, false, false -- success, remain action, output
	end
end

-- notify of item
function RbI.Notify(src)
	
	-- no action to do besides removing the action from stack
	-- message systems takes care of the rest
	
	src.moveCount = 0
	return true, false, true -- success, remain action, output
end


-- deconstruct actual item and update in cache
function RbI.DeconstructItem(src)

	local bagCache, lookup = RbI.GetBagCache(src.cacheId)
	local row = bagCache[src.rowIndex]
	local moveCount = src.moveCount
	local stackCount = row.count["STACK"]
	
	if(row.link == "" or src.link ~= row.link) then
		--item is not at its position anymore, abort action
		return false, false, false -- success, remain action, output
	end
	
	-- this is just a rudimentary check on bagfull and may not work
	-- when craftbag is disabled and iventory is flooded with material
	if(lookup[""] and #lookup[""]>=4) then
	
		-- set new counts
		-- countBank and countCraftbag not to update
		row.count["STACK"] = row.count["STACK"] - src.moveCount
		row.count[row.cacheId] = row.count[row.cacheId] - src.moveCount
		
		RbI.UpdateItemCounts(row.cacheId, row)

		if(row.count["STACK"] > 0) then
			RbI.SetBagCacheSlot(row.cacheId, row.rowIndex, row)
		else
			RbI.SetBagCacheSlot(row.cacheId, row.rowIndex, nil)
		end
		
		if(RbI.craftStationType == CRAFTING_TYPE_ENCHANTING) then
			ExtractEnchantingItem(row.bagId, row.slotIndex)
		elseif (ZO_Smithing_IsSmithingStation(RbI.craftStationType)) then
			ExtractOrRefineSmithingItem(row.bagId, row.slotIndex)
		end

	else
		src.moveCount = src.moveCount - 1
		return false, true, false -- success, remain action, output
	end
	
	return true, false, true -- success, remain action, output
end