# Oh my Posh
# https://ohmyposh.dev/docs/installation/windows
Write-Output 安装 Oh my Posh
Install-Module syntax-highlighting
Write-Output "Import-Module syntax-highlighting" >> $profile
# 主题为 atomic
# $profile 为当前用户的配置文件
Write-Output "function ranger { wsl ranger $args }" >> $profile