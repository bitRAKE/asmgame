;----------------------------------------------------------- more windows stuff
; missing constants


CP_UNICODE := 1200 ; I made this one up, why MS?

LOAD_LIBRARY_SEARCH_SYSTEM32 := 0x0000_0800

WS_EX_NOINHERITLAYOUT	:= 0x00100000
WS_EX_LAYOUTRTL		:= 0x00400000
WS_EX_COMPOSITED	:= 0x02000000
WS_EX_NOACTIVATE	:= 0x08000000

HTCAPTION := 2

GWL_STYLE := -16
GWL_EXSTYLE := -20

DIB_RGB_COLORS := 0

struc(register) MAKELONG low*,high*
	match [high] [low], high low
		; high word, zero high dword
		mov reg32.register, dword [high + 2]
		; non-destructive low word
		mov reg16.register, word [low]
	else
		err 'memory parameters expected'
	end match
end struc

IDI_SHIELD	:= 32518
IDI_WARNING	:= IDI_EXCLAMATION
IDI_ERROR	:= IDI_HAND
IDI_INFORMATION	:= IDI_ASTERISK

WM_CHANGEUISTATE:=0x0127
WM_UPDATEUISTATE:=0x0128
WM_QUERYUISTATE	:=0x0129

UIS_SET		:=1
UIS_CLEAR	:=2
UIS_INITIALIZE	:=3

UISF_HIDEFOCUS	:=0x1
UISF_HIDEACCEL	:=0x2
UISF_ACTIVE	:=0x4

struct VS_FIXEDFILEINFO
	dwSignature		dd ? ; 0xFEEF04BD
	dwStrucVersion		dd ?
	dwFileVersionMS		dd ?
	dwFileVersionLS		dd ?
	dwProductVersionMS	dd ?
	dwProductVersionLS	dd ?
	dwFileFlagsMask		dd ?
	dwFileFlags		dd ?
	dwFileOS		dd ?
	dwFileType		dd ?
	dwFileSubtype		dd ?
	dwFileDateMS		dd ?
	dwFileDateLS		dd ?
ends




; CommCtrl.inc ----------------------------------------------------------------
TB_ADDBUTTONSW := WM_USER + 68

; CommCtrl.inc ----------------------------------Ranges for control message IDs

ICC_NATIVEFNTCTL_CLASS	:=0x00002000	; native font
ICC_STANDARD_CLASSES	:=0x00004000	; intrinsic User32 classes: button, edit, static, listbox, combobox, and scroll bar.
ICC_LINK_CLASS		:=0x00008000	; hyperlink

LVM_FIRST	=0x1000 ; ListView messages
TV_FIRST	=0x1100 ; TreeView messages
HDM_FIRST	=0x1200 ; Header messages
TCM_FIRST	=0x1300 ; Tab control messages
PGM_FIRST	:=0x1400 ; Pager control messages
ECM_FIRST	:=0x1500 ; Edit control messages
BCM_FIRST	:=0x1600 ; Button control messages
CBM_FIRST	:=0x1700 ; Combobox control messages
CCM_FIRST	=0x2000 ; Common control shared messages
CCM_LAST	:=CCM_FIRST + 0x200

CCM_SETBKCOLOR		:=CCM_FIRST + 1 ; lParam is bkColor

struct COLORSCHEME
	dwSize		dd ?
	clrBtnHighlight	dd ?	; COLORREF, highlight color
	clrBtnShadow	dd ?	; COLORREF, shadow color
ends

CCM_SETCOLORSCHEME	=CCM_FIRST + 2 ; lParam is color scheme
CCM_GETCOLORSCHEME	=CCM_FIRST + 3 ; fills in COLORSCHEME pointed to by lParam
CCM_GETDROPTARGET	=CCM_FIRST + 4
CCM_SETUNICODEFORMAT	=CCM_FIRST + 5
CCM_GETUNICODEFORMAT	=CCM_FIRST + 6

CCM_SETVERSION		:=CCM_FIRST + 0x7
CCM_GETVERSION		:=CCM_FIRST + 0x8
CCM_SETNOTIFYWINDOW	:=CCM_FIRST + 0x9 ; wParam == hwndParent
CCM_SETWINDOWTHEME	:=CCM_FIRST + 0xb
CCM_DPISCALE		:=CCM_FIRST + 0xc ; wParam == Awareness

