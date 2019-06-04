# ---------------------------------------
# �@�\  �FSharePoint �A�v���J�^���O�쐬 (�T�C�g�R���N�V�����P��)
# �쐬�ҁF�n��
# �X�V�ҁF
# �쐬���F2019/06/03
# �X�V���F
# ---------------------------------------

# --------------------------------------------------------------------------------------
# �X�N���v�g�t�@�C���ւ̖��O�t�������̒�`
# --------------------------------------------------------------------------------------
	Param(
		# �ڑ���h���C���� (��: techdev
		[string] $domain,
		
		# �T�C�gURL
		[string] $siteUrl,
		
		# �p�X���[�h�t�@�C���p�X (���O��CreateCred.bat�ō쐬���邱��
		[string] $credFilePath
	)
	
# --------------------------------------------------------------------------------------
# �������Ŏg�p����֐��̒�`
# --------------------------------------------------------------------------------------

# �����̃`�F�b�N
function CheckArgs($parameters)
{
	# �߂�l
	$ret = $true

	# ���b�Z�[�W�o��
	[Console]::WriteLine("")
	[Console]::WriteLine("�����`�F�b�N�����{���܂��B")
	[Console]::WriteLine("   -----")

	# �����`�F�b�N
	if($domain -eq $null)
	{
		[Console]::WriteLine("domain�p�����[�^�͏ȗ��ł��܂���B�ڑ���h���C�������w�肵�Ă��������B (��: techdev")
		
		$ret = $false
	}
	else
	{
		[Console]::WriteLine("   domain�p�����[�^	�F" + $domain)
	}
	
	if($siteUrl -eq $null)
	{
		[Console]::WriteLine("siteUrl�p�����[�^�͏ȗ��ł��܂���B�T�C�gURL���w�肵�Ă��������B")
		
		$ret = $false
	}
	else
	{
		[Console]::WriteLine("   siteUrl�p�����[�^	�F" + $siteUrl)
	}
	
	if($credFilePath -eq $null)
	{
		[Console]::WriteLine("credFilePath�p�����[�^�͏ȗ��ł��܂���B�p�X���[�h�t�@�C���p�X���w�肵�Ă��������B (�p�X���[�h�t�@�C���͎��O��CreateCred.bat�ō쐬���Ă�������")
		
		$ret = $false
	}
	else
	{
		[Console]::WriteLine("   credFilePath�p�����[�^	�F" + $credFilePath)
	}
	
	# ���b�Z�[�W�o��
	[Console]::WriteLine("   -----")
	[Console]::WriteLine("�����`�F�b�N���ʁF" + $ret)
	[Console]::WriteLine("")
	
	# �`�F�b�N���ʂ�ԋp
	return $ret
}

# --------------------------------------------------------------------------------------
# ���C������
# --------------------------------------------------------------------------------------
function Main()
{
	# SharePoint�Ǘ��V�F���̓ǂݍ���
	Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking;
	
	# SharePoint�e�i���g�ڑ�
	[Console]::WriteLine("�e�i���g�ɐڑ����܂��B�h���C���F" + $domain + " �p�X���[�h�t�@�C���F" + $credFilePath)
	$credentials = Import-Clixml $credFilePath
	Connect-SPOService -Url https://$domain-admin.sharepoint.com -Credential $credentials
	
	# �A�v���J�^���O�쐬
	[Console]::WriteLine("�A�v���J�^���O���쐬���܂��B�T�C�gURL�F" + $siteUrl)
	[Console]::WriteLine("    ---------")
	$site = Get-SPOSite $siteUrl
	Add-SPOSiteCollectionAppCatalog -Site $site
	[Console]::WriteLine("    ---------")

	# ���b�Z�[�W
	$now = (Get-Date).ToString("yyyy/MM/dd HH:mm:ss")
	[Console]::WriteLine($now + " " + "�������������܂����B")
}


# --------------------------------------------------------------------------------------
# �X�N���v�g�J�n���Ɏ��s����閽��
# --------------------------------------------------------------------------------------
[Console]::WriteLine("")
[Console]::WriteLine("------------------------------------")
[Console]::WriteLine("PowerShell�X�N���v�g���J�n���܂��B")
[Console]::WriteLine("")

try
{
	# �����̃`�F�b�N
	if(CheckArgs)
	{
		# ���C������
		Main
	}
}
catch
{
	[Console]::WriteLine("�G���[���������܂����B" + $_.Exception.Message)
}
finally
{
	[Console]::WriteLine("")
	[Console]::WriteLine("PowerShell�X�N���v�g���I�����܂��B")
	[Console]::WriteLine("------------------------------------")
	[Console]::WriteLine("")
}
