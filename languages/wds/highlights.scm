(comment) @comment

(string) @string
(number) @number
(boolean) @constant.builtin

(variable_declaration
  name: (identifier) @variable)

(lvalue
  (identifier) @variable)

(subscript_expression
  object: (identifier) @variable)

(member_expression
  object: (identifier) @variable
  property: (identifier) @property)

(function_call
  function: (identifier) @function)

(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^(WD|Tcp|Udp|Osc|ArtNet|Serial|Http|Json|Xml|File|Timer|Math)[A-Za-z0-9_]*$"))

(function_call
  function: (member_expression
    object: (identifier) @variable
    property: (identifier) @function.method))

((identifier) @constant.builtin
  (#match? @constant.builtin "^(CR|LF|CRLF|NULL|null)$"))

[
  "var" "Var" "VAR"
] @keyword

[
  "if" "If" "IF"
  "elseif" "Elseif" "ElseIf" "ELSEIF"
  "else" "Else" "ELSE"
  "switch" "Switch" "SWITCH"
  "case" "Case" "CASE"
] @keyword.control.conditional

[
  "for" "For" "FOR"
  "foreach" "Foreach" "ForEach" "FOREACH"
  "while" "While" "WHILE"
  "in" "In" "IN"
  "to" "To" "TO"
  "step" "Step" "STEP"
] @keyword.control.repeat

[
  "return" "Return" "RETURN"
  "break" "Break" "BREAK"
  "continue" "Continue" "CONTINUE"
  "exit" "Exit" "EXIT"
] @keyword.return

[
  "true" "True" "TRUE"
  "false" "False" "FALSE"
] @constant.builtin.boolean

[
  "+"
  "-"
  "*"
  "/"
  "="
  "=="
  "!="
  "<"
  "<="
  ">"
  ">="
  "&&"
  "||"
  "!"
  "+="
  "-="
  "*="
  "/="
] @operator

[
  "."
  ","
] @punctuation.delimiter

[
  "(" ")"
  "[" "]"
  "{" "}"
] @punctuation.bracket
