
; Notes:
;	- ANSI and legacy 32-bit redirects produce an error
;	? Dbghelp ANSI functions are undecorated, wide-char functions have 'W' suffix.
;	- Comparitively, this API changes quite frequently.
;	- wip ...
;
; Modifications:
;	STACKFRAME64.Virtual		-> STACKFRAME64._Virtual
;	IMAGEHLP_STACK_FRAME.Virtual	-> IMAGEHLP_STACK_FRAME._Virtual
;	IMAGEHLP_SYMBOL_SRC.file	-> IMAGEHLP_SYMBOL_SRC._file
;	SYMSRV_INDEX_INFO.file		-> SYMSRV_INDEX_INFO._file
;	SYMSRV_INDEX_INFOW.file		-> SYMSRV_INDEX_INFOW._file
;
; References:
;	https://learn.microsoft.com/en-us/windows/win32/debug/debug-help-library





IMAGE_SEPARATION:=0x10000

struct LOADED_IMAGE
	ModuleName		dq ?	; PSTR
	hFile			dq ?	; HANDLE
	MappedAddress		dq ?	; PUCHAR
	FileHeader		dq ?	; PIMAGE_NT_HEADERS64
	LastRvaSection		dq ?	; PIMAGE_SECTION_HEADER
	NumberOfSections	dd ?,?	; ULONG
	Sections		dq ?	; PIMAGE_SECTION_HEADER
	Characteristics		dd ?	; ULONG
	fSystemImage		db ?	; BOOLEAN
	fDOSImage		db ?	; BOOLEAN
	fReadOnly		db ?	; BOOLEAN
	Version			db ?	; UCHAR
	Links			LIST_ENTRY
	SizeOfImage		dd ?,?	; ULONG
ends

MAX_SYM_NAME:=2000


; Error codes set by dbghelp functions.  Call GetLastError to see them.
; Dbghelp also sets error codes found in winerror.h

ERROR_IMAGE_NOT_STRIPPED:=0x8800 ; the image is not stripped.  No dbg file available.
ERROR_NO_DBG_POINTER	:=0x8801 ; image is stripped but there is no pointer to a dbg file
ERROR_NO_PDB_POINTER	:=0x8802 ; image does not point to a pdb file


UNDNAME_COMPLETE		:=0x0000 ; Enable full undecoration
UNDNAME_NO_LEADING_UNDERSCORES	:=0x0001 ; Remove leading underscores from MS extended keywords
UNDNAME_NO_MS_KEYWORDS		:=0x0002 ; Disable expansion of MS extended keywords
UNDNAME_NO_FUNCTION_RETURNS	:=0x0004 ; Disable expansion of return type for primary declaration
UNDNAME_NO_ALLOCATION_MODEL	:=0x0008 ; Disable expansion of the declaration model
UNDNAME_NO_ALLOCATION_LANGUAGE	:=0x0010 ; Disable expansion of the declaration language specifier
UNDNAME_NO_MS_THISTYPE		:=0x0020 ; NYI Disable expansion of MS keywords on the 'this' type for primary declaration
UNDNAME_NO_CV_THISTYPE		:=0x0040 ; NYI Disable expansion of CV modifiers on the 'this' type for primary declaration
UNDNAME_NO_THISTYPE		:=0x0060 ; Disable all modifiers on the 'this' type
UNDNAME_NO_ACCESS_SPECIFIERS	:=0x0080 ; Disable expansion of access specifiers for members
UNDNAME_NO_THROW_SIGNATURES	:=0x0100 ; Disable expansion of 'throw-signatures' for functions and pointers to functions
UNDNAME_NO_MEMBER_TYPE		:=0x0200 ; Disable expansion of 'static' or 'virtual'ness of members
UNDNAME_NO_RETURN_UDT_MODEL	:=0x0400 ; Disable expansion of MS model for UDT returns
UNDNAME_32_BIT_DECODE		:=0x0800 ; Undecorate 32-bit decorated names
UNDNAME_NAME_ONLY		:=0x1000 ; Crack only the name for primary declaration; return just [scope::]name. Does expand template params
UNDNAME_NO_ARGUMENTS		:=0x2000 ; Don't undecorate arguments to function
UNDNAME_NO_SPECIAL_SYMS		:=0x4000 ; Don't undecorate special names (v-table, vcall, vector xxx, metatype, etc)


; these values are used for synthesized file types that can be passed in as
; image headers instead of the standard ones from ntimage.h
DBHHEADER_DEBUGDIRS	:= 0x1
DBHHEADER_CVMISC	:= 0x2
DBHHEADER_PDBGUID	:= 0x3

struct MODLOAD_DATA
	ssize	dd ?
	ssig	dd ?
	data	dq ?
	size	dd ?
	flags	dd ?
ends

struct MODLOAD_CVMISC
	oCV	dd ?,?	; offset to the codeview record
	cCV	dq ?	; size of the codeview record
	oMisc	dd ?,?	; offset to the misc record
	cMisc	dq ?	; size of the misc record
	dtImage	dd ?	; datetime stamp of the image
	cImage	dd ?	; size of the image
ends

struct MODLOAD_PDBGUID_PDBAGE
	PdbGuid	rd 4	; Pdb Guid
	PdbAge	dd ?	; Pdb Age