INFOTIPSIZE := 1024 ; for tooltips

NM_CUSTOMTEXT	:=NM_FIRST-24

struct NMCUSTOMTEXT
	hdr		NMHDR	;
	hDC		dq ?	; HDC
	lpString	dq ?	; LPCWSTR
	nCount		dd ?,?	; int
	lpRect		dq ?	; LPRECT
	uFormat		dd ?	; UINT
	fLink		dd ?	; BOOL
ends

struct NMCUSTOMDRAWINFO
	hdr		NMHDR
	dwDrawStage	dd ?,?
	hdc		dq ?	; HDC
	rc		RECT
	dwItemSpec	dq ?	; DWORD_PTR
	uItemState	dd ?,?	; UINT
	lItemlParam	dq ?	; LPARAM
ends


; CommCtrl.inc ---------------------------------------------------"ComboBoxEx32"
struct COMBOBOXEXITEMW
	mask		dd ?,?	; UINT
	iItem		dq ?	; INT_PTR
	pszText		dq ?	; LPWSTR
	cchTextMax	dd ?	; int
	iImage		dd ?	; int
	iSelectedImage	dd ?	; int
	iOverlay	dd ?	; int
	iIndent		dd ?,?	; int
	lParam		dq ?	; LPARAM
ends
CBEIF_TEXT		:=0x00000001
CBEIF_IMAGE		:=0x00000002
CBEIF_SELECTEDIMAGE	:=0x00000004
CBEIF_OVERLAY		:=0x00000008
CBEIF_INDENT		:=0x00000010
CBEIF_LPARAM		:=0x00000020
CBEIF_DI_SETITEM	:=0x10000000


CBEM_DELETEITEM         :=CB_DELETESTRING
CBEM_INSERTITEMA	:=WM_USER + 1
CBEM_SETIMAGELIST	:=WM_USER + 2
CBEM_GETIMAGELIST	:=WM_USER + 3
CBEM_GETITEMA		:=WM_USER + 4
CBEM_SETITEMA		:=WM_USER + 5
CBEM_GETCOMBOCONTROL	:=WM_USER + 6
CBEM_GETEDITCONTROL	:=WM_USER + 7
CBEM_SETEXSTYLE		:=WM_USER + 8	; use SETEXTENDEDSTYLE instead
CBEM_GETEXSTYLE		:=WM_USER + 9	; use GETEXTENDEDSTYLE instead
CBEM_GETEXTENDEDSTYLE	:=WM_USER + 9
CBEM_HASEDITCHANGED	:=WM_USER + 10
CBEM_INSERTITEMW	:=WM_USER + 11
CBEM_SETITEMW		:=WM_USER + 12
CBEM_GETITEMW		:=WM_USER + 13
CBEM_SETEXTENDEDSTYLE	:=WM_USER + 14	; lparam == new style, wParam (optional) == mask

CBEM_SETUNICODEFORMAT	:=CCM_SETUNICODEFORMAT
CBEM_GETUNICODEFORMAT	:=CCM_GETUNICODEFORMAT
CBEM_SETWINDOWTHEME	:=CCM_SETWINDOWTHEME


CBES_EX_NOEDITIMAGE		:=0x00000001
CBES_EX_NOEDITIMAGEINDENT	:=0x00000002
CBES_EX_PATHWORDBREAKPROC	:=0x00000004
CBES_EX_NOSIZELIMIT		:=0x00000008
CBES_EX_CASESENSITIVE		:=0x00000010
CBES_EX_TEXTENDELLIPSIS		:=0x00000020

struct NMCOMBOBOXEXW
	hdr	NMHDR
	ceItem	COMBOBOXEXITEMW
ends

CBEN_GETDISPINFOA	:=CBEN_FIRST - 0
CBEN_INSERTITEM		:=CBEN_FIRST - 1
CBEN_DELETEITEM		:=CBEN_FIRST - 2
CBEN_BEGINEDIT		:=CBEN_FIRST - 4
CBEN_ENDEDITA		:=CBEN_FIRST - 5
CBEN_ENDEDITW		:=CBEN_FIRST - 6 ; lParam specifies why the endedit is happening
CBEN_GETDISPINFOW	:=CBEN_FIRST - 7
CBEN_DRAGBEGINA		:=CBEN_FIRST - 8
CBEN_DRAGBEGINW		:=CBEN_FIRST - 9

