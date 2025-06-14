#
# 问题反馈：卡死你3000 官方技术支持群 qq群：700816263

param
(
	[parameter(Mandatory = $true)]
	[ValidateNotNullOrEmpty()]
	[string]$LiteralPath,

	[parameter(Mandatory = $true,ValueFromPipeline = $true)]
	[ValidateNotNullOrEmpty()]
	[string]$Values
)

if ( $LiteralPath.StartsWith('/') -or ($LiteralPath[1] -eq ':') )
{
}
else
{
	if ($env:LANG -eq 'zh_CN.UTF-8')
	{
		Write-Error "错误：必须使用绝对路径。返回码1"
	}
	else
	{
		Write-Error "Error: Absolute path must be used. Return code 1"
	}
	exit 1
}

$utf8无bom编码对象 = New-Object System.Text.UTF8Encoding($False)
${Private:输出字符串} = '' + ($Values -replace "`r`n","`n") + "`n"
[system.IO.File]::WriteAllText($LiteralPath, ${Private:输出字符串}, $utf8无bom编码对象) #必须用绝对路径。
