if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

-- enriches a simplified rulestring to be used as boolean rule
function RbI.EnrichRule(basicRulestring, rulestring)

	if(rulestring == nil or not string.find(rulestring, "%a")) then
		rulestring = "false" -- makes any term invalid if the user did not set a rule
	else
		if(basicRulestring ~= nil and string.find(basicRulestring, "%a")) then
			-- combine basicRulestring and rulestring if basicRulestring is set
			rulestring = " " .. basicRulestring .. " and ( " .. rulestring .. " ) "
		else -- important: the spaces added above and below are necessary for patternmatching!
			rulestring = " " .. rulestring .. " "
		end
		
		rulestring = string.lower(rulestring)
		-- a rule is derived from the basic rulestring for this task and the user-given rulestring
		-- append spaces for some magic to get ESOLua-patterns to work (can't figure this out right now...)
		-- TODO (low priority): figure out how gsub/match works in ESOLua
				
		local patternblocker = "([^%a\"\_])"
		
		for _, genericFunction in ipairs(RbI.genericFunctions) do
			local pattern = genericFunction[1]
			local substitute = genericFunction[2]
			local escapedPattern = patternblocker .. string.gsub(pattern, "%p", "%%%1") .. patternblocker
			rulestring = string.gsub(rulestring, escapedPattern, "%1"..substitute.."%2")
		end
		
		for pattern, substitute in pairs(RbI.enrichRuleBasedata) do
			local escapedPattern = patternblocker .. string.gsub(pattern, "%p", "%%%1") .. patternblocker
			rulestring = string.gsub(rulestring, escapedPattern, "%1"..substitute.."%2")
		end
		
		for _, enrichRuleESOConstantdata in pairs(RbI.enrichRuleESOConstantdata) do
			for pattern, substitute in pairs(enrichRuleESOConstantdata) do
				local escapedPattern = patternblocker .. string.gsub(pattern, "%p", "%%%1") .. patternblocker
				rulestring = string.gsub(rulestring, escapedPattern, "%1"..substitute.."%2")
			end
		end
		
		for pattern, substitute in pairs(RbI.enrichRuleExtendeddata) do
			local escapedPattern = patternblocker .. string.gsub(pattern, "%p", "%%%1") .. patternblocker
			rulestring = string.gsub(rulestring, escapedPattern, "%1"..substitute.."%2")
		end
		
	end
	
	return rulestring
	
end

function RbI.PrintRule(taskName, testrun)
	local rulestring = ""
	local baseTaskName = taskName
	if(taskName == "SellStore" or taskName == "SellFence") then 
		baseTaskName = "Sell"
	end
	if(testrun) then
		RbI.ReportStatus(false, RBI_STATUS_PRINTRULE_TEST_START, GetString(_G[string.upper("RBI_MENU_TASK_" .. taskName .. "_SUBMENU_NAME")]))
		if(RbI.userSettings["General"].printCompiledRule) then
			rulestring = RbI.tasks[taskName].testRulestring
		else
			rulestring = RbI.testrulestrings[baseTaskName]
		end
	else
		RbI.ReportStatus(false, RBI_STATUS_PRINTRULE_START, GetString(_G[string.upper("RBI_MENU_TASK_" .. taskName .. "_SUBMENU_NAME")]))
		if(RbI.userSettings["General"].printCompiledRule) then
			rulestring = RbI.tasks[taskName].rulestring
		else
			rulestring = RbI.userSettings[baseTaskName].rulestring
		end
	end

	RbI.PrintColoredRulestring(rulestring)
	RbI.ReportStatus(false, RBI_STATUS_PRINTRULE_END, GetString(_G[string.upper("RBI_MENU_TASK_" .. taskName .. "_SUBMENU_NAME")]))
end

function RbI.PrintColoredRulestring(rulestring)
	if(rulestring == "" or rulestring == nil) then 
		rulestring = "false" 
	end
	for word in string.gmatch(rulestring, "[%a_]+") do 
		local known
		if(string.lower(word) == "and" 
			or string.lower(word) == "or"
			or string.lower(word) == "not"
			or string.lower(word) == "false"
			or string.lower(word) == "true"
			or string.lower(word) == "nil"
			or string.lower(word) == "match"
			or string.lower(word) == "lower"
			or string.lower(word) == "learn"
			or string.lower(word) == "learnlist"
			or string.lower(word) == "research"
			or string.lower(word) == "researchlist"
			or string.lower(word) == "itemname"
			or string.lower(word) == "itemnamematch"
			or string.lower(word) == "creatorname"
			or string.lower(word) == "creatornamematch"			
			or string.lower(word) == "reagenttrait"
			or string.lower(word) == "reagenttraitmatch"			
			or string.lower(word) == "itemtag"
			or string.lower(word) == "itemtagmatch"
			or string.lower(word) == "fcoismarker"
			or string.lower(word) == "fcoismarkermatch"
			or string.lower(word) == "count"
			or string.lower(word) == "craftstationtype"
			or string.lower(word) == "autocategory") then
			known = true
		else 
			known = false
			for masterkey, mastervalue in pairs(RbI.enrichRuleESOConstantdata) do
				if(string.lower(word) == string.lower(string.match(masterkey, "[%a_]+"))) then 
					known = true 
					break
				end
				for key, value in pairs(mastervalue) do
					if(string.lower(word) == string.lower(string.match(key, "[%a_]+")) or string.lower(word) == string.lower(string.match(value, "[%a_]+"))) then 
						known = true 
						break
					end
				end
			end 
			
			for _, datatable in pairs({RbI.enrichRuleBasedata, RbI.esoConstantEnvironment}) do
				for key, value in pairs(datatable) do
					if(string.lower(word) == string.lower(string.match(key, "[%a_]+")) or string.lower(word) == string.lower(string.match(value, "[%a_]+"))) then 
						known = true 
						break
					end
				end
			end
			
			for _, genericFunction in pairs(RbI.genericFunctions) do
				if(string.lower(word) == string.lower(string.match(genericFunction[1], "[%a_]+"))) then 
					known = true 
					break
				end
			end
			
		end
		if(known == false) then
			-- mark any not recognized whole word in red, exept when its surroundet in double quotes
			rulestring = string.gsub(rulestring, "[^%a\"\_]" .. word .. "[^%a\"\_]", "|cFF0000" .. word .. "|c00FF00")
			-- mark unrecognized words in double qoutes in grey
			rulestring = string.gsub(rulestring, "[\"][%s]*" .. word .. "[%s]*[\"]", "\"|cC0C0C0" .. word .. "|c00FF00\"")
		end
	end
	rulestring = "|c00FF00".. rulestring .. "|r"
	RbI.ReportStatus(false, nil, rulestring)
end

-- returns a function taking the item as parameter and returning true or false if the item matches the rule or not
local function LoadRule(taskName, testrun)
	
	local rule = RbI.tasks[taskName].rulestring
	if(testrun) then
		rule = RbI.tasks[taskName].testRulestring
	end
	-- append needed syntax for loading of string for evaluation
	rule = "return ( " .. rule .. " )"

	-- defining the environment for the function returning the evaluation of the boolean term

	local Match = nil
	
	-- load a string to be evaluated in lua
	-- used to implement complex user-given boolean terms
	Match = zo_loadstring(rule)
	
	if(Match ~= nil) then
		setfenv(Match, RbI.environment)
	end
	
	if(testrun) then
		RbI.tasks[taskName].testRule = Match
	else
		RbI.tasks[taskName].rule = Match
	end
end



function RbI.InitializeRule(taskName, testrun)
	local baseTaskName = taskName
	local baseRule = ""
	
	if(taskName=="Sell") then
		baseTaskName = "SellStore"
		if(RbI.tasks[baseTaskName].baseRulestring ~= "") then
			baseRule = "( " .. RbI.tasks[baseTaskName].baseRulestring .. " )"
		end
		if(baseRule ~= "" and RbI.userSettings[taskName].safeRule and RbI.tasks[baseTaskName].safeRulestring ~= "") then
			baseRule = baseRule .. " and "
		end
		if(RbI.userSettings[taskName].safeRule and RbI.tasks[baseTaskName].safeRulestring ~= "") then
			baseRule = baseRule .. "( " .. RbI.tasks[baseTaskName].safeRulestring .. " )"
		end
		
		if(not testrun) then
			RbI.tasks[baseTaskName].rulestring = RbI.EnrichRule(baseRule, RbI.userSettings[taskName]["rulestring"])
			LoadRule(baseTaskName, false)
		end
		-- when testrulestring is nil (which it is initially) testrulestring should be the user-given rulestring
		RbI.tasks[baseTaskName].testRulestring = RbI.EnrichRule(baseRule, (RbI.testrulestrings[taskName] or RbI.userSettings[taskName]["rulestring"]))
		LoadRule(baseTaskName, true)
		baseTaskName = "SellFence"
	end
	
	baseRule = ""
	if(RbI.tasks[baseTaskName].baseRulestring ~= "") then
		baseRule = "( " .. RbI.tasks[baseTaskName].baseRulestring .. " )"
	end
	if(baseRule ~= "" and RbI.userSettings[taskName].safeRule and RbI.tasks[baseTaskName].safeRulestring ~= "") then
		baseRule = baseRule .. " and "
	end
	if(RbI.userSettings[taskName].safeRule and RbI.tasks[baseTaskName].safeRulestring ~= "") then
		baseRule = baseRule .. "( " .. RbI.tasks[baseTaskName].safeRulestring .. " )"
	end
	
	if(not testrun) then
		RbI.tasks[baseTaskName].rulestring = RbI.EnrichRule(baseRule, RbI.userSettings[taskName]["rulestring"])
		LoadRule(baseTaskName, false)
	end
	-- when testrulestring is nil (which it is initially) testrulestring should be the user-given rulestring
	RbI.tasks[baseTaskName].testRulestring = RbI.EnrichRule(baseRule, (RbI.testrulestrings[taskName] or RbI.userSettings[taskName]["rulestring"]))
	LoadRule(baseTaskName, true)
end


-- load userRulestring from savedVariables and compile the rules
function RbI.InitializeRules()
	
	for _, taskName in pairs({"Junk", "BagToBank", "BankToBag", "Sell", "Launder", "Destroy", "Notify", "Deconstruct"}) do
		RbI.testrulestrings[taskName] = RbI.userSettings[taskName]["rulestring"]
		RbI.InitializeRule(taskName)
	end
	
	-- special case as unjunk only takes basicRulestring rule and never get's updated by the user
	RbI.tasks["UnJunk"].rulestring = RbI.EnrichRule(nil, RbI.tasks["UnJunk"]["baseRulestring"]) 
	LoadRule("UnJunk", false)

end



