CBENF_KILLFOCUS	:=1
CBENF_RETURN	:=2
CBENF_ESCAPE	:=3
CBENF_DROPDOWN	:=4

CBEMAXSTRLEN := 260

; CBEN_DRAGBEGIN sends this information ...

struct NMCBEDRAGBEGINW
	hdr	NMHDR
	iItemid	dd ? ; int
	szText	rw CBEMAXSTRLEN ; WCHAR
	_padding dd ?
ends

struct NMCBEDRAGBEGINA
	hdr	NMHDR
	iItemid	dd ? ; int
	szText	rb CBEMAXSTRLEN ; char
ends

; CBEN_ENDEDIT sends this information...
; fChanged if the user actually did anything
; iNewSelection gives what would be the new selection unless the notify is failed
;                     iNewSelection may be CB_ERR if there's no match
struct NMCBEENDEDITW
	hdr		NMHDR
	fChanged	dd ?	; BOOL
	iNewSelection	dd ?	; int
	szText		rw CBEMAXSTRLEN ; WCHAR
	iWhy		dd ?	; int
	_padding dd ?
ends

struct NMCBEENDEDITA
	hdr		NMHDR
	fChanged	dd ?	; BOOL
	iNewSelection	dd ?	; int
	szText		rb CBEMAXSTRLEN ; char
	iWhy		dd ?	; int
ends

; CommCtrl.inc ----------------------------------------------------"SysHeader32"
HDS_HORZ	=0x0000
HDS_BUTTONS	=0x0002
HDS_HOTTRACK	=0x0004
HDS_HIDDEN	=0x0008
HDS_DRAGDROP	=0x0040
HDS_FULLDRAG	=0x0080
HDS_FILTERBAR	:=0x0100
HDS_FLAT	:=0x0200
HDS_CHECKBOXES	:=0x0400
HDS_NOSIZING	:=0x0800
HDS_OVERFLOW	:=0x1000

HDFT_ISSTRING	:=0x0000 ; HD_ITEM.pvFilter points to a HD_TEXTFILTER
HDFT_ISNUMBER	:=0x0001 ; HD_ITEM.pvFilter points to a INT
HDFT_ISDATE	:=0x0002 ; HD_ITEM.pvFilter points to a DWORD (dos date)
HDFT_HASNOVALUE	:=0x8000 ; clear the filter, by setting this bit

struct HD_TEXTFILTERW
	pszText		dq ?	; LPWSTR	[in] pointer to the buffer contiaining the filter (UNICODE)
	cchTextMax	dd ?,?	; INT		[in] max size of buffer/edit control buffer
ends

struct HD_ITEMW
	mask		dd ?	; UINT
	cxy		dd ?	; int
	pszText		dq ?	; LPSTR
	hbm		dq ?	; HBITMAP
	cchTextMax	dd ?	; int
	fmt		dd ?	; int
	lParam		dq ?	; LPARAM
	iImage		dd ?	; int	index of bitmap in ImageList
	iOrder		dd ?	; int	where to draw this item
	type		dd ?,?	; UINT	[in] filter type (defined what pvFilter is a pointer to)
	pvFilter	dq ?	; void	[in] filter data see above
	state		dd ?,?	; UINT
ends

HDI_WIDTH	=0x0001
HDI_HEIGHT	=HDI_WIDTH
HDI_TEXT	=0x0002
HDI_FORMAT	=0x0004
HDI_LPARAM	=0x0008
HDI_BITMAP	=0x0010
HDI_IMAGE	:=0x0020
HDI_DI_SETITEM	:=0x0040
HDI_ORDER	:=0x0080
HDI_FILTER	:=0x0100
HDI_STATE	:=0x0200

