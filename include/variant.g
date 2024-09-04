
; wtypes & oaidl

; VARENUM usage key,
;	* [V] - may appear in a VARIANT
;	* [T] - may appear in a TYPEDESC
;	* [P] - may appear in an OLE property set
;	* [S] - may appear in a Safe Array
;
; VT_EMPTY		[V]   [P]	nothing
; VT_NULL		[V]   [P]	SQL style Null
; VT_I2			[V][T][P][S]	2 byte signed int
; VT_I4			[V][T][P][S]	4 byte signed int
; VT_R4			[V][T][P][S]	4 byte real
; VT_R8			[V][T][P][S]	8 byte real
; VT_CY			[V][T][P][S]	currency
; VT_DATE		[V][T][P][S]	date
; VT_BSTR		[V][T][P][S]	OLE Automation string
; VT_DISPATCH		[V][T]   [S]	IDispatch *
; VT_ERROR		[V][T][P][S]	SCODE
; VT_BOOL		[V][T][P][S]	True=-1, False=0
; VT_VARIANT		[V][T][P][S]	VARIANT *
; VT_UNKNOWN		[V][T]   [S]	IUnknown *
; VT_DECIMAL		[V][T]   [S]	16 byte fixed point
; VT_RECORD		[V]   [P][S]	user defined type
; VT_I1			[V][T][P][s]	signed char
; VT_UI1		[V][T][P][S]	unsigned char
; VT_UI2		[V][T][P][S]	unsigned short
; VT_UI4		[V][T][P][S]	ULONG
; VT_I8			   [T][P]	signed 64-bit int
; VT_UI8		   [T][P]	unsigned 64-bit int
; VT_INT		[V][T][P][S]	signed machine int
; VT_UINT		[V][T]   [S]	unsigned machine int
; VT_INT_PTR		   [T]		signed machine register size width
; VT_UINT_PTR		   [T]		unsigned machine register size width
; VT_VOID		   [T]		C style void
; VT_HRESULT		   [T]		standard return type
; VT_PTR		   [T]		pointer type
; VT_SAFEARRAY		   [T]		(use VT_ARRAY in VARIANT)
; VT_CARRAY		   [T]		C style array
; VT_USERDEFINED	   [T]		user defined type
; VT_LPSTR		   [T][P]	null terminated string
; VT_LPWSTR		   [T][P]	wide null terminated string
; VT_FILETIME		      [P]	FILETIME
; VT_BLOB		      [P]	length prefixed bytes
; VT_STREAM		      [P]	name of the stream follows
; VT_STORAGE		      [P]	name of the storage follows
; VT_STREAMED_OBJECT	      [P]	stream contains an object
; VT_STORED_OBJECT	      [P]	storage contains an object
; VT_VERSIONED_STREAM	      [P]	stream with a GUID version
; VT_BLOB_OBJECT	      [P]	blob contains an object 
; VT_CF			      [P]	clipboard format
; VT_CLSID		      [P]	a class ID
; VT_VECTOR		      [P]	simple counted array
; VT_ARRAY		[V]		SAFEARRAY*
; VT_BYREF		[V]		void* for local use
; VT_BSTR_BLOB ------------------------ reserved for system use

; enum VARENUM
VT_EMPTY		:=0
VT_NULL			:=1
VT_I2			:=2
VT_I4			:=3
VT_R4			:=4
VT_R8			:=5
VT_CY			:=6
VT_DATE			:=7
VT_BSTR			:=8
VT_DISPATCH		:=9
VT_ERROR		:=10
VT_BOOL			:=11
VT_VARIANT		:=12
VT_UNKNOWN		:=13
VT_DECIMAL		:=14
VT_I1			:=16
VT_UI1			:=17
VT_UI2			:=18
VT_UI4			:=19
VT_I8			:=20
VT_UI8			:=21
VT_INT			:=22
VT_UINT			:=23
VT_VOID			:=24
VT_HRESULT		:=25
VT_PTR			:=26
VT_SAFEARRAY		:=27
VT_CARRAY		:=28
VT_USERDEFINED		:=29
VT_LPSTR		:=30
VT_LPWSTR		:=31
VT_RECORD		:=36
VT_INT_PTR		:=37
VT_UINT_PTR		:=38
VT_FILETIME		:=64
VT_BLOB			:=65
VT_STREAM		:=66
VT_STORAGE		:=67
VT_STREAMED_OBJECT	:=68
VT_STORED_OBJECT	:=69
VT_BLOB_OBJECT		:=70
VT_CF			:=71
VT_CLSID		:=72
VT_VERSIONED_STREAM	:=73

