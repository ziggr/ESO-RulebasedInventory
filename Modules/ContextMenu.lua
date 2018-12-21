if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

function RbI.InventorySlot_ShowContextMenu(rowControl)
    zo_callLater(function ()
		AddCustomMenuItem(GetString(RBI_CONTEXTMENU_NAME), function ()
			local bagId, slotIndex = ZO_Inventory_GetBagAndIndex(rowControl)
			local item = RbI.GetItemData(bagId, slotIndex)
			d("------------ITEMDATA--------------")
            for index, data in RbI.spairs(item) do
				local printstring = ""
				
				if(RbI.enrichRuleESOConstantdata[index]) then
					for key, constant in pairs(RbI.enrichRuleESOConstantdata[index]) do
						if(data == RbI.esoConstantEnvironment[constant]) then						
							printstring = key
							break
						end
					end
				end
				
				if(printstring == "") then
					if(type(data) ~= "table") then
						d(index .. ": " .. tostring(data))
					else
						d(index .. ":")
						d(data)
					end
				else
					printstring = index .. ": " .. printstring
					d(printstring)
				end
				
			end
			d("----------ITEMDATA-END------------")
        end, MENU_ADD_OPTION_LABEL)
        ShowMenu()
    end, 50)
end
function RbI.InitializeContextMenu()
	if(RbI.userSettings["General"].contextMenu) then
		ZO_PreHook('ZO_InventorySlot_ShowContextMenu', function (rowControl) RbI.InventorySlot_ShowContextMenu(rowControl) end)
	end
end