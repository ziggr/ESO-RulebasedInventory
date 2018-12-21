
local localization = {
	-- status messages
	 RBI_STATUS_SPLITFAILURE = "Aufteilen von Gegenständen für's Zerstören ist fehlgeschlagen"
	,RBI_STATUS_BAGFULL = "Der Zielbeutel ist voll"
	,RBI_STATUS_ACTIONS_NONE = "Keine Aktionen zu vollführen"
	,RBI_STATUS_ACTIONS_CANCELED = "Ausführung abgebrochen"
	,RBI_STATUS_ACTIONS_FINISHED = "Ausführung abgeschlossen"
	,RBI_STATUS_TASKTESTRUN = "(TEST)"
	,RBI_STATUS_ERROR_RULESYNTAX = "Syntaktischer Fehler in Regel für"
	,RBI_STATUS_ERROR_RULECONTENT = "Ein inhaltlicher Fehler unterbrach die Ausführung der Regel"
	,RBI_STATUS_ERROR_FCOISNOTFOUND = "FCOIS wurde nicht gefunden! Alle Gegenstände geschützt um Schaden zu verhindern. Bitte prüfe ob FCOIS correct installiert ist, oder deaktiviere den FCOIS-Schutz im Menu von RbI"
	
	,RBI_STATUS_PRINTRULE_START = "Regel für"
	,RBI_STATUS_PRINTRULE_END = "Ende der Regel für"
	,RBI_STATUS_PRINTRULE_TEST_START = "Test-Regel für"
	,RBI_STATUS_START_TASK = "Beginne Ausführung von"
	

	-- task messages
	,RBI_TASK_JUNK_SUCCESS = "Als Trödel markiert"
	,RBI_TASK_BAGTOBANK_SUCCESS = "Eingelagert"
	,RBI_TASK_BANKTOBAG_SUCCESS = "Entnommen"
	,RBI_TASK_SELLSTORE_SUCCESS = "Verkauft"
	,RBI_TASK_SELLFENCE_SUCCESS = "Verhehlt"
	,RBI_TASK_LAUNDER_SUCCESS = "Schieben"
	,RBI_TASK_DESTROY_SUCCESS = "Zerstört"
	,RBI_TASK_NOTIFY_SUCCESS = "Gefunden"
	,RBI_TASK_DECONSTRUCT_SUCCESS = "Zerlegt"
	
	-- addon interface profiles
	,RBI_MENU_PROFILES_SUBMENU_NAME = "Profile"
	,RBI_MENU_PROFILES_PROFILE_DROPDOWN_NAME = "Profil auswählen"
	,RBI_MENU_PROFILES_EDITBOX_PROFILE_NAME = "Profil Name"
	,RBI_MENU_PROFILES_BUTTON_LOAD_NAME = "Laden"
	,RBI_MENU_PROFILES_BUTTON_LOAD_TOOLTIP = "Überschreibt jegliche Einstellungen mit denen des ausgewählten Profils."
	,RBI_MENU_PROFILES_BUTTON_SAVE_TOOLTIP = "Gib einen Profilnamen ein um ein neues Profil zu speichern oder ein bestehendes zu überschreiben."
	,RBI_MENU_PROFILES_BUTTON_DELETE_NAME = "Löschen"
	,RBI_MENU_PROFILES_BUTTON_DELETE_TOOLTIP = "Gib den Namen eines existierenden Profils ein um dieses zu löschen."
	
	-- addon interface general
	,RBI_MENU_PANEL_DISPLAYNAME = "Einstellungen"
	,RBI_MENU_GENERAL_SUBMENU_NAME = "Allgemeines" 
	,RBI_MENU_GENERAL_OUTPUT_CHECKBOX_NAME = "Ausgabe" 
	,RBI_MENU_GENERAL_OUTPUT_CHECKBOX_TOOLTIP = "An/Aus der Ausgaben aller Aufgaben."
	,RBI_MENU_GENERAL_SUMMARY_CHECKBOX_NAME = "Zusammenfassung" 
	,RBI_MENU_GENERAL_SUMMARY_CHECKBOX_TOOLTIP = "An/Aus der Zusammenfassungen aller Aufgaben."
	,RBI_MENU_GENERAL_PROCESSEDRULE_CHECKBOX_NAME = "Zeige verarbeitete Regel" 
	,RBI_MENU_GENERAL_PROCESSEDRULE_CHECKBOX_TOOLTIP = "Wenn aktiviert wird die verarbeitete Regel, statt der vereinfachten angezeigt."
	,RBI_MENU_GENERAL_CONTEXTMENU_CHECKBOX_NAME = "Kontextmenu"
	,RBI_MENU_GENERAL_CONTEXTMENU_CHECKBOX_TOOLTIP = "Aktiviert eine Option im Kontextmenu des inventars, die es ermöglicht die von diesem Addon genutzten Daten eines Geganstandes auszugeben."
	,RBI_MENU_GENERAL_FCOIS_CHECKBOX_NAME = "Benutze FCOIS-Schutz"
	,RBI_MENU_GENERAL_FCOIS_CHECKBOX_TOOLTIP = "Gegenstände können vor Zerstörung, Verkaufen, Hehlen, Schieben, Zerlegen oder vor dem als Trödel markiert werden geschützt sein."
	,RBI_MENU_GENERAL_START_TASK_MESSAGE = "Aufgaben-Start Nachricht"
	,RBI_MENU_GENERAL_START_TASK_MESSAGE_TOOLTIP = "Zu Beginn einer Aufgabenausführung wird eine Nachricht ausgegeben."
	
	-- addon interface task
	,RBI_MENU_TASK_GENERAL_BUTTON_ABORT_NAME = "Abbrechen" 
	,RBI_MENU_TASK_GENERAL_BUTTON_ABORT_TOOLTIP = "Bricht die Testregel ab und kehrt zur gespeicherten zurück."
	,RBI_MENU_TASK_GENERAL_BUTTON_SAVE_NAME = "Sichern"
	,RBI_MENU_TASK_GENERAL_BUTTON_SAVE_TOOLTIP = "Sichert die Regel um sie bei nächster Gelegenheit anzuwenden."
	,RBI_MENU_TASK_GENERAL_BUTTON_TEST_NAME = "Test"
	,RBI_MENU_TASK_GENERAL_BUTTON_TEST_TOOLTIP = "Prüft jeden Gegenstand im Ursprungsbeutel mit dieser Aufgabe ohne die Aktionen auszuführen."
	,RBI_MENU_TASK_GENERAL_BUTTON_RUN_NAME = "Ausführen"
	,RBI_MENU_TASK_GENERAL_BUTTON_RUN_TOOLTIP = "Führt die Aufgabe auf dem Ursprungsbeutel aus."
	,RBI_MENU_TASK_GENERAL_CHECKBOX_OUTPUT_NAME = "Ausgabe"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_OUTPUT_TOOLTIP = "Zeigt an ob Aktionen dieser Aufgabe ausgegeben werden sollen, oder nicht."
	,RBI_MENU_TASK_GENERAL_CHECKBOX_SUMMARY_NAME = "Zusammenfassung"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_SUMMARY_TOOLTIP = "Zeigt an ob die Zusammenfassung dieser Aufgabe ausgegeben werden soll, oder nicht."
	,RBI_MENU_TASK_GENERAL_CHECKBOX_THRESHOLD_NAME = "Grenzwert"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_THRESHOLD_TOOLTIP = "Zeigt an ob ein Grenzwert an freien Inventarplätzen verwendet werden soll, an dem die Aufgabe ausgeführt werden soll."
	,RBI_MENU_TASK_GENERAL_SLIDER_THRESHOLD_NAME = "Grenzwert an freien Inventarplätzen"
	,RBI_MENU_TASK_GENERAL_SLIDER_DELAY_NAME = "Wartezeit zwischen Aktionen"
	,RBI_MENU_TASK_GENERAL_SLIDER_DELAY_TOOLTIP = "Ein zu geringer Wert kann zum Verbindungsabbruch führen, wenn viele Aktionen hintereinander ausgeführt werden."
	,RBI_MENU_TASK_GENERAL_SLIDER_TIMEOUT_NAME = "Wartezeit vor einer Aufgabe"
	,RBI_MENU_TASK_GENERAL_SLIDER_TIMEOUT_TOOLTIP = "Die Zeit zwischen dem Ereignis, dass eine Aufgabe startet und der eigentlichen Ausführung der Aufgabe."
	,RBI_MENU_TASK_GENERAL_EDITBOX_RULE_NAME = "Regel"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_SAFERULE_NAME = "Abgesicherter Modus"
	,RBI_MENU_TASK_GENERAL_CHECKBOX_EXLUDERULE_NAME = "Ausschluss von"
	
	,RBI_MENU_TASK_JUNK_SUBMENU_NAME = "Trödel"
	,RBI_MENU_TASK_BAGTOBANK_SUBMENU_NAME = "Rucksack-Zu-Bank"
	,RBI_MENU_TASK_BANKTOBAG_SUBMENU_NAME = "Bank-Zu-Rucksack"
	,RBI_MENU_TASK_SELLSTORE_SUBMENU_NAME = "Verkaufen"
	,RBI_MENU_TASK_SELLFENCE_SUBMENU_NAME = "Hehlen"
	,RBI_MENU_TASK_SELLSTORE_SAFERULE_TOOLTIP = "Schließe legendäre oder nirngeschliffene Gegenstände aus und, wenn installiert, solche mit MM/TTC-Preisen über 10k."
	,RBI_MENU_TASK_LAUNDER_SUBMENU_NAME = "Schieben"
	,RBI_MENU_TASK_DESTROY_SUBMENU_NAME = "Zerstören"
	,RBI_MENU_TASK_DESTROY_SAFERULE_TOOLTIP = "Schließe legendäre oder nirngeschliffene Gegenstände aus und, wenn installiert, solche mit MM/TTC-Preisen über 10k."
	,RBI_MENU_TASK_NOTIFY_SUBMENU_NAME = "Benachrichtige"
	,RBI_MENU_TASK_DECONSTRUCT_SUBMENU_NAME = "Zerlege"
	,RBI_MENU_TASK_DECONSTRUCT_SAFERULE_TOOLTIP = "Schließe legendäre oder nirngeschliffene Gegenstände aus und, wenn installiert, solche mit MM/TTC-Preisen über 10k."
	
	-- context menu
	,RBI_CONTEXTMENU_NAME = "RbI - Zeige Gegenstandsdaten"
}

for stringId, translation in pairs(localization) do
	ZO_CreateStringId(stringId, translation)
	SafeAddVersion(stringId, 1)
end