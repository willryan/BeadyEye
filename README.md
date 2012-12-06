BeadyEye
=======

Boo Dependency Injection (BDI)

Usage
=====

namespace BeadyEye

class MyClass:

  constructsWith foo, bar, baz

  def someFunc():
    foo.FooFunc()

The constructsWith macro will create a constructor for MyClass which takes a Hash.  It should have
keys matching the arguments to contstructs with, and the constructor will assign to member variables
of the same name as the argument.  (It also declares these members.)

Additionally, if a key is not set in the construction Hash, BeadyEye will attempt to create an object
matching that classname.  For example,

class MyClass:

  constructsWith helper, anotherGuy

  def MyFunc():
    assert helper.GetType() == Helper
    assert anotherGuy.GetType() == AnotherGuy

BeadyEye assumes that the classnames are in the same assembly as the object being constructed.  If this is not the
case, for now you will have to provide that object on construction.  Later I intend to add support for a YAML file
to guide BeadyEye in construction.

Finally, you can specify the type before the member name by <Type>.<MemberName>:

class MyClass:

  constructsWith MyType.foo, duck.bar, bool.baz

  def MyFunc():
    if baz:
      foo.MyTypFunc(bar.AnyFunc())

TODO: infer type by member name if not supplied


