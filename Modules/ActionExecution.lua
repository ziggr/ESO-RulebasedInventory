if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

local isExecuting = false

local bagFullFlag = false

function RbI.GetTotalMoveCount(row, task, testrun)

	local totalMoveCount = 0
	local taskName = task.name
	if(taskName == "SellStore" or taskName == "SellFence") then
		taskName = "Sell"
	end
	
	-- check general protection
	if((RbI.userSettings["General"].useFCOIS and row.protected[task.name]) -- protected by FCOIS
		or (row.locked and (taskName == "Sell" or taskName == "Deconstruct" or taskName == "Destroy"))) then -- protected by ESO
		--d("item is protected")
		return totalMoveCount -- which is 0
	end
	
	local Rule = task.rule
	local OtherRule
	if(RbI.userSettings[taskName].excludeOtherRule and task.excludeRuleOf ~= nil) then
		OtherRule = RbI.tasks[task.excludeRuleOf].rule
	else
		OtherRule = function() return false end -- no rule or no exclusion equals an result of false
	end
	if(testrun) then
		Rule = task.testRule
		if(RbI.userSettings[taskName].excludeOtherRule and task.excludeRuleOf ~= nil) then
			OtherRule = RbI.tasks[task.excludeRuleOf].testRule
		end
	end 
	

	if(Rule == nil) then
		-- catch error on compilation of rule (syntax error etc.)
		if(not testrun) then
			-- in testrun rule is displayed anyway
			RbI.PrintRule(taskName)
		end
		RbI.ReportStatus(true, RBI_STATUS_ERROR_RULESYNTAX, GetString(_G[string.upper("RBI_MENU_TASK_" .. taskName .. "_SUBMENU_NAME")]))
		return false
	end
	
	if(RbI.userSettings[taskName].excludeOtherRule and OtherRule == nil and task.excludeRuleOf ~= nil) then
		-- catch error on compilation of rule (syntax error etc.)
		RbI.PrintRule(task.excludeRuleOf, testrun)
		RbI.ReportStatus(true, RBI_STATUS_ERROR_RULESYNTAX, GetString(_G[string.upper("RBI_MENU_TASK_" .. task.excludeRuleOf .. "_SUBMENU_NAME")]))
		return false
	end
	
	-- set current data for this execution of this rule
	RbI.environment.craftstationtype = RbI.craftStationType
	RbI.environment.item = row
	
	-- backup counts
	local bakCountSourceBag = row.count[task.bagId]
	local bakCountTargetBag
	if(task.bagIdTo) then
		bakCountTargetBag = row.count[task.bagIdTo]
	end
	
	-- catch error on execution of rule (compare with nil etc.)
	local outcome, result = pcall(Rule)
	
	-- excluded rule needs an offset
	row.count[task.bagId] = row.count[task.bagId] - 1
	if(task.bagIdTo) then
		row.count[task.bagIdTo] = row.count[task.bagIdTo] + 1
	end
	local otherOutcome, otherResult = pcall(OtherRule)
	
	-- test if even a single item is to be moved or if a rule fails
	if(outcome and otherOutcome) then
		if ((not result) or otherResult) then -- included in other rule so excluded in this one, is false if excludeOtherRule is false
			-- reset row to backuped count values
			row.count[task.bagId] = bakCountSourceBag
			if(task.bagIdTo) then
				row.count[task.bagIdTo] = bakCountTargetBag
			end
			--d("item does not match the rule")
			return totalMoveCount -- which is 0 at this time
		end
	elseif(not outcome) then
		if(not testrun) then
			-- in testrun rule is displayed anyway
			RbI.PrintRule(taskName)
		end
		RbI.ReportStatus(true, RBI_STATUS_ERROR_RULECONTENT, GetString(_G[string.upper("RBI_MENU_TASK_" .. taskName .. "_SUBMENU_NAME")]))
		return false
	elseif(not otherOutcome) then
		-- testrun was for different task, but this task's rule missbehaved, print it!
		RbI.PrintRule(task.excludeRuleOf, testrun)
		RbI.ReportStatus(true, RBI_STATUS_ERROR_RULECONTENT, GetString(_G[string.upper("RBI_MENU_TASK_" .. task.excludeRuleOf .. "_SUBMENU_NAME")]))
		return false
	end
	
	
	-- trying to find the moveCount of this item by an binary search like aproach
	-- starting at 1 moveCount going up 2, 4 ,8, 16 ... till a rule fails
	-- then taking the highest value which was still possible and going the values back
	-- now adding them (afterwards subtract them if rule failes) and so on 
	-- until moveCount is found when highest value for a matching rule 
	-- is just below the lowest value for the missmatching rule
	local valBinarySearch = 1
	totalMoveCount = valBinarySearch
	local valTrue = 0
	local valFalse = bakCountSourceBag + 1
	local directBinary = true -- this does not add the valBinarySearch to totalMoveCount but set it instead
	
	while (valTrue + 1 < valFalse) do		
		row.count[task.bagId] = bakCountSourceBag - totalMoveCount
		if(task.bagIdTo) then
			row.count[task.bagIdTo] = bakCountTargetBag + totalMoveCount
		end
	
		local result = Rule()
		
		-- excluded rule needs an offset
		row.count[task.bagId] = row.count[task.bagId] - 1
		if(task.bagIdTo) then
			row.count[task.bagIdTo] = row.count[task.bagIdTo] + 1
		end
		
		local otherResult = OtherRule()

		if ((not result) or otherResult) then -- included in other rule so excluded in this one, is false if excludeOtherRule is false
			valFalse = totalMoveCount
			-- setback to valTrue and divide valBinarySearch here too to be double divided
			
			if(directBinary) then
				totalMoveCount = valTrue
				valBinarySearch = math.floor(valBinarySearch / 2)
			else
				totalMoveCount = totalMoveCount - valBinarySearch
			end
			
			directBinary = false
		else
			valTrue = totalMoveCount
		end
		if(directBinary) then
			valBinarySearch = valBinarySearch * 2
			totalMoveCount = valBinarySearch
		else
			valBinarySearch = math.floor(valBinarySearch / 2)
			totalMoveCount = totalMoveCount + valBinarySearch
		end
	end
	
	-- reset row to backuped count values
	row.count[task.bagId] = bakCountSourceBag
	if(task.bagIdTo) then
		row.count[task.bagIdTo] = bakCountTargetBag
	end
	--d("item moves by " .. totalMoveCount + 1)
	return totalMoveCount + 1

