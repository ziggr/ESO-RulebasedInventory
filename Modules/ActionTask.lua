if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

local taskQueue = {}
local activeTask = {}

local function TaskNamesNotInQueue(newTaskNames)

	if(activeTask[1] == newTaskNames[1] 
		and (activeTask[2] == newTaskNames[2] or (activeTask[2] == nil and newTaskNames[2] == nil))) then
		return false
	end

	for _, queuerow in pairs(taskQueue) do
		local taskNames = queuerow[2]
		if(taskNames[1] == newTaskNames[1]
		and (taskNames[2] == newTaskNames[2] or (taskNames[2] == nil and newTaskNames[2] == nil))) then
			--d("Task " .. tostring(taskNames[1]) .. "/" .. tostring(taskNames[2]) .. " already in queue")
			return false
		end
	end

	return true	
end

function RbI.AddTaskToQueue(testrun, ...)
	local taskNames = {...}
	if(TaskNamesNotInQueue(taskNames)) then
		table.insert(taskQueue, {testrun, taskNames})
		--d("insert task " .. tostring(taskNames[1]) .. " " .. tostring(taskNames[2]))
		RbI.StartExecution(...)
	end
end

local function GetTaskFromQueue()
	if(#taskQueue > 0) then
		local queuerow = table.remove(taskQueue, 1)
		activeTask = {queuerow[2], queuerow[3]}
		return true, unpack(queuerow)
	else
		activeTask = {}
		return false
	end
end


-- executes an task batch or adds it to the queue
-- parallel only when noted in same call and interleave is true for both 
-- otherwise the non-interleave task will be executed completed first (after at most one action of the other)
-- ExecuteTask is called with the next item of the taskQueue by ExecuteActionStacks when it has finished the current actionStack,
-- this way currenActionStack is nil and the task is not again queued but executed right away
-- interleaveable tasks may be called together in one batch, but not non-interleavables as this could affect the outcome
-- as the actionStack does not update after it was build, the bagCache however may update with ever action taken
function RbI.StartTask()

	local status, testflag, taskNames = GetTaskFromQueue()
	
	if(status) then
		--d("task " .. tostring(taskNames[1]) .. " " .. tostring(taskNames[2]))
		--if(testflag) then d("this is a testrun") end
		local priority = 3
		for _, taskName in pairs(taskNames) do
			local task = RbI.tasks[taskName]
			--d("for task " .. taskName)
			-- abort preparation if not at needed place (bank, craftstation,...)
			-- do not abort if testrun, junk, unjunk or destroy, because these are possible everywhere
			if(testflag or taskName == "Destroy" or taskName == "Junk" or taskName == "UnJunk" 
				or (((taskName == "BagToBank" or taskName == "BankToBag") and RbI.atBank)
					or ((taskName == "SellStore") and RbI.atStore)
					or ((taskName == "SellFence" or taskName == "Launder") and RbI.atFence)
					or ((taskName == "Deconstruct") and RbI.craftStationType ~= nil))) then
				
				--d("correct environment for " .. taskName)
				
				-- abort preparation if no rule exists for this task
				if(task.rulestring ~= "false" or testflag) then
					
					--d("rule existing for " .. taskName)
					
					local bagCache = RbI.GetBagCache(task.bagId)
				
					local message = false
				
					for _, row in pairs(bagCache) do
						if(row.link ~= "") then
							RbI.AddActionToQueue(priority, row.bagId, row.slotIndex, taskName, nil, testflag)
							message = true
						end
					end		

					if(message and RbI.userSettings["General"].taskStartMessage) then
						RbI.ReportStatus(false, RBI_STATUS_START_TASK, GetString(_G[string.upper("RBI_MENU_TASK_" .. taskName .. "_SUBMENU_NAME")]))
					end
				end
			end
			priority = priority + 1
		end
	else
		--d("no tasks")
	end
end