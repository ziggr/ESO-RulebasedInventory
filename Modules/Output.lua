if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

local printName = "[" .. RbI.name .. "]: "
local printShortName = "[RbI]: "

local name = printShortName

local messages = {}
messages.Junk = name .. "<<6>> <<C:1>> <<2>>x <<3>>."
messages.BagToBank = name .. "<<6>> <<C:1>> <<2>>x <<3>> <<5>>."
messages.BankToBag = name .. "<<6>> <<C:1>> <<2>>x <<3>> <<5>>."
messages.SellStore = name .. "<<6>> <<C:1>> <<2>>x <<3>> for <<4>>."
messages.SellFence = name .. "<<6>> <<C:1>> <<2>>x <<3>> for <<4>>."
messages.Launder = name .. "<<6>> <<C:1>> <<2>>x <<3>> for <<4>>."
messages.Destroy = name .. "<<6>> <<C:1>> <<2>>x <<3>>."
messages.Notify = name .. "<<6>> <<C:1>> <<2>>x <<3>> <<5>>."
messages.Deconstruct = name .. "<<6>> <<C:1>> <<3>>."

messages.Summary = name .. "<<C:1>> <<2>> items for <<4>>."

messages.ReportStatus ="<<1>>" .. name .. "<<2>>" .. "<<3>>"

RbI.actionSummary = {}

function RbI.SumAction(taskName, value, count)
	if(not RbI.actionSummary[taskName]) then
		RbI.actionSummary[taskName] = {}
	end
	RbI.actionSummary[taskName].value = (RbI.actionSummary[taskName].value or 0) + (value * count)
	RbI.actionSummary[taskName].count = (RbI.actionSummary[taskName].count or 0) + count
end

function RbI.PrintSummary()
	for name, data in pairs(RbI.actionSummary) do
		local taskName = name
		if(taskName == "SellStore" or taskName == "SellFence") then
			taskName = "Sell"
		end
		if(RbI.userSettings["General"].summary and RbI.userSettings[taskName].summary) then
			
			RbI.Message("Summary", true, {["taskName"] = name, ["moveCount"] = data.count, ["value"] = data.value})
			
		end
	end
	RbI.actionSummary = {}
end


-- status is unused atm, must never be false
function RbI.Message(taskName, status, item, testrun)

	if(status) then
		status="success"
	else
		status="failure"
	end
	
	if(testrun) then
		testrun = GetString(RBI_STATUS_TASKTESTRUN)
	else
		testrun = ""
	end
	local messageTaskName = taskName
	local userTaskName = taskName
	local option = "output"
	local value = item.value
	
	if(taskName == "Summary") then
		userTaskName = item.taskName
		taskName = item.taskName
		option = "summary"
	else
		value = value * item.moveCount
	end
	
	if(userTaskName == "SellStore" or userTaskName == "SellFence") then
		userTaskName = "Sell"
	end
	
	if((RbI.userSettings["General"][option] 
		and RbI.userSettings[userTaskName][option]) 
		or testrun ~= "") then

		local itemdata = ""
		local fontsize = CHAT_SYSTEM.GetFontSizeFromSetting()
		if(item.link ~= nil) then
			-- show vouchers on all messages which are designed to show additional data
			if(item.vouchers > 0) then
				if(itemdata ~= "") then
					itemdata = itemdata ..", "
				end
				itemdata = itemdata .. ZO_Currency_FormatPlatform(CURT_WRIT_VOUCHERS, item.vouchers, ZO_CURRENCY_FORMAT_AMOUNT_ICON)
			end
					
			if item.count[BAG_VIRTUAL] > 0 then
				if(itemdata ~= "") then
					itemdata = itemdata ..", "
				end
				itemdata = itemdata .. item.count[BAG_VIRTUAL] .. zo_iconTextFormat("EsoUI/Art/Tooltips/icon_craft_bag.dds", fontsize, fontsize)
			end
			if item.count[BAG_BANK] > 0 then
				if(itemdata ~= "") then
					itemdata = itemdata ..", "
				end
				itemdata = itemdata .. item.count[BAG_BANK] .. zo_iconTextFormat("EsoUI/Art/Tooltips/icon_bank.dds", fontsize, fontsize)
			end
			if item.count[BAG_BACKPACK] > 0 then
				if(itemdata ~= "") then
					itemdata = itemdata ..", "
				end
				itemdata = itemdata .. item.count[BAG_BACKPACK] .. zo_iconTextFormat("EsoUI/Art/Tooltips/icon_bag.dds", fontsize, fontsize)
			end
			
			if(item.traitInfo == ITEM_TRAIT_INFORMATION_ORNATE) then
				if(itemdata ~= "") then
					itemdata = itemdata ..", "
				end
				itemdata = itemdata .. zo_iconTextFormat("EsoUI/Art/Inventory/inventory_trait_ornate_icon.dds", fontsize+2, fontsize+2)
			elseif(item.traitInfo == ITEM_TRAIT_INFORMATION_INTRICATE) then
				if(itemdata ~= "") then
					itemdata = itemdata ..", "
				end
				itemdata = itemdata .. zo_iconTextFormat("EsoUI/Art/Inventory/inventory_trait_intricate_icon.dds", fontsize+2, fontsize+2)
			end
			
			-- show extendet data only on notify message
			if(taskName == "Notify") then
				if(item.mmValue > 0) then
					if(itemdata ~= "") then
						itemdata = itemdata ..", "
					end
					itemdata = itemdata .. "MM " .. ZO_Currency_FormatPlatform(CURT_MONEY, item.mmValue, ZO_CURRENCY_FORMAT_AMOUNT_ICON)
				end
				if(item.ttcValueAvg > 0) then
					if(itemdata ~= "") then
						itemdata = itemdata ..", "
					end
					itemdata = itemdata .. "TTC " .. ZO_Currency_FormatPlatform(CURT_MONEY, item.ttcValueAvg, ZO_CURRENCY_FORMAT_AMOUNT_ICON)
				end
			end
			
			if(itemdata ~= "") then
				itemdata = "(" .. itemdata ..")"
			end

		end
		
		CHAT_SYSTEM:AddMessage(
			zo_strformat(
				 messages[messageTaskName]
				,GetString(_G[string.upper("RBI_TASK_" .. taskName .. "_" .. status)])
				,item.moveCount
				,item.link
				,ZO_Currency_FormatPlatform(CURT_MONEY, value, ZO_CURRENCY_FORMAT_AMOUNT_ICON)
				,itemdata
				,testrun
			)
		)
	
	end
end

function RbI.ReportStatus(isError, stringId, stringdata)
	
	local errorcolor = ""
	
	if(stringdata == nil) then
		stringdata = ""
	else
		stringdata = " " .. stringdata
	end
		
	if(isError) then
		errorcolor = "|cFF0000"
		stringdata = stringdata .. "!|r"
	else
		stringdata = stringdata .. "."
	end

	CHAT_SYSTEM:AddMessage(
		zo_strformat(
			messages.ReportStatus
			,errorcolor
			,GetString(stringId)
			,stringdata
		)
	)
end