ends


; enum ADDRESS_MODE
AddrMode1616:=0
AddrMode1632:=1
AddrModeReal:=2
AddrModeFlat:=3

struct ADDRESS64
	Offset	dq ?
	Segment	dw ?,?
	Mode	dd ?	; ADDRESS_MODE
ends



; This structure is included in the STACKFRAME structure, and is used to trace
; through usermode callbacks in a thread's kernel stack.  The values must be
; copied by the kernel debugger from the DBGKD_GET_VERSION and WAIT_STATE_CHANGE packets.

struct KDHELP64
; address of kernel thread object, as provided in the WAIT_STATE_CHANGE packet.
	Thread				dq ?

; offsets in thread object to pointer to the current callback:
	ThCallbackStack			dd ?	; frame in kernel stack.
	ThCallbackBStore		dd ?	; backing store frame in kernel stack.

; offsets to values in frame:
	NextCallback			dd ?	;	address of next callback frame
	FramePointer			dd ?	;	address of saved frame pointer (if applicable)

	KiCallUserMode			dq ?	; Address of the kernel function that calls out to user mode
	KeUserCallbackDispatcher	dq ?	; Address of the user mode dispatcher function
	SystemRangeStart		dq ?	; Lowest kernel mode address

; Address of the user mode exception dispatcher function, added in API version 10.
	KiUserExceptionDispatcher dq ?

; Stack bounds, added in API version 11.
	StackBase	dq ?
	StackLimit	dq ?

; Target OS build number. Added in API version 12.
	BuildVersion			dd ?
	RetpolineStubFunctionTableSize	dd ?
	RetpolineStubFunctionTable	dq ?
	RetpolineStubOffset		dd ?
	RetpolineStubSize		dd ?
	Reserved0			rq 2
ends


struct STACKFRAME64
	AddrPC		ADDRESS64	; program counter
	AddrReturn	ADDRESS64	; return address
	AddrFrame	ADDRESS64	; frame pointer
	AddrStack	ADDRESS64	; stack pointer
	AddrBStore	ADDRESS64	; backing store pointer
	FuncTableEntry	dq ?		; pointer to pdata/fpo or NULL
	Params		dq ?,?,?,?	; possible arguments to the function
	Far		dd ?		; BOOL, WOW far call
	_Virtual	dd ?		; BOOL, is this a virtual frame?
	Reserved	dq ?,?,?
	KdHelp		KDHELP64
ends

INLINE_FRAME_CONTEXT_INIT	:=0
INLINE_FRAME_CONTEXT_IGNORE	:=0xFFFFFFFF

struct STACKFRAME_EX
	; First, copy STACKFRAME64 structure:
	AddrPC		ADDRESS64	; program counter
	AddrReturn	ADDRESS64	; return address
	AddrFrame	ADDRESS64	; frame pointer
	AddrStack	ADDRESS64	; stack pointer
	AddrBStore	ADDRESS64	; backing store pointer
	FuncTableEntry	dq ?		; pointer to pdata/fpo or NULL
	Params		dq ?,?,?,?	; possible arguments to the function
	Far		dd ?		; BOOL, WOW far call
	_Virtual	dd ?		; BOOL, is this a virtual frame?
	Reserved	dq ?,?,?
	KdHelp		KDHELP64

	; Extended STACKFRAME fields
	StackFrameSize		dd ?
	InlineFrameContext	dd ?
ends


; Target Attributes:

; Asks the caller to return a 64-bit mask which indicates which bits in a
; code address are PAC bits. This attribute is only relevant for ARM64 debug
; targets. The attribute data must be the address for which the PAC mask is
; being fetched. This allows the caller to deal with differences in PAC
; masks for ARM64 EL0/1/2. If PAC is disabled or the attribute does not
; apply, FALSE should be returned from the attribute getter. If the special
; value TARGET_ATTRIBUTE_PACMASK_LIVETARGET is returned, the PAC mask for
; the call is assumed to be the same as the PAC mask for the currently
; running process.

TARGET_ATTRIBUTE_PACMASK:=0x00000001

; Target Attribute Special Values:
TARGET_ATTRIBUTE_PACMASK_LIVETARGET:=0xFFFFFFFFFFFFFFFF


SYM_STKWALK_DEFAULT		:=0x00000000
SYM_STKWALK_FORCE_FRAMEPTR	:=0x00000001
SYM_STKWALK_ZEROEXTEND_PTRS	:=0x00000002


API_VERSION_NUMBER:=12

struct API_VERSION
	MajorVersion	dw ?
	MinorVersion	dw ?
	Revision	dw ?
	Reserved	dw ?
ends


