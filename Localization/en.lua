
local localization = {
	-- status messages
	 RBI_STATUS_SPLITFAILURE = "Splitting item for destroy failed"
	,RBI_STATUS_BAGFULL = "The targetbag is full"
	,RBI_STATUS_ACTIONS_NONE = "No actions to perform"
	,RBI_STATUS_ACTIONS_CANCELED = "Execution canceled"
	,RBI_STATUS_ACTIONS_FINISHED = "Actions finished"
	,RBI_STATUS_TASKTESTRUN = "(TEST)"
	,RBI_STATUS_ERROR_RULESYNTAX = "Syntactical error in rule for"
	,RBI_STATUS_ERROR_RULECONTENT = "A content-related error occured while executing rule for"
	,RBI_STATUS_ERROR_FCOISNOTFOUND = "FCOIS was not detected! Protection enabled on all items to prevent harm. Please ensure FCOIS is installed correctly, or deactivate the protection in RbI's menu"
	
	,RBI_STATUS_PRINTRULE_START = "Rule for"
	,RBI_STATUS_PRINTRULE_END = "End of rule for"
	,RBI_STATUS_PRINTRULE_TEST_START = "Test-Rule for"
	,RBI_STATUS_START_TASK = "Starting execution for"
	

	-- task messages
	,RBI_TASK_JUNK_SUCCESS = "Junked"
	,RBI_TASK_BAGTOBANK_SUCCESS = "Stored"
	,RBI_TASK_BANKTOBAG_SUCCESS = "Received"
	,RBI_TASK_SELLSTORE_SUCCESS = "Sold"
	,RBI_TASK_SELLFENCE_SUCCESS = "Fenced"
	,RBI_TASK_LAUNDER_SUCCESS = "Laundered"
	,RBI_TASK_DESTROY_SUCCESS = "Destroyed"
	,RBI_TASK_NOTIFY_SUCCESS = "Found"
	,RBI_TASK_DECONSTRUCT_SUCCESS = "Deconstructed"
	
	-- addon interface profiles
	,RBI_MENU_PROFILES_SUBMENU_NAME = "Profiles"
	,RBI_MENU_PROFILES_PROFILE_DROPDOWN_NAME = "Select Profile"
	,RBI_MENU_PROFILES_EDITBOX_PROFILE_NAME = "Profile Name"
	,RBI_MENU_PROFILES_BUTTON_LOAD_NAME = "Load"
	,RBI_MENU_PROFILES_BUTTON_LOAD_TOOLTIP = "Overwrite any current settings with the settings of the chosen profile."
	,RBI_MENU_PROFILES_BUTTON_SAVE_TOOLTIP = "You need to enter a profile name to save a new profile or overwrite an existing one."
	,RBI_MENU_PROFILES_BUTTON_DELETE_NAME = "Delete"
	,RBI_MENU_PROFILES_BUTTON_DELETE_TOOLTIP = "You need to enter the name of an existing profile to delete it."
	
	-- addon interface general
	,RBI_MENU_PANEL_DISPLAYNAME = "Settings"
	,RBI_MENU_GENERAL_SUBMENU_NAME = "General" 
	,RBI_MENU_GENERAL_OUTPUT_CHECKBOX_NAME = "Output" 
	,RBI_MENU_GENERAL_OUTPUT_CHECKBOX_TOOLTIP = "On/Off for all task's outputs."
	,RBI_MENU_GENERAL_SUMMARY_CHECKBOX_NAME = "Summary" 
	,RBI_MENU_GENERAL_SUMMARY_CHECKBOX_TOOLTIP = "On/Off for all task's summaries."
	,RBI_MENU_GENERAL_PROCESSEDRULE_CHECKBOX_NAME = "Show processed rule" 
	,RBI_MENU_GENERAL_PROCESSEDRULE_CHECKBOX_TOOLTIP = "If enabled a processed rule is shown instead of the simplified one."
	,RBI_MENU_GENERAL_CONTEXTMENU_CHECKBOX_NAME = "Context Menu"
	,RBI_MENU_GENERAL_CONTEXTMENU_CHECKBOX_TOOLTIP = "This enables an option in the contextmenu of the inventory to print itemdata used by this addon"
	,RBI_MENU_GENERAL_FCOIS_CHECKBOX_NAME = "Use FCOIS protection"
	,RBI_MENU_GENERAL_FCOIS_CHECKBOX_TOOLTIP = "Items may be protected from being destroyed, sold, fenced, laundered, deconstructed or junked."
	,RBI_MENU_GENERAL_START_TASK_MESSAGE = "Task-Start Message"
	,RBI_MENU_GENERAL_START_TASK_MESSAGE_TOOLTIP = "At start of an Task a notification is displayed."
	
	-- addon interface task
	,RBI_MENU_TASK_GENERAL_BUTTON_ABORT_NAME = "Abort" 
	,RBI_MENU_TASK_GENERAL_BUTTON_ABORT_TOOLTIP = "Aborts the test rule and reverts to the saved rule."
	,RBI_MENU_TASK_GENERAL_BUTTON_SAVE_NAME = "Save"
	,RBI_MENU_TASK_GENERAL_BUTTON_SAVE_TOOLTIP = "Saves the rule to perform it on the next occasion."
	,RBI_MENU_TASK_GENERAL_BUTTON_TEST_NAME = "Test"
	,RBI_MENU_TASK_GENERAL_BUTTON_TEST_TOOLTIP = "Checks every item of the source bag of this task without actually performing it."
	,RBI_MENU_TASK_GENERAL_BUTTON_RUN_NAME = "Run"
	,RBI_MENU_TASK_GENERAL_BUTTON_RUN_TOOLTIP = "Performs the task on the whole source bag of this task."
	,RBI_MENU_TASK_GENERAL_CHECKBOX_OUTPUT_NAME = "Output"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_OUTPUT_TOOLTIP = "Determines if actions of this task should be printed."
	,RBI_MENU_TASK_GENERAL_CHECKBOX_SUMMARY_NAME = "Summary"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_SUMMARY_TOOLTIP = "Determines if a summary of this task should be printed."
	,RBI_MENU_TASK_GENERAL_CHECKBOX_THRESHOLD_NAME = "Threshold"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_THRESHOLD_TOOLTIP = "Determines if the threshold for the free slots in backpack should be used at which the task is executed."
	,RBI_MENU_TASK_GENERAL_SLIDER_THRESHOLD_NAME = "Threshold of free slots"
	,RBI_MENU_TASK_GENERAL_SLIDER_DELAY_NAME = "Delay between actions"
	,RBI_MENU_TASK_GENERAL_SLIDER_DELAY_TOOLTIP = "A value too low might cause a disconnect when executing many actions."
	,RBI_MENU_TASK_GENERAL_SLIDER_TIMEOUT_NAME = "Pre-Execution Timeout"
	,RBI_MENU_TASK_GENERAL_SLIDER_TIMEOUT_TOOLTIP = "The timeout between the event starting a task and the execution of actions."
	,RBI_MENU_TASK_GENERAL_EDITBOX_RULE_NAME = "Rule"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_SAFERULE_NAME = "Safe Mode"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_EXLUDERULE_NAME = "Exclude"
	
	,RBI_MENU_TASK_JUNK_SUBMENU_NAME = "Junk"
	,RBI_MENU_TASK_BAGTOBANK_SUBMENU_NAME = "Bag-To-Bank"
	,RBI_MENU_TASK_BANKTOBAG_SUBMENU_NAME = "Bank-To-Bag"
	,RBI_MENU_TASK_SELLSTORE_SUBMENU_NAME = "Sell"
	,RBI_MENU_TASK_SELLFENCE_SUBMENU_NAME = "Fence"
	,RBI_MENU_TASK_SELLSTORE_SAFERULE_TOOLTIP = "Always ignore legendary or nirnhoned items and, if installed, items with a MM/TTC-value above 10k."
	,RBI_MENU_TASK_LAUNDER_SUBMENU_NAME = "Launder"
	,RBI_MENU_TASK_DESTROY_SUBMENU_NAME = "Destroy"
	,RBI_MENU_TASK_DESTROY_SAFERULE_TOOLTIP = "Always ignore legendary or nirnhoned items and, if installed, items with a MM/TTC-value above 10k."
	,RBI_MENU_TASK_NOTIFY_SUBMENU_NAME = "Notification"
	,RBI_MENU_TASK_DECONSTRUCT_SUBMENU_NAME = "Deconstruct"
	,RBI_MENU_TASK_DECONSTRUCT_SAFERULE_TOOLTIP = "Always ignore legendary or nirnhoned items and, if installed, items with a MM/TTC-value above 10k."
	
	-- context menu
	,RBI_CONTEXTMENU_NAME = "RbI - Print item data"
}

for stringId, translation in pairs(localization) do
	ZO_CreateStringId(stringId, translation)
	SafeAddVersion(stringId, 1)
end