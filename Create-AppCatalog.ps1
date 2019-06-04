# ---------------------------------------
# 機能  ：SharePoint アプリカタログ作成 (サイトコレクション単位)
# 作成者：渡辺
# 更新者：
# 作成日：2019/06/03
# 更新日：
# ---------------------------------------

# --------------------------------------------------------------------------------------
# スクリプトファイルへの名前付き引数の定義
# --------------------------------------------------------------------------------------
	Param(
		# 接続先ドメイン名 (例: techdev
		[string] $domain,
		
		# サイトURL
		[string] $siteUrl,
		
		# パスワードファイルパス (事前にCreateCred.batで作成すること
		[string] $credFilePath
	)
	
# --------------------------------------------------------------------------------------
# 処理内で使用する関数の定義
# --------------------------------------------------------------------------------------

# 引数のチェック
function CheckArgs($parameters)
{
	# 戻り値
	$ret = $true

	# メッセージ出力
	[Console]::WriteLine("")
	[Console]::WriteLine("引数チェックを実施します。")
	[Console]::WriteLine("   -----")

	# 引数チェック
	if($domain -eq $null)
	{
		[Console]::WriteLine("domainパラメータは省略できません。接続先ドメイン名を指定してください。 (例: techdev")
		
		$ret = $false
	}
	else
	{
		[Console]::WriteLine("   domainパラメータ	：" + $domain)
	}
	
	if($siteUrl -eq $null)
	{
		[Console]::WriteLine("siteUrlパラメータは省略できません。サイトURLを指定してください。")
		
		$ret = $false
	}
	else
	{
		[Console]::WriteLine("   siteUrlパラメータ	：" + $siteUrl)
	}
	
	if($credFilePath -eq $null)
	{
		[Console]::WriteLine("credFilePathパラメータは省略できません。パスワードファイルパスを指定してください。 (パスワードファイルは事前にCreateCred.batで作成してください")
		
		$ret = $false
	}
	else
	{
		[Console]::WriteLine("   credFilePathパラメータ	：" + $credFilePath)
	}
	
	# メッセージ出力
	[Console]::WriteLine("   -----")
	[Console]::WriteLine("引数チェック結果：" + $ret)
	[Console]::WriteLine("")
	
	# チェック結果を返却
	return $ret
}

# --------------------------------------------------------------------------------------
# メイン処理
# --------------------------------------------------------------------------------------
function Main()
{
	# SharePoint管理シェルの読み込み
	Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking;
	
	# SharePointテナント接続
	[Console]::WriteLine("テナントに接続します。ドメイン：" + $domain + " パスワードファイル：" + $credFilePath)
	$credentials = Import-Clixml $credFilePath
	Connect-SPOService -Url https://$domain-admin.sharepoint.com -Credential $credentials
	
	# アプリカタログ作成
	[Console]::WriteLine("アプリカタログを作成します。サイトURL：" + $siteUrl)
	[Console]::WriteLine("    ---------")
	$site = Get-SPOSite $siteUrl
	Add-SPOSiteCollectionAppCatalog -Site $site
	[Console]::WriteLine("    ---------")

	# メッセージ
	$now = (Get-Date).ToString("yyyy/MM/dd HH:mm:ss")
	[Console]::WriteLine($now + " " + "処理を完了しました。")
}


# --------------------------------------------------------------------------------------
# スクリプト開始時に実行される命令
# --------------------------------------------------------------------------------------
[Console]::WriteLine("")
[Console]::WriteLine("------------------------------------")
[Console]::WriteLine("PowerShellスクリプトを開始します。")
[Console]::WriteLine("")

try
{
	# 引数のチェック
	if(CheckArgs)
	{
		# メイン処理
		Main
	}
}
catch
{
	[Console]::WriteLine("エラーが発生しました。" + $_.Exception.Message)
}
finally
{
	[Console]::WriteLine("")
	[Console]::WriteLine("PowerShellスクリプトを終了します。")
	[Console]::WriteLine("------------------------------------")
	[Console]::WriteLine("")
}
