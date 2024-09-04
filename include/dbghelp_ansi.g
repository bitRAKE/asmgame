
; ANSI specific structures (must have *W variant)

struct IMAGEHLP_SYMBOL64
	SizeOfStruct	dd ?,?	; set to sizeof(IMAGEHLP_SYMBOL64)
	Address		dq ?	; virtual address including dll base address
	Size		dd ?	; estimated size of symbol, can be zero
	Flags		dd ?	; info about the symbols, see the SYMF defines
	MaxNameLength	dd ?	; maximum size of symbol name in 'Name'
	Name		rb 4	; CHAR[?] symbol name (null terminated string)
ends
struct IMAGEHLP_SYMBOL64_PACKAGE
	sym	IMAGEHLP_SYMBOL64
	name	rb 8+MAX_SYM_NAME ; *alignment*
ends

struct IMAGEHLP_MODULE64 ; 1680 bytes, align 8
	SizeOfStruct	dd ?,?	; set to sizeof(IMAGEHLP_MODULE64)
	BaseOfImage	dq ?	; base load address of module
	ImageSize	dd ?	; virtual size of the loaded module
	TimeDateStamp	dd ?	; date/time stamp from pe header
	CheckSum	dd ?	; checksum from the pe header
	NumSyms		dd ?	; number of symbols in the symbol table
	SymType		dd ?	; SYM_TYPE ; type of symbols loaded
	ModuleName	rb 32	; CHAR[] module name
	ImageName	rb 256	; CHAR[] image name
	LoadedImageName	rb 256	; CHAR[] symbol file name
	LoadedPdbName	rb 256	; CHAR[] pdb file name
	CVSig		dd ?	; Signature of the CV record in the debug directories
	CVData		rb 3*MAX_PATH ; CHAR[] ; Contents of the CV record
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
	Reserved	dd ?	; Padding - don't remove.
ends

; (Extended) ANSI version of IMAGEHLP_MODULE64 that supports Search Hints
struct IMAGEHLP_MODULE64_EX
	Module		IMAGEHLP_MODULE64
	RegionFlags	dd ?,?	; Region Search Flags - IMAGEHLP_MODULE_REGION_XXX
ends

struct IMAGEHLP_DEFERRED_SYMBOL_LOAD64 ; 304 bytes
	SizeOfStruct	dd ?,?		; set to sizeof(IMAGEHLP_DEFERRED_SYMBOL_LOAD64)
	BaseOfImage	dq ?		; base load address of module
	CheckSum	dd ?		; checksum from the pe header
	TimeDateStamp	dd ?		; date/time stamp from pe header
	FileName	rb MAX_PATH	; CHAR[], symbols file or image name
	Reparse		dd ?		; BOOLEAN, load failure reparse
	hFile		dq ?		; file handle, if passed
	Flags		dd ?,?		;
ends

struct SRCCODEINFO ; 560
	SizeOfStruct	dd ?,?		; set to sizeof(SRCCODEINFO)
	Key		dq ?		; not used
	ModBase		dq ?		; base address of module this applies to
	Obj		rb 1+MAX_PATH	; CHAR[], the object file within the module
	FileName	rb 3+MAX_PATH	; CHAR[], full filename
	LineNumber	dd ?		; line number in file
	Address		dq ?		; first instruction of line
ends

struct SYMBOL_INFO
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
	Name		rb 4	; CHAR[?], Name of symbol
ends

struct SYMBOL_INFO_PACKAGE ; 2098 bytes
	si	SYMBOL_INFO
	name	rb 8+MAX_SYM_NAME	; CHAR[] ; *alignment*
ends

struct SYMSRV_INDEX_INFO ; 828 bytes
	sizeofstruct	dd ?
	_file		rb 4+MAX_PATH	; CHAR []
	stripped	dd ?		; BOOL
	timestamp	dd ?
	size		dd ?
	dbgfile		rb 1+MAX_PATH	; CHAR[]
	pdbfile		rb 3+MAX_PATH	; CHAR[]
	guid		rd 4		; GUID
	sig		dd ?
	age		dd ?
ends
