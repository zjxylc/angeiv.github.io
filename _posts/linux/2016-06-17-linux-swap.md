---
layout: post
title: Linux Swap
category: Linux
tags: linux
keywords: linux swap
description:
---

## Recommended System Swap Space


<table xmlns:d="http://docbook.org/ns/docbook" class="lt-4-cols lt-7-rows" summary="Recommended System Swap Space"><colgroup><col align="left" class="col1" /><col align="left" class="col2" /><col align="left" class="col3" /></colgroup><thead><tr><th align="left"> Amount of RAM in the system </th><th align="left"> Recommended swap space </th><th align="left"> Recommended swap space if allowing for hibernation </th></tr></thead><tbody><tr><td align="left"> ⩽ 2 GB </td><td align="left"> 2 times the amount of RAM </td><td align="left"> 3 times the amount of RAM </td></tr><tr><td align="left"> &gt; 2 GB – 8 GB </td><td align="left"> Equal to the amount of RAM </td><td align="left"> 2 times the amount of RAM </td></tr><tr><td align="left"> &gt; 8 GB – 64 GB </td><td align="left"> At least 4 GB </td><td align="left"> 1.5 times the amount of RAM </td></tr><tr><td align="left"> &gt; 64 GB </td><td align="left"> At least 4 GB </td><td align="left"> Hibernation not recommended </td></tr></tbody></table>

## Referance

[redhat-documentation](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/ch-swapspace.html#tb-recommended-system-swap-space "redhat-documentation")