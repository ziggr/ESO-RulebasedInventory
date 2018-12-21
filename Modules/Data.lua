if not RulebasedInventory then RulebasedInventory = {} end
local RbI = RulebasedInventory

-- Default Addon SavedVariables
RbI.default = {
	 userSettings = {
		 ["General"] = {
			 ["output"] = true
			,["printCompiledRule"] = false
			,["summary"] = true
			,["contextMenu"] = false
			,["useFCOIS"] = false
			,["profile"] = ""
			,["taskStartMessage"] = false
		}
		,["Junk"] = {
			 ["rulestring"] = ""
			,["output"] = true
			,["summary"] = false
			,["delay"] = 300
			,["timeout"] = 0
		}
		,["UnJunk"] = {
			 ["output"] = false
			,["summary"] = false
			,["delay"] = 200
			,["timeout"] = 0
		}
		,["BagToBank"] = {
			 ["rulestring"] = ""
			,["output"] = true
			,["summary"] = false
			,["delay"] = 300
			,["timeout"] = 1000
			,["excludeOtherRule"] = false
		}
		,["BankToBag"] = {
			 ["rulestring"] = ""
			,["output"] = true
			,["summary"] = false
			,["delay"] = 300
			,["timeout"] = 1000
			,["excludeOtherRule"] = false
		}
		,["Sell"] = {
			 ["rulestring"] = ""
			,["output"] = true
			,["summary"] = true
			,["delay"] = 300
			,["safeRule"] = true
			,["timeout"] = 100
		}
		,["Launder"] = {
			 ["rulestring"] = ""
			,["output"] = true
			,["summary"] = true
			,["delay"] = 300
			,["safeRule"] = false
			,["timeout"] = 100
		}
		,["Destroy"] = {
			 ["rulestring"] = ""
			,["output"] = true
			,["summary"] = false
			,["delay"] = 300
			,["treshold"] = true
			,["thresholdcount"] = 5
			,["safeRule"] = true
			,["timeout"] = 100
		}
		,["Notify"] = {
			 ["rulestring"] = ""
			,["output"] = true
			,["summary"] = false
			,["delay"] = 0
			,["timeout"] = 0
		}		
		,["Deconstruct"] = {
			 ["rulestring"] = ""
			,["output"] = true
			,["summary"] = false
			,["delay"] = 1500
			,["safeRule"] = true
			,["timeout"] = 500
		}
	}
	,profiles = {}
}

RbI.testrulestrings = {}
RbI.testprofile = nil
RbI.newprofile = ""

