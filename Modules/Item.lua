if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory
	
function RbI.GetItemData(bagId, slotIndex)
 
	local item = {}
	local itemLink = GetItemLink(bagId, slotIndex)

	item.bagId = bagId
	item.slotIndex = slotIndex
	
	if(bagId == BAG_SUBSCRIBER_BANK) then
		item.cacheId = BAG_BANK
	else
		item.cacheId = bagId
	end
	
	item.rowIndex = slotIndex
	if(bagId == BAG_BANK) then
		item.rowIndex = item.rowIndex + GetBagSize(bagId)
	end
	
	
	item.rowIndex = slotIndex
	
	item.link = itemLink or "" --just in case an empty slot does not always return "" but nil
	item.count={}
	if(itemLink ~= "") then
		item.count[BAG_BACKPACK], item.count[BAG_BANK], item.count[BAG_VIRTUAL] = GetItemLinkStacks(itemLink) -- CountBackpack, CountBank, CountCraftBag
		item.count["STACK"], item.count["MAX"] = GetSlotStackSize(bagId, slotIndex)
		item.uniqueId = GetItemUniqueId(bagId, slotIndex)

		-- BEGIN of function calls to get the data about the item we're currently matching
		item.crownStore = IsItemFromCrownStore(bagId, slotIndex)
		item.crownCrate = IsItemFromCrownCrate(bagId, slotIndex)
		item.crownGems = 0
		if(item.crownCrate) then
			item.crownGems = GetNumCrownGemsFromItemManualGemification(bagId, slotIndex)
		end
		item.instanceId = GetItemInstanceId(bagId,  slotIndex)
		item.armorType = GetItemLinkArmorType(itemLink)
		item.bindType = GetItemLinkBindType(itemLink)
		item.equipType = GetItemLinkEquipType(itemLink)
		item.glyphMinLvl, item.glyphMinCP = GetItemLinkGlyphMinLevels(itemLink) -- MinLvl, MinCP
		item.icon = GetItemLinkIcon(item.itemLink)
		item.style = GetItemLinkItemStyle(itemLink)
		item.type, item.sType = GetItemLinkItemType(itemLink) -- ItemType, SpecializedItemType
		item.name = GetItemLinkName(itemLink)
		item.quality = GetItemLinkQuality(itemLink)
		item.cp = GetItemLinkRequiredChampionPoints(itemLink)
		item.level = GetItemLinkRequiredLevel(itemLink)
		item.set, item.setName = GetItemLinkSetInfo(itemLink) -- HasSet, SetName, …
		item.traitInfo = GetItemTraitInformation(bagId, slotIndex)
		item.trait = GetItemLinkTraitInfo(itemLink) -- TraitType, …
		item.traitCategory = GetItemTraitTypeCategory(item.trait) -- TraitCategory
		item.value = GetItemLinkValue(itemLink, false)
		item.weaponType = GetItemLinkWeaponType(itemLink)
		
		-- item tags
		local tagcount = GetItemLinkNumItemTags(itemLink)
		item.tags = {}
		for tagIndex = 0, tagcount, 1 do
			local tag = GetItemLinkItemTagInfo(itemLink, tagIndex)
			if(tag ~= nil and tag ~= "") then
				table.insert(item.tags, tag)
			end
		end
		
		-- item alchemyTraits
		item.reagentTraits = {}
		local alchemyTraits = {GetAlchemyItemTraits(bagId, slotIndex)}
		for traitIndex = 1, #alchemyTraits, 5 do
			table.insert(item.reagentTraits, alchemyTraits[traitIndex])
		end
		
		-- not all non-writ items show a reward of 0, just check on masterwrits
		item.vouchers = 0
		if(item.type == ITEMTYPE_MASTER_WRIT or item.stype == SPECIALIZED_ITEMTYPE_MASTER_WRIT) then
			item.vouchers = tonumber(string.match(GenerateMasterWritRewardText(itemLink), "[%d]+"))
		end
		
		if(item.type == ITEMTYPE_SOUL_GEM or item.stype == SPECIALIZED_ITEMTYPE_SOUL_GEM) then
			local soulgem_tier -- prevent global leak
			soulgem_tier, item.soulGemType = GetSoulGemItemInfo(bagId, slotIndex) -- tier, SoulGemType
			if(item.name == "Crown Soul Gem") then
				item.soulGemType = SOUL_GEM_TYPE_FILLED -- crown soulgems are always full but SoulGemType is "empty"
			end
		end
		
		
		item.junked = IsItemJunk(bagId, slotIndex)
		item.bound = IsItemLinkBound(itemLink)
		item.crafted = IsItemLinkCrafted(itemLink)
		item.creator = GetItemCreatorName(bagId, slotIndex)
		item.recipeKnown = IsItemLinkRecipeKnown(itemLink)
		item.stackable = IsItemLinkStackable(itemLink)
		item.stolen = IsItemLinkStolen(itemLink)
		item.unique = IsItemLinkUnique(itemLink)
		item.locked = IsItemPlayerLocked(bagId, slotIndex)

		-- END of function calls
	
		-- MasterMerchant Integration (initialize values even if mm not loaded)
		local mmStats
		if(MasterMerchant ~= nil) then
			mmStats =  MasterMerchant:itemStats(itemLink, true)
		end
		if(mmStats == nil) then
			mmStats = {}
		end
		item.mmValue = mmStats.avgPrice or -1
		item.mmSalesCount = mmStats.numSales or -1
		item.mmDays = mmStats.numDays or -1
		item.mmSoldCount = mmStats.numItems or -1
		item.mmCraftCost = mmStats.craftCost or -1
		
		-- WritWorthy Integration (initialize values even if ttc not loaded)
		item.wwMatCost = -1
		item.wwMatCostPerVoucher = -1
		if (WritWorthy ~= nil) then
			if 0 < (item.vouchers or 0) then
				local matCost = WritWorthy.ToMatCost(itemLink)
				item.wwMatCost = matCost
				item.wwMatCostPerVoucher = matCost / item.vouchers
			end
		end

		-- Tamriel Trade Center Integration (initialize values even if ttc not loaded)
		local ttcStats
		if(TamrielTradeCentrePrice ~= nil) then
			ttcStats = TamrielTradeCentrePrice:GetPriceInfo(itemLink)
		end
		if(ttcStats == nil) then
			ttcStats = {}
		end
		item.ttcValueMin = ttcStats.Min or -1
		item.ttcOfferCount = ttcStats.EntryCount or -1
		item.ttcItemCount = ttcStats.AmountCount or -1
		item.ttcValueSuggestion = ttcStats.SuggestedPrice or -1
		item.ttcValueAvg = ttcStats.Avg or -1
		item.ttcValueMax = ttcStats.Max or -1		

		-- FCOIS Integration (loaded even if general protection was not enabled to be used in rules)
		item.protected = {}
		item.fcoisIsMarked = false
		item.fcoisMarker = {}
		local protected = {}
	
		if(FCOIS ~= nil) then
			
			local isMarked, marker = FCOIS.IsMarked(bagId, slotIndex, -1)

			item.fcoisIsMarked = isMarked
			
			if(isMarked and marker ~= nil) then
				for index, mark in ipairs(marker) do
					if(mark == true) then
						local locNameStr = FCOIS.localizationVars.iconEndStrArray[index]
						local iconName = FCOIS.GetIconText(index) or FCOIS.localizationVars.fcois_loc["options_icon" .. tostring(index) .. "_" .. locNameStr]
						table.insert(item.fcoisMarker, iconName)
					end
				end
			end
			
			-- overwrite ESO locked with FCOIS locked if FCOIS has disabled ESO Lock 
			-- (this takes the icon, not protections into account)
			local FCOISettings = FCOIS.BuildAndGetSettingsFromExternal()
			if FCOISettings  then
				if (FCOISettings.useZOsLockFunctions == false) then
					item.locked = FCOIS.IsMarked(bagId, slotIndex, -1, FCOIS_CON_ICON_LOCK)
				end
			end
			
			protected["Junk"] = FCOIS.IsJunkLocked(bagId, slotIndex)
			protected["BagToBank"] = false -- no FCOIS protection available
			protected["BankToBag"] = false -- no FCOIS protection available
			protected["SellStore"] = FCOIS.IsVendorSellLocked(bagId, slotIndex)
			protected["SellFence"] = FCOIS.IsFenceSellLocked(bagId, slotIndex)
			protected["Launder"] = FCOIS.IsLaunderLocked(bagId, slotIndex)
			protected["Destroy"] = FCOIS.IsDestroyLocked(bagId, slotIndex)
			protected["Deconstruct"] = FCOIS.IsDeconstructionLocked(bagId, slotIndex)
		
		elseif(RbI.userSettings["General"].useFCOIS) then 
			-- all locks and protections true if FCOIS should be used but was not found
			item.fcoisIsMarked = true
			item.locked = true
			protected["Junk"] = true
			protected["BagToBank"] = true
			protected["BankToBag"] = true
			protected["SellStore"] = true
			protected["SellFence"] = true
			protected["Launder"] = true
			protected["Destroy"] = true
			protected["Deconstruct"] = true
		end
		item.protected = protected
	
	
		-- CraftStore Integration (only recipes and traits, motif still missing in craftstore api)
		item.isLearnableBy = {}	
		item.isResearchableBy = {}
		if(CraftStoreFixedAndImprovedLongClassName ~= nil) then
			
			-- IsLearnable returns an table with names for many items which aren't even learnable at all, like lockpicks
			-- this keeps it for recipes only
			if(item.type == ITEMTYPE_RECIPE) then
				local isLearnableBy = CraftStoreFixedAndImprovedLongClassName.IsLearnable(itemLink, false) -- list of chars able to learn this
				if(isLearnableBy ~= false) then
					for index, character in ipairs(isLearnableBy) do
						if(character[2] == true) then
							table.insert(item.isLearnableBy, string.lower(character[1]))
						end
					end
				end
			end
			local isResearchableBy = CraftStoreFixedAndImprovedLongClassName.IsResearchable(itemLink, false)  -- list of chars able to research this
				if(isResearchableBy ~= false) then
				for index, character in ipairs(isResearchableBy) do
					if(character[2] == true) then
						table.insert(item.isResearchableBy, string.lower(character[1]))
					end
				end
			end
		end
		
		
		-- AutoCategory Integration
		item.autoCategory = ""
		if(AutoCategory ~= nil and AutoCategory.MatchCategoryRules ~= nil) then
			local _, category = AutoCategory:MatchCategoryRules(bagId, slotIndex)
			item.autoCategory = string.lower(category)
		end
	
	end
	
	return item
	
