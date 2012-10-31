import BeadyEye
import BooSpec

class TestClass:

  constructsWith alpha, beta, gamma

  def getAlpha():
    return alpha

  def getBeta():
    return beta

  def getGamma():
    return gamma

class ConstructorSpec (Spec):
  def Spec():
    Describe("assigns variables") do:
      It("does it") do:
        tester = TestClass({'alpha': 1, 'beta': 2, 'gamma': 3})
        Expect(tester.getAlpha()).ToEqual(1)
        Expect(tester.getBeta()).ToEqual(2)
        Expect(tester.getGamma()).ToEqual(3)
