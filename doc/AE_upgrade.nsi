!define SOURCE_LOCATION "C:\Program Files\Authority Editor"

!include LogicLib.nsh

; The name of the installer
Name "Upgrade AE"

; The file to write
OutFile "UpgradeAuthorityEditor.exe"

Icon "${SOURCE_LOCATION}\lib\ruby\site_ruby\1.8\ae\data\xmlicon.ico"

RequestExecutionLevel highest

;--------------------------------

; Pages

Page instfiles

;--------------------------------

; The stuff to install
Section "Main"
 ReadRegStr $0 HKLM "Software\Authority Editor" "Install_Dir"
 ${If} $0 != ""
  MessageBox MB_OK "Please close Authority Editor now if it is running."
  RMDir /r "$0\lib\ruby\site_ruby\1.8\ae"
  ; RMDir /r "$APPDATA\AuthorityEditorSettings\*.*" 
  SetOutPath "$0\lib\ruby\site_ruby\1.8\ae"
  File /r /x .git "${SOURCE_LOCATION}\lib\ruby\site_ruby\1.8\ae\*.*"
 ${Else}
  ReadRegStr $1 HKCU "Software\Authority Editor" "Install_Dir"
    ${If} $1 != ""
      MessageBox MB_OK "Please close Authority Editor now if it is running."
      RMDir /r "$1\lib\ruby\site_ruby\1.8\ae"
      ; RMDir /r "$APPDATA\AuthorityEditorSettings\*.*" 
      SetOutPath "$1\lib\ruby\site_ruby\1.8\ae"
      File /r /x .git "${SOURCE_LOCATION}\lib\ruby\site_ruby\1.8\ae\*.*"
    ${Else}
      MessageBox MB_OK "Unable to upgrade. Authority Editor is not installed on this computer."
    ${Endif}
  ${Endif}
 SectionEnd




