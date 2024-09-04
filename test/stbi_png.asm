
; Using PNG transparency in windows:
;	- four channel (RGBA)
;	- gray scale with alpha
;	- optional tRNS chunk marks color(s) as transparent

; View details in file explorer, look for attributes "A"

; REFERENCES:
;	http://www.libpng.org/pub/png/pngmisc.html#images
;


; build with ...
;	..\fasm2.cmd -v 2 -e 3 stbi_png.asm
;	link @stbi_png.response stbi_png.obj
include 'windows.g'
include 'stb_image.g'

; TODO: Add string/data abstraction to struct (like fastcall).

calminstruction (NAMED) file? line&
	local bytes
	asm	label NAMED:bytes
	asm	file? line
	asm	bytes:=$-NAMED
end calminstruction


:CursorMonitorA:
{data:8} .mi MONITORINFOEXA cbSize: sizeof .mi ; return product is global data
	virtual at rbp + 16
		.hMonitor	dq ? ; HMONITOR
		.point		POINT
		assert $ - $$ < 33 ; shadow use only
	end virtual
	enter .frame, 0
	GetCursorPos & .point
	; note: point structure data is pass in register
	MonitorFromPoint qword [.point], MONITOR_DEFAULTTONEAREST
	xchg rcx, rax
	GetMonitorInfoA rcx, & .mi
	leave
	retn
;-------------------------------------------------------------------------------




; Image file is directly stored in the executable.
; (can be overwritten once decoded)
BLOCK COFF.64.DATA
	label _image:_image.bytes
;	file 'wheel.png' ; RGBA, 32-bit image
;	file 'alphatest.png'
;	file 'donut.png'
	file 'dice.png'
	_image.bytes := $ - _image

;	_image file 'wheel.png' ; RGBA, 32-bit image
END BLOCK

BLOCK COFF.8.DATA
	_image.BMP_data	dq ?
	_image.BMP_info	BITMAPINFOHEADER\; <BITMAPINFO>
		biSize:		sizeof BITMAPINFOHEADER,\
		biPlanes:	1,\
		biBitCount:	32,\; DWORD per pixel
		biCompression:	BI_RGB
	_image.width		equ _image.BMP_info.biWidth
	_image.height		equ _image.BMP_info.biHeight
	_image.channels	dd ?
END BLOCK

{const:32} ABGR_ARGB db \
	2,1,0,3,  6,5,4,7, 10,9,8,11, 14,13,12,15,\
	2,1,0,3,  6,5,4,7, 10,9,8,11, 14,13,12,15

:ABGR_to_ARGB: ; reorder color components
	mov rcx, [_image.BMP_data]
	jrcxz @9F
	cmp [_image.channels], 4
	jz @F
@9:	retn

@@:	imul edx, [_image.width], 4
	imul edx, [_image.height]
	add rdx, rcx
	vmovdqa ymm0, qqword [ABGR_ARGB]

@1:	test rcx, not -32	; NOTE: ASSUME at least 7 pixels
	jz @F
	mov al, [rcx]
	mov ah, [rcx+2]
	mov [rcx], ah
	mov [rcx+2], al
	add rcx, 4
	jmp @1B

@@:	add rcx, 32*.UNROLL
	cmp rdx, rcx
	jc @F
	.UNROLL := 4
	repeat .UNROLL
		vmovdqa ymm#%, [rcx - 32*%]
	end repeat
	repeat .UNROLL
		vpshufb ymm#%, ymm#%, ymm0
	end repeat
	repeat .UNROLL
		vmovdqa [rcx - 32*%], ymm#%
	end repeat
	jmp @B
@@:	sub rcx, 32*.UNROLL

@@:	cmp rdx, rcx
	jz @F
	mov al, [rcx]
	mov ah, [rcx+2]
	mov [rcx], ah
	mov [rcx+2], al
	add rcx, 4
	jmp @B
@@:
	retn



:unpremultiply:
	mov rcx, [_image.BMP_data]
	jrcxz @9F
	cmp [_image.channels], 4
	jz @F
@9:	retn
@@:
	push rsi rdi rbx rbp
	virtual at rsp+8*5 ; use shadow space
		.tail		dq ?
		.alpha		dd ?
		.frac_alpha	dd ?
	end virtual

@@:	imul ebp, [_image.width], 4
	imul ebp, [_image.height]
	add rbp, rcx ; tail pointer
.more:
	movzx esi, byte [rcx+3]		; alpha
	xor edx, edx			; scaled fraction 1/a
	test esi, esi
	jz .zero
	mov eax, 1 shl (32-8)		; scaled integer
	div esi
	xchg edx, eax
.zero:
	iterate REG, eax,ebx,edi
		movzx REG, byte [rcx+%-1]
		imul REG, 255*2		; by two so alpha bits are 1/2 weight
		add REG, esi		; round to inf
		imul REG, edx		; scaled fraction of 1/a shl (32-9)
		shr REG, 31-8		; reduce to integer [0,FF]
		mov [rcx+%-1], reg8low.REG
	end iterate
	add rcx, 4
	cmp rbp, rcx
	jnz .more
	pop rbp rbx rdi rsi
	retn