; enum SymTagEnum ; values found in SYMBOL_INFO.Tag
SymTagNull		:=0
SymTagExe		:=1
SymTagCompiland		:=2
SymTagCompilandDetails	:=3
SymTagCompilandEnv	:=4
SymTagFunction		:=5
SymTagBlock		:=6
SymTagData		:=7
SymTagAnnotation	:=8
SymTagLabel		:=9
SymTagPublicSymbol	:=10
SymTagUDT		:=11
SymTagEnum		:=12
SymTagFunctionType	:=13
SymTagPointerType	:=14
SymTagArrayType		:=15
SymTagBaseType		:=16
SymTagTypedef		:=17
SymTagBaseClass		:=18
SymTagFriend		:=19
SymTagFunctionArgType	:=20
SymTagFuncDebugStart	:=21
SymTagFuncDebugEnd	:=22
SymTagUsingNamespace	:=23
SymTagVTableShape	:=24
SymTagVTable		:=25
SymTagCustom		:=26
SymTagThunk		:=27
SymTagCustomType	:=28
SymTagManagedType	:=29
SymTagDimension		:=30
SymTagCallSite		:=31
SymTagInlineSite	:=32
SymTagBaseInterface	:=33
SymTagVectorType	:=34
SymTagMatrixType	:=35
SymTagHLSLType		:=36
SymTagCaller		:=37
SymTagCallee		:=38
SymTagExport		:=39
SymTagHeapAllocationSite:=40
SymTagCoffGroup		:=41
SymTagInlinee		:=42
SymTagTaggedUnionCase	:=43	; a case of a tagged union UDT type
SymTagMax		:=44

; flags found in SYMBOL_INFO.Flags
SYMFLAG_VALUEPRESENT		:=0x00000001
SYMFLAG_REGISTER		:=0x00000008
SYMFLAG_REGREL			:=0x00000010
SYMFLAG_FRAMEREL		:=0x00000020
SYMFLAG_PARAMETER		:=0x00000040
SYMFLAG_LOCAL			:=0x00000080
SYMFLAG_CONSTANT		:=0x00000100
SYMFLAG_EXPORT			:=0x00000200
SYMFLAG_FORWARDER		:=0x00000400
SYMFLAG_FUNCTION		:=0x00000800
SYMFLAG_VIRTUAL			:=0x00001000
SYMFLAG_THUNK			:=0x00002000
SYMFLAG_TLSREL			:=0x00004000
SYMFLAG_SLOT			:=0x00008000
SYMFLAG_ILREL			:=0x00010000
SYMFLAG_METADATA		:=0x00020000
SYMFLAG_CLR_TOKEN		:=0x00040000
SYMFLAG_NULL			:=0x00080000
SYMFLAG_FUNC_NO_RETURN		:=0x00100000
SYMFLAG_SYNTHETIC_ZEROBASE	:=0x00200000
SYMFLAG_PUBLIC_CODE		:=0x00400000
SYMFLAG_REGREL_ALIASINDIR	:=0x00800000
SYMFLAG_FIXUP_ARM64X		:=0x01000000
SYMFLAG_GLOBAL			:=0x02000000
; this resets SymNext/Prev to the beginning of the module passed in the address field
SYMFLAG_RESET			:=0x80000000

; SYM_TYPE ; symbol type enumeration
SymNone 	:=0
SymCoff		:=1
SymCv		:=2
SymPdb		:=3
SymExport	:=4
SymDeferred	:=5
SymSym		:=6	; .sym file
SymDia		:=7
SymVirtual	:=8
NumSymTypes	:=9

struct IMAGEHLP_SYMBOLW64
	SizeOfStruct	dd ?,?	; set to sizeof(IMAGEHLP_SYMBOL64)
	Address		dq ?	; virtual address including dll base address
	Size		dd ?	; estimated size of symbol, can be zero
	Flags		dd ?	; info about the symbols, see the SYMF defines
	MaxNameLength	dd ?	; maximum size of symbol name in 'Name'
	Name		rw 2	; WCHAR[?] symbol name (null terminated string)
ends
struct IMAGEHLP_SYMBOLW64_PACKAGE
	sym	IMAGEHLP_SYMBOLW64
	name	rw 4+MAX_SYM_NAME ; *alignment*
ends

struct IMAGEHLP_MODULEW64 ; 3264 bytes, align 8
	SizeOfStruct	dd ?,?	; set to sizeof(IMAGEHLP_MODULE64)
	BaseOfImage	dq ?	; base load address of module
	ImageSize	dd ?	; virtual size of the loaded module
	TimeDateStamp	dd ?	; date/time stamp from pe header
	CheckSum	dd ?	; checksum from the pe header
	NumSyms		dd ?	; number of symbols in the symbol table
	SymType		dd ?	; SYM_TYPE ; type of symbols loaded
	ModuleName	rw 32	; WCHAR[] module name
	ImageName	rw 256	; WCHAR[] image name
	LoadedImageName	rw 256	; WCHAR[] symbol file name
	LoadedPdbName	rw 256	; WCHAR[] pdb file name
	CVSig		dd ?	; Signature of the CV record in the debug directories
	CVData		rw 3*MAX_PATH ; WCHAR[] ; Contents of the CV record
	PdbSig		dd ?	; Signature of PDB
	PdbSig70	rd 4	; GUID ; Signature of PDB (VC 7 and up)
	PdbAge		dd ?	; DBI age of pdb
	PdbUnmatched	dd ?	; BOOL ; loaded an unmatched pdb
	DbgUnmatched	dd ?	; BOOL ; loaded an unmatched dbg
	LineNumbers	dd ?	; BOOL ; we have line number information
	GlobalSymbols	dd ?	; BOOL ; we have internal symbol information
	TypeInfo	dd ?	; BOOL ; we have type information
	SourceIndexed	dd ?	; BOOL ; pdb supports source server
	Publics		dd ?	; BOOL ; contains public symbols
	MachineType	dd ?	; IMAGE_FILE_MACHINE_XXX from ntimage.h and winnt.h
	Reserved	dd ?,?	; Padding - don't remove.