-- data for all kind of tasks executable
-- baseRulestring here will be appended to every user-rule for a specific task (written in key)
-- safeRulestring is used if option was enabled to keep valuable stuff from being handled
-- in "rulestring" and "testRulestring" the combined, enriched rulestring is stored for saved rule and test rule
-- in "rule" and "testRule" the compiled rules will be stored
-- this for example keeps stolen, characterbound, or unique items (which are also present in bank) from being pushed to the bank 
RbI.tasks = {
	 ["Junk"] = {
		 ["name"] = "Junk"
		,["baseRulestring"] = "not (JUNKED)"
		,["safeRulestring"] = ""
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = nil
		,["callback"] = RbI.Junk
		,["interleave"] = false
		,["menu"] = true
		,["menuRun"] = true
		,["menuOutput"] = true
		,["menuSummary"] = false
		,["menuThreshold"] = false
		,["menuTimeout"] = false
		,["menuDelay"] = true
		,["menuSaveRule"] = false
		,["menuExcludeOtherRule"] = false
	}
	,["UnJunk"] = {
		 ["name"] = "UnJunk"
		,["baseRulestring"] = "(JUNKED)"
		,["safeRulestring"] = ""
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = nil
		,["callback"] = RbI.UnJunk
		,["interleave"] = false
		,["menu"] = false
		,["menuRun"] = false
		,["menuOutput"] = false
		,["menuSummary"] = false
		,["menuThreshold"] = false
		,["menuTimeout"] = false
		,["menuDelay"] = false
		,["menuSaveRule"] = false
		,["menuExcludeOtherRule"] = false
	}
	,["BagToBank"] = {
		 ["name"] = "BagToBank"
		,["baseRulestring"] = "not (STOLEN or (characterbound) or (UNIQUE and countbank > 0) or (CONTAINER))"
		,["safeRulestring"] = ""
		,["excludeRuleOf"] = "BankToBag"
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = BAG_BANK
		,["callback"] = RbI.MoveItem
		,["interleave"] = true
		,["menu"] = true
		,["menuRun"] = false
		,["menuOutput"] = true
		,["menuSummary"] = false
		,["menuThreshold"] = false
		,["menuTimeout"] = true
		,["menuDelay"] = true
		,["menuSaveRule"] = false
		,["menuExcludeOtherRule"] = true
	}
	,["BankToBag"] = {
		 ["name"] = "BankToBag"
		,["baseRulestring"] = "not (UNIQUE and countbackpack > 0)"
		,["safeRulestring"] = ""
		,["excludeRuleOf"] = "BagToBank"
		,["bagId"] = BAG_BANK
		,["bagIdTo"] = BAG_BACKPACK
		,["callback"] = RbI.MoveItem
		,["interleave"] = true
		,["menu"] = true
		,["menuRun"] = false
		,["menuOutput"] = true
		,["menuSummary"] = false
		,["menuThreshold"] = false
		,["menuTimeout"] = true
		,["menuDelay"] = true
		,["menuSaveRule"] = false
		,["menuExcludeOtherRule"] = true
	}
	,["SellStore"] = {
		 ["name"] = "SellStore"
		,["baseRulestring"] = "not STOLEN"
		,["safeRulestring"] = "not ( (legendary) or (weapon_nirnhoned) or (armor_nirnhoned) or mmvalue > 10000 or ttcvalueavg > 10000 )"
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = nil
		,["callback"] = RbI.SellItem
		,["interleave"] = false
		,["menu"] = true
		,["menuRun"] = false
		,["menuOutput"] = true
		,["menuSummary"] = true
		,["menuThreshold"] = false
		,["menuTimeout"] = true
		,["menuDelay"] = true
		,["menuSaveRule"] = true
		,["menuExcludeOtherRule"] = false
	}
	,["SellFence"] = {
		 ["name"] = "SellFence"
		,["baseRulestring"] = "STOLEN"
		,["safeRulestring"] = "not ( (legendary) or (weapon_nirnhoned) or (armor_nirnhoned) or mmvalue > 10000 or ttcvalueavg > 10000 )"
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = nil
		,["callback"] = RbI.SellItem
		,["interleave"] = false
		,["menu"] = false
		,["menuRun"] = false
		,["menuOutput"] = false
		,["menuSummary"] = false
		,["menuThreshold"] = false
		,["menuTimeout"] = false
		,["menuDelay"] = false
		,["menuSaveRule"] = false
		,["menuExcludeOtherRule"] = false
	}
	,["Launder"] = {
		 ["name"] = "Launder"
		,["baseRulestring"] = "STOLEN"
		,["safeRulestring"] = ""
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = nil
		,["callback"] = RbI.LaunderItem
		,["interleave"] = false
		,["menu"] = true
		,["menuRun"] = false
		,["menuOutput"] = true
		,["menuSummary"] = true
		,["menuThreshold"] = false
		,["menuTimeout"] = true
		,["menuDelay"] = true
		,["menuSaveRule"] = false
		,["menuExcludeOtherRule"] = false
	}
	,["Destroy"] = {
		 ["name"] = "Destroy"
		,["baseRulestring"] = ""
		,["safeRulestring"] = "not ( (legendary) or (weapon_nirnhoned) or (armor_nirnhoned) or mmvalue > 10000 or ttcvalueavg > 10000 )"
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = nil
		,["callback"] = RbI.DestroyItem
		,["interleave"] = false
		,["menu"] = true
		,["menuRun"] = false
		,["menuOutput"] = true
		,["menuSummary"] = false
		,["menuThreshold"] = true
		,["menuTimeout"] = false
		,["menuDelay"] = true
		,["menuSaveRule"] = true
		,["menuExcludeOtherRule"] = false
	}
	,["Notify"] = {
		 ["name"] = "Notify"
		,["baseRulestring"] = ""
		,["safeRulestring"] = ""
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = nil
		,["callback"] = RbI.Notify
		,["interleave"] = false
		,["threshold"] = true
		,["menu"] = true
		,["menuRun"] = false
		,["menuOutput"] = false
		,["menuSummary"] = false
		,["menuThreshold"] = false
		,["menuTimeout"] = false
		,["menuDelay"] = false
		,["menuSaveRule"] = false
		,["menuExcludeOtherRule"] = false
	}
	,["Deconstruct"] = {
		 ["name"] = "Deconstruct"
		,["baseRulestring"] = ""
							.. "((craftstationtype == CRAFTING_TYPE_BLACKSMITHING or craftstationtype == nil) and (item_blacksmithing)) "
							.. "or ((craftstationtype == CRAFTING_TYPE_CLOTHIER or craftstationtype == nil) and (item_clothier)) "
							.. "or ((craftstationtype == CRAFTING_TYPE_WOODWORKING or craftstationtype == nil) and (item_woodworking)) "
							.. "or ((craftstationtype == CRAFTING_TYPE_JEWELRYCRAFTING or craftstationtype == nil) and (item_jewelry))"
							.. "or ((craftstationtype == CRAFTING_TYPE_ENCHANTING or craftstationtype == nil) and (item_enchanting)) "
		,["safeRulestring"] = "not ( (legendary) or (weapon_nirnhoned) or (armor_nirnhoned) or mmvalue > 10000 or ttcvalueavg > 10000 )"
		,["bagId"] = BAG_BACKPACK
		,["bagIdTo"] = nil
		,["callback"] = RbI.DeconstructItem
		,["interleave"] = false
		,["threshold"] = false
		,["menu"] = true
		,["menuRun"] = false
		,["menuOutput"] = true
		,["menuSummary"] = false
		,["menuThreshold"] = false
		,["menuTimeout"] = true
		,["menuDelay"] = true
		,["menuMinDelay"] = 1000
		,["menuMaxDelay"] = 3000
		,["menuSaveRule"] = true
	}
}

