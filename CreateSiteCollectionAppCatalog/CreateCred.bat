@echo off

cd %~dp0
powershell -ExecutionPolicy "UnRestricted" "Get-Credential | Export-Clixml userCred.xml"

echo "�p�X���[�h�t�@�C�� userCred.xml ���쐬����܂����B(���Ԃ�"
echo "push any key..."
pause