end

function RbI.SplitMoveCountOnRows(lookup, bagCache, task, testrun)
	for index = #lookup, 1, -1 do
		local row = bagCache[lookup[index]]
		row.totalMoveCount = RbI.GetTotalMoveCount(row, task, testrun)
		if(row.totalMoveCount == false) then
			return false
		end
		if(row.totalMoveCount == 0) then
			row.moveCount = 0
			--d("item removed from lookup")
			table.remove(lookup, index)
		end
	end
	
	--if(not lookup[1]) then d("no items left in lookup") end
	
	local totalMoveCount = 0
	-- split totalMoveCount reasonable onto existing items from stack
	-- always start by checking for an exact stack matching the moveCount, 
	-- followed by a check of moving always the smallest stack possible
	while (lookup[1]) do
		local matchingIndex = nil
		
		-- check for direct match
		for index in pairs(lookup) do
			if(lookup[index] ~= nil and 
				bagCache[lookup[index]].count["STACK"] == bagCache[lookup[index]].totalMoveCount) then
				matchingIndex = index
				--d("matching index found")
			break
			end
		end
	
		-- fall back to smallest possible
		if(not matchingIndex) then
			for index in pairs(lookup) do
				if(lookup[index] ~= nil and (not matchingIndex or 
				  (bagCache[lookup[index]].count["STACK"]
				  < bagCache[lookup[matchingIndex]].count["STACK"]))) then
					matchingIndex = index
				end
			end
			--d("smallest count index taken")
		end
		
		-- set movecount of this rows item
		local row = bagCache[table.remove(lookup, matchingIndex)]
		-- set movecount to what is lowest, the stacksize or the maximum amount to move for this specific stack minus the already moved items
		-- as for eso all items of the same link/instanceId count towards the bag-count
		row.moveCount = math.min(row.count["STACK"], math.max(0, (row.totalMoveCount-totalMoveCount)))
		
		-- set a new count of all transfered items (row.moveCount is at least 0 as set above)
		totalMoveCount = totalMoveCount + row.moveCount
	end
	
	return true
end



