BeadyEye
=======

Boo Dependency Injection (BDI)

Usage
=====

namespace BeadyEye

class MyClass:

  constructsWith fooFactory, string.bar, AnotherClass.baz:
    additionalSetupFunc(bar)

  def someFunc():
    fooFactory.CreateFoo()

The constructsWith macro declares member variables for each argument it is
given, and creates a constructor which assigns them. Each argument follows
the format ClassName.memberVariableName. If ClassName is omitted, it is
inferred from capitalizing the first letter of memberVariableName and taking
that as the class. It is designed as a convenience, not to be the perfect
intelligent solution. 

The constructor created by constructsWith takes a hash as its argument, the 
keys to which are the same as the names of the member variables. It will assign 
each key that is present, and ask BeadyEye to supply any missing keys. BeadyEye 
will first look to see if that key has been previously set with DI.Set. If not, 
it will attempt to create the object based on its type.

You can supply additional initialization logic to happen after constructsWith
assigns the member variables, by providing a body to the macro.

BeadyEye assumes that the classnames are in the same assembly as the object 
being constructed.  If this is not the case, for now you will have to provide 
that object on construction.


