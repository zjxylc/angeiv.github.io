---
layout: post
title: Django过滤器
category: django
tags: django filter 过滤器
keywords: django 过滤器 filter
description: 
---

在Django的template中，如果需要直接输出原始的html代码，需要关闭该功能，使用safe这个过滤器对每一个变量进行禁用自动转义，`{{ data|safe }}`,此时data的值不会被转义。

> 参考文档
> 
> 1. http://www.cnblogs.com/liton/p/4244514.html
