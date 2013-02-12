import BeadyEye
import BooSpec

class Test1:
  constructsWith

class Test2:
  constructsWith test1

  def GetTest1():
    return test1

class Test3:
  pass

class Test4:
  constructsWith test3

  def GetTest3():
    return test3

class Test5:
  constructsWith Test4.foo

  def GetFooStuff():
    return foo.GetTest3()

#WFIXME for now only reuses object if you "Set" it, what should it be???
class BeadyEyeSpec (Spec):
  def Spec():
    BeforeAll() do:
      DI.SetAssembly(self.GetType().Assembly.FullName.ToString())

    Before() do:
      DI.Clear()

    Describe("creates new objects") do:
      Describe("with no sub-dependencies") do:
        It("creates the object") do:
          test1 = DI.Get("test1")
          Expect(test1.GetType()).ToEqual(Test1)

      Describe("with a dependency") do:
        It("creates the object and subobjects") do:
          test2 = DI.Get("test2")
          Expect(test2.GetType()).ToEqual(Test2)
          Expect((test2 as Test2).GetTest1().GetType()).ToEqual(Test1)

        It("uses the default constructor (no args) when there is no DI constructor") do:
          test4 = DI.Get("test4")
          Expect(test4.GetType()).ToEqual(Test4)
          Expect((test4 as Test4).GetTest3().GetType()).ToEqual(Test3)

        It("uses the value before . as a type, if provided") do:
          DI.Set("foo", DI.Get("test4"))
          test5 = DI.Get("test5") as Test5
          Expect(test5.GetFooStuff().GetType()).ToEqual(Test3)

    Describe("uses existing objects") do:
      It("uses an existing object") do:
        setTest1 = Test1({})
        DI.Set("test1", setTest1)
        Expect(DI.Get("test1")).ToEqual(setTest1)

      It("uses an existing object within a created object") do:
        setTest1 = Test1({})
        DI.Set("test1", setTest1)
        test2 = DI.Get("test2")
        Expect(test2.GetType()).ToEqual(Test2)
        Expect((test2 as Test2).GetTest1()).ToEqual(setTest1)

