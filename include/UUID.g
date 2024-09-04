
; Microsoft variant ('mixed endian')
;
; GUID:
;	IID - interface identifier
;	CLSID - class identifier
;	LIBID - type library identifier
;	CATID - category identifier

calminstruction UUID line&
	match { A =, B =, C =, D =, { E } }, line, {}
	jyes cform
	match { A - B - C - D - E }, line, {}
	jyes stnd
	match A - B - C - D - E, line
	jyes stnd
bad:	err 'unexpected UUID form'
	exit

stnd:	arrange A, 0x#A
	arrange B, 0x#B
	arrange C, 0x#C
	arrange D, 0x#D#E
	compute D, D
	emit 4, A
	emit 2, B
	emit 2, C
	emit 8, D bswap 8
	exit

cform:	emit 4,A
	emit 2,B
	emit 2,C
	emit 2,D bswap 2
	match A =, B =, C =, D =, E =, F, E
	jno bad
	emit 1,A
	emit 1,B
	emit 1,C
	emit 1,D
	emit 1,E
	emit 1,F
end calminstruction

calminstruction(NAMED) UUID line&
	local tmp
	arrange tmp, =label NAMED:16
	assemble tmp
	arrange tmp, =UUID line
	assemble tmp
end calminstruction

; testing ...
;
; 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
;	UUID {0x03020100,0x0504,0x0706,0x0809,{0x0a,0x0b,0x0c,0x0d,0x0e,0x0f}}
;	UUID {03020100-0504-0706-0809-0a0b0c0d0e0f}
;	UUID 03020100-0504-0706-0809-0a0b0c0d0e0f
;
;name0	UUID {0x03020100,0x0504,0x0706,0x0809,{0x0a,0x0b,0x0c,0x0d,0x0e,0x0f}}
;name1	UUID {03020100-0504-0706-0809-0a0b0c0d0e0f}
;name2	UUID 03020100-0504-0706-0809-0a0b0c0d0e0f
;
; verify sets ...
;
;	forms := 3
;	offset = $$
;	repeat ($-$$)/(forms shl 4)
;		load target:16 from offset
;		repeat forms-1
;			offset = offset + 16
;			load temp:16 from offset
;			assert temp = target
;		end repeat
;		offset = offset + 16
;	end repeat


if used uuidv7
; https://www.rfc-editor.org/rfc/rfc9562#name-uuid-version-7
;
;	 0                   1                   2                   3
;	 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
;	+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
;	|                           unix_ts_ms                          |
;	+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
;	|          unix_ts_ms           |  ver  |       rand_a          |
;	+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
;	|var|                        rand_b                             |
;	+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
;	|                            rand_b                             |
;	+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
;
:uuidv7:
	enter .frame, 0
	; return UUID in shadow space
	label .uuid:16		at rbp+16	; caller created space on the stack
	label .filetime:8	at rbp+32

	; Windows epoch (January 1, 1601 UTC) based time
	GetSystemTimeAsFileTime & .filetime

	; 100-nanosecond intervals to milliseconds
	mov rax, 0xD1B71758E219652C
	mul [.filetime]
	shr rdx, 13 ; = [.filetime]/10_000

	; offset to Unix epoch ( January 1, 1970 UTC) based time

	mov	rax, -11644473600000
	add	rax, rdx

	bswap	rax
	rdseed	ax ; entropy
	ror	rax, 16
	mov	qword [.uuid], rax

	rdseed	rax ; entropy
	mov	qword [.uuid+8], rax

	; 4-bit version field (0b0111) and 2-bit variant field (0b10)
	and	dword [.uuid+6], 0xFF_3F_FF_0F
	or	dword [.uuid+6], 0x00_80_00_70
	leave
	retn
end if
