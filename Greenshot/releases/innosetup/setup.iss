[Files]
Source: ..\..\bin\Release\*; DestDir: {app}; Flags: overwritereadonly ignoreversion replacesameversion
Source: ..\..\bin\Release\Languages\*; DestDir: {app}\Languages; Flags: overwritereadonly ignoreversion replacesameversion
Source: ..\additional_files\*; DestDir: {app}; Flags: overwritereadonly recursesubdirs ignoreversion replacesameversion
;OCR Plugin
;Source: ..\..\bin\Release\Plugins\Greenshot-OCR-Plugin\*; DestDir: {app}\Plugins\Greenshot-OCR-Plugin; Components: plugins\ocr; Flags: overwritereadonly recursesubdirs ignoreversion replacesameversion;
;Source: ..\..\bin\Release\Languages\Plugins\Greenshot-OCR-Plugin\*; DestDir: {app}\Languages\Plugins\Greenshot-OCR-Plugin; Components: plugins\ocr; Flags: overwritereadonly ignoreversion replacesameversion;
;JIRA Plugin
;Source: ..\..\bin\Release\Plugins\GreenshotJiraPlugin\*; DestDir: {app}\Plugins\GreenshotJiraPlugin; Components: plugins\jira; Flags: overwritereadonly recursesubdirs ignoreversion replacesameversion;
;Source: ..\..\bin\Release\Languages\Plugins\GreenshotJiraPlugin\*; DestDir: {app}\Languages\Plugins\GreenshotJiraPlugin; Components: plugins\jira; Flags: overwritereadonly ignoreversion replacesameversion;
;Title-Fix Plugin
;Source: ..\..\bin\Release\Plugins\Greenshot-TitleFix-Plugin\*; DestDir: {app}\Plugins\Greenshot-TitleFix-Plugin; Components: plugins\titlefix; Flags: overwritereadonly recursesubdirs ignoreversion replacesameversion;
;Source: ..\..\bin\Release\Languages\Plugins\Greenshot-TitleFix-Plugin\*; DestDir: {app}\Languages\Plugins\Greenshot-TitleFix-Plugin; Components: plugins\titlefix; Flags: overwritereadonly ignoreversion replacesameversion;
[Setup]
OutputDir=..\
OutputBaseFilename=Greenshot-INSTALLER-0.8.0.$WCREV$
DefaultDirName={pf}\Greenshot
DefaultGroupName=Greenshot
AppName=Greenshot
AppVerName=Greenshot
AppMutex=F48E86D3-E34C-4DB7-8F8F-9A0EA55F0D08,Global\F48E86D3-E34C-4DB7-8F8F-9A0EA55F0D08
PrivilegesRequired=admin
[Registry]
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "Greenshot"; ValueData: "{app}\Greenshot.exe"; Permissions: users-modify; Flags: uninsdeletevalue; Tasks: startup
[Icons]
Name: {group}\Greenshot; Filename: {app}\Greenshot.exe; WorkingDir: {app}
Name: {group}\Uninstall Greenshot; Filename: {app}\unins000.exe; WorkingDir: {app}
Name: {group}\Readme.txt; Filename: {app}\readme.txt; WorkingDir: {app}
Name: {group}\License.txt; Filename: {app}\license.txt; WorkingDir: {app}
[UninstallRun]
Filename: {app}\Greenshot.exe; Parameters: uninstall; WorkingDir: {app}; Languages: 
[Languages]
Name: en; MessagesFile: compiler:Default.isl
Name: de; MessagesFile: compiler:Languages\German.isl
Name: nl; MessagesFile: compiler:Languages\Dutch.isl
[Tasks]
Name: startup; Description: "{cm:startup}";
;[Components]
;Name: "plugins"; Description: "Plugins"; Types: Full
;Name: "plugins\ocr"; Description: "OCR Plugin"; Types: Full
;Name: "plugins\jira"; Description: "JIRA Plugin"; Types: Full
;Name: "plugins\titlefix"; Description: "Title-fix Plugin"; Types: Full
[CustomMessages]
en.dotnetmissing=This setup requires the .NET Framework v2.0.%nDo you want to download the framework now?
de.dotnetmissing=Dieses Programm ben�tigt Microsoft .NET Framework v2.0.%nWollen Sie das Framework jetzt downloaden?
nl.dotnetmissing=Dit programma heeft Microsoft .NET Framework v2.0. nodig%nWilt u het Framework nu downloaden?
en.startup=Start Greenshot with Windows start
de.startup=Greenshot starten wenn Windows hochfahrt
nl.startup=Start Greenshot wanneer Windows opstart
en.startgreenshot=Start Greenshot
de.startgreenshot=Greenshot starten
nl.startgreenshot=Start Greenshot
[Code]
function InitializeSetup(): Boolean;
var
	ErrorCode : Integer;
	NetFrameWorkInstalled : Boolean;
	MsgBoxResult : Boolean;
begin

	NetFrameWorkInstalled := RegKeyExists(HKLM, 'SOFTWARE\Microsoft\.NETFramework\policy\v2.0');
	if NetFrameWorkInstalled = true then
	begin
		Result := true;
	end;

	if NetFrameWorkInstalled = false then
	begin
		MsgBoxResult := MsgBox(ExpandConstant('{cm:dotnetmissing}'), mbConfirmation, MB_YESNO) = idYes;
		Result := false;
		if MsgBoxResult = true then
		begin
			ShellExec(
				'open', 'http://download.microsoft.com/download/5/6/7/567758a3-759e-473e-bf8f-52154438565a/dotnetfx.exe',
				'','',SW_SHOWNORMAL,ewNoWait,ErrorCode
			);
		end;
	end;

end;

[Run]
Filename: {app}\Greenshot.exe; Description: "{cm:startgreenshot}"; Parameters: --config Ui_Language={language}; WorkingDir: {app}; Flags: nowait postinstall runasoriginaluser skipifsilent
[InstallDelete]
Name: {app}; Type: filesandordirs; Languages: 
Name: {userstartup}\Greenshot.lnk; Type: files; Languages:
Name: {commonstartup}\Greenshot.lnk; Type: files; Languages:
