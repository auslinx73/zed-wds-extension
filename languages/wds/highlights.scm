"var" @keyword
"If" @keyword
"ElseIf" @keyword
"Else" @keyword
"Switch" @keyword
"Case" @keyword
"return" @keyword

(boolean) @constant
(number) @number
(string) @string
(escape_sequence) @string.escape
(comment) @comment

"=" @operator
"+" @operator
"-" @operator
"*" @operator
"/" @operator
"<" @operator
">" @operator

(function_call
  function: (identifier) @function)

(variable_declaration
  name: (identifier) @variable)

(identifier) @variable

"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"," @punctuation.delimiter
"." @punctuation.delimiter
