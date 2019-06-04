@echo off

rem �Œ蕶����
set SCRIPTFILEPATH=%~dp0Create-AppCatalog.ps1
set LOG=%~dp0Create-AppCatalog.log
set EXECUTION_POLICY=UnRestricted

rem �X�N���v�g���s�p�����[�^
set DOMAIN="techdev"
set SITE_URL="https://contoso.sharepoint.com/sites/test"
set CRED_FILE_PATH="userCred.xml"

rem ���s
cd %~dp0
echo script_start >> %LOG%
powershell -ExecutionPolicy %EXECUTION_POLICY% -Command %SCRIPTFILEPATH% -domain %DOMAIN% -siteUrl %SITE_URL% -credFilePath %CRED_FILE_PATH% >> %LOG%
echo script_end >> %LOG%

@echo on