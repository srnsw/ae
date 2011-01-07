; AE_full_install.nsi
; If you are building this yourself, change SOURCE_LOCATION to the root folder
; of your AE install.
!define SOURCE_LOCATION "C:\Program Files\Authority Editor"
!define APP_NAME "Authority Editor"
!define APP_NAME_SQUASHED "AuthorityEditor"
!define APP_VERSION "1.0"
!define APP_PUBLISHER "State Records NSW"
!define APP_WEB_SITE "http://www.records.nsw.gov.au"
!define APP_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

!define MULTIUSER_EXECUTIONLEVEL Highest
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_COMMANDLINE
!define MULTIUSER_INSTALLMODE_INSTDIR "${APP_NAME}"
!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_KEY "Software\${APP_NAME}"
!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_VALUENAME "Install_Dir"

; Setup GTK
Function ReconfigGTK
	Exec '"$INSTDIR\lib\GTK\bin\reconfig.bat"'
FunctionEnd

Function CreateReconfigGTK
	Push $4
	FileOpen $4 "$INSTDIR\lib\GTK\bin\reconfig.bat" w
	FileWrite $4 "@echo on$\r$\n"
	FileWrite $4 "set INSTDIR=$INSTDIR$\r$\n"
	FileWrite $4 "set PATH=%INSTDIR%\lib\GTK\bin;%PATH%$\r$\n"
	FileWrite $4 '"$INSTDIR\lib\GTK\bin\gdk-pixbuf-query-loaders.exe" > "$INSTDIR\lib\GTK\etc\gtk-2.0\gdk-pixbuf.loaders"$\r$\n'
	FileWrite $4 '"$INSTDIR\lib\GTK\bin\gtk-query-immodules-2.0.exe" > "$INSTDIR\lib\GTK\etc\gtk-2.0\gtk.immodules"$\r$\n'
	FileWrite $4 '"$INSTDIR\lib\GTK\bin\pango-querymodules.exe" > "$INSTDIR\lib\GTK\etc\pango\pango.modules"$\r$\n'
	FileClose $4
	Pop $4
FunctionEnd

Function LaunchAE
	Exec '"$INSTDIR\bin\rubyw.exe" "$INSTDIR\bin\init.rb"'
FunctionEnd

!include "FileFunc.nsh"
!include "MultiUser.nsh"
!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "${SOURCE_LOCATION}\lib\ruby\site_ruby\1.8\ae\data\xmlicon.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Launch ${APP_NAME}"
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchAE"

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; License page
!insertmacro MUI_PAGE_LICENSE "${SOURCE_LOCATION}\lib\ruby\site_ruby\1.8\ae\COPYING"

; Multi-user page
!insertmacro MULTIUSER_PAGE_INSTALLMODE

; Directory page
!insertmacro MUI_PAGE_DIRECTORY

; Directory page
!insertmacro MUI_PAGE_COMPONENTS

