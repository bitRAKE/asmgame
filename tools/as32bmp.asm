;	cls & ..\fasm2 -e 50 as32bmp.asm
;	link @as32bmp.response as32bmp.obj
;	as32bmp.exe "C:\_daily\asmgame\tools\house.png" "C:\_daily\asmgame\tools\house.bmp"

; Just a simple tool to convert images using WIC. The default behaviour
; is to output 32-bit BMP file, named similar to passed image file name.
; for easier compile-time manipulation by fasmg of pixel data.

include 'console.g'
include 'wincodec.g'

calminstruction ✓ line& ; very simple HRESULT error debug helper
	assemble line
	arrange line,=mov =r8d,=__LINE__
	assemble line
	arrange line,=test =eax,=eax
	assemble line
	arrange line,=js .=HR_FAILURE
	assemble line
end calminstruction

;=============================================================== mainCRTStartup:
public mainCRTStartup ; linker expects this default entry point name
:mainCRTStartup:
	virtual at rbp - .local
		.inputPath	dq ?
		.outputPath	dq ?

	; needed COM objects (:note: order is important):
		.pFactory	IWICImagingFactory
		.pDecoder	IWICBitmapDecoder
		.pFrameDecode	IWICBitmapFrameDecode
		.pConverter	IWICFormatConverter
		.pStream	IWICStream
		.pEncoder	IWICBitmapEncoder
		.pFrameEncode	IWICBitmapFrameEncode
			align.assume rbp,16
			align 16
		.local := $-$$
				rq 2
		.hStdOut	dq ?
		.width		dd ?
		.height		dd ?
		.result		dd ?
		.argn		dd ?
		.argv		dq ?
		assert $-.hStdOut < 33 ; shadowspace limitation
	end virtual
	enter .frame + .local, 0
	mov [.result], 1 ; EXIT_FAILURE

	GetStdHandle STD_OUTPUT_HANDLE
	mov [.hStdOut], rax

	GetCommandLineW
	xchg rcx, rax
	jrcxz .display_usage
	CommandLineToArgvW rcx, & .argn
	mov [.argv], rax
	test rax, rax
	jz .display_usage

; todo: parse options?

	mov rcx, [rax + 8]
	jrcxz .display_usage
	mov [.inputPath], rcx
	push [rax + 16]
	pop [.outputPath]
	jmp .process_image
.display_usage:
	{const:2} .usage du "usage: as32bmp.exe <input> [<output>]",10
	{const:2} .usage.chars := ($ - .usage) shr 1
	lea rdx, [.usage]
	mov r8d, .usage.chars
	jmp .exit_usage

.process_image:
	; zero COM object pointers
	mov ecx, (.pFrameEncode - .pFactory + 8) shr 2
@@:	mov dword [.pFactory + 4*(rcx-1)], 0
	loop @B

✓	CoInitializeEx NULL, COINIT_MULTITHREADED
✓	CoCreateInstance & CLSID_WICImagingFactory2, NULL, CLSCTX_INPROC_SERVER,\
		& IID_IWICImagingFactory, & .pFactory

✓	IWICImagingFactory__CreateDecoderFromFilename [.pFactory],\
		[.inputPath], NULL, GENERIC_READ,\
		WICDecodeMetadataCacheOnDemand, & .pDecoder
✓	IWICBitmapDecoder__GetFrame [.pDecoder], 0, & .pFrameDecode

; create and configuring converter for desired output format:

✓	IWICImagingFactory__CreateFormatConverter [.pFactory], & .pConverter
✓	IWICFormatConverter__Initialize [.pConverter], [.pFrameDecode],\
		& GUID_WICPixelFormat32bppBGRA, WICBitmapDitherTypeNone,\
		NULL, 0.0, WICBitmapPaletteTypeCustom

; todo: create output pathfilename?

✓	IWICImagingFactory__CreateStream [.pFactory], & .pStream
✓	IWICStream__InitializeFromFilename [.pStream], [.outputPath], GENERIC_WRITE

✓	IWICImagingFactory__CreateEncoder [.pFactory],\
		& GUID_ContainerFormatBmp, NULL, & .pEncoder
✓	IWICBitmapEncoder__Initialize [.pEncoder], [.pStream], WICBitmapEncoderNoCache

; create a new frame for the BMP

✓	IWICBitmapEncoder__CreateNewFrame [.pEncoder], & .pFrameEncode, NULL
✓	IWICBitmapFrameEncode__Initialize [.pFrameEncode], NULL

	{data:16} .format ddq ? ; format need to be readwrite
	movdqa xmm0, [GUID_WICPixelFormat32bppBGRA]
	movdqa [.format], xmm0
✓	IWICBitmapFrameEncode__SetPixelFormat [.pFrameEncode], & .format

; write the converted pixels to the frame