-- the environment to execute rules in. "item" is set just before execution
local environment = {}
	-- allow ESOConstants to be used directly, but no other functions
	setmetatable(environment, {__index = RbI.esoConstantEnvironment}) 
	environment.match = string.match
	environment.lower = string.lower
	environment.learnlist = function(...) return RbI.IsIncludedInList(true, environment.item.isLearnableBy, ...) end
	environment.learn = function(...) return RbI.IsIncludedInList(false, environment.item.isLearnableBy, ...) end
	environment.researchlist = function(...) return RbI.IsIncludedInList(true, environment.item.isResearchableBy, ...) end
	environment.research = function(...) return RbI.IsIncludedInList(false, environment.item.isResearchableBy, ...) end
	environment.autocategory = function(...) return RbI.IsIncludedInList(false, {environment.item.autoCategory}, ...) end
	environment.threshold = function() 
								local _, instanceIdLookup = RbI.GetBagCache(BAG_BACKPACK)
								return RbI.userSettings["Destroy"].threshold and RbI.userSettings["Destroy"].thresholdcount >= #instanceIdLookup[""] 
							end
	environment.itemname = function(...) return RbI.NameMatches(false, {environment.item.name}, ...) end
	environment.itemnamematch = function(...) return RbI.NameMatches(true, {environment.item.name}, ...) end
	environment.creatorname = function(...) return RbI.NameMatches(false, {environment.item.creator}, ...) end
	environment.creatornamematch = function(...) return RbI.NameMatches(true, {environment.item.creator}, ...) end
	environment.reagenttrait = function(...) return RbI.NameMatches(false, environment.item.reagentTraits, ...) end
	environment.reagenttraitmatch = function(...) return RbI.NameMatches(true, environment.item.reagentTraits, ...) end
	environment.itemtag = function(...) return RbI.NameMatches(false, environment.item.tags, ...) end
	environment.itemtagmatch = function(...) return RbI.NameMatches(true, environment.item.tags, ...) end
	environment.fcoismarker = function(...) return RbI.NameMatches(false, environment.item.fcoisMarker, ...) end
	environment.fcoismarkermatch = function(...) return RbI.NameMatches(true, environment.item.fcoisMarker, ...) end
	