VT_BSTR_BLOB	:=0x0FFF
VT_VECTOR	:=0x1000
VT_ARRAY	:=0x2000
VT_BYREF	:=0x4000
VT_RESERVED	:=0x8000
VT_ILLEGAL	:=0xFFFF
VT_ILLEGALMASKED:=0x0FFF
VT_TYPEMASK	:=0x0FFF


struct VARIANT
	vt		dw ?
	wReserved1	dw ?
	wReserved2	dw ?
	wReserved3	dw ?
	Val		dq ? ; document type use (see below to help conversion)
ends

; VARIANT STRUCTURE
;	VARTYPE vt;
;	WORD wReserved1;
;	WORD wReserved2;
;	WORD wReserved3;
;	union {
;		CHAR		VT_I1			cVal
;		BYTE		VT_UI1			bVal
;		SHORT		VT_I2			iVal
;		USHORT		VT_UI2			uiVal
;		LONG		VT_I4			lVal
;		FLOAT		VT_R4			fltVal
;		ULONG		VT_UI4			ulVal
;		LONGLONG	VT_I8			llVal
;		DOUBLE		VT_R8			dblVal
;		ULONGLONG	VT_UI8			ullVal
;		INT		VT_INT			intVal
;		UINT		VT_UINT			uintVal
;		VARIANT_BOOL	VT_BOOL			boolVal
;		SCODE		VT_ERROR		scode
;		CY		VT_CY			cyVal
;		DATE		VT_DATE			date
;		BSTR		VT_BSTR			bstrVal
;		IUnknown *	VT_UNKNOWN		punkVal
;		IDispatch *	VT_DISPATCH		pdispVal
;		SAFEARRAY *	VT_ARRAY		parray
;		PVOID		VT_BYREF(Generic ByRef)	byref
;		DECIMAL *	VT_BYREF|VT_DECIMAL	pdecVal
;
;		CHAR *		VT_BYREF|VT_I1
;		USHORT *	VT_BYREF|VT_UI2
;		ULONG *		VT_BYREF|VT_UI4
;		ULONGLONG *	VT_BYREF|VT_UI8
;		INT *		VT_BYREF|VT_INT
;		UINT *		VT_BYREF|VT_UINT
;		BYTE *		VT_BYREF|VT_UI1
;		SHORT *		VT_BYREF|VT_I2
;		LONG *		VT_BYREF|VT_I4
;		LONGLONG *	VT_BYREF|VT_I8
;		FLOAT *		VT_BYREF|VT_R4
;		DOUBLE *	VT_BYREF|VT_R8
;		VARIANT_BOOL *	VT_BYREF|VT_BOOL
;		SCODE *		VT_BYREF|VT_ERROR
;		CY *		VT_BYREF|VT_CY
;		DATE *		VT_BYREF|VT_DATE
;		BSTR *		VT_BYREF|VT_BSTR
;		IUnknown **	VT_BYREF|VT_UNKNOWN	ppunkVal
;		IDispatch **	VT_BYREF|VT_DISPATCH	ppdispVal
;		SAFEARRAY **	VT_BYREF|VT_ARRAY	pparray
;		VARIANT *	VT_BYREF|VT_VARIANT	pvarVal
;	}
;
