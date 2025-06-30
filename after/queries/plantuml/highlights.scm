(activity) @string

[
  "@startuml"
  "@enduml"

  "@startjson"
  "@endjson"

  "@startyaml"
  "@endyaml"

  "@startebnf"
  "@endebnf"

  "@startregex"
  "@endregex"

  "@startregex"
  "@endregex"
] @constant.builtin

(string) @string

[
  (left)
  (right)
] @variable

[
  "autonumber"
  "inc"
  "resume"
  "autonumber stop"
  "as"
  "order"
] @attribute

(attribute
  (kind) @keyword)

(attribute
  (name) @variable)

(comment) @comment

[
  "group"
  "end"
  "loop"
] @label

[
 (label)
] @label

(outgoing) @punctuation.special

(custom_label
  "[" @punctuation.bracket
  (content) @label
  "]" @punctuation.bracket)

(escape_char) @string.escape

(attr_alias
  (new_name) @variable)

(attr_order
  (value) @number)

(connector) @punctuation.bracket