; HDF_ flags are shared with the listview control (LVCFMT_ flags)
HDF_LEFT		=0x0000 ; Same as LVCFMT_LEFT
HDF_RIGHT		=0x0001 ; Same as LVCFMT_RIGHT
HDF_CENTER		=0x0002 ; Same as LVCFMT_CENTER
HDF_JUSTIFYMASK		=0x0003 ; Same as LVCFMT_JUSTIFYMASK
HDF_RTLREADING		=0x0004 ; Same as LVCFMT_LEFT
HDF_CHECKBOX		:=0x0040
HDF_CHECKED		:=0x0080
HDF_FIXEDWIDTH		:=0x0100 ; Can't resize the column; same as LVCFMT_FIXED_WIDTH
HDF_SORTDOWN		:=0x0200
HDF_SORTUP		:=0x0400
HDF_BITMAP		=0x2000
HDF_STRING		=0x4000
HDF_OWNERDRAW		=0x8000 ; Same as LVCFMT_COL_HAS_IMAGES
HDF_IMAGE		:=0x0800 ; Same as LVCFMT_IMAGE
HDF_BITMAP_ON_RIGHT	:=0x1000 ; Same as LVCFMT_BITMAP_ON_RIGHT
HDF_SPLITBUTTON		:=0x1000000 ; Column is a split button; same as LVCFMT_SPLITBUTTON

HDIS_FOCUSED := 0x00000001

;struct HD_LAYOUT
;	prc	dq ?	;*RECT
;	pwpos	dq ?	;*WINDOWPOS
;ends

HHT_NOWHERE		=0x0001
HHT_ONHEADER		=0x0002
HHT_ONDIVIDER		=0x0004
HHT_ONDIVOPEN		=0x0008
HHT_ONFILTER		:=0x0010
HHT_ONFILTERBUTTON	:=0x0020
HHT_ABOVE		=0x0100
HHT_BELOW		=0x0200
HHT_TORIGHT		=0x0400
HHT_TOLEFT		=0x0800
HHT_ONITEMSTATEICON	:=0x1000
HHT_ONDROPDOWN		:=0x2000
HHT_ONOVERFLOW		:=0x4000

;struct HD_HITTESTINFO
;	pt	POINT
;	flags	dd ? ; UINT
;	iItem	dd ? ; int
;ends

HDSIL_NORMAL	:=0
HDSIL_STATE	:=1

HDM_GETITEMCOUNT		=HDM_FIRST+0
HDM_INSERTITEMA			=HDM_FIRST+1
HDM_DELETEITEM			=HDM_FIRST+2
HDM_GETITEMA			=HDM_FIRST+3
HDM_SETITEMA			=HDM_FIRST+4
HDM_LAYOUT			=HDM_FIRST+5
HDM_HITTEST			=HDM_FIRST+6
HDM_GETITEMRECT			=HDM_FIRST+7
HDM_SETIMAGELIST		=HDM_FIRST+8
HDM_GETIMAGELIST		=HDM_FIRST+9
HDM_INSERTITEMW			=HDM_FIRST+10
HDM_GETITEMW			=HDM_FIRST+11
HDM_SETITEMW			=HDM_FIRST+12

HDM_ORDERTOINDEX		:=HDM_FIRST+15
HDM_CREATEDRAGIMAGE		:=HDM_FIRST+16	; wparam = which item (by index)
HDM_GETORDERARRAY		:=HDM_FIRST+17
HDM_SETORDERARRAY		:=HDM_FIRST+18
HDM_SETHOTDIVIDER		:=HDM_FIRST+19
HDM_SETBITMAPMARGIN		:=HDM_FIRST+20
HDM_GETBITMAPMARGIN		:=HDM_FIRST+21
HDM_SETFILTERCHANGETIMEOUT	:=HDM_FIRST+22
HDM_EDITFILTER			:=HDM_FIRST+23
HDM_CLEARFILTER			:=HDM_FIRST+24
HDM_GETITEMDROPDOWNRECT		:=HDM_FIRST+25	; rect of item's drop down button
HDM_GETOVERFLOWRECT		:=HDM_FIRST+26	; rect of overflow button
HDM_GETFOCUSEDITEM		:=HDM_FIRST+27
HDM_SETFOCUSEDITEM		:=HDM_FIRST+28
HDM_SETUNICODEFORMAT		:=CCM_SETUNICODEFORMAT
HDM_GETUNICODEFORMAT		:=CCM_GETUNICODEFORMAT
;HDM_TRANSLATEACCELERATOR	:=CCM_TRANSLATEACCELERATOR

