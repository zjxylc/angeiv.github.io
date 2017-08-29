---
layout: post
title: Puppet custom type
category: Puppet
tags: puppet type
keywords: puppet type
description:
---

## Puppet custom type

自定义类型可以存在于任何模块中，存放在模块子目录 `lib/puppet/type` 下，以类型名称来命名，在该文件中进行类型的声明，如 `lib/puppet/type/<TYPE NAME>.rb`。

## 示例

Types are created by calling the `newtype` method on the `Puppet::Type` class.

### 示例1

```ruby
# lib/puppet/type/gitrepo.rb
Puppet::Type.newtype(:gitrepo) do
  @doc = "Manages Git repos"
  ensurable
  newparam(:source) do
    desc "Git source URL for the repo"
    isnamevar
  end
  newparam(:path) do
    desc "Path where the repo should be created"
    validate do | value|
      basepath = File.dirname(value)
      unless File.directory?(basepath)
        raise ArgumentError , "The path %s doesn' t exist" % basepath
    end
  end
end
```

* The name of the type is the only required argument to `newtype`. The name must be a [Ruby symbol](http://www.ruby-doc.org/core/Symbol.html), and the name of the file containing the type must match the type’s name.
* The `newtype` method also requires a [block of code](http://www.robertsosinski.com/2008/12/21/understanding-ruby-blocks-procs-and-lambdas/), specified with either curly braces (`{ ... }`) or the `do ... end` syntax. This code block will implement the type, and contains all of the properties and parameters. The block will not be passed any arguments.
* `Puppet::Type.newtype(:gitrepo)` 注册一种新类型gitrepo
* `@doc` 文档，用来描述这个类型以及参数的用途
* `ensurable` 给类型添加了 `ensure` 属性
* `newparam(:source)` 参数 `source`
* Namevar: Every type must have at least one mandatory parameter: the [namevar](https://docs.puppet.com/puppet/latest//lang_resources.html#namenamevar). This parameter will uniquely identify each resource of the type on the target system
* `isnamevar` 声明告知 Puppet source 这个参数是这个类型的名称参数。所以，当声明这个资源的一个实例时，无论给这个资源什么名字，这个名字都会是 `source` 这个参数的值
* `newparam(:path)` 该类型包含 `path` 参数
* `validate` 参数校验机制，如果传递不合适的参数，会返回有用的错误信息

### 示例2

```ruby
# lib/puppet/type/database.rb
Puppet::Type.newtype(:database) do
  @doc = %q{Creates a new database. Depending
    on the provider, this may create relational
    databases or NoSQL document stores.

    Example:

        database {'mydatabase':
          ensure => present,
          owner  => root,
        }
  }

  ensurable

  newproperty(:owner) do
    desc "The owner of the database."
    validate do |value|
      unless value =~ /^\w+/
        raise ArgumentError, "%s is not a valid user name" % value
      end
    end
  end

  newproperty(:enable) do
    newvalue(:true)
    newvalue(:false)
  end

  newproperty(:minute, :array_matching => :all) do # :array_matching defaults to :first
    ...
  end

  newparam(:path) do
    isnamevar
  end
end
```
* `:database` 是[Ruby symbol](http://www.ruby-doc.org/core/Symbol.html)， 符号，名称标签。
* `ensurable` ensure property, this property uses three methods on the provider: create, destroy, and exists?. The last method, somewhat obviously, is a boolean to determine if the resource current exists. If a resource’s ensure property is out of sync, then no other properties will be checked or modified.
* `ensure` property should be the first property, because puppet keeps track of the definition order, and it always checks and fixes properties in the order they are defined.
* [Regular expressions](http://www.rubyist.net/~slagell/ruby/regexp.html) `$`: start with, `\w`: word character; same as `[0-9A-Za-z_]`, `+`: one or more repetitions of the preceding
* Array value: By default, if a property is assigned multiple values in an array:
    * It is considered in sync if any of those values matches the current value.
    * If none of those values match, the first one will be used when syncing the property.

也可以为这个参数能够接收的所有值指定一个列表:

```ruby
newparam(:breakfast) do
  newvalues(:bacon, :eggs, :sausages)
end
```

## 参考资料

* [英]约翰 阿伦德尔（John Arundel. Puppet实战手册. Kindle 版本.
* https://docs.puppet.com/puppet/3.8/custom_types.html