RbI.environment = environment

-- the following three tables are key-value-pairs for string juggling,
--	bringing a simplified rulestring as given by user back to life - to LUAif one might say.

-- first enrich any item-data object to it's lua-usable table entry
-- a user might input "ARMORTYPE = HEAVY", then "ARMORTYPE" becomes "item.ARMORTYPE" 
-- to be used in the boolean term when matching an item with this rule
RbI.enrichRuleBasedata = {	
	 ["armortype"] = "item.armorType"
	,["bindtype"] = "item.bindType"
	,["bound"] = "item.bound"
	,["cp"] = "item.cp"
	,["countbackpack"] = "item.count[backpack]"
	,["countbank"] = "item.count[bank]"
	,["countcraftbag"] = "item.count[craftbag]"
	,["countstack"] = "item.count[\"STACK\"]"
	,["countmax"] = "item.count[\"MAX\"]"
	,["crowncrate"] = "item.crownCrate"
	,["crownstore"] = "item.crownStore"
	,["crafted"] = "item.crafted"
	,["equiptype"] = "item.equipType"
	,["glyphmincp"] = "item.glyphMinCP"
	,["glyphminlvl"] = "item.glyphMinLvl"
	,["icon"] = "item.icon"
	,["instanceid"] = "item.instanceId"
	,["type"] = "item.type"
	,["junked"] = "item.junked"
	,["level"] = "item.level"
	,["locked"] = "item.locked"
	,["name"] = "item.name"
	,["quality"] = "item.quality"
	,["recipeknown"] = "item.recipeKnown"
	,["set"] = "item.set"
	,["setname"] = "item.setName"
	,["sType"] = "item.sType"
	,["soulgemtype"] = "item.soulGemType"
	,["stackable"] = "item.stackable"
	,["stolen"] = "item.stolen"
	,["style"] = "item.style"
	,["trait"] = "item.trait"
	,["traitinfo"] = "item.traitInfo"
	,["unique"] = "item.unique"
	,["value"] = "item.value"
	,["weapontype"] = "item.weaponType"
	,["isresearchableby"] = "item.isResearchableBy"
	,["islearnableby"] = "item.isLearnableBy"
	,["vouchers"] = "item.vouchers"
	,["creator"] = "item.creator"
	
	
	,["mmvalue"] = "item.mmValue"
	,["mmsalescount"] = "item.mmSalesCount"
	,["mmdays"] = "item.mmDays"
	,["mmsoldcount"] = "item.mmSoldCount"
	,["mmcraftcost"] = "item.mmCraftCost"
	
	,["wwmatcost"] = "item.wwMatCost"
	,["wwmatcostpervoucher"] = "item.wwMatCostPerVoucher"

	,["ttcvaluemin"] = "item.ttcValueMin"
	,["ttcoffercount"] = "item.ttcOfferCount"
	,["ttcitemcount"] = "item.ttcItemCount"
	,["ttcvaluesuggestion"] = "item.ttcValueSuggestion"
	,["ttcvalueavg"] = "item.ttcValueAvg"
	,["ttcvaluemax"] = "item.ttcValueMax"
	
	,["fcoisismarked"] = "item.fcoisIsMarked"
	,["protectjunk"] = "item.protected[\"Junk\"]"
	,["protectsell"] = "item.protected[\"SellStore\"]"
	,["protectfence"] = "item.protected[\"SellFence\"]"
	,["protectlaunder"] = "item.protected[\"Launder\"]"
	,["protectdestroy"] = "item.protected[\"Destroy\"]"
	,["protectdeconstruct"] = "item.protected[\"Deconstruct\"]"
}	


