if ~ definite __gdiplus_g__
__gdiplus_g__:=1



struct GdiplusStartupInput
	GdiplusVersion dd ?,? ; UINT32
	DebugEventCallback dq ? ; DebugEventProc
	SuppressBackgroundThread dd ? ; BOOL
	SuppressExternalCodecs dd ? ; BOOL
ends

define Gdiplus_Status.Ok 0
define Gdiplus_Status.GenericError 1
define Gdiplus_Status.InvalidParameter 2
define Gdiplus_Status.OutOfMemory 3
define Gdiplus_Status.ObjectBusy 4
define Gdiplus_Status.InsufficientBuffer 5
define Gdiplus_Status.NotImplemented 6
define Gdiplus_Status.Win32Error 7
define Gdiplus_Status.WrongState 8
define Gdiplus_Status.Aborted 9
define Gdiplus_Status.FileNotFound 10
define Gdiplus_Status.ValueOverflow 11
define Gdiplus_Status.AccessDenied 12
define Gdiplus_Status.UnknownImageFormat 13
define Gdiplus_Status.FontFamilyNotFound 14
define Gdiplus_Status.FontStyleNotFound 15
define Gdiplus_Status.NotTrueTypeFont 16
define Gdiplus_Status.UnsupportedGdiplusVersion 17
define Gdiplus_Status.GdiplusNotInitialized 18
define Gdiplus_Status.PropertyNotFound 19
define Gdiplus_Status.PropertyNotSupported 20
define Gdiplus_Status.ProfileNotFound 21







{data:4} g_gdiplusToken		dd ?
{data:8} g_GdiplusStartupInput	GdiplusStartupInput 1,0,0,0

end if ;~ definite __gdiplus_g__
