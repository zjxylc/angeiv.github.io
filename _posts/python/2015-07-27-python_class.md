---
layout: post
title: Python类
category: Python
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

## 私有属性

`__private_attr`，开头两个下划线，声明该属性为**私有属性**，不能在类的外部被使用或者直接访问。类的内部需要用`self.__private_attr`来使用。

## 方法(method)

类的内部，使用`def`关键字可以定义一个方法，与一般函数定义不同，类的方法必须包含参数`self`，并且为第一个参数。

## 私有方法

`__private_method`，开头两个下划线，声明该方法为**私有方法**，不能在类的外部调用。在类的内部使用`self.__private_method`

## 专有方法

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

继承可以从现有的类进行继承，新的类称为**子类(Subclass)**，被继承的类称为**基类、父类或超类(Base class, Super class)**。

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

我们已经定义了一个名为Animal的类，有`eat()`方法和`song()`方法可以用，那么现在需要编写`Bird`类，直接从`Animal`类进行继承，最大的好处就是`Bird`自动拥有了`Animal`的`eat()`方法和`song()`方法。

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
    A new specie was born, it is called 'Bird'.
    """
    name = 'bird'


a = Animal()
a.eat()
a.song()
b = Bird()
b.eat()
b.song()
```

输出结果：

```
An Animal was born. Hello World!
Hmm...Yummy!
Ho~ho~
An Bird was born. Hello World!
Hmm...Yummy!
Ho~ho~
An Animal is dying. Goodbye World.
An Bird is dying. Goodbye World.
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

当父类和子类都拥有相同的方法的时候，子类的方法覆盖了父类的方法，运行的时候调用子类的方法，这样我们拥有了继承的另一个好处：**多态**。

现在我们解决一下刚才例子的冠词问题。

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
        print 'An %s was born. Hello world!' % self.name

    # 类在删除对象的时候会调用此方法，是析构函数，但是垃圾回收机制调用时间未知
    def __del__(self):
        print 'An %s is dying. Goodbye world.' % self.name

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

    # 用另一种表达方式避免冠词a/an判断
    def __del__(self):
        print 'A bird called %s is dying. Goodbye the beautiful world.' % self.name


a = Animal()
a.eat()
a.song()
b = Bird(name='parrot')
b.eat()
b.song()
```

输出结果：

```
An animal was born. Hello world!
Hmm...Yummy!
Ho~ho~
An animal was born. Hello world!
A bird called parrot was born.
Hmm...Yummy!
Ho~ho~
An animal is dying. Goodbye world.
A bird called parrot is dying. Goodbye the beautiful world.
```

## 方法多态

不同的对象可以使用相同的操作，结果可能会以多种形态展现出来。Python中，不知道对象到底是什么类型，需要对象做些事情的时候，会用到多态。

### 鸭子类型(Duck typing)

```
class Duck:
    def quack(self):
        print("Quaaaaaack!")
    def feathers(self):
        print("The duck has white and gray feathers.")

class Person:
    def quack(self):
        print("The person imitates a duck.")
    def feathers(self):
        print("The person takes a feather from the ground and shows it.")
    def name(self):
        print("John Smith")

def in_the_forest(duck):
    duck.quack()
    duck.feathers()

def game():
    donald = Duck()
    john = Person()
    in_the_forest(donald)
    in_the_forest(john)

game()
```

在`in_the_forest()`里，参数对象是一只鸭子，它实现了方法多态。从严格的抽象上来讲，`Person`类型和`Duck`类型没有关联。

参考 https://en.wikipedia.org/wiki/Duck_typing

# 新式类(new-style class)

Python的新式类是2.2版本引进来的，我们可以将之前的类叫做经典类或者旧类。引入新式类官方的解释是：**为了统一类(class)和类型(type)**

为了保证自己使用的是新式类，有以下方法：

1. 在类模块最前边加入`__metaclass__ = type`
2. 类从内建类`object`直接或间接继承。

在Python 3里面，不存在这些问题，因为所有的类都是`object`类的子类（隐式）。

http://www.python.org/doc/newstyle/

# super关键字

Python 2.2之前，类的继承使用的时候，通常就像多态部分示例的代码那样。这样是使用**非绑定(unbound)**的方法(用类名引用方法)，在参数列表引入待引用的对象(`self`)

这样有一个缺点，当一个子类的父类发生变化的时候，必须遍历整个类的定义，把所有通过非绑定方法的类名全部替换，代码量大的时候，这样的改动是灾难性的。

为了解决这个问题，从Python 2.2开始增加了一个新的关键字`super`。

Python 2的`super()`是一定需要参数的，而且父类必须是一个新式类

```
class Animal(object):
    """
    父类必须是一个新式类
    """
    def speak(self):
        print 'I am an animal.'


class Bird(Animal):
    def speak(self):
        print 'I am a bird.'
        super(Bird, self).speak()
```

Python 3

```
class Animal:
    def speak(self):
        print ('I am an animal.')


class Bird(Animal):
    def speak(self):
        print ('I am a bird.')
        super().speak()
```

在程序运行的时候两种方法的结果是一致的。但是在内部处理机制有很大不同，涉及到多继承的时候，就能表现出来。下面是一个比较复杂的类的继承(先不考虑逻辑是否合理)：

```
#!/usr/bin/env python
# coding: utf-8


class Animal:
    def __init__(self):
        print 'An animal was born. Hello world!'
        print 'An animal is dying. Goodbye world.'


class Bird(Animal):
    def __init__(self):
        print 'I am a bird.'
        Animal.__init__(self)
        print 'The bird is dying. Goodbye the beautiful world.'


class Pet(Animal):
    def __init__(self):
        print 'I am a pet.'
        Animal.__init__(self)
        print 'I am old.'

class Action:
    def __init__(self):
        print 'I can move.'
        print 'I am leaving.'


class Fly(Action):
    def __init__(self):
        print 'I can fly.'
        Action.__init__(self)
        print 'I am flying away.'


class Parrot(Bird, Fly):
    def __init__(self):
        print 'I can say "Hello".'
        Bird.__init__(self)
        Fly.__init__(self)
        print 'Bye Bye~'


class PetParrot(Pet, Parrot):
    def __init__(self):
        print 'My name is Peter, a pet bird, I can fly.'
        Pet.__init__(self)
        Parrot.__init__(self)
        print 'Bye.'


pp = PetParrot()
```

执行结果：

```
My name is Peter, a pet bird, I can fly.
I am a pet.
An animal was born. Hello world!
An animal is dying. Goodbye world.
I am old.
I can say "Hello".
I am a bird.
An animal was born. Hello world!
An animal is dying. Goodbye world.
The bird is dying. Goodbye the beautiful world.
I can fly.
I can move.
I am leaving.
I am flying away.
Bye Bye~
Bye.
```

从上面的例子可以看出，`Animal`和被重复调用了两次，这显然不是我们想要的。

使用`super`的改进版本，在新式类中，查看**方法解析顺序(Method Resolution Order, MRO)**可以使用`class.__mro__`：

```
#!/usr/bin/env python
# coding: utf-8


class Animal(object):
    def __init__(self):
        print 'An animal was born. Hello world!'
        super(Animal, self).__init__()                  # new
        print 'An animal is dying. Goodbye world.'


class Bird(Animal):
    def __init__(self):
        print 'I am a bird.'
        super(Bird, self).__init__()
        print 'The bird is dying. Goodbye the beautiful world.'


class Pet(Animal):
    def __init__(self):
        print 'I am a pet.'
        super(Pet, self).__init__()
        print 'I am old.'


class Action(object):
    def __init__(self):
        print 'I can move.'
        super(Action, self).__init__()                  # new
        print 'I am leaving.'


class Fly(Action):
    def __init__(self):
        print 'I can fly.'
        super(Fly, self).__init__()
        print 'I am flying away.'


class Parrot(Bird, Fly):
    def __init__(self):
        print 'I can say "Hello".'
        super(Parrot, self).__init__()
        print 'Bye Bye~'


class PetParrot(Pet, Parrot):
    def __init__(self):
        print 'My name is Peter, a pet bird, I can fly.'
        super(PetParrot, self).__init__()
        print 'Bye.'


print PetParrot.__mro__
pp = PetParrot()
```

`super`在调用的时候，它的机制能够保证公共的父类只被执行一次。执行结果：

```
(<class '__main__.PetParrot'>, <class '__main__.Pet'>, <class '__main__.Parrot'>, <class '__main__.Bird'>, <class '__main__.Animal'>, <class '__main__.Fly'>, <class '__main__.Action'>, <type 'object'>)
My name is Peter, a pet bird, I can fly.
I am a pet.
I can say "Hello".
I am a bird.
An animal was born. Hello world!
I can fly.
I can move.
I am leaving.
I am flying away.
An animal is dying. Goodbye world.
The bird is dying. Goodbye the beautiful world.
Bye Bye~
I am old.
Bye.
```

> 参考文档：
>
> 1. https://docs.python.org/3/tutorial/classes.html?highlight=class
>
> 2. http://www.cnblogs.com/lovemo1314/archive/2011/05/03/2035005.html
>
> 3. http://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000/001431865288798deef438d865e4c2985acff7e9fad15e3000
>
> 4. http://segmentfault.com/a/1190000000455295
>
> 5. http://www.cnblogs.com/jeffwongishandsome/archive/2012/10/06/2713258.html
>
> 6. http://249wangmang.blog.163.com/blog/static/5263076520122533158941/
>
> 7. https://rhettinger.wordpress.com/2011/05/26/super-considered-super/