-- enrich when user used generic names (need to be ordered to be sequential substituted)
RbI.genericFunctions = {}
RbI.genericFunctions[1] = {"(traited)", "(((armortrait) or (jewelrytrait) or (weapontrait)) and not (equip_none))"}
RbI.genericFunctions[2] = {"(material)", "((material_raw) or (material_refined))"}
RbI.genericFunctions[3] = {"(material_raw)", "((material_raw_blacksmithing) or (material_raw_clothier) or (material_raw_woodworking) or (material_raw_jewelry) or (material_raw_trait) or (material_raw_style) or (material_raw_booster))"}
RbI.genericFunctions[4] = {"(material_refined)", "((material_refined_blacksmithing) or (material_refined_clothier) or (material_refined_woodworking) or (material_refined_jewelry) or (material_refined_trait) or (material_refined_style) or (material_refined_booster) or (material_furnishing) or (material_alchemy) or (material_enchantment) or (ingredient))"}
RbI.genericFunctions[5] = {"(material_booster)", "((material_raw_booster) or (material_refined_booster))"}
RbI.genericFunctions[6] = {"(material_raw_booster)", "((booster_raw_jewelry))"}
RbI.genericFunctions[7] = {"(material_refined_booster)", "((booster_blacksmithing) or (booster_clothier) or (booster_woodworking) or (booster_refined_jewelry))"}
RbI.genericFunctions[8] = {"(material_trait)", "((material_raw_trait) or (material_refined_trait))"}
RbI.genericFunctions[9] = {"(material_raw_trait)", "((material_raw_jewelrytrait))"}
RbI.genericFunctions[10] = {"(material_refined_trait)", "((material_armortrait) or (material_weapontrait) or (material_refined_jewelrytrait))"}
RbI.genericFunctions[11] = {"(material_enchantment)", "((aspect) or (essence) or (potency))"}
RbI.genericFunctions[12] = {"(material_style)", "((material_refined_style) or (material_raw_style))"}
RbI.genericFunctions[13] = {"(material_alchemy)", "((reagent) or (potion_base) or (poison_base))"}
RbI.genericFunctions[14] = {"(material_blacksmithing)", "((material_raw_blacksmithing) or (material_refined_blacksmithing) or (booster_blacksmithing))"}
RbI.genericFunctions[15] = {"(material_clothier)", "((material_raw_clothier) or (material_refined_clothier) or (booster_clothier))"}
RbI.genericFunctions[16] = {"(material_woodworking)", "((material_raw_woodworking) or (material_refined_woodworking) or (booster_woodworking))"}
RbI.genericFunctions[17] = {"(material_jewelry)", "((material_raw_jewelry) or (material_refined_jewelry) or (booster_refined_jewelry))"}
RbI.genericFunctions[18] = {"(material_jewelrytrait)", "((material_raw_jewelrytrait) or (material_refined_jewelrytrait))"}
RbI.genericFunctions[19] = {"(threshold)", "((threshold()))"} --only for destroy atm
RbI.genericFunctions[20] = {"(item_blacksmithing)", "((weapon_blacksmithing) or (armor_blacksmithing))"}
RbI.genericFunctions[21] = {"(weapon_blacksmithing)", "((axe) or (dagger) or (mace) or (sword) or (battleaxe) or (maul) or (greatsword))"}
RbI.genericFunctions[22] = {"(armor_blacksmithing)", "((armor_heavy))"}
RbI.genericFunctions[23] = {"(item_woodworking)", "((weapon_woodworking))"}
RbI.genericFunctions[24] = {"(weapon_woodworking)", "((bow) or (firestaff) or (froststaff) or (healingstaff) or (lightningstaff) or (shield))"}
RbI.genericFunctions[25] = {"(item_clothier)", "((armor_clothier))"}
RbI.genericFunctions[26] = {"(armor_clothier)", "((armor_light) or (armor_medium))"}
RbI.genericFunctions[27] = {"(item_jewelry)", "((equip_ring) or (equip_neck))"}
RbI.genericFunctions[28] = {"(item_enchanting)", "((glyph_armor) or (glyph_weapon) or (glyph_jewelry))"}
