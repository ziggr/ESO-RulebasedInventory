if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

-- function by M. Kottman, https://stackoverflow.com/questions/15706270/sort-a-table-in-lua [2018-07-29]
-- pairs in a sorted order
function RbI.spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

local function buildOptionsData()
	
	local submenudivider = {
					 ["type"] = "divider"
					,["height"] = 15
					,["alpha"] = 0.5
					,["width"] = "full"
				}
	
	local optionsData = {}
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	-- PROFILES ------------------------------------------------------------------
	------------------------------------------------------------------------------
	local submenu = {}
	submenu["type"] = "submenu"
	submenu["name"] = GetString(RBI_MENU_PROFILES_SUBMENU_NAME)									
	submenu["controls"] = {}
	table.insert(submenu["controls"], {	 -- PROFILE DROPDOWN
		 ["type"] = "dropdown"
		,["name"] = GetString(RBI_MENU_PROFILES_PROFILE_DROPDOWN_NAME)
		,["choices"] = RbI.profileList
		,["getFunc"] = function() return RbI.userSettings["General"].profile end
		,["setFunc"] = function(profile) RbI.testprofile = profile end
		,["default"] = nil
		,["width"] = "half"
		,["reference"] = "RBI_MENU_PROFILES_DROPDOWN"
		})
	table.insert(submenu["controls"], {	 -- PROFILE NAME
		 ["type"] = "editbox"
		,["name"] = GetString(RBI_MENU_PROFILES_EDITBOX_PROFILE_NAME)
		,["getFunc"] = 	function() 
							return ""
						end
		,["setFunc"] = function(name) 
							RbI.newprofile = name
						end
		,["isMultiline"] = false
		,["isExtraWide"] = false
		,["width"] = "half"
		,["default"] = ""
		})
	table.insert(submenu["controls"], {	 -- LOAD
		 ["type"] = "button"
		,["name"] = GetString(RBI_MENU_PROFILES_BUTTON_LOAD_NAME)
		,["tooltip"] = GetString(RBI_MENU_PROFILES_BUTTON_LOAD_TOOLTIP)
		,["disabled"] = function()
							if(RbI.profiles[RbI.testprofile] == nil 
								or RbI.testprofile == ""
								or RbI.testprofile == RbI.userSettings["General"].profile) then
								return true
							end
							return false
						end
		,["func"] = function() 
							RbI.charVars.userSettings = RbI.DeepCopy(RbI.profiles[RbI.testprofile])
							RbI.userSettings = RbI.charVars.userSettings
							RbI.userSettings["General"].profile = RbI.testprofile
							RbI.testprofile = ""
							RbI.InitializeRules()
						end
		,["width"] = "half"
		})		
	table.insert(submenu["controls"], {	 -- SAVE
		 ["type"] = "button"
		,["name"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_SAVE_NAME)
		,["tooltip"] = GetString(RBI_MENU_PROFILES_BUTTON_SAVE_TOOLTIP)
		,["disabled"] = function()
							if(RbI.newprofile == "") then
								return true
							end
							return false
						end
		,["func"] = function() 
							RbI.userSettings["General"].profile = RbI.newprofile
							RbI.profiles[RbI.newprofile] = RbI.DeepCopy(RbI.userSettings)
							RbI.newprofile = ""
							RbI.UpdateProfileList()
						end
		,["width"] = "half"
		})
	table.insert(submenu["controls"], {	 -- DELETE
		 ["type"] = "button"
		,["name"] = GetString(RBI_MENU_PROFILES_BUTTON_DELETE_NAME)
		,["tooltip"] = GetString(RBI_MENU_PROFILES_BUTTON_DELETE_TOOLTIP)
		,["disabled"] = function()
							if(RbI.profiles[RbI.newprofile] == nil) then
								return true
							end
							return false
						end
		,["func"] = function() 
							RbI.profiles[RbI.newprofile] = nil
							if(RbI.userSettings["General"].profile == RbI.newprofile) then
								RbI.userSettings["General"].profile = ""
							end
							RbI.newprofile = ""
							RbI.UpdateProfileList()
						end
		,["width"] = "half"
		})		
	table.insert(optionsData, submenu)
	
	
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	-- GENERAL -------------------------------------------------------------------
	------------------------------------------------------------------------------
	local submenu = {}
	submenu["type"] = "submenu"
	submenu["name"] = GetString(RBI_MENU_GENERAL_SUBMENU_NAME)									
	submenu["controls"] = {}
	table.insert(submenu["controls"], {	 
		 ["type"] = "checkbox"
		,["name"] = GetString(RBI_MENU_GENERAL_OUTPUT_CHECKBOX_NAME)
		,["tooltip"] = GetString(RBI_MENU_GENERAL_OUTPUT_CHECKBOX_TOOLTIP)
		,["getFunc"] = function() return RbI.userSettings["General"].output end
		,["setFunc"] = function(status) RbI.userSettings["General"].output = status 
							RbI.userSettings["General"].profile = "" 
						end
		,["default"] = RbI.default.userSettings["General"].output
		,["width"] = "half"
		})
	table.insert(submenu["controls"], {	 
		 ["type"] = "checkbox"
		,["name"] = GetString(RBI_MENU_GENERAL_SUMMARY_CHECKBOX_NAME)
		,["tooltip"] = GetString(RBI_MENU_GENERAL_SUMMARY_CHECKBOX_TOOLTIP)
		,["getFunc"] = function() return RbI.userSettings["General"].summary end
		,["setFunc"] = function(status) RbI.userSettings["General"].summary = status 
							RbI.userSettings["General"].profile = "" 
						end
		,["default"] = RbI.default.userSettings["General"].summary
		,["width"] = "half"
		})
	table.insert(submenu["controls"], {	 
		 ["type"] = "checkbox"
		,["name"] = GetString(RBI_MENU_GENERAL_PROCESSEDRULE_CHECKBOX_NAME)
		,["tooltip"] = GetString(RBI_MENU_GENERAL_PROCESSEDRULE_CHECKBOX_TOOLTIP)
		,["getFunc"] = function() return RbI.userSettings["General"].printCompiledRule end
		,["setFunc"] = function(status) RbI.userSettings["General"].printCompiledRule = status 
							RbI.userSettings["General"].profile = "" 
						end
		,["default"] = RbI.default.userSettings["General"].printCompiledRule
		,["width"] = "half"
		})			
	table.insert(submenu["controls"], {	 
		 ["type"] = "checkbox"
		,["name"] = GetString(RBI_MENU_GENERAL_CONTEXTMENU_CHECKBOX_NAME)
		,["tooltip"] = GetString(RBI_MENU_GENERAL_CONTEXTMENU_CHECKBOX_TOOLTIP)
		,["getFunc"] = function() return RbI.userSettings["General"].contextMenu end
		,["setFunc"] = function(status) RbI.userSettings["General"].contextMenu = status 
							RbI.userSettings["General"].profile = "" 
						end
		,["default"] = RbI.default.userSettings["General"].contextMenu
		,["width"] = "half"
		,["requiresReload"] = true
		})	
	table.insert(submenu["controls"], {	 
		 ["type"] = "checkbox"
		,["name"] = GetString(RBI_MENU_GENERAL_FCOIS_CHECKBOX_NAME)
		,["tooltip"] = GetString(RBI_MENU_GENERAL_FCOIS_CHECKBOX_TOOLTIP)
		,["getFunc"] = function() return RbI.userSettings["General"].useFCOIS end
		,["setFunc"] = function(status) RbI.userSettings["General"].useFCOIS = status 
							RbI.userSettings["General"].profile = "" 
						end
		,["default"] = RbI.default.userSettings["General"].useFCOIS
		,["width"] = "half"
		,["disabled"] = function() return not (FCOIS ~= nil or RbI.userSettings["General"].useFCOIS) end
		})	
	table.insert(submenu["controls"], {	 
		 ["type"] = "checkbox"
		,["name"] = GetString(RBI_MENU_GENERAL_START_TASK_MESSAGE)
		,["tooltip"] = GetString(RBI_MENU_GENERAL_START_TASK_MESSAGE_TOOLTIP)
		,["getFunc"] = function() return RbI.userSettings["General"].taskStartMessage end
		,["setFunc"] = function(status) RbI.userSettings["General"].taskStartMessage = status 
							RbI.userSettings["General"].profile = "" 
						end
		,["default"] = RbI.default.userSettings["General"].taskStartMessage
		,["width"] = "half"
		})					
	table.insert(optionsData, submenu)
	
	------------------------------------------------------------------------------
	------------------------------------------------------------------------------
	-- TASKSPECIFIC --------------------------------------------------------------
	------------------------------------------------------------------------------
	for _, task in RbI.spairs(RbI.tasks) do
	
		local placeDivider = true
	
		if(task.menu) then
		
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- SUBMENU -------------------------------------------------------------------
			------------------------------------------------------------------------------
			local submenu = {}
			submenu["type"] = "submenu"
			submenu["name"] = GetString(_G[string.upper("RBI_MENU_TASK_" .. task.name .. "_SUBMENU_NAME")])									
			submenu["controls"] = {}
			
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- RULESTRING ----------------------------------------------------------------
			------------------------------------------------------------------------------
			table.insert(submenu["controls"], {	 
				 ["type"] = "editbox"
				,["name"] = GetString(RBI_MENU_TASK_GENERAL_EDITBOX_RULE_NAME)
				,["getFunc"] = 	function() 
									local taskName = task.name
									if(task.name == "SellStore") then 
										taskName = "Sell"
									end
									return RbI.testrulestrings[taskName] or RbI.userSettings[taskName]["rulestring"]
								end
				,["setFunc"] = function(rulestring) 
									local taskName = task.name
									if(task.name == "SellStore") then 
										taskName = "Sell"
									end
									RbI.testrulestrings[taskName] = rulestring
									RbI.InitializeRule(taskName, true)
								end
				,["isMultiline"] = true
				,["isExtraWide"] = true
				,["width"] = "full"
				,["default"] = function() 
									local taskName = task.name
									if(task.name == "SellStore") then 
										taskName = "Sell"
									end
									RbI.userSettings[taskName]["rulestring"] = RbI.default.userSettings[taskName].rulestring
									RbI.InitializeRule(taskName, false)
									return RbI.default.userSettings[taskName].rulestring
								end
				})
			
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- ABORT-BUTTON --------------------------------------------------------------
			------------------------------------------------------------------------------
			table.insert(submenu["controls"], {	 
				 ["type"] = "button"
				,["name"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_ABORT_NAME)
				,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_ABORT_TOOLTIP)
				,["disabled"] = function()
									local taskName = task.name
									if(task.name == "SellStore") then 
										taskName = "Sell"
									end
									return RbI.testrulestrings[taskName] == nil 
										or RbI.userSettings[taskName]["rulestring"] == RbI.testrulestrings[taskName]
								end
				,["func"] = function() 
									local taskName = task.name
									if(task.name == "SellStore") then 
										taskName = "Sell"
									end
									RbI.testrulestrings[taskName] = RbI.userSettings[taskName]["rulestring"]
									RbI.InitializeRule(taskName, false)
								end
				,["width"] = "half"
				})		
				
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- SAVE-BUTTON ---------------------------------------------------------------
			------------------------------------------------------------------------------
			table.insert(submenu["controls"], {	 
				 ["type"] = "button"
				,["name"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_SAVE_NAME)
				,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_SAVE_TOOLTIP)
				,["disabled"] = function()
									local taskName = task.name
									if(task.name == "SellStore") then 
										taskName = "Sell"
									end
									return RbI.testrulestrings[taskName] == nil 
										or RbI.userSettings[taskName]["rulestring"] == RbI.testrulestrings[taskName]
								end
				,["func"] = function() 
									local taskName = task.name
									if(task.name == "SellStore") then 
										taskName = "Sell"
									end
									RbI.userSettings[taskName]["rulestring"] = RbI.testrulestrings[taskName]
									RbI.userSettings["General"].profile = "" 
									RbI.InitializeRule(taskName, false)
								end
				,["width"] = "half"
				})		
			
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- TEST-BUTTON ---------------------------------------------------------------
			------------------------------------------------------------------------------
			table.insert(submenu["controls"], {	 
				 ["type"] = "button"
				,["name"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_TEST_NAME)
				,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_TEST_TOOLTIP)
				,["func"] = function() 
								RbI.PrintRule(task.name, true)
								
								RbI.AddTaskToQueue(true, task.name) 
								if(task.name == "SellStore") then  
									RbI.PrintRule("SellFence", true)
									RbI.AddTaskToQueue(true, "SellFence") 
								end
							end
				,["width"] = "half"
				})

			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- RUN-BUTTON ----------------------------------------------------------------
			------------------------------------------------------------------------------
			if(task.menuRun) then
				table.insert(submenu["controls"], {	 
					 ["type"] = "button"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_RUN_NAME)
					,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_BUTTON_RUN_TOOLTIP)
					,["func"] = function()
									RbI.onUpdate = false
									if(task.name == "Junk") then
										RbI.AddTaskToQueue(false, "UnJunk")
									end
									RbI.AddTaskToQueue(false, task.name) 
								end
					,["width"] = "half"
					})
			end

			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- OUTPUT-CONTROL ------------------------------------------------------------
			------------------------------------------------------------------------------
			if(task.menuOutput) then
				
				if(placeDivider) then
					placeDivider = false
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
					table.insert(submenu["controls"], submenudivider)
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
				end
				
				table.insert(submenu["controls"], {	 
					 ["type"] = "checkbox"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_CHECKBOX_OUTPUT_NAME)
					,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_CHECKBOX_OUTPUT_TOOLTIP)
					,["getFunc"] = function()
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										return RbI.userSettings[taskName].output 
									end
					,["setFunc"] = function(status)
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										RbI.userSettings[taskName].output = status 
										RbI.userSettings["General"].profile = "" 
									end
					,["width"] = "half"
					,["default"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.default.userSettings[taskName].output
									end
					,["disabled"] = function() return not RbI.userSettings["General"].output end
					})	
			end
			
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- SUMMARY-CONTROL -----------------------------------------------------------
			------------------------------------------------------------------------------
			if(task.menuSummary) then
				
				if(placeDivider) then
					placeDivider = false
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
					table.insert(submenu["controls"], submenudivider)
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
				end
				
				table.insert(submenu["controls"], {	 
					 ["type"] = "checkbox"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_CHECKBOX_SUMMARY_NAME)
					,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_CHECKBOX_SUMMARY_TOOLTIP)
					,["getFunc"] = function()
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										return RbI.userSettings[taskName].summary 
									end
					,["setFunc"] = function(status)
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										RbI.userSettings[taskName].summary = status 
										RbI.userSettings["General"].profile = "" 
									end
					,["width"] = "half"
					,["default"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.default.userSettings[taskName].summary
									end
					,["disabled"] = function() return not RbI.userSettings["General"].summary end
					})	
			end
			
			------------------------------------------------------------------------------
			if(task.menuOutput or task.menuSummary) then
				placeDivider = true
			end
			------------------------------------------------------------------------------
			

			if(task.menuThreshold) then
				
				if(placeDivider) then
					--placeDivider = false -- this block is already toggled in whole, no need for afterwards check
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
					table.insert(submenu["controls"], submenudivider)
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
				end
				
				------------------------------------------------------------------------------
				------------------------------------------------------------------------------
				-- THRESHOLD-CONTROL ---------------------------------------------------------
				------------------------------------------------------------------------------
				table.insert(submenu["controls"], {	 
					 ["type"] = "checkbox"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_CHECKBOX_THRESHOLD_NAME)
					,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_CHECKBOX_THRESHOLD_TOOLTIP)
					,["getFunc"] = function()
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										return RbI.userSettings[taskName].threshold 
									end
					,["setFunc"] = function(status)
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										RbI.userSettings[taskName].threshold = status 
										RbI.userSettings["General"].profile = "" 
									end
					,["width"] = "half"
					,["default"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.default.userSettings[taskName].threshold
									end
					,["disabled"] = false
					})	
			
				------------------------------------------------------------------------------
				------------------------------------------------------------------------------
				-- THRESHOLD-COUNT -----------------------------------------------------------
				------------------------------------------------------------------------------
				table.insert(submenu["controls"], {	 
					 ["type"] = "slider"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_SLIDER_THRESHOLD_NAME)
					,["getFunc"] = 	function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.userSettings[taskName].thresholdcount
									end
					,["setFunc"] = function(thresholdcount) 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										RbI.userSettings[taskName].thresholdcount = thresholdcount
										RbI.userSettings["General"].profile = "" 
									end
					,["width"] = "half"
					,["disabled"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return not RbI.userSettings[taskName].threshold 
									end
					,["default"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.default.userSettings[taskName].thresholdcount
									end
					,["min"] = 0
					,["max"] = GetBagSize(BAG_BACKPACK)
					,["clampInput"] = true
					,["step"] = 1
					})		
					
			end

			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- TIMEOUT -------------------------------------------------------------------
			------------------------------------------------------------------------------
			if(task.menuTimeout) then
			
				if(placeDivider) then
					placeDivider = false
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
					table.insert(submenu["controls"], submenudivider)
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
				end
			
				table.insert(submenu["controls"], {	 
					 ["type"] = "slider"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_SLIDER_TIMEOUT_NAME)
					,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_SLIDER_TIMEOUT_TOOLTIP)
					,["getFunc"] = 	function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.userSettings[taskName].timeout
									end
					,["setFunc"] = function(timeout) 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										elseif(task.name == "BagToBank") then
											RbI.userSettings["BankToBag"].timeout = timeout
										end
										RbI.userSettings[taskName].timeout = timeout
										RbI.userSettings["General"].profile = "" 
									end
					,["width"] = "half"
					,["default"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										elseif(task.name == "BankToBag") then
											taskName = "BagToBank"
										end
										return RbI.default.userSettings[taskName].timeout
									end
					,["min"] = 0
					,["max"] = 3000
					,["clampInput"] = true
					,["step"] = 100
					})						
			end
			
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- DELAY -------------------------------------------------------------------
			------------------------------------------------------------------------------
			if(task.menuDelay) then
			
				if(placeDivider) then
					placeDivider = false
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
					table.insert(submenu["controls"], submenudivider)
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
				end			
			
				table.insert(submenu["controls"], {	 
					 ["type"] = "slider"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_SLIDER_DELAY_NAME)
					,["tooltip"] = GetString(RBI_MENU_TASK_GENERAL_SLIDER_DELAY_TOOLTIP)
					,["getFunc"] = 	function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.userSettings[taskName].delay
									end
					,["setFunc"] = function(delay) 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										elseif(task.name == "BagToBank") then
											RbI.userSettings["BankToBag"].delay = delay
										end
										RbI.userSettings[taskName].delay = delay
										RbI.userSettings["General"].profile = "" 
									end
					,["width"] = "half"
					,["default"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										elseif(task.name == "BankToBag") then
											taskName = "BagToBank"
										end
										return RbI.default.userSettings[taskName].delay
									end
					,["min"] = RbI.tasks[task.name].menuMinDelay or 0
					,["max"] = RbI.tasks[task.name].menuMaxDelay or 2000
					,["clampInput"] = true
					,["step"] = 100
					})						
			end	
			
			------------------------------------------------------------------------------
			if(task.menuTimeout or task.menuDelay) then
				placeDivider = true
			end
			------------------------------------------------------------------------------
			
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- SAFERULE-CONTROL ---------------------------------------------------------
			------------------------------------------------------------------------------
			if(task.menuSaveRule) then
			
				if(placeDivider) then
					placeDivider = false
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
					table.insert(submenu["controls"], submenudivider)
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
				end
			
				table.insert(submenu["controls"], {	 
					 ["type"] = "checkbox"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_CHECKBOX_SAFERULE_NAME)
					,["tooltip"] = GetString(_G[string.upper("RBI_MENU_TASK_" .. task.name .. "_SAFERULE_TOOLTIP")])
					,["getFunc"] = function()
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										return RbI.userSettings[taskName].safeRule 
									end
					,["setFunc"] = function(status)
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										RbI.userSettings[taskName].safeRule = status 
										RbI.userSettings["General"].profile = "" 
										RbI.InitializeRule(taskName, false)
									end
					,["width"] = "half"
					,["default"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.default.userSettings[taskName].safeRule
									end
					,["disabled"] = false
					})	
			end
			
			------------------------------------------------------------------------------
			------------------------------------------------------------------------------
			-- EXCLUDE-OTHER-RULE-CONTROL ---------------------------------------------------------
			------------------------------------------------------------------------------
			if(task.menuExcludeOtherRule) then
			
				if(placeDivider) then
					placeDivider = false
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
					table.insert(submenu["controls"], submenudivider)
					------------------------------------------------------------------------------
					------------------------------------------------------------------------------
				end
			
				table.insert(submenu["controls"], {	 
					 ["type"] = "checkbox"
					,["name"] = GetString(RBI_MENU_TASK_GENERAL_CHECKBOX_EXLUDERULE_NAME) .. " " .. GetString(_G[string.upper("RBI_MENU_TASK_" .. task.excludeRuleOf .. "_SUBMENU_NAME")])
					,["getFunc"] = function()
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										return RbI.userSettings[taskName].excludeOtherRule 
									end
					,["setFunc"] = function(status)
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end  
										RbI.userSettings[taskName].excludeOtherRule = status 
										RbI.userSettings["General"].profile = "" 
										RbI.InitializeRule(taskName, false)
									end
					,["width"] = "half"
					,["default"] = function() 
										local taskName = task.name
										if(task.name == "SellStore") then 
											taskName = "Sell"
										end
										return RbI.default.userSettings[taskName].excludeOtherRule
									end
					,["disabled"] = false
					})	
			end
			--[[----------------------------------------------------------------------------
			if(task.menuSaveRule or task.menuExcludeOtherRule) then
				placeDivider = true
			end
			]]------------------------------------------------------------------------------
		
		
		table.insert(optionsData, submenu)
		
		end
	end
	return optionsData
end


function RbI.CreateSettingsWindow()

	local LAM2 = LibStub:GetLibrary("LibAddonMenu-2.0")

	local panelData = {
		 type = "panel"
		,name = RbI.name
		,displayName = RbI.name .. GetString(RBI_MENU_PANEL_DISPLAYNAME)
		,author = RbI.author
		,version = tostring(RbI.addonVersion)
		,slashCommand = "/rbi"
		,registerForRefresh = true
		,registerForDefaults = true
	}
	
	local cntrlOptionsPanel = LAM2:RegisterAddonPanel("RBISettingsPanel", panelData)
	
	
	local optionsData = buildOptionsData()
	LAM2:RegisterOptionControls("RBISettingsPanel", optionsData)
end