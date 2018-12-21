if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

local actionQueues = {}
actionQueues[1] = {} -- New Item Event
actionQueues[2] = {} -- Item Event
actionQueues[3] = {} -- Task Action
actionQueues[4] = {} -- Task Action Interleave

local activeFirstTaskQueue = true
local actionAbort = false
local actionTask = false

function RbI.SwitchActiveTaskQueue()
	if(activeFirstTaskQueue) then
		activeFirstTaskQueue = false
	else
		activeFirstTaskQueue = true
	end
end


function RbI.AddActionToQueue(priority, bagId, slotIndex, taskName, stackCountChange, testflag, executionCounter)
	
	--d("prio" .. priority .. " (" .. tostring(stackCountChange) .. ") action inserted in queue for " .. tostring(taskName) .. " " .. bagId .. "/" .. slotIndex)
	
	if(not executionCounter) then
		executionCounter = 0
	end
	if(priority > 2) then
		actionTask = true
	end
	table.insert(actionQueues[priority], {bagId, slotIndex, taskName, stackCountChange, testflag, executionCounter})
	
end

function RbI.RemoveActionsForTask()
	if(#actionQueues[3] > 0 or #actionQueues[4] > 0) then
		actionAbort = true
	end
	actionQueues[3] = {}
	actionQueues[4] = {}
end
	

function RbI.GetActionFromQueue()
	
	if(#actionQueues[1] > 0) then
		--d("Prio 1 action taken from queue")
		return true, 1, unpack(table.remove(actionQueues[1], 1))
	end
	
	if(#actionQueues[2] > 0) then
		--d("Prio2 action taken from queue")
		return true, 2, unpack(table.remove(actionQueues[2], 1))
	end
	
	-- start new task from taskQueue if no taskActions are up
	if(#actionQueues[3] == 0 and #actionQueues[4] == 0) then
		RbI.StartTask()
	end
	
	if(#actionQueues[3] > 0) then
		if(activeFirstTaskQueue or #actionQueues[4] == 0) then
			if(#actionQueues[4] == 0) then
				RbI.SwitchActiveTaskQueue()
			end
			--d("Prio 3 action taken from queue")
			return true, 3, unpack(table.remove(actionQueues[3], 1))
		end
	end
		
	if(#actionQueues[4] > 0) then
		if(not activeFirstTaskQueue or #actionQueues[3] == 0) then
			if(#actionQueues[3] == 0) then
				RbI.SwitchActiveTaskQueue()
			end
			--d("Prio 4 action taken from queue")
			return true, 4, unpack(table.remove(actionQueues[4], 1))
		end
	end

	local abort = actionAbort
	actionAbort = false
	local task = actionTask
	actionTask = false
	RbI.ClearBagCache()
	return false, abort, task -- queue is empty
	
end