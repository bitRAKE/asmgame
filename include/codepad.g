; References:
;	Intel® 64 and IA-32 Architectures, Software Developer’s Manual
;	Vol 2B, Table 4-12. Recommended Multi-Byte Sequence of NOP Instruction
;
;	AMD Software Optimization Guide, Publication No. 56665
;	2.8.3.1 Encoding Padding for Loop Alignment
;
; Notes:
;
; + Multi-byte NOPs can improve code cache use, branch prediction
; and pipeline (OpCode cache) utilization.
;
; + Modern processors can discard several 0x90 NOPs during decode (i.e. no
; execution costs).
;
; + The best alignment can usually be achieved through instruction
; tuning. Non-critical code is poly-morphed into similar instructions
; with zero side-effects but longer encodings.
;
; - Profile code to understand how 16/32/64 byte alignment of loop and
; function entry addresses impact performance.
;
; - Some processors (P3, early P4) have a false dependancy on the rAX
; register when using these multi-byte NOPs. AMD processors (Family 15h)
; have a performance penalty for >3 override prefixes.
;
; - The instruction map lists several NOPs and many instructions can act
; like a NOP under some conditions. Use of “Reserved NOP” could break on
; future processors.

iterate bytes,\
	'',\
	0x90,\
	0x9066,\
	0x001F0F,\
	0x00401F0F,\
	0x0000441F0F,\
	0x0000441F0F66,\
	0x00000000801F0F,\
	0x0000000000841F0F,\
	0x0000000000841F0F66,\
\; Intel, two instruction forms:
\;	0x0000441F0F_0000441F0F,\
\;	0x0000441F0F66_0000441F0F,\
\;	0x0000441F0F66_0000441F0F66,\
\;	0x00000000801F0F_0000441F0F66,\
\;	0x00000000801F0F_00000000801F0F,\
\;	0x0000000000841F0F_00000000801F0F
\; AMD recommended forms:
	0x0000000000841F0F6666,\
	0x0000000000841F0F666666,\
	0x0000000000841F0F66666666,\
	0x0000000000841F0F6666666666,\
	0x0000000000841F0F666666666666,\
	0x0000000000841F0F66666666666666

	repeat 1, N:%-1
	calminstruction aligncode.N
		emit N,bytes
	end calminstruction
	end repeat
end iterate

calminstruction codepad length*
	local line
	compute length, length
limit:
	check length > 15
	jno tail
	call aligncode.9
	compute length, length - 9
	jump limit
tail:
	arrange length, =aligncode.length
	assemble length
end calminstruction
