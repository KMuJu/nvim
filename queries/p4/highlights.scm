; highlights.scm

;; Preprocessor directives
(preproc) @preproc

;; Keywords
"parser" @keyword
"control" @keyword
"struct" @keyword
"header" @keyword
"action" @keyword
"table" @keyword
"state" @keyword
"package" @keyword

;; Directions (in, out, inout)
(direction) @keyword.modifier

;; Bit type e.g. bit<8>
(bit_type) @type.builtin

;; Key type in table elements
(key_type) @keyword.operator

;; Type identifiers
(type_identifier) @type

;; Definitions — name highlights
(struct_definition
  (type_identifier) @type.definition)

(header_definition
  (type_identifier) @type.definition)

(parser_definition
  (method_identifier) @function.definition)

;; Control name at definition site
(control_definition
  (method_identifier
    (identifier) @function.definition)
  (#set! priority 110))

;; Action name at definition site
(action
  (method_identifier
    (identifier) @function.definition)
  (#set! priority 110))

;; Table name at definition site
(table
  (type_identifier
    (identifier) @type.definition)
  (#set! priority 110))

;; Method call: dmac.apply()
(call
  (fval
    (identifier) @variable
    (method_identifier
      (identifier) @function.call)
    (#set! priority 110)))

;; Action items in tables
(action_item
  (method_identifier) @function.method)

;; Function/method calls
(call
  (fval
    (method_identifier) @function.call))

;; Method identifiers (catch-all for remaining cases)
(method_identifier) @function

;; Parameters
(parameter
  (identifier) @variable.parameter)

;; Fields
(field
  (identifier) @variable.member)

;; Variable declarations
(var_decl
  (lval) @variable)

;; Transitions
(transition
  (identifier) @keyword.control.return)

;; Package instantiation
(package
  (method_identifier) @function.macro
  (identifier) @variable)

;; Numbers
(number) @number
(decimal) @number

;; Catch-all identifiers (lowest priority)
((identifier) @variable
  (#set! priority 90))
