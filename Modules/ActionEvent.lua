if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- BAG_BACKPACK SINGLE SLOT UPDATE -------------------------------------------
------------------------------------------------------------------------------

local function OnSlotUpdate(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
	--d(tostring(eventCode) .. " / " .. tostring(bagId)  .. " / " .. tostring(slotIndex)  .. " / " .. tostring(isNewItem)  .. " / " .. tostring(itemSoundCategory)  .. " / " .. tostring(inventoryUpdateReason)  .. " / " .. tostring(stackCountChange))
	if(stackCountChange ~= 0 
		and (bagId == BAG_BACKPACK or bagId == BAG_BANK or bagId == BAG_SUBSCRIBER_BANK or bagId == BAG_VIRTUAL)
		and SCENE_MANAGER:GetCurrentScene() ~= STABLES_SCENE
		and RbI.onUpdate
		and not (Roomba and Roomba.WorkInProgress and Roomba.WorkInProgress())) then
		
		if(bagId ~= BAG_VIRTUAL) then
			RbI.AddActionToQueue(1, bagId, slotIndex, nil, stackCountChange)
		end
		
		if(isNewItem) then
			if(RbI.tasks["Notify"].rulestring ~= "false") then
				RbI.AddActionToQueue(2, bagId, slotIndex, "Notify", stackCountChange)
			end
		end
		
		if(bagId == BAG_BACKPACK and stackCountChange > 0) then
			for _, taskName in pairs({"Junk", "Destroy"}) do
				if(RbI.tasks[taskName].rulestring ~= "false") then
					RbI.AddActionToQueue(1, bagId, slotIndex, taskName)
				end
			end
		end

		RbI.StartExecution()
		
		-- check for backpackspace and run destroy on whole bag if threshold is passed
		if(RbI.userSettings["Destroy"].threshold and RbI.userSettings["Destroy"].thresholdcount >= GetNumBagFreeSlots(bagId)) then
			RbI.AddTaskToQueue(false, "Destroy")
		end
		
	end
end


EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, OnSlotUpdate)
-- Filter Events
EVENT_MANAGER:AddFilterForEvent(RbI.name, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)
EVENT_MANAGER:AddFilterForEvent(RbI.name, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_UNIT_TAG, "player")



------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- BANK ----------------------------------------------------------------------
------------------------------------------------------------------------------

local function OnBankOpen(eventCode, bagId)
	if(bagId == BAG_BANK) then
		RbI.atBank = true
		zo_callLater(function() RbI.AddTaskToQueue(false, "BagToBank", "BankToBag") end, RbI.userSettings["BankToBag"].timeout)
	end
end

local function OnBankClose()
	RbI.atBank = false
	RbI.RemoveActionsForTask()
end

EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_OPEN_BANK, OnBankOpen)
EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_CLOSE_BANK, OnBankClose)


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- STORE ---------------------------------------------------------------------
------------------------------------------------------------------------------

local function OnStoreOpen()
	RbI.atStore = true
	zo_callLater(function() RbI.AddTaskToQueue(false, "SellStore") end, RbI.userSettings["Sell"].timeout)
end

local function OnStoreClose()
	RbI.atStore = false
	RbI.RemoveActionsForTask()
end

EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_OPEN_STORE, OnStoreOpen)
EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_CLOSE_STORE, OnStoreClose)


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- FENCE ---------------------------------------------------------------------
------------------------------------------------------------------------------

local function OnFenceOpen()
	RbI.atFence = true
	-- with timeouts user can determine if launder or sellfence is executed first (well at least to some degree)
	zo_callLater(function() RbI.AddTaskToQueue(false, "Launder") end, RbI.userSettings["Launder"].timeout)
	zo_callLater(function() RbI.AddTaskToQueue(false, "SellFence") end, RbI.userSettings["Sell"].timeout)
end

local function OnFenceClose()
	RbI.atFence = false
	RbI.RemoveActionsForTask()
end

EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_OPEN_FENCE, OnFenceOpen)
EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_CLOSE_FENCE, OnFenceClose)


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- DECONSTRUCT ---------------------------------------------------------------
------------------------------------------------------------------------------

local function WaitForDeconstructTab()
	if(not ZO_EnchantingTopLevelExtractionSlotContainer:IsHidden()
		or not ZO_SmithingTopLevelDeconstructionPanelSlotContainer:IsHidden()) then
		zo_callLater(function() RbI.AddTaskToQueue(false, "Deconstruct") end, RbI.userSettings["Deconstruct"].timeout)
		return
	end
	
	-- repeat wait until tab opened or station closed
	if(RbI.craftStationType ~= nil) then
		zo_callLater(WaitForDeconstructTab, 500)
	end
end

local function OnCraftingStationOpen(eventCode, craftingType)
	if(craftingType ~= CRAFTING_TYPE_ALCHEMY and craftingType ~= CRAFTING_TYPE_PROVISIONING) then
		RbI.craftStationType = craftingType
		WaitForDeconstructTab()
	end
end

local function OnCraftingStationClose()
	RbI.RemoveActionsForTask()
	RbI.craftStationType = nil
end

EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_CRAFTING_STATION_INTERACT, OnCraftingStationOpen)
EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_END_CRAFTING_STATION_INTERACT, OnCraftingStationClose)


