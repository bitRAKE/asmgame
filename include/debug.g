; Note: Obviously, this balloons the output - just for debug/test use!
DEBUG := 1
ERRMSG_INDEX = 0

;	calminstruction ✓ line& ; bypass
;		assemble line
;	end calminstruction

; Simplistic automatic error message string in R11:
;	+ error determination and branching remains in the code

macro ✓ line& ; wide-char version
	line
	; Resolve symbols here so COFF.2.CONST doesn't get a different values when delayed evaluation happens.
	repeat 1,N:ERRMSG_INDEX,L:__LINE__,F:__FILE__
		COFF.2.CONST dw DEBUG_ERRMSG.N.chars
		COFF.2.CONST DEBUG_ERRMSG.N du string F,', ',`L,': ',`line,10
		COFF.2.CONST DEBUG_ERRMSG.N.chars := ($ - DEBUG_ERRMSG.N) shr 1
		lea r11,[DEBUG_ERRMSG.N]
	end repeat
	ERRMSG_INDEX = 1+ERRMSG_INDEX
end macro
