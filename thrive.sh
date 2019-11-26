#!/bin/bash
#
# Author:  Isaac 《ncagov@msn.com》
#
# Installs a Outline for CentOS
sh_ver="1.0.4"


# Font set
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" &&  Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"



# Check if user is root
[ $(id -u) != "0" ] && echo -e "${Error} 当前非ROOT账号(或没有ROOT权限)，无法继续操作，请更换ROOT账号或使用 ${Green_background_prefix}sudo su${Font_color_suffix} 命令获取临时ROOT权限（执行后可能会提示输入当前账号的密码）。" && exit 1}

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
clear
printf "
#######################################################################
#                       Outline for CentOS 7.0+                       #
#                    Installs a Outline for CentOS                    #
#######################################################################
" 

# Check and Install
Install(){
echo -e "${Info} 系统检测中，请稍后..."
sudo yum -y update
[ ! -e '/usr/bin/curl' ] && yum -y install curl
[ ! -e '/usr/bin/wget' ] && yum -y install wget
echo -e "${Info} 系统检测完成"

echo -e "${Info} 安装必要插件"
curl -fsSL https://get.docker.com/ | sh
sudo service docker start
echo -e "${Info} 安装完成"

systemctl stop firewalld.service
systemctl disable firewalld.service

echo -e "${Info} 机场建设中"
systemctl stop firewalld.service
systemctl disable firewalld.service
wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh | bash
echo -e "${Info} 机场建设完成"

echo -e "${Info} 复制apiURL，并贴上Outline服务器端"

echo -e "${Info} 安装完成"
}

Find(){
sudo cat /opt/outline/access.txt
}

Restart(){
sudo systemctl restart docker.service
echo -e "${Tip} 重启完毕"
}

echo && echo -e "  Outline一键脚本 ${Red_font_prefix}[v${sh_ver}]${Font_color_suffix}
----by Isaac 20191125----
  
————————————
 ${Green_font_prefix} 1.${Font_color_suffix} 安装 Outline一键脚本
————————————
 ${Green_font_prefix} 2.${Font_color_suffix} API信息
 ————————————
 ${Green_font_prefix} 3.${Font_color_suffix} 重启Outline
————————————"&& echo

read -e -p " 请输入数字 [0-10]:" num
case "$num" in
	1)
	Install
	;;
	2)
	Find
	;;
	3)
	Restart
	;;
	*)
	echo "请输入正确数字 [1-3]"
	;;	
esac