; (255*255 + 128)/255 = 255
; (0*255 + 128)/255 = 0









;/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
; Default DefWindowProcA handling:
;	WM_CREATE	return 0
;	WM_CLOSE	DestroyWindow
:WndProcA:
	iterate message, WM_ERASEBKGND,\
		WM_KEYDOWN,WM_SYSCOMMAND,\
		WM_LBUTTONDOWN,WM_RBUTTONUP,\
		WM_DESTROY

		cmp edx, message
		jz .message
	end iterate
.default:
	extrn __imp_DefWindowProcA
	jmp qword [__imp_DefWindowProcA]


.WM_SYSCOMMAND:
	cmp r8d, ID_ABOUT
	jnz .default
	enter 32, 0
	MessageBoxA rcx, A "Using GDI to create an immediate type UI.",\
		A "About ...", MB_OK
	jmp .leave_zero


.WM_KEYDOWN:
	cmp r8d, VK_ESCAPE
	jnz .default
	; respect window message heirarchy
	enter 32, 0
	DestroyWindow rcx
.leave_zero:
	xor eax, eax
	leave
	retn


.WM_DESTROY: ; n/a, n/a ; window already closed
	enter 32, 0
	PostQuitMessage 0
	jmp .leave_zero


.WM_LBUTTONDOWN:
	enter 32, 0
	; Windows shows the cursor during move operation,
	; but doesn't change cursor. TODO: set cursor to hand?

	; undocumented, SC_MOVE or HTCAPTION = SC_DRAGMOVE = F012
	SendMessageA rcx, WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0
	jmp .leave_zero


.WM_ERASEBKGND: ; hDC, n/a
	push rax ; n/a
	mov eax, [_image.height]
	xchg rcx, r8			; hDC
	xor edx, edx			; xDest
	xor r8, r8			; yDest
	mov r9d, [_image.width]		; w
	push rdx			; DIB_RGB_COLORS
	push _image.BMP_info		;*lpbmi
	push [_image.BMP_data]		;*lpvBits
	push rax			; cLines
	push rdx			; StartScan
	push rdx			; ySrc
	push rdx			; xSrc
	push rax			; h
	sub esp, 8*4 ; #32#
	SetDIBitsToDevice
	add esp, 8*13 ; #32#
	; only return non-zero if lines were copied
	test eax, eax
	setnz al
	movzx eax, al
	retn


; We can split any messages off to use their own scope ...
:WndProcA.WM_RBUTTONUP:
	enter .frame, 0
	virtual at rbp+16 ; use shadow space
		.hWnd		dq ?
;		.hMenu		dq ?
		.pt		POINT
		assert $-$$ < 33
	end virtual
; notes: WM_RBUTTONUP mouse coordinates are screen relative
;	WM_RBUTTONDOWN brings window forward?
;	SetForegroundWindow [.hWnd]
	; preserve fastcall parameter(s)
	mov [.hWnd], rcx
	GetCursorPos addr .pt ; client relative coordinates
	TrackPopupMenu [WinMainCRTStartup.hSysMenu],\
		TPM_RIGHTBUTTON or TPM_RETURNCMD,\
		[.pt.x], [.pt.y], 0, [.hWnd], 0
	xchg ecx, eax
	jrcxz .no_sysmenu
	; forward system command for default processing
	mov r8d, ecx
	mov r9d, [.pt.y + 2] ; high word, zero high dword
	mov r9w, word [.pt.x] ; just low word
	SendMessageA [.hWnd], WM_SYSCOMMAND, r8, r9
.no_sysmenu:
	xor eax, eax ; handled
	leave
	retn

;SC_SEPARATOR


;*******************************************************************************
public WinMainCRTStartup as 'WinMainCRTStartup'
:WinMainCRTStartup: ; linker expects this default symbol for entry point
	enter .frame, 0
	mov [.msg.wParam], 1 ; EXIT_FAILURE

	; TODO: pre-flip images to improve load time, but adds a step to external interop. So, create a build-time tool that flips images.
	stbi_set_flip_vertically_on_load 1

	; decompress PNG image data
	stbi_load_from_memory & _image, sizeof _image,\
		& _image.width, & _image.height,\
		& _image.channels, STBI_rgb_alpha
	test rax, rax
	jz .Fatal ; image is baked into program, this does not fail
	mov [_image.BMP_data], rax
	call ABGR_to_ARGB

; idea: I think gamma is still making image too bright?


