---
layout: post
title: Puppet custom provider
category: Puppet
tags: puppet type
keywords: puppet provider
description:
---

## Puppet custom provider

自定义提供者存放在模块子目录 `lib/puppet/provider` 下，如 `lib/puppet/provider/<TYPE NAME>/<PROVIDER NAME>.rb`。

前面的章节创建了一个新的自定义类型 git repo，并告知 Puppet，该类型需要两个参数：source 和 path 。然而，到目前为止，还没有告知 Puppet 如何从 Git 仓库中检出所要的文件/数据。换句话说，就是如何给这种类型的指定实例。

## 示例

```ruby
require 'fileutils'
Puppet::Type.type(:gitrepo).provide(:git) do
  commands :git =>" git"
  def create
    git "clone", resource[:source], resource[:path]
  end
  def exists?
    File.directory? resource[:path]
  end
end
```

## 参考资料

* [英]约翰 阿伦德尔（John Arundel. Puppet实战手册. Kindle 版本.
* https://docs.puppet.com/puppet/3.8/provider_development.html
