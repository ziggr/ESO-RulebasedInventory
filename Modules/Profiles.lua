if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

RbI.profileList = {}

function RbI.UpdateProfileList()
	
	RbI.profileList = {}
	
	for profile, _ in pairs(RbI.profiles) do
		RbI.profileList[#RbI.profileList+1] = profile
	end

	if(RBI_MENU_PROFILES_DROPDOWN) then
		RBI_MENU_PROFILES_DROPDOWN:UpdateChoices(RbI.profileList)
	end
end


function RbI.InitializeProfile()

	if(RbI.userSettings["General"].profile ~= nil and RbI.userSettings["General"].profile ~= "" and RbI.profiles[RbI.userSettings["General"].profile] ~= nil) then
		RbI.charVars.userSettings = RbI.DeepCopy(RbI.profiles[RbI.userSettings["General"].profile])
		RbI.userSettings = RbI.charVars.userSettings
	else
		RbI.userSettings["General"].profile = ""
	end

	RbI.UpdateProfileList()
end

