charVars =
{
    ["Default"] = 
    {
        ["@ziggr"] = 
        {
            ["8796093022722147"] = 
            {
                ["version"] = 1,
                ["userSettings"] = 
                {
                    ["General"] = 
                    {
                        ["summary"] = true,
                        ["contextMenu"] = false,
                        ["taskStartMessage"] = false,
                        ["useFCOIS"] = false,
                        ["printCompiledRule"] = false,
                        ["output"] = true,
                        ["profile"] = "",
                    },
                    ["Launder"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["safeRule"] = false,
                        ["rulestring"] = "",
                        ["delay"] = 300,
                        ["output"] = true,
                    },
                    ["Sell"] = 
                    {
                        ["summary"] = true,
                        ["timeout"] = 100,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                        ["delay"] = 300,
                        ["output"] = true,
                    },
                    ["Destroy"] = 
                    {
                        ["thresholdcount"] = 5,
                        ["summary"] = false,
                        ["safeRule"] = true,
                        ["treshold"] = true,
                        ["rulestring"] = "",
                        ["timeout"] = 100,
                        ["output"] = true,
                        ["delay"] = 300,
                    },
                    ["Junk"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["output"] = true,
                        ["delay"] = 300,
                        ["rulestring"] = "",
                    },
                    ["Deconstruct"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 500,
                        ["safeRule"] = true,
                        ["rulestring"] = "",
                        ["delay"] = 1500,
                        ["output"] = true,
                    },
                    ["Notify"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 0,
                        ["output"] = true,
                        ["delay"] = 0,
                        ["rulestring"] = "",
                    },
                    ["UnJunk"] = 
                    {
                        ["output"] = false,
                        ["summary"] = false,
                        ["delay"] = 200,
                        ["timeout"] = 0,
                    },
                    ["BankToBag"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 800,
                        ["output"] = true,
                        ["rulestring"] = "(material_booster)\nOR ((material) AND (itemname(\"rubedite\",\"ancestor\",\"rubedo\",\"ruby ash\")))\nOR ((aspect) AND (legendary))\nOR (ornate)\nOR ((item_jewelry) AND (intricate))",
                        ["delay"] = 300,
                        ["excludeOtherRule"] = false,
                    },
                    ["BagToBank"] = 
                    {
                        ["summary"] = false,
                        ["timeout"] = 800,
                        ["output"] = true,
                        ["rulestring"] = "(material)",
                        ["delay"] = 300,
                        ["excludeOtherRule"] = true,
                    },
                },
                ["$LastCharacterName"] = "Zhaksyr the Mighty",
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
                ["profiles"] = 
                {
                    ["Zhaksyr"] = 
                    {
                        ["General"] = 
                        {
                            ["summary"] = true,
                            ["contextMenu"] = false,
                            ["taskStartMessage"] = false,
                            ["useFCOIS"] = false,
                            ["printCompiledRule"] = false,
                            ["output"] = true,
                            ["profile"] = "Zhaksyr",
                        },
                        ["Launder"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["safeRule"] = false,
                            ["output"] = true,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                        },
                        ["Sell"] = 
                        {
                            ["summary"] = true,
                            ["timeout"] = 100,
                            ["safeRule"] = true,
                            ["output"] = true,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                        },
                        ["Notify"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["output"] = true,
                            ["delay"] = 0,
                            ["rulestring"] = "",
                        },
                        ["Junk"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 0,
                            ["output"] = true,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                        },
                        ["Deconstruct"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 500,
                            ["safeRule"] = true,
                            ["output"] = true,
                            ["delay"] = 1500,
                            ["rulestring"] = "",
                        },
                        ["Destroy"] = 
                        {
                            ["thresholdcount"] = 5,
                            ["summary"] = false,
                            ["safeRule"] = true,
                            ["treshold"] = true,
                            ["output"] = true,
                            ["timeout"] = 100,
                            ["delay"] = 300,
                            ["rulestring"] = "",
                        },
                        ["UnJunk"] = 
                        {
                            ["output"] = false,
                            ["summary"] = false,
                            ["delay"] = 200,
                            ["timeout"] = 0,
                        },
                        ["BankToBag"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["delay"] = 300,
                            ["excludeOtherRule"] = false,
                        },
                        ["BagToBank"] = 
                        {
                            ["summary"] = false,
                            ["timeout"] = 1000,
                            ["rulestring"] = "",
                            ["output"] = true,
                            ["delay"] = 300,
                            ["excludeOtherRule"] = false,
                        },
                    },
                },
                ["version"] = 1,
            },
        },
    },
}
