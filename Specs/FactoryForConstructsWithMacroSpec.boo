import BeadyEye
import BooSpec

class TestZ:
  constructsWith string.key, int.value

  Key as string:
    get: return key

  Value as int:
    get: return value

factoryForConstructsWith TestZ

class FactoryForConstructsWithMacroSpec (Spec):
  def Spec():
    BeforeAll() do:
      DI.SetAssembly(self.GetType().Assembly.FullName.ToString())

    Describe("creating a factory") do:
      It("makes a factory that invokes the default constructor") do:
        factory as duck = DI.Get("testZFactory")
        testy = factory.Create({'key': 'apple', 'value': 10})
        Expect(testy.GetType()).ToEqual(TestZ)
        Expect(testy.Key).ToEqual('apple')
        Expect(testy.Value).ToEqual(10)