ends

; (Extended) WIDE version of IMAGEHLP_MODULEW64 that supports Search Hints
struct IMAGEHLP_MODULEW64_EX
	Module		IMAGEHLP_MODULEW64
	RegionFlags	dd ?,?	; Region Search Flags - IMAGEHLP_MODULE_REGION_XXX
ends


IMAGEHLP_MODULE_REGION_DLLBASE		:=0x01
IMAGEHLP_MODULE_REGION_DLLRANGE		:=0x02
IMAGEHLP_MODULE_REGION_ADDITIONAL	:=0x04
IMAGEHLP_MODULE_REGION_JIT		:=0x08
IMAGEHLP_MODULE_REGION_ALL		:=0xFF


struct IMAGEHLP_LINE64 ; A/W same
	SizeOfStruct	dd ?,?	; set to sizeof(IMAGEHLP_LINE64)
	Key		dq ?	; internal
	LineNumber	dd ?,?	; line number in file
	FileName	dq ?	; WCHAR[] or CHAR[] ; full filename
	Address		dq ?	; first instruction of line
ends

struct SOURCEFILE ; A/W same
	ModBase		dq ?	; base address of loaded module
	FileName	dq ?	; WCHAR[] or CHAR[] ; full filename of source
ends


; data structures used for registered symbol callbacks

CBA_DEFERRED_SYMBOL_LOAD_START			:=0x00000001
CBA_DEFERRED_SYMBOL_LOAD_COMPLETE		:=0x00000002
CBA_DEFERRED_SYMBOL_LOAD_FAILURE		:=0x00000003
CBA_SYMBOLS_UNLOADED				:=0x00000004
CBA_DUPLICATE_SYMBOL				:=0x00000005
CBA_READ_MEMORY					:=0x00000006
CBA_DEFERRED_SYMBOL_LOAD_CANCEL			:=0x00000007

CBA_SET_OPTIONS					:=0x00000008
CBA_EVENT					:=0x00000010
CBA_DEFERRED_SYMBOL_LOAD_PARTIAL		:=0x00000020

CBA_DEBUG_INFO					:=0x10000000
CBA_SRCSRV_INFO					:=0x20000000
CBA_SRCSRV_EVENT				:=0x40000000
CBA_UPDATE_STATUS_BAR				:=0x50000000
CBA_ENGINE_PRESENT				:=0x60000000
CBA_CHECK_ENGOPT_DISALLOW_NETWORK_PATHS		:=0x70000000
CBA_CHECK_ARM_MACHINE_THUMB_TYPE_OVERRIDE	:=0x80000000
CBA_XML_LOG					:=0x90000000
CBA_MAP_JIT_SYMBOL				:=0xA0000000


struct IMAGEHLP_CBA_READ_MEMORY
	addr		dq ?	; address to read from
	buf		dq ?	; buffer to read to
	bytes		dd ?,?	; amount of bytes to read
	bytesread	dq ?	; pointer to store amount of bytes read
ends

sevInfo		:=0
sevProblem	:=1
sevAttn		:=2
sevFatal	:=3
sevMax		:=4

EVENT_SRCSPEW_START	:=100
EVENT_SRCSPEW		:=100
EVENT_SRCSPEW_END	:=199

struct IMAGEHLP_CBA_EVENT ; W same
	severity	dd ?	; values from sevInfo to sevFatal
	code		dd ?	; numerical code IDs the error
	desc		dq ?	; may contain a text description of the error
	object		dq ?	; value dependant upon the error code
ends

struct IMAGEHLP_DEFERRED_SYMBOL_LOADW64 ; 568 bytes
	SizeOfStruct	dd ?,?		; set to sizeof(IMAGEHLP_DEFERRED_SYMBOL_LOADW64)
	BaseOfImage	dq ?		; base load address of module
	CheckSum	dd ?		; checksum from the pe header
	TimeDateStamp	dd ?		; date/time stamp from pe header
	FileName	rw 2+MAX_PATH	; WCHAR[], symbols file or image name
	Reparse		dd ?		; BOOLEAN, load failure reparse
	hFile		dq ?		; file handle, if passed
	Flags		dd ?,?		;
ends

DSLFLAG_MISMATCHED_PDB			:=0x01
DSLFLAG_MISMATCHED_DBG			:=0x02
FLAG_ENGINE_PRESENT			:=0x04
FLAG_ENGOPT_DISALLOW_NETWORK_PATHS	:=0x08
FLAG_OVERRIDE_ARM_MACHINE_TYPE		:=0x10

struct IMAGEHLP_DUPLICATE_SYMBOL64
	SizeOfStruct	dd ?	; set to sizeof(IMAGEHLP_DUPLICATE_SYMBOL64)
	NumberOfDups	dd ?	; number of duplicates in the Symbol array
	Symbol		dq ?	;*IMAGEHLP_SYMBOL64, array of duplicate symbols
	SelectedSymbol	dd ?,?	; symbol selected (-1 to start)