end
	
-- listswitch switches evaluation from (false) "just look if name of names is included in list"
-- to (true) "look if no name from name, which comes before this characters name, included in this list
-- needs this item (and if this character needs it)"
function RbI.IsIncludedInList(listswitch, list, ...)
		
	local names = {...}
	if(#names == 0) then
		if(#list == 0) then
			-- no one should need this item,
			-- and list really is empty
			return true
		else
			-- no one should need this item,
			-- but list isn't empty
			return false
		end
	end
	
	local thisCharactersName = string.lower(GetUnitName('player'))
	
	for _, name in ipairs(names) do -- names lowered in rulestring
		for _, character in ipairs(list) do -- characername lowered in GetItemData
			if(character == name and (thisCharactersName == name or not listswitch)) then
				-- name matches and it's this very character, so item is "needed"
				return true
			elseif(character == name) then
				-- name matches, but it's not this character, so another "needs" this item!
				return false
			end
		end
	end
	-- names did not match any name from the list
	-- item is not needed by anyone
	return false
end

-- if patternSwitch false then given patterns will be escaped
function RbI.NameMatches(patternSwitch, names, ...)
	local patterns = {...}
	if(#names == 0) then
		if(#patterns == 0) then
			-- no name existing,
			-- and no name to match
			return true
		else
			-- no name existing,
			-- but list isn't empty
			return false
		end
	end		
	for _, name in pairs(names) do
		name = string.lower(name)
		for _, pattern in ipairs(patterns) do
			if(not patternSwitch) then 
				pattern = string.gsub(pattern, "%p", "%%%1")
			end
			if(string.match(name, pattern) ~= nil) then
				return true
			end
		end
	end
	return false
end
	
