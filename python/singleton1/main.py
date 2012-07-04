#!/usr/bin/env python

class Singleton(type):
    """A metaclass which can be used to create singletons.

    Should behave properly with inheritance. To use, add the following into a
    class definition:
    __metaclass__ = Singleton"""

    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super(Singleton, cls).__call__(*args, **kwargs)
        return cls._instances[cls]

class MyClass(object):
    __metaclass__ = Singleton

    def identify(self):
        print str(self)

class MyOtherClass(object):
    __metaclass__ = Singleton

    def identify(self):
        print str(self)

class MySubClass(MyClass):
    pass

thing1 = None
thing2 = None

for i in range(2):
    print "Attributes for MyClass objects:"
    thing1 = MyClass()
    thing2 = MyClass()
    thing1.identify()
    thing2.identify()
    MyClass().identify()
    print id(thing1)
    print id(thing2)
    print "Attributes for MyOtherClass objects:"
    thing1 = MyOtherClass()
    thing2 = MyOtherClass()
    thing1.identify()
    thing2.identify()
    MyOtherClass().identify()
    print id(thing1)
    print id(thing2)
    print "Attributes for MySubClass objects:"
    thing1 = MySubClass()
    thing2 = MySubClass()
    thing1.identify()
    thing2.identify()
    MySubClass().identify()
    print id(thing1)
    print id(thing2)
    print ""
