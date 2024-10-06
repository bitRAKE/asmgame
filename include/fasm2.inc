include 'dd.inc'
include 'align.inc'
include 'format.inc' ; extended format\coffms.inc
include 'x86-2.inc'
use everything
use AVX2

include '@@.inc'
include 'times.inc'
include 'fix.inc'

;--------------------------------------------------------------- more additions:
include 'codepad.g'
include 'const.g'
include 'reg_helper.g'


; Attempt to create a more verbose self-documenting syntax:
;	size
define VPCMPxSTRx
define VPCMPxSTRx.BYTE?		00h
define VPCMPxSTRx.WORD?		01h
;	type
define VPCMPxSTRx.UNSIGNED?	00h
define VPCMPxSTRx.SIGNED?	02h
;	mode
define VPCMPxSTRx.ANY?		00h
define VPCMPxSTRx.RANGES?	04h
define VPCMPxSTRx.EACH?		08h
define VPCMPxSTRx.ORDERED?	0Ch
;	polarity
define VPCMPxSTRx.POSITIVE?	00h
define VPCMPxSTRx.NEGATIVE?	10h
define VPCMPxSTRx.MASKED?	20h
;	return
define VPCMPxSTRx.LSB?		00h
define VPCMPxSTRx.MSB?		40h

iterate instr, pcmpestrm,pcmpestri,pcmpistrm,pcmpistri
	calminstruction instr? dest*,src*,imm*
		transform imm,VPCMPxSTRx
		asm instr dest,src,imm
	end calminstruction
	calminstruction v#instr? dest*,src*,imm*
		transform imm,VPCMPxSTRx
		asm v#instr dest,src,imm
	end calminstruction
end iterate


; compare constants (similar to intrinsics)
define CMPCONST CMPCONST
define CMPCONST.CMP_EQ_OQ	0x00 ; Equal (ordered, non-signaling)
define CMPCONST.CMP_LT_OS	0x01 ; Less-than (ordered, signaling)
define CMPCONST.CMP_LE_OS	0x02 ; Less-than-or-equal (ordered, signaling)
define CMPCONST.CMP_UNORD_Q	0x03 ; Unordered (non-signaling)
define CMPCONST.CMP_NEQ_UQ	0x04 ; Not-equal (unordered, non-signaling)
define CMPCONST.CMP_NLT_US	0x05 ; Not-less-than (unordered, signaling)
define CMPCONST.CMP_NLE_US	0x06 ; Not-less-than-or-equal (unordered, signaling)
define CMPCONST.CMP_ORD_Q	0x07 ; Ordered (nonsignaling)
define CMPCONST.CMP_EQ_UQ	0x08 ; Equal (unordered, non-signaling)
define CMPCONST.CMP_NGE_US	0x09 ; Not-greater-than-or-equal (unord, signaling)
define CMPCONST.CMP_NGT_US	0x0A ; Not-greater-than (unordered, signaling)
define CMPCONST.CMP_FALSE_OQ	0x0B ; False (ordered, non-signaling)
define CMPCONST.CMP_NEQ_OQ	0x0C ; Not-equal (ordered, non-signaling)
define CMPCONST.CMP_GE_OS	0x0D ; Greater-than-or-equal (ordered, signaling)
define CMPCONST.CMP_GT_OS	0x0E ; Greater-than (ordered, signaling)
define CMPCONST.CMP_TRUE_UQ	0x0F ; True (unordered, non-signaling)
define CMPCONST.CMP_EQ_OS	0x10 ; Equal (ordered, signaling)
define CMPCONST.CMP_LT_OQ	0x11 ; Less-than (ordered, non-signaling)
define CMPCONST.CMP_LE_OQ	0x12 ; Less-than-or-equal (ordered, non-signaling)
define CMPCONST.CMP_UNORD_S	0x13 ; Unordered (signaling)
define CMPCONST.CMP_NEQ_US	0x14 ; Not-equal (unordered, signaling)
define CMPCONST.CMP_NLT_UQ	0x15 ; Not-less-than (unordered, non-signaling)
define CMPCONST.CMP_NLE_UQ	0x16 ; Not-less-than-or-equal (unord, non-signaling)
define CMPCONST.CMP_ORD_S	0x17 ; Ordered (signaling)
define CMPCONST.CMP_EQ_US	0x18 ; Equal (unordered, signaling)
define CMPCONST.CMP_NGE_UQ	0x19 ; Not-greater-than-or-equal (unord, non-sign)
define CMPCONST.CMP_NGT_UQ	0x1A ; Not-greater-than (unordered, non-signaling)
define CMPCONST.CMP_FALSE_OS	0x1B ; False (ordered, signaling)
define CMPCONST.CMP_NEQ_OS	0x1C ; Not-equal (ordered, signaling)
define CMPCONST.CMP_GE_OQ	0x1D ; Greater-than-or-equal (ordered, non-signaling)
define CMPCONST.CMP_GT_OQ	0x1E ; Greater-than (ordered, non-signaling)
define CMPCONST.CMP_TRUE_US	0x1F ; True (unordered, signaling)

iterate instr, cmppd,cmpps,cmpsd,cmpss
	calminstruction instr? A*,B*,imm*
		transform imm, CMPCONST
		asm instr A,B,imm
	end calminstruction

	calminstruction v#instr? A*,B*,C*,imm*
		transform imm, CMPCONST
		asm v#instr A,B,C,imm
	end calminstruction
end iterate

;-------------------------------------------------------------------------------

iterate <instr,		vex_mpw,	evex_f,			opcode_rm,opcode_mr>,\
	vmovdqa,	VEX_66_0F_W0,	EVEX_W1+EVEX_VL,	6Fh,7Fh,\
	vmovdqu,	VEX_F3_0F_W0,	EVEX_W1+EVEX_VL,	6Fh,7Fh

	macro instr? dest*,src*
		AVX_512.parse_k1z_operand@dest dest
		AVX_512.parse_operand@src src
		if @dest.type = 'mmreg' & (@src.type = 'mmreg' | @src.type = 'mem')
			if @src.size and not @dest.size
				err 'operand sizes do not match'
			end if
			AVX_512.store_instruction@src @dest.size,vex_mpw,evex_f,opcode_rm,@dest.mask,@dest.rm
		else if @dest.type = 'mem' & @src.type = 'mmreg'
			if @dest.size and not @src.size
				err 'operand sizes do not match'
			end if
			AVX_512.store_instruction@dest @src.size,vex_mpw,evex_f,opcode_mr,@dest.mask,@src.rm
		else
			err 'invalid combination of operands'
		end if
	end macro

end iterate
