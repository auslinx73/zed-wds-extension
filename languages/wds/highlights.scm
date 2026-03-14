; ═══════════════════════════════════════════════════════════════
; WDS — Widget Designer Script — Syntax Highlighting for Zed
; v0.2.0 — Based on official Christie WD 6.6.2 documentation
; ═══════════════════════════════════════════════════════════════

; ─── Keywords ──────────────────────────────────────────────────
[
  "var" "Var" "VAR"
  "if" "If" "IF"
  "elseif" "ElseIf" "Elseif" "ELSEIF"
  "else" "Else" "ELSE"
  "switch" "Switch" "SWITCH"
  "case" "Case" "CASE"
  "for" "For" "FOR"
  "foreach" "Foreach" "ForEach" "FOREACH"
  "return" "Return" "RETURN"
  "break" "Break" "BREAK"
  "exit" "Exit" "EXIT"
  "to" "To" "TO"
  "in" "In" "IN"
  "step" "Step" "STEP"
] @keyword

; ─── Logical Operators (word-style) ───────────────────────────
[
  "and" "And" "AND"
  "or" "Or" "OR"
] @keyword.operator

; ─── Literals ──────────────────────────────────────────────────
(string) @string
(comment) @comment
(number) @number
(boolean) @constant.builtin

; ─── System Variables ──────────────────────────────────────────
((identifier) @variable.builtin
 (#match? @variable.builtin "^Now$"))

; ─── Declared Variables ────────────────────────────────────────
(variable_declaration
  name: (identifier) @variable)

; ─── For / ForEach Loop Variables ──────────────────────────────
(for_statement
  variable: (identifier) @variable)

(foreach_statement
  variable: (identifier) @variable)

; ═══════════════════════════════════════════════════════════════
; BUILT-IN WD COMMANDS (3000+ commands)
; ═══════════════════════════════════════════════════════════════

; WD* commands — Widget Designer core
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^WD"))

; Tcp* commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Tcp"))

; Udp* commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Udp"))

; Rs232/Rs422 commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Rs[24]"))

; Debug commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Debug"))

; V* variable commands (VCreate, VValue, VAdd, VLock, etc.)
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^V[A-Z]"))

; ArtNet commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^ArtNet"))

; DMX commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Dmx"))

; Midi / MSC commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Midi"))

(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Msc"))

; OSC commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Osc"))

; HTTP commands
(function_call
  function: (identifier) @function.builtin
  (#match? @function.builtin "^Http"))

; ═══════════════════════════════════════════════════════════════
; MATH OBJECT
; ═══════════════════════════════════════════════════════════════

; Math as built-in type
(member_expression
  object: (identifier) @type.builtin
  (#match? @type.builtin "^Math$"))

; ═══════════════════════════════════════════════════════════════
; DOT SYNTAX METHODS (from official documentation)
; ═══════════════════════════════════════════════════════════════

; ─── Type Conversion Methods ───────────────────────────────────
(member_expression
  property: (identifier) @function.method
  (#match? @function.method "^To(String|Integer|Double|Boolean|Color|Date|Json|List|Upper|Lower|CamelCase|SnakeCase|CharArray|Base64String|PrettyString|Hex|File)$"))

; ─── String Methods ────────────────────────────────────────────
(member_expression
  property: (identifier) @function.method
  (#match? @function.method "^(Trim|TrimStart|TrimEnd|Split|Contains|StartsWith|EndsWith|SubString|Replace|Length|Left|Right|PadLeft|PadRight|Format|IsEmpty|IsMatch|IsNumeric|EncodeBytes|FromBase64String|Unescape)$"))

; ─── List Methods ──────────────────────────────────────────────
(member_expression
  property: (identifier) @function.method
  (#match? @function.method "^(Count|Copy|Sort|Join|Remove|IndexOf|Distinct|Min|Max|Avg|WhereRegex|DecodeBytes|Base64StringToBytes)$"))

; ─── Boolean Methods ───────────────────────────────────────────
(member_expression
  property: (identifier) @function.method
  (#match? @function.method "^Not$"))

; ─── Color Methods ─────────────────────────────────────────────
(member_expression
  property: (identifier) @function.method
  (#match? @function.method "^(SetRGB|SetRGBA|ToHex)$"))

; ─── Date Methods ──────────────────────────────────────────────
(member_expression
  property: (identifier) @function.method
  (#match? @function.method "^(AddDays|AddHours|AddMinutes|AddSeconds|AddMilliseconds|AddMonths|AddYears|DiffDays|DiffHours|DiffMinutes|DiffSeconds|DiffMilliseconds|DayOfWeek|DayOfYear)$"))

; ─── JSON Methods ──────────────────────────────────────────────
(member_expression
  property: (identifier) @function.method
  (#match? @function.method "^(Get|GetDate|GetDouble|GetInteger|GetList|GetString|Set|Add|Clear|Keys|Values)$"))

; ═══════════════════════════════════════════════════════════════
; WIDGET TYPES (dot syntax objects)
; ═══════════════════════════════════════════════════════════════

; Fader1, Label1, CustomScriptButton1, etc.
(member_expression
  object: (identifier) @type
  (#match? @type "^(Fader|Label|CustomScriptButton|ScriptTimer|DropDownList|TextBox|ListView|XYPanel|RadioButton|CheckBox|ColorPicker|Image|ProgressBar|ComboBox|Gauge|Spinner|Page|Window)[0-9]+$"))

; ─── Widget Properties ─────────────────────────────────────────
(member_expression
  property: (identifier) @property
  (#match? @property "^(Value|Text|Visible|Enabled|Note|Name|ForeColor|BackColor|SelectedColor|SelectedRow|SelectedIndex|IpAddress|Port|LastMessageReceived|Type|Locked)$"))

; ─── Widget Action Methods ─────────────────────────────────────
(member_expression
  property: (identifier) @function.method
  (#match? @function.method "^(FadeUp|FadeDown|GoUp|GoDown|Click|Press|Release|ResetDefault|SetItemsFromArray|GetCell|SetCell)$"))

; ═══════════════════════════════════════════════════════════════
; DEVICE TYPES
; ═══════════════════════════════════════════════════════════════

(member_expression
  object: (identifier) @type
  (#match? @type "^(Tcp_Server|Tcp_Client|Udp_Server|Udp_Client|Rs232|Rs422|ArtNet|Midi|Osc|Http)[0-9]*$"))

; ═══════════════════════════════════════════════════════════════
; GENERIC FALLBACKS (must be LAST)
; ═══════════════════════════════════════════════════════════════

; Generic function calls
(function_call
  function: (identifier) @function)

; Generic method calls
(function_call
  function: (member_expression
    property: (identifier) @function.method))

; Generic member object
(member_expression
  object: (identifier) @variable)

; Generic member property
(member_expression
  property: (identifier) @property)

; Array/list access
(subscript_expression
  object: (identifier) @variable)

; ─── Operators ─────────────────────────────────────────────────
[
  "=" "==" "!="
  ">" "<" ">=" "<="
  "+" "-" "*" "/"
  "+=" "-=" "*=" "/="
  "&&" "||" "^" "!"
] @operator

; ─── Punctuation ───────────────────────────────────────────────
["(" ")" "[" "]"] @punctuation.bracket
["{" "}"] @punctuation.special
["," "."] @punctuation.delimiter