ends

struct IMAGEHLP_JIT_SYMBOL_MAP
	SizeOfStruct	dd ?,?	; set to sizeof(IMAGEHLP_JIT_SYMBOL_MAP)
	Address		dq ?	; address to map to JIT association with an image
	BaseOfImage	dq ?	; base load address (0 == unmapped)
ends

; enum IMAGEHLP_HD_TYPE
hdBase	:=0	; root directory for dbghelp
hdSym	:=1	; where symbols are stored
hdSrc	:=2	; where source is stored
hdMax	:=3	; end marker

struct OMAP
	rva	dd ?
	rvaTo	dd ?
ends


; options that are set/returned by SymSetOptions() & SymGetOptions()
; these are used as a mask

SYMOPT_CASE_INSENSITIVE			:=0x00000001
SYMOPT_UNDNAME				:=0x00000002
SYMOPT_DEFERRED_LOADS			:=0x00000004
SYMOPT_NO_CPP				:=0x00000008
SYMOPT_LOAD_LINES			:=0x00000010
SYMOPT_OMAP_FIND_NEAREST		:=0x00000020
SYMOPT_LOAD_ANYTHING			:=0x00000040
SYMOPT_IGNORE_CVREC			:=0x00000080
SYMOPT_NO_UNQUALIFIED_LOADS		:=0x00000100
SYMOPT_FAIL_CRITICAL_ERRORS		:=0x00000200
SYMOPT_EXACT_SYMBOLS			:=0x00000400
SYMOPT_ALLOW_ABSOLUTE_SYMBOLS		:=0x00000800
SYMOPT_IGNORE_NT_SYMPATH		:=0x00001000
SYMOPT_INCLUDE_32BIT_MODULES		:=0x00002000
SYMOPT_PUBLICS_ONLY			:=0x00004000
SYMOPT_NO_PUBLICS			:=0x00008000
SYMOPT_AUTO_PUBLICS			:=0x00010000
SYMOPT_NO_IMAGE_SEARCH			:=0x00020000
SYMOPT_SECURE				:=0x00040000
SYMOPT_NO_PROMPTS			:=0x00080000
SYMOPT_OVERWRITE			:=0x00100000
SYMOPT_IGNORE_IMAGEDIR			:=0x00200000
SYMOPT_FLAT_DIRECTORY			:=0x00400000
SYMOPT_FAVOR_COMPRESSED			:=0x00800000
SYMOPT_ALLOW_ZERO_ADDRESS		:=0x01000000
SYMOPT_DISABLE_SYMSRV_AUTODETECT	:=0x02000000
SYMOPT_READONLY_CACHE			:=0x04000000
SYMOPT_SYMPATH_LAST			:=0x08000000
SYMOPT_DISABLE_FAST_SYMBOLS		:=0x10000000
SYMOPT_DISABLE_SYMSRV_TIMEOUT		:=0x20000000
SYMOPT_DISABLE_SRVSTAR_ON_STARTUP	:=0x40000000
SYMOPT_DEBUG				:=0x80000000


; enum IMAGEHLP_EXTENDED_OPTIONS
SYMOPT_EX_DISABLEACCESSTIMEUPDATE	:=0 ; Disable File Last Access Time on Symbols
SYMOPT_EX_LASTVALIDDEBUGDIRECTORY	:=1 ; For entries with multiple debug directories: prefer the last to the first
SYMOPT_EX_NOIMPLICITPATTERNSEARCH	:=2 ; For SymEnum* APIs: never implicitly run a pattern search without explicit pattern characters
SYMOPT_EX_NEVERLOADSYMBOLS		:=3 ; Never try to load and parse symbols 
SYMOPT_EX_MAX				:=4 ; Unused

struct SRCCODEINFOW ; 1080
	SizeOfStruct	dd ?,?		; set to sizeof(SRCCODEINFOW)
	Key		dq ?		; not used
	ModBase		dq ?		; base address of module this applies to
	Obj		rw 1+MAX_PATH	; WCHAR[], the object file within the module
	FileName	rw 1+MAX_PATH	; WCHAR[], full filename
	LineNumber	dd ?		; line number in file
	Address		dq ?		; first instruction of line
ends

SYM_INLINE_COMP_ERROR		:=0
SYM_INLINE_COMP_IDENTICAL	:=1
SYM_INLINE_COMP_STEPIN		:=2
SYM_INLINE_COMP_STEPOUT		:=3
SYM_INLINE_COMP_STEPOVER	:=4
SYM_INLINE_COMP_DIFFERENT	:=5

; flags for SymEnumSourceLines
ESLFLAG_FULLPATH	:=0x00000001
ESLFLAG_NEAREST		:=0x00000002
ESLFLAG_PREV		:=0x00000004
ESLFLAG_NEXT		:=0x00000008
ESLFLAG_INLINE_SITE	:=0x00000010

SLMFLAG_VIRTUAL		:=0x1
SLMFLAG_ALT_INDEX	:=0x2
SLMFLAG_NO_SYMBOLS	:=0x4


