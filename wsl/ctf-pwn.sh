# CTP-PWN 环境
echo "正在安装checksec，用于识别程序的安全属性"
echo "简单用法：checksec --file=./test.o"
sudo apt install checksec

# 安装i386环境
# 参考 https://askubuntu.com/questions/430705/how-to-use-apt-get-to-download-multi-arch-library
# https://www.cnblogs.com/gaohongyu/p/14137312.html
sudo dpkg --add-architecture i386
sudo cp ./files/sources.list /etc/apt/sources.list
# i386的源在这
# https://gist.github.com/ishad0w/2187a4eaab9273387645ac11905aca68
sudo apt update
sudo apt install libc6:i386 -y
sudo apt install qemu-user:arm64 qemu-user-static:arm64 -y
echo "安装完成！使用 qemu-i386 <文件名> 即可运行程序"