✓	IWICBitmapFrameEncode__WriteSource [.pFrameEncode], [.pConverter], NULL
✓	IWICBitmapFrameEncode__Commit [.pFrameEncode]
✓	IWICBitmapEncoder__Commit [.pEncoder]

	mov [.result], 0 ; EXIT_SUCCESS
	jmp .done

.HR_FAILURE:
	xchg r9d, eax
	{bss:64} .buffer rw 1024
	wsprintfW & .buffer, <W "Error at line %d: HRESULT 0x%08x",10>, r8, r9
	xchg r8d, eax ; characters
	lea rdx, [.buffer]
.exit_usage:
	WriteConsoleW [.hStdOut], rdx, r8d, 0, 0
.done:
	; release non-zero COM objects (:note: order is important)
	mov ebx, (.pFrameEncode - .pFactory) shr 3
@@:	mov rcx, [.pFactory + 8*rbx]
	jrcxz @0F
	IUnknown__Release rcx
@0:	dec ebx
	jns @B

	CoUninitialize
	ExitProcess [.result] ; why is this double loading ECX?
	jmp $

;===============================================================================
; Todo/Ideas:
;	+ any destination type
;	+ image transformations: clip, flip h/v, rotate, re-size
;	+ patterned image
;	+ composite image
;	+ display encode/decode support
;-------------------------------------------------------------------------------
; REFERENCES:
;	https://learn.microsoft.com/en-us/windows/win32/wic/-wic-about-windows-imaging-codec
;	https://learn.microsoft.com/en-us/windows/win32/wic/-wic-samples
;	https://en.wikipedia.org/wiki/Windows_Imaging_Component
;									Decode	Encode
; BMP	Windows Bitmap Format, Spec v5.		image/bmp		Yes	Yes
; JPEG	JFIF Spec 1.02		image/jpeg, image/jpe, image/jpg	Yes	Yes
; JPEG XR	JPEG Extended Range		image/jxr		Yes	Yes
; PNG	Portable Network Graphics, PNG Spec 1.2	image/png		Yes	Yes
; TIFF	Tagged Image File Format, TIFF Spec 6.0	image/tiff, image/tif	Yes	Yes
;	Windows Media Photo			image/vnd.ms-photo	Yes	Yes
; DDS	DirectDraw Surface			image/vnd.ms-dds	Yes	Yes
; GIF	Graphics Interchange Format, Spec 89a/89m	image/gif	Yes	Yes
; ICO	Icon Format				image/ico		Yes	No
; WEBP	(in App store)							Yes	Yes
;	RAW camera formats (NRW, NEF, CR2, DNG)
;


virtual as "response" ; Configure linker from here:
; don't show linker version header
	db '/NOLOGO',10

; Use to debug build process:
;	db '/VERBOSE',10
;	db '/TIME+',10

; Create unique binary using image version and checksum:
	repeat 1,T:__TIME__ shr 16,t:__TIME__ and 0xFFFF
		db '/VERSION:',`T,'.',`t,10
	end repeat
	; set program checksum in header
	db '/RELEASE',10

	db '/NODEFAULTLIB',10
	db '/IGNORE:4281',10 ; ASLR doesn't happen for /FIXED!
	db '/FIXED',10 ; don't generate relocation information
;	db '/DYNAMICBASE:NO',10 ; same as /FIXED
	db '/BASE:0x7FFF0000',10 ; above KUSER_SHARED_DATA
	db '/SUBSYSTEM:CONSOLE,6.02',10

; UNDOCUMENTED: no POGO debug info stored, corrupts sections?
	db '/EMITPOGOPHASEINFO',10
	; todo: what is the 64-bytes still present in .rdata?
	db '/MERGE:.rdata=.text',10 ; needed to prevent corruption.

; DLLs are loaded into 32-bit address space (ntdll still high!)
;	db '/LARGEADDRESSAWARE:NO',10

;	db '/HEAP:0x80000000,0x1000',10 ; 2GB
;	db '/STACK:0x100000,0x1000',10 ; 1MB

	db '/HIGHENTROPYVA:NO',10
	db '/GUARD:NO',10 ; requires /DYNAMICBASE
	db '/CETCOMPAT:NO',10

;	db '/DELAYLOAD:kernel32.dll',10
;	db '/DEPENDENTLOADFLAG:0x800',10 ; LOAD_LIBRARY_SEARCH_SYSTEM32

	db 'kernel32.lib',10
	db 'user32.lib',10
;		wsprintfW
	db 'shell32.lib',10
;		CommandLineToArgvW
;	db 'shlwapi.lib',10
	db 'ole32.lib',10
;		CoInitializeEx
;		CoCreateInstance
;		CoUninitialize
	db 'windowscodecs.lib',10 ; for all the GUIDs
end virtual
