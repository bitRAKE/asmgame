include 'dd.inc'
include 'align.inc'
include 'format.inc' ; extended format\coffms.inc
include 'x86-2.inc'
use everything

include '@@.inc'
include 'times.inc'
include 'fix.inc'

;--------------------------------------------------------------- more additions:
include 'const.g'
include 'reg_helper.g'

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
