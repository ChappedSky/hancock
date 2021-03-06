signature CNVEXT =
sig

  type coreConversionFuns = 
	{
	 stateFuns : State.stateFuns,
	 mungeTyDecr: (Ast.ctype*ParseTree.declarator ->Ast.ctype * string option),

	 cnvType : bool*ParseTree.decltype -> Ast.ctype*Ast.storageClass,
	 cnvExpression: ParseTree.expression -> Ast.ctype * Ast.expression,
	 cnvStatement : ParseTree.statement -> Ast.statement,
	 cnvExternalDecl: ParseTree.externalDecl -> Ast.externalDecl list,

	 wrapEXPR: (Ast.ctype*Ast.coreExpression -> Ast.ctype*Ast.expression),
	 wrapSTMT: Ast.coreStatement -> Ast.statement,
	 wrapDECL: Ast.coreExternalDecl -> Ast.externalDecl,
	 evalExpr: ParseTree.expression -> 
	              (IntInf.int option * Ast.ctype * Ast.expression * bool)
	 }


(* HANCOCK : Keep these extensions in ParseTree where they belong! *)
(*
  type expressionExt = (ParseTree.specifier, ParseTree.declarator, ParseTree.ctype, ParseTree.decltype,
			ParseTree.operator, ParseTree.expression, ParseTree.statement)
                       ParseTreeExt.expressionExt

  type statementExt = (ParseTree.specifier, ParseTree.declarator, ParseTree.ctype, ParseTree.decltype,
		       ParseTree.operator, ParseTree.expression, ParseTree.statement)
	              ParseTreeExt.statementExt

  type externalDeclExt = (ParseTree.specifier, ParseTree.declarator, ParseTree.ctype, ParseTree.decltype,
		          ParseTree.operator, ParseTree.expression, ParseTree.statement)
	                 ParseTreeExt.externalDeclExt 

  type specifierExt = (ParseTree.specifier, ParseTree.declarator, ParseTree.ctype, ParseTree.decltype,
		       ParseTree.operator, ParseTree.expression, ParseTree.statement)
	              ParseTreeExt.specifierExt

  type declaratorExt = (ParseTree.specifier, ParseTree.declarator, ParseTree.ctype, ParseTree.decltype,
		        ParseTree.operator, ParseTree.expression, ParseTree.statement)
	               ParseTreeExt.declaratorExt

  type declarationExt = (ParseTree.specifier, ParseTree.declarator, ParseTree.ctype, ParseTree.decltype,
		        ParseTree.operator, ParseTree.expression, ParseTree.statement)
	               ParseTreeExt.declarationExt
*)

(* HANCOCK: Modify types to take into account that extensions are now in parse tree. *)
  type extensionFuns = 
      {CNVExp: ParseTree.expressionExt -> Ast.ctype * Ast.expression,
       CNVStat: ParseTree.statementExt -> Ast.statement,
       CNVBinop: ({binop: ParseTreeExt.operatorExt, 
		   arg1Expr: ParseTree.expression, 
		   arg2Expr: ParseTree.expression}
		  -> Ast.ctype * Ast.expression),
       CNVUnop: ({unop: ParseTreeExt.operatorExt, 
		  argExpr: ParseTree.expression}
                 -> Ast.ctype * Ast.expression),
       CNVExternalDecl: ParseTree.externalDeclExt -> Ast.externalDecl list,
       CNVSpecifier: {isShadow: bool, rest : ParseTree.specifier list} 
                 -> ParseTree.specifierExt
                 -> Ast.ctype,
       CNVDeclarator: Ast.ctype * ParseTree.declaratorExt 
                 -> Ast.ctype * string option,
       CNVDeclaration: ParseTree.declarationExt -> Ast.declaration list}
(*
  type extensionFuns = 
      {CNVExp: expressionExt -> Ast.ctype * Ast.expression,
       CNVStat: statementExt -> Ast.statement,
       CNVBinop: {binop: ParseTreeExt.operatorExt, arg1Expr: ParseTree.expression, arg2Expr: ParseTree.expression}
                 -> Ast.ctype * Ast.expression,
       CNVUnop: {unop: ParseTreeExt.operatorExt, argExpr: ParseTree.expression}
                 -> Ast.ctype * Ast.expression,
       CNVExternalDecl: externalDeclExt -> Ast.externalDecl list,
       CNVSpecifier: {isShadow: bool, rest : ParseTree.specifier list} 
                 -> specifierExt
                 -> Ast.ctype,
       CNVDeclarator: Ast.ctype * declaratorExt 
                 -> Ast.ctype * string option,
       CNVDeclaration: declarationExt -> Ast.declaration list}
*)

   val makeExtensionFuns: coreConversionFuns -> extensionFuns

end (* signature CNVEXTENSION *)
