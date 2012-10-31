namespace BeadyEye

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast

macro constructsWith:
  for member as ReferenceExpression in constructsWith.Arguments:
    yield Field(Name: member.Name, Type: SimpleTypeReference("object"), Modifiers: TypeMemberModifiers.Protected)
  klass = [|
    def constructor(args as Hash):
      DI.SetAssembly(self.GetType().Assembly.FullName.ToString())
  |]
  for member as ReferenceExpression in constructsWith.Arguments:
    memberName = member.Name
    klass.Body.Add([|
      self.$memberName = (args[$memberName] or DI.Get($memberName))
    |])
  yield klass

