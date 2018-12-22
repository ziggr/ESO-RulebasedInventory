dofile("data/RulebasedInventory.lua")


function warn(msg,...) print(string.format(msg,...)) end
function info(msg,...) print(string.format(msg,...)) end
function entab(s) return string.gsub(s,"\n","\n         ") end

char = {}
to_bank_ct = {}

master_to_bank = nil

chariable_z = charVars["Default"]["@ziggr"]
for k,t in pairs(chariable_z) do
    char_name = t["$LastCharacterName"]
    u         = t["userSettings"]
    to_bank   = u["BagToBank"]["rulestring"]
    to_bag    = u["BankToBag"]["rulestring"]
    if not u["BagToBank"]["excludeOtherRule"] then
        warn( "-> bank.exclude: %s (want true)\t%s"
            , tostring(u["BagToBank"]["excludeOtherRule"])
            , char_name
            )
    end
    if u["BankToBag"]["excludeOtherRule"] then
        warn( "-> bag.exclude: %s (want false)\t%s"
            , tostring(u["BankToBag"]["excludeOtherRule"])
            , char_name
            )
    end

                        -- Require all to_bank strings to match, except for
                        -- Zecorwyn, whose master writ handling requires a dip
                        -- into Baetram's  FCOItemSaver.
    if char_name ~= "Zecorwyn" then
        if not master_to_bank then master_to_bank = to_bank end
        if to_bank ~= master_to_bank then
            warn("-> bank != master: %s", char_name)
        end
    end

    char[char_name] = { to_bag  = to_bag
                      , to_bank = to_bank
                      }

    to_bank_ct[to_bank] = (to_bank_ct[to_bank] or 0) + 1
end

keys = {}
for k,_ in pairs(char) do table.insert(keys,k) end
table.sort(keys)

for _,char_name in ipairs(keys) do
    t = char[char_name]
    info("char   : %s", char_name)
    info("to_bank: %s", entab(t.to_bank))
    info("to_bag : %s", entab(t.to_bag ))
    info("")
end

-- for k,ct in pairs(to_bank_ct) do
--     info("ct     : %d", ct)
--     info("to_bank: %s", entab(k))
--     info("")
-- end
