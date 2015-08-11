---
layout: post
title: Django verbatim
category: django
tags: django 
keywords: django verbatim
description: 
---

从Django 1.5开始，Django就增加了一个新的template tag，`{% verbatim %}`，用于javascript框架中和django的标签冲突的时候，使用这个标签，django不会去解析其中的javascript标签。

```
{% verbatim %}
...
{% endverbatim %}
```
