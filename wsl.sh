#!/bin/bash
# chmod +x script.sh
# before ./script.sh

echo $http_proxy
if [ -z "$http_proxy" ]; then
    echo "环境变量 \$http_proxy 为空。请更改Windows系统代理后"
    echo "使用 wsl --shundown 和 wsl 重启 Wsl"
    exit 1
else
    echo "环境变量 \$http_proxy 不为空。继续执行脚本。"
    # 在这里可以添加脚本的其他操作
fi

# 设置apt的代理
echo 正在设置apt代理...
echo 写入 "Acquire::http::Proxy \"$http_proxy/\";" 到 /etc/apt/apt.conf.d/proxy.conf
sudo -E sh -c 'echo "Acquire::http::Proxy \"$http_proxy/\";" > /etc/apt/apt.conf.d/proxy.conf'
echo 写入 "Acquire::https::Proxy \"$http_proxy/\";" 到 /etc/apt/apt.conf.d/proxy.conf
sudo -E sh -c 'echo "Acquire::https::Proxy \"$http_proxy/\";" >> /etc/apt/apt.conf.d/proxy.conf'
echo apt代理设置完成！

# 更新
echo 正在更新apt
sudo apt update
echo apt 更新完成！

# 安装zsh
echo 正在安装zsh
sudo apt install zsh git vim -y
echo zsh安装完成！
echo 正在配置 oh-my-zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s $(which zsh) $USER

echo 配置完成！
echo 主题修改为ZSH_THEME="agnoster"
echo 注意，如果字体显示错误，请安装 Powerline 字体
# 设置新的主题
new_theme="agnoster"
# 用 sed 命令替换 ZSH_THEME 的值
sed -i 's/ZSH_THEME="[^\"]*"/ZSH_THEME="'"$new_theme"'"/' ~/.zshrc
echo "ZSH_THEME 已更改为 $new_theme"
echo 配置完成！按回车键退出...
read
zsh
