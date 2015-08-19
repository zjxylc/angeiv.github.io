---
layout: post
title: Zabbix 2.2 监控 MySQL
category: zabbix
tags: zabbix
keywords: zabbix mysql zabbix2.2
description: 
---

使用Zabbix 2.2系统自带的模板监控MySQL的状态。

## 配置环境

* CentOS 6.6及以上
* Zabbix 2.2
* MySQL
* 已关闭防火墙

## 配置Zabbix

1. 在zabbix的主机监控下添加**Template App MySQL**的监控项。
2. 在被监控的主机上建立一个不需要任何权限的MySQL账户：
  
```
GRANT USAGE ON *.* TO 'zabbix'@'localhost' IDENTIFIED BY '密码';
FLUSH PRIVILEGES;
```

3. 添加监控访问MySQL的配置文件

新建一个文件`.my.cnf`，默认文件的位置应该是`/var/lib/zabbix`，这里我选择存放在`/etc/zabbix/`下。

.my.cnf内容

```
# Zabbix Agent
[mysql]
host=127.0.0.1
user=zabbix
password=密码
socket=/var/lib/mysql/mysqld.sock
[mysqladmin]
host=127.0.0.1
user=zabbix
password=密码
socket=/var/lib/mysql/mysqld.sock
```

一定要注意各项信息是否符合本机，检查`mysqld.sock`文件。在配置过程中，**host后边添加了多余的空格导致zabbix_agent访问数据库失败**。

4. 修改zabbix配置

修改`/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf`文件，将所有的`HOME`指向的文件路径指向到上一步保存的`.my.cnf`文件所在的目录。修改后的文件如下：

```
# For all the following commands HOME should be set to the directory that has .my.cnf file with password information.

# Flexible parameter to grab global variables. On the frontend side, use keys like mysql.status[Com_insert].
# Key syntax is mysql.status[variable].
UserParameter=mysql.status[*],echo "show global status where Variable_name='$1';" | HOME=/etc/zabbix mysql -N | awk '{print $$2}'

# Flexible parameter to determine database or table size. On the frontend side, use keys like mysql.size[zabbix,history,data].
# Key syntax is mysql.size[<database>,<table>,<type>].
# Database may be a database name or "all". Default is "all".
# Table may be a table name or "all". Default is "all".
# Type may be "data", "index", "free" or "both". Both is a sum of data and index. Default is "both".
# Database is mandatory if a table is specified. Type may be specified always.
# Returns value in bytes.
# 'sum' on data_length or index_length alone needed when we are getting this information for whole database instead of a single table
UserParameter=mysql.size[*],echo "select sum($(case "$3" in both|"") echo "data_length+index_length";; data|index) echo "$3_length";; free) echo "data_free";; esac)) from information_schema.tables$([[ "$1" = "all" || ! "$1" ]] || echo " where table_schema='$1'")$([[ "$2" = "all" || ! "$2" ]] || echo "and table_name='$2'");" | HOME=/etc/zabbix mysql -N

UserParameter=mysql.ping,HOME=/etc/zabbix mysqladmin ping | grep -c alive
UserParameter=mysql.version,mysql -V
```

5. 重启zabbix agent

6. 参考文档

http://www.kaijia.me/2014/01/use-zabbix-monitor-mysql-server/
http://blog.themilkyway.org/2013/11/how-to-monitor-mysql-using-the-new-zabbix-template-app-mysql/
http://jaychang.iteye.com/blog/2214996
http://os.51cto.com/art/201404/435139.htm
http://magic3.blog.51cto.com/1146917/1324494