; Center window on monitor where mouse pointer is:
	call CursorMonitorA
	{bss:16} .rc RECT
	movq xmm0, qword [CursorMonitorA.mi.rcMonitor.right]
	movq xmm1, qword [CursorMonitorA.mi.rcMonitor.left]
	movq xmm2, qword [_image.width]
	psubd xmm0, xmm1		; monitor: width, height
	psubd xmm0, xmm2
	psrad xmm0, 1
	paddd xmm1, xmm0
	movq qword [.rc.left], xmm1	; window: upper left coords
	movq qword [.rc.right], xmm2	; window: width, height


{data:8} .szClassNameA db "bitRAKE",0
{data:8} .wndclass WNDCLASS 0,WndProcA,0,0,__ImageBase,0,0,0,0,.szClassNameA

	RegisterClassA dword .wndclass
	movzx edx, ax ; ATOM

.XSTYLE = WS_EX_APPWINDOW or WS_EX_LAYERED
.STYLE = WS_POPUP or WS_VISIBLE or WS_SYSMENU

	CreateWindowExA .XSTYLE, rdx, 0, .STYLE,\
		[.rc.left], [.rc.top], [.rc.right], [.rc.bottom],\
		0, 0, __ImageBase, 0
{bss:8}	.hWnd dq ?
	mov [.hWnd], rax

if 1 ; Set layering style bit to enable per-pixel alpha (of blur behind).
	{data:8} .bb DWM_BLURBEHIND fEnable: TRUE, dwFlags: DWM_BB_ENABLE
	DwmEnableBlurBehindWindow [.hWnd], addr .bb
	SetLayeredWindowAttributes [.hWnd], 0, 255, LWA_ALPHA ; opaque
else ; Irregular window region based on transparency!
	SetLayeredWindowAttributes [.hWnd], 0xFF000000, 0, LWA_COLORKEY
end if

; configure system menu
	GetSystemMenu [.hWnd], 0
	test rax, rax
	jz .Fatal
{bss:8} .hSysMenu dq ?
	mov [.hSysMenu], rax

{data:2} _XSysCommands dw SC_SIZE,SC_MOVE,SC_MINIMIZE,SC_MAXIMIZE,SC_RESTORE,0

	lea esi, [_XSysCommands]
@@:	lodsw
	movzx edx,ax
	RemoveMenu [.hSysMenu],rdx,MF_BYCOMMAND
	cmp byte [rsi], 0
	jnz @B

ID_ABOUT := 100h
;	InsertMenuA [.hSysMenu], 0, MF_BYPOSITION or MF_SEPARATOR, 0, 0
	InsertMenuA [.hSysMenu], 0, MF_BYPOSITION or MF_STRING, ID_ABOUT, A "About ..."
;	InsertMenuA [.hSysMenu], 0, MF_BYPOSITION or MF_SEPARATOR, 0, 0

	jmp .peek

{bss:8} .msg MSG
.message_loop:
	TranslateMessage dword .msg
	DispatchMessageA dword .msg
.peek:	PeekMessageA dword .msg, 0, 0, 0, PM_REMOVE
	test eax, eax ; BOOL
	jnz .message_loop

	Sleep 1

;	InvalidateRect [.hWnd], 0, 1 ; use WM_ERASEBKGND handler

	cmp [.msg.message], WM_QUIT
	jnz .peek
.Fatal:
	ExitProcess [.msg.wParam]


;,.-`-.,;,.-`-.,;,.-`-.,;,.-`-.,;,.-`-.,;,.-`-.,;,.-`-.,;,.-`-.,;,.-`-.,;,.-`-.,
; We can generate a response file to configure the linker. This is better than
; using a '.drectve' section as all the commands are allowed. :-)
virtual as "response"
	db '/NOLOGO',10
;	db '/VERBOSE',10 ; use to debug build
	db '/NODEFAULTLIB',10 ; just because we want to see all the ingredience
	db '/LTCG',10 ; libraries were build for lto
	db '/BASE:0x10000',10
;	db '/HEAP:0x10000000',10
	db '/DYNAMICBASE:NO',10
	db '/IGNORE:4281',10 ; ASLR not active for fixed address - message is an error
	db '/SUBSYSTEM:WINDOWS,6.02',10
	db '/MANIFEST:EMBED',10
	db "/MANIFESTDEPENDENCY:""type='Win32' name='Microsoft.Windows.Common-Controls' version='6.0.0.0' processorArchitecture='*' publicKeyToken='6595b64144ccf1df' language='*'""",10

;	db 'OneCoreUAP.lib',10
	db 'kernel32.lib',10
	db 'user32.lib',10
	db 'gdi32.lib',10
	db 'dwmapi.lib',10

; C-language libraries require additional support functions, CRT:
	db 'libcmt.lib',10		; __chkstk,_tls_index
	db 'libvcruntime.lib',10	; memmove, memset, ...
	db 'libucrt.lib',10
end virtual

; https://learn.microsoft.com/en-us/cpp/error-messages/tool-errors/linker-tools-warning-lnk4210
;	_CRT_INIT ; DLL static initialization of CRT
