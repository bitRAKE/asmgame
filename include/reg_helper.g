; Macros are written to process 64-bit/32-bit register inputs. yet, sometimes
; conversion to register parts is convenient. Root namespaces are globally accessible.

constdefine reg8low reg8low
constdefine reg8high reg8high
constdefine reg16low reg16low
constdefine reg32 reg32
iterate <reg,	rhigh,	rlow>,\
	ax,	ah,	al,\
	cx,	ch,	cl,\
	dx,	dh,	dl,\
	bx,	bh,	bl,\
	sp,	,	spl,\
	bp,	,	bpl,\
	si,	,	sil,\
	di,	,	dil

	constdefine reg16low.e#reg?	reg
	constdefine reg8low.e#reg?	rlow

	constdefine reg32.r#reg?	e#reg
	constdefine reg16low.r#reg?	reg
	constdefine reg8low.r#reg?	rlow

	match ,rhigh
	else
		constdefine reg8high.r#reg?	rhigh
		constdefine reg8high.e#reg?	rhigh
	end match
end iterate
repeat 8, i:8
	constdefine reg32.r#i? r#i#d
	constdefine reg16low.r#i? r#i#w
	constdefine reg8low.r#i? r#i#b
end repeat
