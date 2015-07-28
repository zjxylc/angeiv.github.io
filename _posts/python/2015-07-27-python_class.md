---
layout: post
title: Python类和继承
category: python
tags: python class 类
keywords: python class 类 继承 super subclass 子类
description: 
---

# 类(class)

在**面向对象编程(Object Oriented Programming, OOP)**的时候，我们会用到类。类在实例化之后，可以对它的属性进行访问。

类的结构示例：

```
class MyClass:
    """A simple example class"""
    i = 12345
    def f(self):
        return 'hello world'
```

## 类的私有属性

`__private_attr`，开头两个下划线，声明该属性为**私有属性**，不能在类的外部被使用或者直接访问。类的内部需要用`self.__private_attr`来使用。

## 类的方法(method)

类的内部，使用`def`关键字可以定义一个方法，与一般函数定义不同，类的方法必须包含参数`self`，并且为第一个参数。

## 类的私有方法

`__private_method`，开头两个下划线，声明该方法为**私有方法**，不能在类的外部调用。在类的内部使用`self.__private_method`

## 类的专有方法

该方法称为**魔法方法(Magic Methods)**。

```
__init__      构造函数，在生成对象时调用
__del__       析构函数，释放对象时使用

__repr__      打印，转换
__setitem__   按照索引赋值
__getitem__   按照索引获取值

__len__       获得长度
__cmp__       比较运算
__call__      函数调用

__add__       加运算
__sub__       减运算
__mul__       乘运算
__div__       除运算
__mod__       求余运算
__pow__       乘方
```

> 更多讲解参见：
> 
> 1. http://www.rafekettler.com/magicmethods.html      [en-us]
> 
> 2. http://pyzh.readthedocs.org/en/latest/python-magic-methods-guide.html  [zh-hans]

## 示例

类的示例：

```
#!/usr/bin/env python
# coding: utf-8


class Animal:
    """
    This is a class.
    """
    name = 'Animal'

    # 类的初始化，可以在这里传入参数成为构造函数
    def __init__(self):
        print '%s was born. Hello World!' % self.name

    # 类在删除对象的时候会调用此方法，是析构函数，但是垃圾回收机制调用时间未知
    def __del__(self):
        print '%s become extinct. Goodbye World.' % self.name

    def eat(self):
        print 'Hmm...Yummy!'

    def song(self):
        print 'Ho~ho~'

a = Animal()
a.eat()
a.song()
```

输出结果：

```
Animal is born. Hello World!
Hmm...Yummy!
Ho~ho~
Animal become extinct. Goodbye World.
```

# 继承

## 单继承(Inheritance)

示例结构如下：

```
class DerivedClassName(BaseClassName):
    <statement-1>
    .
    .
    .
    <statement-N>
```

> inheritance  美[ɪnˈherɪt(ə)ns]  继承
> derive       美[dɪ'raɪv]        衍生

## 示例

```
#!/usr/bin/env python
# coding: utf-8


class Animal:
    """
    This is a base class.
    """
    name = 'animal'

    # 类的初始化，可以在这里传入参数成为构造函数
    def __init__(self):
        print 'An %s was born. Hello World!' % self.name

    # 类在删除对象的时候会调用此方法，是析构函数，但是垃圾回收机制调用时间未知
    def __del__(self):
        print 'An %s is dying. Goodbye World.' % self.name

    def eat(self):
        print 'Hmm...Yummy!'

    def song(self):
        print 'Ho~ho~'


class Bird(Animal):
    """
    A new specie is born, it is called 'Bird'.
    """
    name = 'bird'

    # 鸟类的初始化
    def __init__(self, name):
        Animal.__init__(self)
        self.name = name
        print 'A bird called %s was born.' % self.name

a = Animal()
a.eat()
a.song()
b = Bird(name='parrot')
b.eat()
b.song()
```

输出结果：

```
An Animal was born. Hello World!
Hmm...Yummy!
Ho~ho~
An bird was born. Hello World!
A bird called Parrot was born.
Hmm...Yummy!
Ho~ho~
An animal is dying. Goodbye World.
An parrot is dying. Goodbye World.
```

英文的冠词没有做处理。

## 多重继承(Multiple Inheritance)

多重继承的示例如下：

```
class DerivedClassName(Base1, Base2, Base3):
    <statement-1>
    .
    .
    .
    <statement-N>
```

# 多态

# 新式类(new-style class)

http://www.python.org/doc/newstyle/

https://en.wikipedia.org/wiki/Duck_typing

## 鸭子类型(Duck typing)

https://en.wikipedia.org/wiki/Duck_typing

> 参考文档：
> 
> 1. https://docs.python.org/3/tutorial/classes.html?highlight=class
> 
> 2. http://www.cnblogs.com/lovemo1314/archive/2011/05/03/2035005.html
