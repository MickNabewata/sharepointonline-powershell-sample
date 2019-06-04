@echo off

rem 固定文字列
set SCRIPTFILEPATH=%~dp0Create-AppCatalog.ps1
set LOG=%~dp0Create-AppCatalog.log
set EXECUTION_POLICY=UnRestricted

rem スクリプト実行パラメータ
set DOMAIN="techdev"
set SITE_URL="https://contoso.sharepoint.com/sites/test"
set CRED_FILE_PATH="userCred.xml"

rem 実行
cd %~dp0
echo script_start >> %LOG%
powershell -ExecutionPolicy %EXECUTION_POLICY% -Command %SCRIPTFILEPATH% -domain %DOMAIN% -siteUrl %SITE_URL% -credFilePath %CRED_FILE_PATH% >> %LOG%
echo script_end >> %LOG%

@echo on