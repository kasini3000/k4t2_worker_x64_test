# 例子 tcp--ping www.baidu.com 80
param
(
	$MyComputerName = 'www.baidu.com',
	[uint16]$port = '80',
	[switch]$Quiet = $false,
	[string]$AdapterNameLinux = ''
)

#Write-Verbose "$MyComputerName $port $Quiet"

if ( ($MyComputerName -eq 'www.baidu.com') -and ($port -eq '80') )
{
	Write-Host "命令格式： tcp--ping 域名 端口" -ForegroundColor Yellow
}

try
{
	[array]$ip地址组 = [System.Net.Dns]::GetHostAddresses($MyComputerName) | Where-Object { $_.AddressFamily -eq 'InterNetwork' -or $_.AddressFamily -eq 'InterNetworkV6' }
}
catch
{
	if ($Quiet -eq $true)
	{
		return $false
	}
	else
	{
		Write-Host  -NoNewline  '【'
		Write-Host  -NoNewline  $mycomputerName  -ForegroundColor  Red
		Write-Host  -NoNewline  "】DNS解析失败!`n"
	}
}
finally
{
}

#问：这个脚本谁写的？有问题找谁技术支持？
#答：QQ群号=183173532
#名称=powershell交流群
#华之夏，脚之巅，有我ps1片天！
#专门教学win，linux通用的ps1脚本。不想学也可以，入群用红包求写脚本。

foreach ($单个ip in $ip地址组)
{
	if ($单个ip.AddressFamily -eq 'InterNetwork')
	{
		if ($单个ip.IPAddressToString -eq '0.0.0.0')
		{
			Write-Error '错误：是否需要ping 127.0.0.1 ？'
			continue
		}

		#必须为每次连接，new对象。
		$tcp对象4 = New-Object System.Net.Sockets.TCPClient ([System.Net.Sockets.AddressFamily]::InterNetwork)
		#$tcp对象4.ReceiveTimeout = 1000
		#$tcp对象4.SendTimeout = 1000
		#这个参数不灵。导致超时默认20秒。

		$connect4 = $tcp对象4.BeginConnect($单个ip, $port, $null, $null)
		$wait = $Connect4.AsyncWaitHandle.WaitOne(2000, $false)
		if ($Quiet -eq $true)
		{
			if ($tcp对象4.Connected -eq $true)
			{
				$tcp对象4.EndConnect($connect4)
				$tcp对象4.Close()
				$tcp对象4.Dispose()
				return $true
			}
			else
			{
				$tcp对象4.Close()
				$tcp对象4.Dispose()
				return $false
			}
		}
		else
		{
			if ($tcp对象4.Connected -eq $true)
			{
				$tcp对象4.EndConnect($connect4)
				Write-Host  -NoNewline  "【$单个ip】【"
				Write-Host  -NoNewline  "$port"  -ForegroundColor  Green
				Write-Host  -NoNewline  "】"
				Write-Host  -NoNewline  " 通了`n"   -ForegroundColor  Green
			}
			else
			{
				Write-Host  -NoNewline  "【$单个ip】【"
				Write-Host  -NoNewline  "$port"  -ForegroundColor Red
				Write-Host  -NoNewline  "】"
				Write-Host  -NoNewline  " 不通`n"   -ForegroundColor Red
			}
		}
		$tcp对象4.Close()
		$tcp对象4.Dispose()
	}
	elseif ($单个ip.AddressFamily -eq 'InterNetworkV6')
	{
		if ($IsLinux -eq $True)
		{
			if ($AdapterNameLinux -eq '')
			{
				Write-Error "错误：`nlinux下使用ipv6，需要提供参数： '-AdapterNameLinux eth0'。`n建议搭配此脚本使用：fh返回网卡名_mac_ip_linux.ps1 `n由于new-pssession的bug，暂不支持从linux主控机经ipv6连linux被控机。从win主控机连linux被控机无此问题。"
				if (Test-Path -LiteralPath "${PSScriptRoot}/node_script/fh返回网卡名_mac_ip_linux.ps1")
				{
					$private:AdapterNameLinux2 = & "${PSScriptRoot}/node_script/fh返回网卡名_mac_ip_linux.ps1"
				}
				elseif (Test-Path -LiteralPath "${PSScriptRoot}/../node_script/fh返回网卡名_mac_ip_linux.ps1")
				{
					$private:AdapterNameLinux2 = & "${PSScriptRoot}/../node_script/fh返回网卡名_mac_ip_linux.ps1"
				}
				else
				{
					Write-Error '错误：找不到【fh返回网卡名_mac_ip_linux.ps1】退出码1 '
					exit 1
				}
				$private:AdapterNameLinux3 = $private:AdapterNameLinux2.NetworkAdapter
				if ($private:AdapterNameLinux3 -is [array])
				{
					$private:AdapterNameLinux4 = $private:AdapterNameLinux3[0]
				}
				else
				{
					$private:AdapterNameLinux4 = $private:AdapterNameLinux3
				}
				$单个ip = [ipaddress]$($单个ip.IPAddressToString + '%' + $private:AdapterNameLinux4)
				Write-Verbose $单个ip
			}
			else
			{
				$单个ip = [ipaddress]$($单个ip.IPAddressToString + '%' + $AdapterNameLinux)
				Write-Verbose $单个ip
			}
		}

		$tcp对象6 = New-Object System.Net.Sockets.TCPClient ([System.Net.Sockets.AddressFamily]::InterNetworkV6)
		#$tcp对象6.ReceiveTimeout = 1000
		#$tcp对象6.SendTimeout = 1000
		#这个参数不灵。导致超时默认20秒。

		$connect6 = $tcp对象6.BeginConnect($单个ip, $port, $null, $null)
		$wait = $Connect6.AsyncWaitHandle.WaitOne(2000, $false)
		if ($Quiet -eq $true)
		{
			if ($tcp对象6.Connected -eq $true)
			{
				$tcp对象6.EndConnect($connect6)
				$tcp对象6.Close()
				$tcp对象6.Dispose()
				return $true
			}
			else
			{
				$tcp对象6.Close()
				$tcp对象6.Dispose()
				return $false
			}
		}
		else
		{
			if ($tcp对象6.Connected -eq $true)
			{
				$tcp对象6.EndConnect($connect6)
				Write-Host  -NoNewline  "【$单个ip】【"
				Write-Host  -NoNewline  "$port"  -ForegroundColor  Green
				Write-Host  -NoNewline  "】"
				Write-Host  -NoNewline  " 通了`n"   -ForegroundColor  Green
			}
			else
			{
				Write-Host  -NoNewline  "【$单个ip】【"
				Write-Host  -NoNewline  "$port"  -ForegroundColor Red
				Write-Host  -NoNewline  "】"
				Write-Host  -NoNewline  " 不通`n"   -ForegroundColor Red
			}
		}
		$tcp对象6.Close()
		$tcp对象6.Dispose()
	}
	else
	{
		Write-Error '错误：ip地址不是v4，也不是v6。错误码111'
	}
}

Write-Host    -ForegroundColor   Yellow  "`n大网站现在全都学坏了：`n每个域名每次解析出至少2个ip，每隔几分钟就换2个ip。`n所以你的【端口测试程序】也应该升级了"

exit 0
