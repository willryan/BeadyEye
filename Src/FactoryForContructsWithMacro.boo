namespace BeadyEye

import Boo.Lang.Compiler
import Boo.Lang.Compiler.Ast

class FactoryForConstructsWithMacro(AbstractAstMacro): 

  override def Expand(macro as MacroStatement) as Statement:
    assert 1 == macro.Arguments.Count
    if (macro.Arguments[0] isa ReferenceExpression):
      klass = macro.Arguments[0] as ReferenceExpression
      klassName = klass.ToString()
      factoryKlassName = "$(klassName)Factory"
    else:
      raise 'invalid class declaration for factoryForConstructsWith'

    klassBody = [|
      class $(factoryKlassName):

        def Create(args as Hash) as $klass:
          return $klass(args)
    |]

    ancestor = macro.GetAncestor(NodeType.Module) as Module
    ancestor.Members.Add(klassBody)

    return null