local function ExecuteAction()
	
	local status, priority, bagId, slotIndex, taskName, stackCountChange, testflag, executionCounter = RbI.GetActionFromQueue()
	--if(testflag) then d("TEST TRUE") end
	if(not status) then 
		isExecuting = false
		local actionMessage 
		if(priority) then
			actionMessage = RBI_STATUS_ACTIONS_CANCELED
		else
			if(bagFullFlag) then
				actionMessage = RBI_STATUS_BAGFULL
			else
				actionMessage = RBI_STATUS_ACTIONS_FINISHED
			end
		end
		if(bagId) then --holds actionTask return showing if actions were from a task now finished
			RbI.ReportStatus(false, actionMessage)
			RbI.PrintSummary()
		end
		bagFullFlag = false
		return
	end
	
	local cacheId
	
	if(bagId == BAG_SUBSCRIBER_BANK) then
		cacheId = BAG_BANK
	else
		cacheId = bagId
	end
	
	local rowIndex = slotIndex
	if(bagId == BAG_BANK) then
		rowIndex = rowIndex + GetBagSize(bagId)
	end
	
	local bagCache, itemInstanceIdLookup, row, lookup
	if(bagId == BAG_VIRTUAL) then
		-- only for notification
		row = RbI.GetItemData(bagId, slotIndex)
	else
		-- only for other tasks
		bagCache, itemInstanceIdLookup = RbI.GetBagCache(cacheId)
		row = bagCache[rowIndex]
		lookup = itemInstanceIdLookup[row.instanceId]
	end
	
	local delay = 0
	
	--d("Executing prio" .. priority .. " (" .. tostring(stackCountChange) .. ") " .. tostring(taskName) .. " on " .. row.link .. row.bagId .. " / " .. row.slotIndex)
	
	if(priority == 1) then
		if(taskName == nil) then	
			local rowUpdate = RbI.GetItemData(row.bagId, row.slotIndex)
			
			if(row.link ~= "" or (stackCountChange and stackCountChange > 0)) then
				-- update for clearing slot will always be before new item enters the slot
				if(row.link ~= "" and (rowUpdate.link == "" or rowUpdate.link ~= row.link) and row.count["STACK"] + stackCountChange == 0) then
					--d("item moved away for " .. row.link .. " " .. rowUpdate.bagId .. " / " .. rowUpdate.slotIndex)
					row.count["STACK"] = row.count["STACK"] + stackCountChange
					row.count[cacheId] = row.count[cacheId] + stackCountChange -- cacheId is either backpack or bank otherwise crashes
					RbI.SetBagCacheSlot(cacheId, rowIndex, nil)
					-- updating counts of count in other bag impossible, as the event does not say where the stackCountChange went to
					RbI.UpdateItemCounts(cacheId, row)
				
				-- new item in slot or count update only without clearing the slot
				elseif(rowUpdate.link ~= "" and (row.link == "" or (row.count["STACK"] == rowUpdate.count["STACK"] + stackCountChange))) then
					--d("item added for " .. rowUpdate.link .. " " .. rowUpdate.bagId .. " / " .. rowUpdate.slotIndex)
					RbI.SetBagCacheSlot(cacheId, rowIndex, rowUpdate)
					RbI.UpdateItemCounts(cacheId, rowUpdate)
				else
					--d("row for " .. rowUpdate.link .. " seems to exist already")
				end
			else
				--d("empty slot stayes empty")
			end
		elseif(row.link ~= "") then
			for _, rowIndex in pairs(lookup) do
				RbI.AddActionToQueue(2, bagId, rowIndex, taskName)
			end
		end
	elseif(taskName == "Notify" and row.link ~= "") then
		RbI.environment.item = row
		-- catch error on execution of rule (compare with nil etc.)
		-- also check for testrun and take testrule
		local rule = RbI.tasks["Notify"].rule
		if(testflag) then 
			rule = RbI.tasks["Notify"].testRule
		end
		local outcome, result = pcall(rule)
		if(outcome) then
			if (result) then
				--d(tostring(stackCountChange))
				row.moveCount = stackCountChange or row.count["STACK"]
				RbI.Message(taskName, true, row)
			end
		else
			RbI.PrintRule(taskName)
			RbI.ReportStatus(true, RBI_STATUS_ERROR_RULECONTENT, GetString(_G[string.upper("RBI_MENU_TASK_" .. taskName .. "_SUBMENU_NAME")]))
			RbI.onUpdate = true
		end
	elseif(row.link ~= "") then
		local task = RbI.tasks[taskName]
		
		executionCounter = executionCounter + 1
	
		if(RbI.SplitMoveCountOnRows(lookup, bagCache, task, testflag)) then
			
			local moveCount = row.moveCount
			--d("moving " .. tostring(moveCount))
			
			local status, remainAction, output
			if(moveCount > 0) then
				if(priority < 3) then
					row.event = true
				else
					row.event = false
				end
				
				if(not testflag) then
					-- execute callback for this tasks action
					status, remainAction, output = task.callback(row, task.bagIdTo)
				else
					-- testrun "action successful" 
					status, remainAction, output = true, false, true
					row.moveCount = 0
				end
			end
			
			if(status) then
				if(not testflag) then
					if(taskName == "SellFence" or taskName == "SellStore") then
						tmpTaskName = "Sell"
					else
						tmpTaskName = taskName
					end
					delay = RbI.userSettings[tmpTaskName].delay
				end
			
				local moveCountBak = row.moveCount
				
				row.moveCount = moveCount-row.moveCount
				
				if(output) then
					RbI.SumAction(taskName, row.value, row.moveCount)
					RbI.Message(taskName, true, row, testflag)
				end
				
				row.moveCount = moveCountBak
			end
			
			if(remainAction) then
				if(executionCounter > 2) then
					bagFullFlag = true
					-- action is not executed and not again added to queue, thus aborted
				else
					-- place the action at the end of the queue, try all others first to check for stacking items on bagfull
					RbI.AddActionToQueue(priority, bagId, slotIndex, taskName, stackCountChange, testflag, executionCounter)
				end
			end 
			
			-- check if this in an interleavable task and try the other taskqueue then
			if(task.interleave and priority > 2 and (status or remainAction)) then
				RbI.SwitchActiveTaskQueue()
			end			
		else
		-- error in rule
		end
	
	else
		--d("row is empty")
	
	end

	zo_callLater(ExecuteAction, delay)
	
end
	
function RbI.StartExecution(...)
	if(isExecuting == false) then
		isExecuting = true
		RbI.asyncTask:Call(RbI.CreateBagCaches):Then(ExecuteAction)
	end
end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

