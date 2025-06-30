((json
  (json_data) @injection.content)
  (#set! injection.language "json"))

((yaml
  (yaml_data) @injection.content)
  (#set! injection.language "yaml"))

((regex
  (regex_data) @injection.content)
  (#set! injection.language "regex"))