HDN_ITEMCHANGINGA	=HDN_FIRST-0
HDN_ITEMCHANGEDA	=HDN_FIRST-1
HDN_ITEMCLICKA		=HDN_FIRST-2
HDN_ITEMDBLCLICKA	=HDN_FIRST-3
HDN_DIVIDERDBLCLICKA	=HDN_FIRST-5
HDN_BEGINTRACKA		=HDN_FIRST-6
HDN_ENDTRACKA		=HDN_FIRST-7
HDN_TRACKA		=HDN_FIRST-8
HDN_GETDISPINFOA	:=HDN_FIRST-9
HDN_BEGINDRAG		:=HDN_FIRST-10
HDN_ENDDRAG		:=HDN_FIRST-11
HDN_FILTERCHANGE	:=HDN_FIRST-12
HDN_FILTERBTNCLICK	:=HDN_FIRST-13
HDN_BEGINFILTEREDIT	:=HDN_FIRST-14
HDN_ENDFILTEREDIT	:=HDN_FIRST-15
HDN_ITEMSTATEICONCLICK	:=HDN_FIRST-16
HDN_ITEMKEYDOWN		:=HDN_FIRST-17
HDN_DROPDOWN		:=HDN_FIRST-18
HDN_OVERFLOWCLICK	:=HDN_FIRST-19
HDN_ITEMCHANGINGW	=HDN_FIRST-20
HDN_ITEMCHANGEDW	=HDN_FIRST-21
HDN_ITEMCLICKW		=HDN_FIRST-22
HDN_ITEMDBLCLICKW	=HDN_FIRST-23
HDN_DIVIDERDBLCLICKW	=HDN_FIRST-25
HDN_BEGINTRACKW		=HDN_FIRST-26
HDN_ENDTRACKW		=HDN_FIRST-27
HDN_TRACKW		=HDN_FIRST-28
HDN_GETDISPINFOW	:=HDN_FIRST-29

struct NMHEADERW
	hdr	NMHDR
	iItem	dd ?	; int
	iButton	dd ?	; int
	pitem	dq ?	; HDITEMW
ends

struct NMHDDISPINFOW
	hdr	NMHDR
	iItem	dd ?	; int
	mask	dd ?	; UINT
	pszText	dq ?	; LPSTR
	cchTextMax dd ?	; int
	iImage	dd ?	; int
	lParam	dq ?	; LPARAM
ends

struct NMHDFILTERBTNCLICK
	hdr	NMHDR
	iItem	dd ? ; INT
	rc	RECT
	_padding dd ?
ends

;-------------------------------------------------------------------------------
struct LVITEMW
	mask		dd ?	; UINT
	iItem		dd ?	; int
	iSubItem	dd ?	; int
	state		dd ?	; UINT
	stateMask	dd ?,?	; UINT
	pszText		dq ?	;*WSTR
	cchTextMax	dd ?	; int
	iImage		dd ?	; int
	lParam		dq ?	; LPARAM
	iIndent		dd ?	; int
	iGroupId	dd ?	; int
	cColumns	dd ?,?	; UINT
	puColumns	dq ?	;*UINT
	piColFmt	dq ?	;*int
	iGroup		dd ?,?	; int
ends
;-------------------------------------------------------------------------------
struct TVITEMEX
	mask		dd ?,?	; UINT
	hItem		dq ?	;HTREEITEM
	state		dd ?	; UINT
	stateMask	dd ?	; UINT
	pszText		dq ?	;LPWSTR
	cchTextMax	dd ?	; int
	iImage		dd ?	; int
	iSelectedImage	dd ?	; int
	cChildren	dd ?	; int
	lParam		dq ?	;LPARAM
	iIntegral	dd ?	; int
	uStateEx	dd ?	; UINT
	hwnd		dq ?	;HWND
	iExpandedImage	dd ?	; int
	iReserved	dd ?	; int
ends
struct TVINSERTSTRUCT
	hParent		dq ?	; HTREEITEM
	hInsertAfter	dq ?	; HTREEITEM
	itemex		TVITEMEX
ends

TVI_ROOT	=-0x10000 ; need to work in PTR size fields
TVI_FIRST	=-0x0FFFF
TVI_LAST	=-0x0FFFE
TVI_SORT	=-0x0FFFD

; CommCtrl.inc -----------------------------------------------------------------
UDS_HOTTRACK := 0x0100

TBSTYLE_AUTOSIZE:=0x0010
TBSTYLE_NOPREFIX:=0x0020

ILC_HIGHQUALITYSCALE:=0x00020000

RBBS_USECHEVRON	:=0x00000200
RBBS_HIDETITLE	:=0x00000400
RBBS_TOPALIGN	:=0x00000800

