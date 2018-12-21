if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

-- MAJOR.MINOR.PATCH
-- MAJOR version when user updating is loosing settings or ruledefinitions getting unsound or a major rewrite has taken place,
-- MINOR version when functionality in a backwards-compatible manner is added, and
-- PATCH version when backwards-compatible bug fixes were made


RbI.name = "RulebasedInventory"
RbI.author = "TaxTalis"
RbI.savedVariableVersion = 1
RbI.savedGlobalVariableVersion = 1
RbI.addonVersion = "1.4.2"

RbI.onUpdate = true
RbI.craftStationType = nil
RbI.atBank = false
RbI.atStore = false
RbI.atFence = false
 
-- libAsync
local async = LibStub("LibAsync")
RbI.asyncTask = async:Create(RbI.name)
 
function RbI.Initialize()
	-- add savedvariable
	RbI.charVars = ZO_SavedVars:NewCharacterIdSettings("charVars", RbI.savedVariableVersion, nil, {["userSettings"] = RbI.default.userSettings})
	RbI.userSettings = RbI.charVars.userSettings
	RbI.globalVars = ZO_SavedVars:NewAccountWide ("globalVars", RbI.savedGlobalVariableVersion, nil, {["profiles"] = RbI.default.profiles})
	RbI.profiles = RbI.globalVars.profiles
	
	RbI.InitializeProfile()
	RbI.InitializeRules()
	RbI.CreateSettingsWindow()
	RbI.InitializeContextMenu()
	RbI.isESOPlusSubscriber = IsESOPlusSubscriber()
	
	if(RbI.userSettings["General"].useFCOIS and FCOIS == nil) then
		zo_callLater(function() return RbI.ReportStatus(true, RBI_STATUS_ERROR_FCOISNOTFOUND) end, 2000)
	end
end
  
function RbI.OnAddOnLoaded(event, addonName)
  if addonName == RbI.name then
    RbI.Initialize()
  end
end
 
EVENT_MANAGER:RegisterForEvent(RbI.name, EVENT_ADD_ON_LOADED, RbI.OnAddOnLoaded)