; const.g

calminstruction constdefine? var&
	local val
	arrange val,
	match var=  val, var
	publish var:, val
end calminstruction

; guid.g

struct GUID
	rb 16
ends
;
;postpone
;virtual at 0
;irpv G,__GUID__temp ; generate GUIDs in common data area
;	match name value,G
;		if used name
;			label name:16 at GUIDS+$
;			UUID value
;		end if
;	end match
;end irpv
;load __GUID__:$ from 0
;repeat 1,k:$
;	display 10,9,`k,' bytes for GUID'
;end repeat
;end virtual
;end postpone
;
;virtual CONST.64
;	GUIDS db __GUID__
;	align 64
;end virtual

;-------------------------------------------------------------------------------
; basic COM support

include 'UUID.g'
include 'variant.g'

define COM
define COM

; allowed {iid} forms: (named pointer to 16 bytes of data)
;	{0x03020100,0x0504,0x0706,0x0809,{0x0a,0x0b,0x0c,0x0d,0x0e,0x0f}}
;	{03020100-0504-0706-0809-0a0b0c0d0e0f}
;	03020100-0504-0706-0809-0a0b0c0d0e0f
;	extrn "{name}"
;	...
;:	interface vtbl offsets for manual use:
;::	fastcall.params [.irich]
;::	mov rax, [rcx]
;::	call [rax + IUnknown__Release]
;
;:	interface vtbl macros for terse use:
;::	IUnknown__Release [.irich]
;

struc(id) interface? iid,funcs&
	match ,iid
	else ; give it a name and pass it along
;		eval 'COM.GUIDS equ IID_',`id,' iid'
		if used IID_#id
			COFF.16.CONST IID_#id UUID iid
		end if
	end match
	match fun,funcs ; expand extensions
		iterate F,fun
			label id#__#F:qword at %*8-8

			calminstruction id#__#F line&
				arrange line, =fastcall {% * 8 - 8}, line
				assemble line
			end calminstruction
		end iterate
		constdefine EXTENDS__#id fun ; extension reference
	end match
	struc (object) id ; typify pointer to document COM interface
		object rq 1
;		macro object A&
;			match -> B= C, A
;				fastcall.params [object],C
;				mov rax,[rcx]
;				call [rax+id#__#B]
;			else match -> B , A
;				mov rcx,[object]
;				mov rax,[rcx]
;				call [rax+id#__#B]
;			else
;				err "COM: expecting an interface->function",13,10
;			end match
;		end macro
	end struc
end struc




; combaseapi.g

COINITBASE_MULTITHREADED:=0

REGCLS_SINGLEUSE	= 00h
REGCLS_MULTIPLEUSE	= 01h
REGCLS_MULTI_SEPARATE	= 02h
REGCLS_SUSPENDED	= 04h
REGCLS_SURROGATE	= 08h
REGCLS_AGILE		= 10h

SMEXF_SERVER     = 0x01
SMEXF_HANDLER    = 0x02

COM_RIGHTS_EXECUTE		:= 01h
COM_RIGHTS_EXECUTE_LOCAL	:= 02h
COM_RIGHTS_EXECUTE_REMOTE	:= 04h
COM_RIGHTS_ACTIVATE_LOCAL	:= 08h
COM_RIGHTS_ACTIVATE_REMOTE	:= 10h
COM_RIGHTS_RESERVED1		:= 20h
COM_RIGHTS_RESERVED2		:= 40h

COWAIT_DEFAULT			= 00h
COWAIT_WAITALL			= 01h
COWAIT_ALERTABLE		= 02h
COWAIT_INPUTAVAILABLE		= 04h
COWAIT_DISPATCH_CALLS		= 08h
COWAIT_DISPATCH_WINDOW_MESSAGES	= 10h

CWMO_DEFAULT = 0
CWMO_DISPATCH_CALLS = 1
CWMO_DISPATCH_WINDOW_MESSAGES = 2


; objbase.inc.g

COINIT_MULTITHREADED		:= 0
COINIT_APARTMENTTHREADED	:= 2
COINIT_DISABLE_OLE1DDE		:= 4
COINIT_SPEED_OVER_MEMORY	:= 8

MARSHALINTERFACE_MIN:=500

ASYNC_MODE_DEFAULT      :=0x00000000
ASYNC_MODE_COMPATIBILITY:=0x00000001

STGTY_REPEAT            :=0x00000100
STG_TOEND               :=0xFFFFFFFF

STG_LAYOUT_SEQUENTIAL   :=0x00000000
STG_LAYOUT_INTERLEAVED  :=0x00000001

SD_LAUNCHPERMISSIONS	:= 0	; Machine wide launch permissions
SD_ACCESSPERMISSIONS	:= 1	; Machine wide acesss permissions
SD_LAUNCHRESTRICTIONS	:= 2	; Machine wide launch limits
SD_ACCESSRESTRICTIONS	:= 3	; Machine wide access limits

; common HRESULT values:
; https://docs.microsoft.com/en-us/windows/win32/seccrypto/common-hresult-values
S_OK		:=00000000h	;
S_FALSE		:=00000001h	;

E_NOTIMPL	:=80004001h	; Not implemented
E_NOINTERFACE	:=80004002h	; No such interface supported
E_POINTER	:=80004003h	; Pointer that is not valid
E_ABORT		:=80004004h	; Operation aborted
E_FAIL		:=80004005h	; Unspecified failure
E_UNEXPECTED	:=8000FFFFh	; Unexpected failure
E_ACCESSDENIED	:=80070005h	; General access denied error
E_HANDLE	:=80070006h	; Handle that is not valid
E_OUTOFMEMORY	:=8007000Eh	; Failed to allocate necessary memory
E_INVALIDARG	:=80070057h	; One or more arguments are not valid


IUnknown	interface	00000000-0000-0000-C000-000000000046,\
	QueryInterface,AddRef,Release

IClassFactory	interface	00000001-0000-0000-C000-000000000046,\
	EXTENDS__IUnknown,\
	CreateInstance,LockServer

IDispatch	interface	00020400-0000-0000-C000-000000000046,\
	EXTENDS__IUnknown,\
	GetTypeInfoCount,GetTypeInfo,GetIDsOfNames,Invoke

AsyncIUnknown	interface	000E0000-0000-0000-C000-000000000046,\
	EXTENDS__IUnknown,\
	Begin_QueryInterface,\
	Finish_QueryInterface,\
	Begin_AddRef,\
	Finish_AddRef,\
	Begin_Release,\
	Finish_Release

;------------------------------------------------------------------ COM Helpers:

macro SAFE_RELEASE line&
	iterate object, line
		mov rcx, object
		jrcxz .%
		IUnknown__Release rcx
	.%:
	end iterate
end macro
