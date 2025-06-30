;; extends

((tag
  (name) @comment.note @nospell
  ("(" @punctuation.bracket (user) @constant ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.note "SEE" "REF"))

("text" @comment.note @nospell
 (#any-of? @comment.note "SEE" "REF"))