struct IMAGEHLP_SYMBOL_SRC ; not used anywhere?
	sizeofstruct	dd ?
	type		dd ?
	_file		rb MAX_PATH ; char[]
ends

struct MODULE_TYPE_INFO ; AKA TYPTYP
	dataLength	dw ?
	leaf		dw ?
	data		rb 2	; BYTE[?]
ends

struct SYMBOL_INFOW
	SizeOfStruct	dd ?	;
	TypeIndex	dd ?	; Type Index of symbol
	Reserved	dq ?,?	;
	Index		dd ?	;
	Size		dd ?	;
	ModBase		dq ?	; Base Address of module comtaining this symbol
	Flags		dd ?,?	; SYMFLAG_*
	Value		dq ?	; Value of symbol, ValuePresent should be 1
	Address		dq ?	; Address of symbol including base address of module
	Register	dd ?	; register holding value or pointer to value
	Scope		dd ?	; scope of the symbol
	Tag		dd ?	; enum SymTag* ; pdb classification
	NameLen		dd ?	; Actual length of name
	MaxNameLen	dd ?	;
	Name		rw 2	; WCHAR[?], Name of symbol
ends

struct SYMBOL_INFO_PACKAGEW ; 4096 bytes
	si	SYMBOL_INFOW
	name	rw 4+MAX_SYM_NAME	; WCHAR[] ; *alignment*
ends

struct IMAGEHLP_STACK_FRAME
	InstructionOffset	dq ?
	ReturnOffset		dq ?
	FrameOffset		dq ?
	StackOffset		dq ?
	BackingStoreOffset	dq ?
	FuncTableEntry		dq ?
	Params			rq 4
	Reserved		rq 5
	_Virtual		dd ?
	Reserved2		dd ?
ends


SYMENUM_OPTIONS_DEFAULT	:=0x00000001
SYMENUM_OPTIONS_INLINE	:=0x00000002


SYMSEARCH_MASKOBJS	:=0x01	; used internally to implement other APIs
SYMSEARCH_RECURSE	:=0x02	; recurse scopes
SYMSEARCH_GLOBALSONLY	:=0x04	; search only for global symbols
SYMSEARCH_ALLITEMS	:=0x08	; search for everything in the pdb, not just normal scoped symbols


; enum IMAGEHLP_SYMBOL_TYPE_INFO
TI_GET_SYMTAG					:=0
TI_GET_SYMNAME					:=1
TI_GET_LENGTH					:=2
TI_GET_TYPE					:=3
TI_GET_TYPEID					:=4
TI_GET_BASETYPE					:=5
TI_GET_ARRAYINDEXTYPEID				:=6
TI_FINDCHILDREN					:=7
TI_GET_DATAKIND					:=8
TI_GET_ADDRESSOFFSET				:=9
TI_GET_OFFSET					:=10
TI_GET_VALUE					:=11
TI_GET_COUNT					:=12
TI_GET_CHILDRENCOUNT				:=13
TI_GET_BITPOSITION				:=14
TI_GET_VIRTUALBASECLASS				:=15
TI_GET_VIRTUALTABLESHAPEID			:=16
TI_GET_VIRTUALBASEPOINTEROFFSET			:=17
TI_GET_CLASSPARENTID				:=18
TI_GET_NESTED					:=19
TI_GET_SYMINDEX					:=20
TI_GET_LEXICALPARENT				:=21
TI_GET_ADDRESS					:=22
TI_GET_THISADJUST				:=23
TI_GET_UDTKIND					:=24
TI_IS_EQUIV_TO					:=25
TI_GET_CALLING_CONVENTION			:=26
TI_IS_CLOSE_EQUIV_TO				:=27
TI_GTIEX_REQS_VALID				:=28
TI_GET_VIRTUALBASEOFFSET			:=29
TI_GET_VIRTUALBASEDISPINDEX			:=30
TI_GET_IS_REFERENCE				:=31
TI_GET_INDIRECTVIRTUALBASECLASS			:=32
TI_GET_VIRTUALBASETABLETYPE			:=33
TI_GET_OBJECTPOINTERTYPE			:=34
TI_GET_DISCRIMINATEDUNION_TAG_TYPEID		:=35
TI_GET_DISCRIMINATEDUNION_TAG_OFFSET		:=36
TI_GET_DISCRIMINATEDUNION_TAG_RANGESCOUNT	:=37
TI_GET_DISCRIMINATEDUNION_TAG_RANGES		:=38
IMAGEHLP_SYMBOL_TYPE_INFO_MAX			:=39


struct TI_FINDCHILDREN_PARAMS
	Count	dd ?
	Start	dd ?
	ChildId	dd ? ; ULONG[?]
ends

IMAGEHLP_GET_TYPE_INFO_UNCACHED:=0x00000001
IMAGEHLP_GET_TYPE_INFO_CHILDREN:=0x00000002

