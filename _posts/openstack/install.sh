#!/bin/bash
# Created By:      Zhang Xing <angeiv.zhang@gmail.com>
# Created Time:    2015-05-04 11:42:13
# Modified Time:   2015-05-04 15:42:33

# 获取脚本当前目录，可以使用绝对路径执行
PWD=$(dirname `readlink -f "$0"`)/
TARGZ=$PWD"logstash-1.4.2.tar.gz"
CONF=$PWD"shipper.conf"
START=$PWD"startlogstash.sh"
LINK="/usr/local/logstash"
DIRCONF="/usr/local/logstash/conf"
DIRLOGS="/usr/local/logstash/logs"
FILELOG="/usr/local/logstash/logs/stdout.log"

# 检查必须文件
function checkfiles() {
  echo -e "\033[44m0. Checking files...\033[0m"

  # 生成启动脚本
  echo "/usr/local/logstash/bin/logstash agent --config /usr/local/logstash/conf/shipper.conf --log /usr/local/logstash/logs/stdout.log &" > $START
  # 生成终止进程脚本
  echo "ps -ef | grep logstash | grep -v grep | awk '{print \$2}' | xargs kill" > $PWD"stoplogstash.sh"

  for i in $TARGZ $CONF $START
  do
    # 检查必须文件是否存在
    if [[ ! -f "$i" ]]; then
      echo -e "\033[31m$i\033[0m was not found, now exiting with \033[41mERROR CODE 1\033[0m..."
      # 返回错误代码1，缺少程序文件
      exit 1
    fi
  done

  echo -e "\033[32mAll Good!\033[0m"
}

# 安装logstash到/usr/local/logstash目录下
function installlogstash() {
  echo -e "\033[44m2. Installing logstash shipper...\033[0m"
  echo -e "Unpacking files to \033[46m/usr/local/logstash/\033[0m ..."
  if [[ ! -d "/usr/local/logstash-1.4.2" ]]; then
    tar zxf $TARGZ -C /usr/local/
  fi
  echo -e "\033[32mDone!\033[0m"

  # 检查链接是否存在
  if [[ ! -L "$LINK" ]]; then
    ln -s /usr/local/logstash-1.4.2 $LINK
    if [[ ! -L "$LINK" ]]; then
      echo -e "Cannot create link \033[31m$LINK\033[0m, now exiting with \033[41mERROR CODE 20\033[0m..."
      # 返回错误代码20，无法创建链接
      exit 20
    fi
  fi

  for i in $DIRCONF $DIRLOGS
  do
    if [[ ! -d "$i" ]]; then
      mdkir $i
      if [[ ! -d "$i" ]]; then
        echo -e "Cannot create directory \033[31m$i\033[0m, now exiting with \033[41mERROR CODE 21\033[0m..."
        # 返回错误代码21，无法创建文件夹
        exit 21
      fi
    fi
  done

  cp $CONF $DIRLOGS
  touch $FILELOG
}

# 检查java是否安装
function checkjava() {
  checkfiles
  echo -e "\033[44m1. Checking JAVA...\033[0m"
  # 检查java是否安装
  if [[ `which java` ]]; then
    echo -e "\033[32mAll Good\033[0m, will now installing \033[32mlogstash shipper\033[0m..."
    installlogstash
    echo -e "\033[32mSuccess!\033[0m"
  else
    echo -e "No JAVA was found! Please check \033[31m\$JAVA_HOME\033[0m, now exiting with \033[41mERROR CODE 10\033[0m..."
    # 可以在这里添加安装java的部分

    # 返回值错误代码10，缺少java环境
    exit 10
  fi
}

# 可以指定安装后启动脚本
function startlogstash() {
  bash $PWD"stoplogstash.sh"
  echo -e "\033[44m3. Starting logstash...\033[0m"
  bash $START
  echo -e "\033[32mAll done! Enjoy it!\033[0m"
}

checkjava
startlogstash
