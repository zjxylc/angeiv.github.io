---
layout: post
title: ELK日志分析监控Gitlab
category: OpenStack
tags: ELK
keywords: ELK 日志分析 gitlab ElasticSearch LogStash Kibana Redis OpenStack
description: 
---

ELK环境搭建完毕，首先将之前搭建的Gitlab进行监控。

查看下目录结构，发现日志文件在`/var/log/gitlab/`的`gitlab-rails`和`logrotate`下，顺便把syslog也监控了。

按照上一篇文章写的，只是改一下配置文件，配置文件如下

	input {
		file {
			type => "type_count"
			path => ["/var/log/gitlab/gitlab-rails/application.log", "/var/log/gitlab/gitlab-rails/githost.log", "/var/log/gitlab/gitlab-rails/production.log", "/var/log/gitlab/gitlab-rails/satellites.log", "/var/log/gitlab/gitlab-rails/sidekiq.log", "/var/log/gitlab/gitlab-rails/gitlab-shell.log", "/var/log/gitlab/logrotate/error.log", "/var/log/gitlab/logrotate/gitlab_access.log", "/var/log/gitlab/logrotate/gitlab_error.log", "/var/log/gitlab/logrotate/unicorn_stderr.log", "/var/log/gitlab/logrotate/unicorn_stdout.log", "/var/log/syslog"]
			exclude => ["*.gz", "access.log"]
		}   
	}
	
	output {
		stdout {}
		redis {
			host => "192.168.1.100"
			port => 6379
			data_type => "list"
			key => "key_count"
		}   
	}


----------

后记：
如果监控OpenStack的话就需要把OpenStack相关的日志文件路径添加到配置文件里。

一个不完全的示例：

	input {
		file {
			type => "type_count"
			path => ["/var/log/messages", "/var/log/rabbitmq/rabbit\@openstack.log", "/var/log/mongodb/mongodb.log", "/var/log/nagios/nagios.log", "/var/log/neutron/dhcp-agent.log", "/var/log/neutron/l3-agent.log", "/var/log/neutron/metadata-agent.log", "/var/log/neutron/openvswitch-agent.log", "/var/log/mariadb/mariadb.log", "/var/log/httpd/horizon_error.log", "/var/log/glance/api.log", "/var/log/glance/registry.log", "/var/log/cinder/volume.log", "/var/log/nova/nova-manage.log", "/var/log/nova/nova-api.log", "/var/log/nova/nova-scheduler.log", "/var/log/nova/nova-conductor.log", "/var/log/nova/nova-compute.log", "/var/log/ceilometer/compute.log", "/var/log/openvswitch/ovs-vswitchd.log"]
			exclude => ["*.gz", "access.log"]
		}  
	}
	
	output {
		redis {
			host => "192.168.1.100"
			port => 6379
			data_type => "list"
			key => "key_count"
		}  
	}