struct IMAGEHLP_GET_TYPE_INFO_PARAMS
	SizeOfStruct	dd ?	; IN
	Flags		dd ?	; IN
	NumIds		dd ?,?	; IN
	TypeIds		dq ?	; IN
	TagFilter	dq ?	; IN
	NumReqs		dd ?,?	; IN
	ReqKinds	dq ?	; IN ;*IMAGEHLP_SYMBOL_TYPE_INFO
	ReqOffsets	dq ?	; IN
	ReqSizes	dq ?	; IN
	ReqStride	dq ?	; IN
	BufferSize	dq ?	; IN
	Buffer		dq ?	; OUT
	EntriesMatched	dd ?	; OUT
	EntriesFilled	dd ?	; OUT
	TagsFound	dq ?	; OUT
	AllReqsValid	dq ?	; OUT
	NumReqsValid	dd ?,?	; IN
	ReqsValid 	dq ?	; OUT OPTIONAL
ends

struct SYMSRV_INDEX_INFOW ; 1608 bytes
	sizeofstruct	dd ?
	_file		rw 2+MAX_PATH	; WCHAR []
	stripped	dd ?		; BOOL
	timestamp	dd ?
	size		dd ?
	dbgfile		rw 1+MAX_PATH	; WCHAR[]
	pdbfile		rw 1+MAX_PATH	; WCHAR[]
	guid		rd 4		; GUID
	sig		dd ?
	age		dd ?
ends


; enum IMAGEHLP_SF_TYPE ; used by SymGetSymbolFile's "Type" parameter
sfImage	:=0
sfDbg	:=1
sfPdb	:=2
sfMpd	:=3
sfMax	:=4


EXT_OUTPUT_VER:=1


struct SYMSRV_EXTENDED_OUTPUT_DATA
	sizeOfStruct	dd ?		; size of the structure
	version		dd ?		; version number (EXT_OUTPUT_VER)
	filePtrMsg	rw 2+MAX_PATH	; File ptr message data buffer
ends

SYMSRV_VERSION:=2

SSRVOPT_CALLBACK		:=0x00000001
SSRVOPT_DWORD			:=0x00000002
SSRVOPT_DWORDPTR		:=0x00000004
SSRVOPT_GUIDPTR			:=0x00000008
SSRVOPT_OLDGUIDPTR		:=0x00000010
SSRVOPT_UNATTENDED		:=0x00000020
SSRVOPT_NOCOPY			:=0x00000040
SSRVOPT_GETPATH			:=0x00000040
SSRVOPT_PARENTWIN		:=0x00000080
SSRVOPT_PARAMTYPE		:=0x00000100
SSRVOPT_SECURE			:=0x00000200
SSRVOPT_TRACE			:=0x00000400
SSRVOPT_SETCONTEXT		:=0x00000800
SSRVOPT_PROXY			:=0x00001000
SSRVOPT_DOWNSTREAM_STORE	:=0x00002000
SSRVOPT_OVERWRITE		:=0x00004000
SSRVOPT_RESETTOU		:=0x00008000
SSRVOPT_CALLBACKW		:=0x00010000
SSRVOPT_FLAT_DEFAULT_STORE	:=0x00020000
SSRVOPT_PROXYW			:=0x00040000
SSRVOPT_MESSAGE			:=0x00080000
SSRVOPT_SERVICE			:=0x00100000 ; deprecated
SSRVOPT_FAVOR_COMPRESSED	:=0x00200000
SSRVOPT_STRING			:=0x00400000
SSRVOPT_WINHTTP			:=0x00800000
SSRVOPT_WININET			:=0x01000000
SSRVOPT_DONT_UNCOMPRESS		:=0x02000000
SSRVOPT_DISABLE_PING_HOST	:=0x04000000
SSRVOPT_DISABLE_TIMEOUT		:=0x08000000
SSRVOPT_ENABLE_COMM_MSG		:=0x10000000
SSRVOPT_URI_FILTER		:=0x20000000
SSRVOPT_URI_TIERS		:=0x40000000
SSRVOPT_RETRY_APP_HANG		:=0x80000000
SSRVOPT_MAX			:=0x80000000
SSRVOPT_RESET			:=(1 shl 64)-1

NUM_SSRVOPTS:=32

SSRVURI_HTTP_NORMAL	:=0x01
SSRVURI_HTTP_COMPRESSED	:=0x02
SSRVURI_HTTP_FILEPTR	:=0x04

SSRVURI_UNC_NORMAL	:=0x10
SSRVURI_UNC_COMPRESSED	:=0x20
SSRVURI_UNC_FILEPTR	:=0x40

SSRVURI_HTTP_MASK	:=0x0F
SSRVURI_UNC_MASK	:=0xF0
SSRVURI_ALL		:=0xFF

SSRVACTION_TRACE		:=1
SSRVACTION_QUERYCANCEL		:=2
SSRVACTION_EVENT		:=3
SSRVACTION_EVENTW		:=4
SSRVACTION_SIZE			:=5
SSRVACTION_HTTPSTATUS		:=6
SSRVACTION_XMLOUTPUT		:=7
SSRVACTION_CHECKSUMSTATUS	:=8


SYMSTOREOPT_COMPRESS		:=0x01
SYMSTOREOPT_OVERWRITE		:=0x02
SYMSTOREOPT_RETURNINDEX		:=0x04
SYMSTOREOPT_POINTER		:=0x08
SYMSTOREOPT_ALT_INDEX		:=0x10
SYMSTOREOPT_UNICODE		:=0x20
SYMSTOREOPT_PASS_IF_EXISTS	:=0x40

