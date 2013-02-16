namespace BeadyEye

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast

macro constructsWith:
  for member as ReferenceExpression in constructsWith.Arguments:
    __type as string = member.Name[0:1].ToUpper() + member.Name[1:]
    if member isa MemberReferenceExpression:
      __type = (member as MemberReferenceExpression).Target.ToString()
    yield Field(Name: member.Name, Type: SimpleTypeReference(__type), Modifiers: TypeMemberModifiers.Protected)
  contsr = [|
    def constructor(args as Hash):
      DI.SetAssembly(self.GetType().Assembly.FullName.ToString())
  |]
  for member as ReferenceExpression in constructsWith.Arguments:
    memberName = member.Name
    objType = memberName
    if member isa MemberReferenceExpression:
      objType = (member as MemberReferenceExpression).Target.ToString()
    contsr.Body.Add([|
      self.$memberName = (args[$memberName] if args.ContainsKey($memberName) else DI.Get(($memberName), ($objType)))
    |])
  if constructsWith.Body:
    contsr.Body.Add(constructsWith.Body)
  yield contsr

