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
    return Singleton().GetObject(name, name)

  static def Get(name as string, objType as string):
    return Singleton().GetObject(name, objType)

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

  #WFIXME how to share, when to share
  def GetObject(name as string, objType as string):
    if _objects[name] != null:
      return _objects[name]
    else:
      obj = CreateObject(objType)
      #_objects[name] = obj
      return obj

  # WFIXME break apart
  def CreateObject(strType as string):
    obj = CreateDefaultTypes(strType)
    if obj != null:
      return obj
    upperType = strType[0:1].ToUpper() + strType[1:]
    alteredType = upperType + ", " + _assembly
    objType = Type.GetType(alteredType)
    if objType != null:
      constr as ConstructorInfo = objType.GetConstructor((Hash,))
      if constr:
        return constr.Invoke(({},))
      else:
        constr = objType.GetConstructor((,))
        if constr:
          return constr.Invoke((,))
    raise "valid constructor for $(upperType) not found"

  def SetObject(name as string, obj as object):
    _objects[name] = obj

  def ClearObjects():
    _objects = {}

  def SetAssemblyName(name as string):
    _assembly = name

  private def CreateDefaultTypes(strType as string) as object:
    if strType == "Hash":
      return Hash()
    elif strType == "List":
      return List()
    elif strType == "int" or strType == "double":
      return 0
    elif strType == "bool":
      return false
    elif strType == "string":
      return ""
    else:
      return null