struct DBGHELP_DATA_REPORT_STRUCT
	pBinPathNonExist	dq ? ; PCWSTR
	pSymbolPathNonExist	dq ? ; PCWSTR
ends

IMAGEHLP_SYMBOL_INFO_VALUEPRESENT:=1

IMAGEHLP_RMAP_MAPPED_FLAT	:=0x00000001
IMAGEHLP_RMAP_BIG_ENDIAN	:=0x00000002
IMAGEHLP_RMAP_IGNORE_MISCOMPARE	:=0x00000004

IMAGEHLP_RMAP_FIXUP_ARM64X			:=0x10000000
IMAGEHLP_RMAP_LOAD_RW_DATA_SECTIONS		:=0x20000000
IMAGEHLP_RMAP_OMIT_SHARED_RW_DATA_SECTIONS	:=0x40000000
IMAGEHLP_RMAP_FIXUP_IMAGEBASE			:=0x80000000


;-------------------------------------------------------------------------------
; These functions are said to be redirected to the *64 variant for both 32-bit and 64-bit.
; https://learn.microsoft.com/en-us/windows/win32/debug/updated-platform-support
iterate _func_,\
	EnumerateLoadedModules,\
	StackWalk,\
	SymEnumerateModules,\
	SymEnumerateSymbols,\
	SymEnumerateSymbolsW,\
	SymFunctionTableAccess,\
	SymGetLineFromAddr,\
	SymGetLineFromName,\
	SymGetLineNext,\
	SymGetLinePrev,\
	SymGetModuleInfo,\
	SymGetModuleInfoW,\
	SymGetModuleBase,\
	SymGetSymFromAddr,\
	SymGetSymFromName,\
	SymGetSymNext,\
	SymGetSymPrev,\
	SymLoadModule,\
	SymRegisterCallback,\
	SymRegisterFunctionEntryCallback,\
	SymUnDName,\
	SymUnloadModule
	calminstruction _func_ line&
		err 'use more efficient *64 version of function'
	end calminstruction
end iterate

; also, don't use the following structures
iterate _struc_,\
	ADDRESS,\
	IMAGEHLP_DEFERRED_SYMBOL_LOAD,\
	IMAGEHLP_DUPLICATE_SYMBOL,\
	IMAGEHLP_LINE,\
	IMAGEHLP_MODULE,\
	IMAGEHLP_SYMBOL,\
	KDHELP,\
	STACKFRAME
	calminstruction(NAMED) _struc_ line&
		err 'do not use deprecated structure'
	end calminstruction
end iterate

;-------------------------------------------------------------------------------
; may as well avoid the ANSI functions, too
iterate _func_,\
	DbgHelpCreateUserDump,\
	EnumDirTree,\
	EnumerateLoadedModules64,\
	EnumerateLoadedModulesEx,\
	FindDebugInfoFileEx,\
	FindExecutableImageEx,\
	SearchTreeForFile,\
	SymAddSourceStreamA,\
	SymAddSymbol,\
	SymDeleteSymbol,\
	SymEnumLines,\
	SymEnumSourceFiles,\
	SymEnumSourceLines,\
	SymEnumSymbols,\
	SymEnumSymbolsEx,\
	SymEnumSymbolsForAddr,\
	SymEnumTypes,\
	SymEnumTypesByName,\
	SymEnumerateModules64,\
	SymEnumerateSymbols64,\
	SymFindDebugInfoFile,\
	SymFindExecutableImage,\
	SymFindFileInPath,\
	SymFromAddr,\
	SymFromIndex,\
	SymFromInlineContext,\
	SymFromName,\
	SymFromToken,\
	SymGetHomeDirectory,\
	SymGetLineFromAddr64,\
	SymGetLineFromInlineContext,\
	SymGetLineFromName64,\
	SymGetLineNext64,\
	SymGetLinePrev64,\
	SymGetModuleInfo64,\
	SymGetScope,\
	SymGetSearchPath,\
	SymGetSourceFileChecksum,\
	SymGetSourceFile,\
	SymGetSourceFileFromToken,\
	SymGetSourceFileFromTokenByTokenName,\
	SymGetSourceFileToken,\
	SymGetSourceFileTokenByTokenName,\
	SymGetSourceVarFromToken,\
	SymGetSymbolFile,\
	SymGetTypeFromName,\
	SymInitialize,\
	SymLoadModuleEx,\
	SymMatchFileName,\
	SymMatchStringA,\
	SymNext,\
	SymPrev,\
	SymRegisterCallback64,\
	SymSearch,\
	SymSetHomeDirectory,\
	SymSetSearchPath,\
	SymSrvDeltaName,\
	SymSrvGetFileIndexInfo,\
	SymSrvGetFileIndexString,\
	SymSrvGetFileIndexes,\
	SymSrvGetSupplement,\
	SymSrvIsStore,\
	SymSrvStoreFile,\
	SymSrvStoreSupplement,\
	UnDecorateSymbolName
	calminstruction _func_ line&
		err 'use WIDE/UNICODE version of function'
	end calminstruction
end iterate
