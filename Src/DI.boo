namespace BeadyEye

import System.Reflection
import System

class DI:

  _objects as Hash
  _assembly as string

  static _singleton as DI

  static def Clear():
    Singleton().ClearObjects()

  static def Get(name as string):
    return Singleton().GetObject(name)

  static def Set(name as string, obj as object):
    Singleton().SetObject(name, obj)

  static def SetAssembly(assemblyName as string):
    Singleton().SetAssemblyName(assemblyName)

  static def Singleton() as DI:
    if _singleton == null:
      _singleton = DI()
    return _singleton

  def constructor():
    _assembly = "Assembly-Boo"
    ClearObjects()

  def GetObject(name as string):
    if _objects[name] == null:
      _objects[name] = CreateObject(name)
    return _objects[name]

  def CreateObject(name as string):
    alteredName as string = name[0:1].ToUpper() + name[1:] + ", " + _assembly
    objType as Type = Type.GetType(alteredName)
    constr as ConstructorInfo = objType.GetConstructor((Hash,))
    return constr.Invoke(({},))

  def SetObject(name as string, obj as object):
    _objects[name] = obj

  def ClearObjects():
    _objects = {}

  def SetAssemblyName(name as string):
    _assembly = name
