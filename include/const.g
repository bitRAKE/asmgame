
; constant language extensions
; (TODO: merge fixed macro)

calminstruction constdefine? var
	local val
	arrange val,
	match var=  val, var
	publish var:, val
end calminstruction

calminstruction (var) constequ? val
	transform val
	publish var:, val
end calminstruction