var ICONS_GROUP
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "${APP_NAME}"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "SHCTX"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${APP_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "NSIS:Startmenu"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
	
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES
	
; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

; The name of the installer
Name "${APP_NAME} ${APP_VERSION}"

; The file to write
OutFile "Install${APP_NAME_SQUASHED}.exe"

;--------------------------------

; Pages

ShowInstDetails show
ShowUnInstDetails show

;--------------------------------

; The stuff to install
Section -SecMain
 
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File /r /x .git "${SOURCE_LOCATION}\*.*"
  
  ; Create shortcut in install directory
  CreateShortCut "$INSTDIR\${APP_NAME}.lnk" "$INSTDIR\bin\rubyw.exe" "'$INSTDIR\bin\init.rb'" "$INSTDIR\lib\ruby\site_ruby\1.8\ae\data\xmlicon.ico" 0

; Setup GTK
	Call CreateReconfigGTK
	Call ReconfigGTK
	
; Setup startmenu
!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\${APP_NAME}.lnk" "$INSTDIR\bin\rubyw.exe" "'$INSTDIR\bin\init.rb'" "$INSTDIR\lib\ruby\site_ruby\1.8\ae\data\xmlicon.ico" 0
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\uninstall.exe" "/$MultiUser.InstallMode" "$INSTDIR\uninstall.exe" 0
!insertmacro MUI_STARTMENU_WRITE_END

 SectionEnd

; Optional section (desktop shortcut)
Section "Desktop shortcut" SecDesktop
  CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\bin\rubyw.exe" "'$INSTDIR\bin\init.rb'" "$INSTDIR\lib\ruby\site_ruby\1.8\ae\data\xmlicon.ico" 0
SectionEnd

; Optional section (associate files)
Section "Associate *.xml files" SecAssociate
WriteRegStr SHCTX "Software\Classes\.xml" "" "${APP_NAME_SQUASHED}.Document"
WriteRegStr SHCTX "Software\Classes\${APP_NAME_SQUASHED}.Document" "" "Retention and Disposal Authority"
WriteRegStr SHCTX "Software\Classes\${APP_NAME_SQUASHED}.Document\DefaultIcon" "" "$INSTDIR\lib\ruby\site_ruby\1.8\ae\data\xmlicon_file.ico"
WriteRegStr SHCTX "Software\Classes\${APP_NAME_SQUASHED}.Document\shell\open\command" "" '"$INSTDIR\bin\rubyw.exe" "$INSTDIR\bin\init.rb" "%1"'
${RefreshShellIcons}
SectionEnd

LangString DESC_SecDesktop ${LANG_ENGLISH} "Installs a shortcut to ${APP_NAME} on your desktop."
LangString DESC_SecAssociate ${LANG_ENGLISH} "Associates files with the extension *.xml with ${APP_NAME}"

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecAssociate} $(DESC_SecAssociate)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function .onInit
  !insertmacro MULTIUSER_INIT
  RMDir /r "$APPDATA\AuthorityEditorSettings\*.*" 
FunctionEnd
;--------------------------------

Section -Post
   WriteUninstaller "uninstall.exe"

; Write the installation path into the registry
  WriteRegStr SHCTX "SOFTWARE\${APP_NAME}" "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr SHCTX "${APP_UNINST_KEY}" "DisplayName" "${APP_NAME}"
  WriteRegStr SHCTX "${APP_UNINST_KEY}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr SHCTX "${APP_UNINST_KEY}" "Publisher" "${APP_PUBLISHER}"
  WriteRegStr SHCTX "${APP_UNINST_KEY}" "UninstallString" '"$INSTDIR\uninstall.exe" "/$MultiUser.InstallMode"'
  WriteRegDWORD SHCTX "${APP_UNINST_KEY}" "NoModify" 1
  WriteRegDWORD SHCTX "${APP_UNINST_KEY}" "NoRepair" 1

SectionEnd

Function un.onUninstSuccess
MessageBox MB_ICONINFORMATION|MB_OK "${APP_NAME} was successfully removed from your computer."
FunctionEnd

Function un.onInit
!insertmacro MULTIUSER_UNINIT
MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to remove ${APP_NAME}?"
FunctionEnd

; Uninstaller
  Section Uninstall
  DeleteRegKey SHCTX "${APP_UNINST_KEY}"
  DeleteRegKey SHCTX "Software\${APP_NAME}"
  DeleteRegKey SHCTX "Software\Classes\${APP_NAME_SQUASHED}.Document"
  ${RefreshShellIcons}
  Delete "$DESKTOP\${APP_NAME}.lnk"
  RMDir /r "$INSTDIR"
  !insertmacro MUI_STARTMENU_GETFOLDER Application $ICONS_GROUP
  RMDir /r "$SMPROGRAMS\$ICONS_GROUP"
  SetAutoClose true
SectionEnd
