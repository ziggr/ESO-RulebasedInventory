charVars =
{
    ["Default"] = 
    {
        ["@ziggr"] = 
        {
            ["8796093039416989"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "(ingredient)\nOR (recipe_fragment)",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((soulgem) and (normal))\n",
                        ["output"] = true,
                        ["excludeOtherRule"] = true,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Destroy"] = 
                    {
                        ["rulestring"] = "",
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["summary"] = true,
                        ["useFCOIS"] = false,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Hagnar",
                    },
                },
                ["$LastCharacterName"] = "Hagnar the Slender",
                ["version"] = 1,
            },
            ["8796093027198257"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 300,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["rulestring"] = "((masterwrit) AND (wwMatCostPerVoucher < 300))",
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["Destroy"] = 
                    {
                        ["thresholdcount"] = 5,
                        ["output"] = true,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["rulestring"] = "",
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 300,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((soulgem) AND (normal))\nOR ((masterwrit) AND (NOT(fcoisismarked)))",
                        ["excludeOtherRule"] = true,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["useFCOIS"] = false,
                        ["summary"] = true,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Zecorwyn",
                    },
                },
                ["$LastCharacterName"] = "Zecorwyn",
                ["version"] = 1,
            },
            ["8796093022722147"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 800,
                        ["delay"] = 300,
                        ["rulestring"] = "(material_booster)\nOR ((material) AND (itemname(\"rubedite\",\"ancestor\",\"rubedo\",\"ruby ash\",\"platinum\")))\nOR ((aspect) AND (legendary))\nOR (ornate)\nOR ((item_jewelry) AND (intricate))\nOR ((masterwrit) AND (wwMatCostPerVoucher >= 300))",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 800,
                        ["delay"] = 300,
                        ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((masterwrit) AND (wwMatCostPerVoucher < 300))",
                        ["output"] = true,
                        ["excludeOtherRule"] = true,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Destroy"] = 
                    {
                        ["rulestring"] = "",
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["summary"] = true,
                        ["useFCOIS"] = false,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Zhaksyr",
                    },
                },
                ["$LastCharacterName"] = "Zhaksyr the Mighty",
                ["version"] = 1,
            },
            ["8796093050316469"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "(material_style)\nOR (itemtype_racial_style_motif)",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                        ["excludeOtherRule"] = true,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Destroy"] = 
                    {
                        ["rulestring"] = "",
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["summary"] = true,
                        ["useFCOIS"] = false,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Zancalmo",
                    },
                },
                ["$LastCharacterName"] = "Zancalmo",
                ["version"] = 1,
            },
            ["8796093045935983"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "(material_alchemy)",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((soulgem) and (normal))\n",
                        ["output"] = true,
                        ["excludeOtherRule"] = true,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Destroy"] = 
                    {
                        ["rulestring"] = "",
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["summary"] = true,
                        ["useFCOIS"] = false,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Daenir",
                    },
                },
                ["$LastCharacterName"] = "Daenir Haggertyn",
                ["version"] = 1,
            },
            ["8796093049167465"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "((material_blacksmithing) AND (NOT(itemname(\"rubedite\"))))\nOR ((material_clothier) AND (NOT(itemname(\"ancestor\",\"rubedo\"))))\nOR ((material_woodworking) AND (NOT(itemname(\"ruby\"))))\nOR ((material_jewelry) AND (NOT(itemname(\"platinum\"))))\nOR (material_trait)\n",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                        ["excludeOtherRule"] = true,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Destroy"] = 
                    {
                        ["rulestring"] = "",
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["summary"] = true,
                        ["useFCOIS"] = false,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Zugbesha",
                    },
                },
                ["$LastCharacterName"] = "Zugbesha",
                ["version"] = 1,
            },
            ["8796093036155895"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "(treasure)\nOR ((junk) AND itemname(\"foul hide\",\"supple root\",\"carapace\",\"elemental essence\",\"daedra husk\",\"ectoplasm\"))",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Destroy"] = 
                    {
                        ["rulestring"] = "",
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["summary"] = true,
                        ["useFCOIS"] = false,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Al",
                    },
                },
                ["$LastCharacterName"] = "Alexander Mundus",
                ["version"] = 1,
            },
            ["8796093037147913"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "(costume) OR (disguise) OR ((armor) AND (armor_none))",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 1000,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Destroy"] = 
                    {
                        ["rulestring"] = "",
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["summary"] = true,
                        ["useFCOIS"] = false,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Simone",
                    },
                },
                ["$LastCharacterName"] = "Simone Chevalier",
                ["version"] = 1,
            },
            ["8796093032933615"] = 
            {
                ["userSettings"] = 
                {
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 900,
                        ["delay"] = 300,
                        ["rulestring"] = "((aspect) AND (NOT (legendary))) OR (essence) OR (potency)",
                        ["output"] = true,
                        ["excludeOtherRule"] = false,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["UnJunk"] = 
                    {
                        ["delay"] = 200,
                        ["summary"] = false,
                        ["output"] = false,
                        ["timeout"] = 0,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["delay"] = 300,
                        ["output"] = true,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                        ["output"] = true,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 900,
                        ["delay"] = 300,
                        ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((soulgem) and (normal))\n",
                        ["output"] = true,
                        ["excludeOtherRule"] = true,
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["delay"] = 1500,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                    },
                    ["Destroy"] = 
                    {
                        ["rulestring"] = "",
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["timeout"] = 100,
                        ["treshold"] = true,
                        ["output"] = true,
                        ["safeRule"] = true,
                        ["delay"] = 300,
                    },
                    ["General"] = 
                    {
                        ["printCompiledRule"] = false,
                        ["summary"] = true,
                        ["useFCOIS"] = false,
                        ["output"] = true,
                        ["taskStartMessage"] = false,
                        ["contextMenu"] = false,
                        ["profile"] = "Lilwen",
                    },
                },
                ["$LastCharacterName"] = "Lilwen",
                ["version"] = 1,
            },
        },
    },
}
globalVars =
{
    ["Default"] = 
    {
        ["@ziggr"] = 
        {
            ["$AccountWide"] = 
            {
                ["version"] = 1,
                ["profiles"] = 
                {
                    ["Zugbesha"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "((material_blacksmithing) AND (NOT(itemname(\"rubedite\"))))\nOR ((material_clothier) AND (NOT(itemname(\"ancestor\",\"rubedo\"))))\nOR ((material_woodworking) AND (NOT(itemname(\"ruby\"))))\nOR ((material_jewelry) AND (NOT(itemname(\"platinum\"))))\nOR (material_trait)\n",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["summary"] = false,
                            ["output"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = false,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["excludeOtherRule"] = true,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["rulestring"] = "",
                            ["thresholdcount"] = 5,
                            ["summary"] = false,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["delay"] = 300,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["summary"] = true,
                            ["useFCOIS"] = false,
                            ["output"] = true,
                            ["taskStartMessage"] = false,
                            ["contextMenu"] = false,
                            ["profile"] = "Zugbesha",
                        },
                    },
                    ["Zhaksyr"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 800,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["rulestring"] = "(material_booster)\nOR ((material) AND (itemname(\"rubedite\",\"ancestor\",\"rubedo\",\"ruby ash\",\"platinum\")))\nOR ((aspect) AND (legendary))\nOR (ornate)\nOR ((item_jewelry) AND (intricate))\nOR ((masterwrit) AND (wwMatCostPerVoucher >= 300))",
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["output"] = false,
                            ["summary"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["safeRule"] = true,
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["safeRule"] = false,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["safeRule"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 800,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((masterwrit) AND (wwMatCostPerVoucher < 300))",
                            ["excludeOtherRule"] = true,
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["Destroy"] = 
                        {
                            ["delay"] = 300,
                            ["safeRule"] = true,
                            ["thresholdcount"] = 5,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["rulestring"] = "",
                            ["summary"] = false,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["useFCOIS"] = false,
                            ["summary"] = true,
                            ["contextMenu"] = false,
                            ["taskStartMessage"] = false,
                            ["output"] = true,
                            ["profile"] = "Zhaksyr",
                        },
                    },
                    ["Hagnar"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "(ingredient)\nOR (recipe_fragment)",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["summary"] = false,
                            ["output"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = false,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((soulgem) and (normal))\n",
                            ["output"] = true,
                            ["excludeOtherRule"] = true,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["rulestring"] = "",
                            ["thresholdcount"] = 5,
                            ["summary"] = false,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["delay"] = 300,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["summary"] = true,
                            ["useFCOIS"] = false,
                            ["output"] = true,
                            ["taskStartMessage"] = false,
                            ["contextMenu"] = false,
                            ["profile"] = "Hagnar",
                        },
                    },
                    ["Zecorwyn"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 300,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["rulestring"] = "((masterwrit) AND (wwMatCostPerVoucher < 300))",
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["summary"] = false,
                            ["output"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = false,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 300,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((soulgem) AND (normal))\nOR ((masterwrit) AND (NOT(fcoisismarked)))",
                            ["excludeOtherRule"] = true,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["summary"] = false,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["thresholdcount"] = 5,
                            ["safeRule"] = true,
                            ["delay"] = 300,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["summary"] = true,
                            ["useFCOIS"] = false,
                            ["output"] = true,
                            ["taskStartMessage"] = false,
                            ["contextMenu"] = false,
                            ["profile"] = "Zecorwyn",
                        },
                    },
                    ["Lilwen"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 900,
                            ["delay"] = 300,
                            ["rulestring"] = "((aspect) AND (NOT (legendary))) OR (essence) OR (potency)",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["summary"] = false,
                            ["output"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = false,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 900,
                            ["delay"] = 300,
                            ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((soulgem) and (normal))\n",
                            ["output"] = true,
                            ["excludeOtherRule"] = true,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["rulestring"] = "",
                            ["thresholdcount"] = 5,
                            ["summary"] = false,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["delay"] = 300,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["summary"] = true,
                            ["useFCOIS"] = false,
                            ["output"] = true,
                            ["taskStartMessage"] = false,
                            ["contextMenu"] = false,
                            ["profile"] = "Lilwen",
                        },
                    },
                    ["Simone"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "(costume) OR (disguise) OR ((armor) AND (armor_none))",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["summary"] = false,
                            ["output"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = false,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["rulestring"] = "",
                            ["thresholdcount"] = 5,
                            ["summary"] = false,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["delay"] = 300,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["summary"] = true,
                            ["useFCOIS"] = false,
                            ["output"] = true,
                            ["taskStartMessage"] = false,
                            ["contextMenu"] = false,
                            ["profile"] = "Simone",
                        },
                    },
                    ["Daenir"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "(material_alchemy)",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["summary"] = false,
                            ["output"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = false,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "(material)\nOR (intricate) \nOR (ornate)\nOR (recipe)\nOR (survey)\nOR ((soulgem) and (normal))\n",
                            ["output"] = true,
                            ["excludeOtherRule"] = true,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["rulestring"] = "",
                            ["thresholdcount"] = 5,
                            ["summary"] = false,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["delay"] = 300,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["summary"] = true,
                            ["useFCOIS"] = false,
                            ["output"] = true,
                            ["taskStartMessage"] = false,
                            ["contextMenu"] = false,
                            ["profile"] = "Daenir",
                        },
                    },
                    ["Al"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "(treasure)\nOR ((junk) AND itemname(\"foul hide\",\"supple root\",\"carapace\",\"elemental essence\",\"daedra husk\",\"ectoplasm\"))",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["summary"] = false,
                            ["output"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = false,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["rulestring"] = "",
                            ["thresholdcount"] = 5,
                            ["summary"] = false,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["delay"] = 300,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["summary"] = true,
                            ["useFCOIS"] = false,
                            ["output"] = true,
                            ["taskStartMessage"] = false,
                            ["contextMenu"] = false,
                            ["profile"] = "Al",
                        },
                    },
                    ["Zancalmo"] = 
                    {
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "(material_style)\nOR (itemtype_racial_style_motif)",
                            ["output"] = true,
                            ["excludeOtherRule"] = false,
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["UnJunk"] = 
                        {
                            ["delay"] = 200,
                            ["summary"] = false,
                            ["output"] = false,
                            ["timeout"] = 0,
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["output"] = true,
                            ["safeRule"] = false,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                            ["output"] = true,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["excludeOtherRule"] = true,
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["delay"] = 1500,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["rulestring"] = "",
                            ["thresholdcount"] = 5,
                            ["summary"] = false,
                            ["timeout"] = 100,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["safeRule"] = true,
                            ["delay"] = 300,
                        },
                        ["General"] = 
                        {
                            ["printCompiledRule"] = false,
                            ["summary"] = true,
                            ["useFCOIS"] = false,
                            ["output"] = true,
                            ["taskStartMessage"] = false,
                            ["contextMenu"] = false,
                            ["profile"] = "Zancalmo",
                        },
                    },
                },
            },
        },
    },
}
