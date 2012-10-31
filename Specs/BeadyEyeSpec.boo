import BeadyEye
import BooSpec

class Test1:
  constructsWith

class Test2:
  constructsWith test1

  def GetTest1():
    return test1

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

