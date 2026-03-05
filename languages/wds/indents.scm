; Indent inside blocks
(block "{" @indent)
(block "}" @outdent)

; Indent inside switch
(switch_statement "{" @indent)
(switch_statement "}" @outdent)

; Indent case clauses
(case_clause) @indent
(case_else_clause) @indent