; NOTE: REBARBANDINFO structure is wrong, use REBARBANDINFOW here until edit
struct REBARBANDINFOW ; 128 bytes
	cbSize			dd ?	; UINT
	fMask			dd ?	; UINT
	fStyle			dd ?	; UINT
	clrFore			dd ?	; COLORREF
	clrBack			dd ?,?	; COLORREF
	lpText			dq ?	;LPWSTR
	cch			dd ?	; UINT
	iImage			dd ?	; int
	hwndChild		dq ?	;HWND
	cxMinChild		dd ?	; UINT
	cyMinChild		dd ?	; UINT
	cx			dd ?,?	; UINT
	hbmBack			dq ?	;HBITMAP
	wID			dd ?	; UINT
	cyChild			dd ?	; UINT
	cyMaxChild		dd ?	; UINT
	cyIntegral		dd ?	; UINT
	cxIdeal			dd ?,?	; UINT
	lParam			dq ?	;LPARAM
	cxHeader		dd ?	; UINT
	rcChevronLocation	RECT
	uChevronState		dd ?	; UINT
ends

;-------------------------------------------------------------------------------
; dwmapi.inc

struct DWM_BLURBEHIND
	dwFlags			dd ?	; DWM_BB_*
	fEnable			dd ?
	hRgnBlur		dq ?
	fTransitionOnMaximized	dd ?,?
ends

DWM_BB_ENABLE			:= 0x00000001
DWM_BB_BLURREGION		:= 0x00000002
DWM_BB_TRANSITIONONMAXIMIZED	:= 0x00000004




MONITOR_DEFAULTTONULL		:= 0x00000000
MONITOR_DEFAULTTOPRIMARY	:= 0x00000001
MONITOR_DEFAULTTONEAREST	:= 0x00000002

MONITORINFOF_PRIMARY		:= 0x00000001

struct MONITORINFOEXA
	cbSize		dd ?
	rcMonitor	RECT
	rcWork		RECT
	dwFlags		dd ?
	szDevice	rb 32 ; CCHDEVICENAME
ends
struct MONITORINFOEXW
	cbSize		dd ?
	rcMonitor	RECT
	rcWork		RECT
	dwFlags		dd ?
	szDevice	rw 32 ; CCHDEVICENAME
ends

;-------------------------------------------------------------------------------

struct IMAGE_DOS_HEADER
	e_magic		dw ?
	e_cblp		dw ?
	e_cp		dw ?
	e_crlc		dw ?
	e_cparhdr	dw ?
	e_minalloc	dw ?
	e_maxalloc	dw ?
	e_ss		dw ?
	e_sp		dw ?
	e_csum		dw ?
	e_ip		dw ?
	e_cs		dw ?
	e_lfarlc	dw ?
	e_ovno		dw ?
	e_res		rw 4
	e_oemid		dw ?
	e_oeminfo	dw ?
	e_res2		rw 10
	e_lfanew	dd ?
ends

struct IMAGE_NT_HEADERS64
	Signature	dd ?
	FileHeader	IMAGE_FILE_HEADER
	OptionalHeader	IMAGE_OPTIONAL_HEADER64
ends

struct IMAGE_FILE_HEADER
	Machine			dw ?
	NumberOfSections	dw ?
	TimeDateStamp		dd ?
	PointerToSymbolTable	dd ?
	NumberOfSymbols		dd ?
	SizeOfOptionalHeader	dw ?
	Characteristics		dw ?
ends

struct IMAGE_OPTIONAL_HEADER64
	Magic				dw ?
	MajorLinkerVersion		db ?
	MinorLinkerVersion		db ?
	SizeOfCode			dd ?
	SizeOfInitializedData		dd ?
	SizeOfUninitializedData		dd ?
	AddressOfEntryPoint		dd ?
	BaseOfCode			dd ?
	ImageBase			dq ?
	SectionAlignment		dd ?
	FileAlignment			dd ?
	MajorOperatingSystemVersion	dw ?
	MinorOperatingSystemVersion	dw ?
	MajorImageVersion		dw ?
	MinorImageVersion		dw ?
	MajorSubsystemVersion		dw ?
	MinorSubsystemVersion		dw ?
	Win32VersionValue		dd ?
	SizeOfImage			dd ?
	SizeOfHeaders			dd ?
	CheckSum			dd ?
	Subsystem			dw ?
	DllCharacteristics		dw ?
	SizeOfStackReserve		dq ?
	SizeOfStackCommit		dq ?
	SizeOfHeapReserve		dq ?
	SizeOfHeapCommit		dq ?
	LoaderFlags			dd ?
	NumberOfRvaAndSizes		dd ?
	DataDirectory			IMAGE_DATA_DIRECTORY
	repeat IMAGE_NUMBEROF_DIRECTORY_ENTRIES-1
		DataDirectory.% IMAGE_DATA_DIRECTORY
	end repeat
ends

struct IMAGE_DATA_DIRECTORY
	VirtualAddress	dd ?
	Size		dd ?
ends

IMAGE_NUMBEROF_DIRECTORY_ENTRIES := 16



; DECLSPEC_ALIGN(16)
struct XMM_SAVE_AREA32
	ControlWord	dw ?
	StatusWord	dw ?
	TagWord		db ?
	Reserved1	db ?
	ErrorOpcode	dw ?
	ErrorOffset	dd ?
	ErrorSelector	dw ?
	Reserved2	dw ?
	DataOffset	dd ?
	DataSelector	dw ?
	Reserved3	dw ?
	MxCsr		dd ?
	MxCsr_Mask	dd ?
	FloatRegisters	rdq 8
	XmmRegisters	rdq 16
	Reserved4	rb 96
ends

; DECLSPEC_ALIGN(16) DECLSPEC_NOINITALL
struct CONTEXT
	; Register parameter home addresses.
	; N.B. These fields are for convience - they could be used to extend the context record in the future.
	P1Home		dq ?
	P2Home		dq ?
	P3Home		dq ?
	P4Home		dq ?
	P5Home		dq ?
	P6Home		dq ?

	; Control flags.
	ContextFlags	dd ?
	MxCsr		dd ?

	; Segment Registers and processor flags.
	SegCs		dw ?
	SegDs		dw ?
	SegEs		dw ?
	SegFs		dw ?
	SegGs		dw ?
	SegSs		dw ?
	EFlags		dd ?

	; Debug registers
	Dr0		dq ?
	Dr1		dq ?
	Dr2		dq ?
	Dr3		dq ?
	Dr6		dq ?
	Dr7		dq ?

	; Integer registers.
	Rax		dq ?
	Rcx		dq ?
	Rdx		dq ?
	Rbx		dq ?
	Rsp		dq ?
	Rbp		dq ?
	Rsi		dq ?
	Rdi		dq ?
	R8		dq ?
	R9		dq ?
	R10		dq ?
	R11		dq ?
	R12		dq ?
	R13		dq ?
	R14		dq ?
	R15		dq ?

	; Program counter.
	Rip		dq ?

	; Floating point state.
	FltSave XMM_SAVE_AREA32

	; Vector registers.
	VectorRegister	rdq 26
	VectorControl	dq ?

	; Special debug control registers.
	DebugControl		dq ?
	LastBranchToRip		dq ?
	LastBranchFromRip	dq ?
	LastExceptionToRip	dq ?
	LastExceptionFromRip	dq ?
ends

;-------------------------------------------------------------------------------

PAGE_SIZE	:= 0x1000
TeStackLimit	:= 0x0010

; Code needs to allocate a stack buffer greater than the page size (4K):
; First, set RSP to the desired address, then use this macro:
;	enter .frame + .local, 0
;	__chkstk
; or...
;	sub rsp, .frame + (1 shl 20)
;	__chkstk
;
; 24 byte overhead, but this is rarely needed.
; (#32# version could save 4/5 bytes)
;
macro __chkstk ; note: ABI parameter registers are not used
	local try,lower
	mov rax, [gs:TeStackLimit]	; pages allocated down to this address
	jmp try
lower:	sub rax, PAGE_SIZE
	cmp byte [rax], 0
try:	cmp rsp, rax
	jc lower
end macro


calminstruction clzero? ; rAX
	emit 3, 0xFC010F
end calminstruction

macro PageZero mem ; 12+ bytes, no flags affected
	local cline
	match ,mem
	else
		mov rax, mem
	end match
	push PAGE_SIZE/64
	pop rcx
cline:	clzero
	lea rax, [rax + 64]
	loop cline
	match ,mem
	else
		sfence
	end match
end macro



