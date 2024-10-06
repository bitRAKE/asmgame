; __wincodec_h__

; external interface requirements:
include 'IUnknown.g'
;include 'objidl.g'
;	IStream
;include 'dcommon.g'
;	D2D1_PIXEL_FORMAT


; objidl.h
ISequentialStream interface 0C733A30-2A1C-11CE-ADE5-00AA0044773D,\
	EXTENDS__IUnknown,\
	Read,Write

IStream interface 0000000C-0000-0000-C000-000000000046,\
	EXTENDS__ISequentialStream,\
	Seek,SetSize,CopyTo,Commit,Revert,LockRegion,UnlockRegion,Stat,Clone


; WTypesbase.h
; enum CLSCTX
CLSCTX_INPROC_SERVER			:= 0x00000001
CLSCTX_INPROC_HANDLER			:= 0x00000002
CLSCTX_LOCAL_SERVER			:= 0x00000004
CLSCTX_INPROC_SERVER16			:= 0x00000008
CLSCTX_REMOTE_SERVER			:= 0x00000010
CLSCTX_INPROC_HANDLER16			:= 0x00000020
CLSCTX_RESERVED1			:= 0x00000040
CLSCTX_RESERVED2			:= 0x00000080
CLSCTX_RESERVED3			:= 0x00000100
CLSCTX_RESERVED4			:= 0x00000200
CLSCTX_NO_CODE_DOWNLOAD			:= 0x00000400
CLSCTX_RESERVED5			:= 0x00000800
CLSCTX_NO_CUSTOM_MARSHAL		:= 0x00001000
CLSCTX_ENABLE_CODE_DOWNLOAD		:= 0x00002000
CLSCTX_NO_FAILURE_LOG			:= 0x00004000
CLSCTX_DISABLE_AAA			:= 0x00008000
CLSCTX_ENABLE_AAA			:= 0x00010000
CLSCTX_FROM_DEFAULT_CONTEXT		:= 0x00020000
CLSCTX_ACTIVATE_X86_SERVER		:= 0x00040000
CLSCTX_ACTIVATE_32_BIT_SERVER		:= CLSCTX_ACTIVATE_X86_SERVER
CLSCTX_ACTIVATE_64_BIT_SERVER		:= 0x00080000
CLSCTX_ENABLE_CLOAKING			:= 0x00100000
CLSCTX_APPCONTAINER			:= 0x00400000
CLSCTX_ACTIVATE_AAA_AS_IU		:= 0x00800000
CLSCTX_RESERVED6			:= 0x01000000
CLSCTX_ACTIVATE_ARM32_SERVER		:= 0x02000000
CLSCTX_ALLOW_LOWER_TRUST_REGISTRATION	:= 0x04000000
CLSCTX_PS_DLL				:= 0x80000000

; dcommon.h
struct D2D1_PIXEL_FORMAT
	_format		dd ?	; DXGI_FORMAT
	alphaMode	dd ?	; D2D1_ALPHA_MODE
ends

; intsafe.h
INTSAFE_E_ARITHMETIC_OVERFLOW := 0x80070216	; HRESULT, 534 = ERROR_ARITHMETIC_OVERFLOW



WINCODEC_SDK_VERSION1 := 0x0236
WINCODEC_SDK_VERSION2 := 0x0237

; these are defined in windowscodecs.lib
iterate <NAME,guid>,\
	CLSID_WICImagingFactory1, <0xcacaf262, 0x9370, 0x4615, 0xa1, 0x3b, 0x9f, 0x55, 0x39, 0xda, 0x4c, 0xa>,\
	CLSID_WICImagingFactory2, <0x317d06e8, 0x5f24, 0x433d, 0xbd, 0xf7, 0x79, 0xce, 0x68, 0xd8, 0xab, 0xc2>,\
	GUID_VendorMicrosoft, <0xf0e749ca, 0xedef, 0x4589, 0xa7, 0x3a, 0xee, 0xe, 0x62, 0x6a, 0x2a, 0x2b>,\
	GUID_VendorMicrosoftBuiltIn, <0x257a30fd, 0x6b6, 0x462b, 0xae, 0xa4, 0x63, 0xf7, 0xb, 0x86, 0xe5, 0x33>,\
	CLSID_WICPngDecoder1, <0x389ea17b, 0x5078, 0x4cde, 0xb6, 0xef, 0x25, 0xc1, 0x51, 0x75, 0xc7, 0x51>,\
	CLSID_WICPngDecoder2, <0xe018945b, 0xaa86, 0x4008, 0x9b, 0xd4, 0x67, 0x77, 0xa1, 0xe4, 0x0c, 0x11>,\
	CLSID_WICBmpDecoder, <0x6b462062, 0x7cbf, 0x400d, 0x9f, 0xdb, 0x81, 0x3d, 0xd1, 0x0f, 0x27, 0x78>,\
	CLSID_WICIcoDecoder, <0xc61bfcdf, 0x2e0f, 0x4aad, 0xa8, 0xd7, 0xe0, 0x6b, 0xaf, 0xeb, 0xcd, 0xfe>,\
	CLSID_WICJpegDecoder, <0x9456a480, 0xe88b, 0x43ea, 0x9e, 0x73, 0x0b, 0x2d, 0x9b, 0x71, 0xb1, 0xca>,\
	CLSID_WICGifDecoder, <0x381dda3c, 0x9ce9, 0x4834, 0xa2, 0x3e, 0x1f, 0x98, 0xf8, 0xfc, 0x52, 0xbe>,\
	CLSID_WICTiffDecoder, <0xb54e85d9, 0xfe23, 0x499f, 0x8b, 0x88, 0x6a, 0xce, 0xa7, 0x13, 0x75, 0x2b>,\
	CLSID_WICWmpDecoder, <0xa26cec36, 0x234c, 0x4950, 0xae, 0x16, 0xe3, 0x4a, 0xac, 0xe7, 0x1d, 0x0d>,\
	CLSID_WICDdsDecoder, <0x9053699f, 0xa341, 0x429d, 0x9e, 0x90, 0xee, 0x43, 0x7c, 0xf8, 0x0c, 0x73>,\
	CLSID_WICBmpEncoder, <0x69be8bb4, 0xd66d, 0x47c8, 0x86, 0x5a, 0xed, 0x15, 0x89, 0x43, 0x37, 0x82>,\
	CLSID_WICPngEncoder, <0x27949969, 0x876a, 0x41d7, 0x94, 0x47, 0x56, 0x8f, 0x6a, 0x35, 0xa4, 0xdc>,\
	CLSID_WICJpegEncoder, <0x1a34f5c1, 0x4a5a, 0x46dc, 0xb6, 0x44, 0x1f, 0x45, 0x67, 0xe7, 0xa6, 0x76>,\
	CLSID_WICGifEncoder, <0x114f5598, 0x0b22, 0x40a0, 0x86, 0xa1, 0xc8, 0x3e, 0xa4, 0x95, 0xad, 0xbd>,\
	CLSID_WICTiffEncoder, <0x0131be10, 0x2001, 0x4c5f, 0xa9, 0xb0, 0xcc, 0x88, 0xfa, 0xb6, 0x4c, 0xe8>,\
	CLSID_WICWmpEncoder, <0xac4ce3cb, 0xe1c1, 0x44cd, 0x82, 0x15, 0x5a, 0x16, 0x65, 0x50, 0x9e, 0xc2>,\
	CLSID_WICDdsEncoder, <0xa61dde94, 0x66ce, 0x4ac1, 0x88, 0x1b, 0x71, 0x68, 0x05, 0x88, 0x89, 0x5e>,\
	CLSID_WICAdngDecoder, <0x981d9411, 0x909e, 0x42a7, 0x8f, 0x5d, 0xa7, 0x47, 0xff, 0x05, 0x2e, 0xdb>,\
	CLSID_WICJpegQualcommPhoneEncoder, <0x68ed5c62, 0xf534, 0x4979, 0xb2, 0xb3, 0x68, 0x6a, 0x12, 0xb2, 0xb3, 0x4c>,\
	CLSID_WICHeifDecoder, <0xe9A4A80a, 0x44fe, 0x4DE4, 0x89, 0x71, 0x71, 0x50, 0XB1, 0X0a, 0X51, 0X99>,\
	CLSID_WICHeifEncoder, <0x0dbecec1, 0x9eb3, 0x4860, 0x9c, 0x6f, 0xdd, 0xbe, 0x86, 0x63, 0x45, 0x75>,\
	CLSID_WICWebpDecoder, <0x7693E886, 0x51C9, 0x4070, 0x84, 0x19, 0x9F, 0x70, 0X73, 0X8E, 0XC8, 0XFA>,\
	CLSID_WICRAWDecoder, <0x41945702, 0x8302, 0x44A6, 0x94, 0x45, 0xAC, 0x98, 0xE8, 0xAF, 0xA0, 0x86>,\
	GUID_ContainerFormatBmp, <0x0af1d87e, 0xfcfe, 0x4188, 0xbd, 0xeb, 0xa7, 0x90, 0x64, 0x71, 0xcb, 0xe3>,\
	GUID_ContainerFormatPng, <0x1b7cfaf4, 0x713f, 0x473c, 0xbb, 0xcd, 0x61, 0x37, 0x42, 0x5f, 0xae, 0xaf>,\
	GUID_ContainerFormatIco, <0xa3a860c4, 0x338f, 0x4c17, 0x91, 0x9a, 0xfb, 0xa4, 0xb5, 0x62, 0x8f, 0x21>,\
	GUID_ContainerFormatJpeg, <0x19e4a5aa, 0x5662, 0x4fc5, 0xa0, 0xc0, 0x17, 0x58, 0x02, 0x8e, 0x10, 0x57>,\
	GUID_ContainerFormatTiff, <0x163bcc30, 0xe2e9, 0x4f0b, 0x96, 0x1d, 0xa3, 0xe9, 0xfd, 0xb7, 0x88, 0xa3>,\
	GUID_ContainerFormatGif, <0x1f8a5601, 0x7d4d, 0x4cbd, 0x9c, 0x82, 0x1b, 0xc8, 0xd4, 0xee, 0xb9, 0xa5>,\
	GUID_ContainerFormatWmp, <0x57a37caa, 0x367a, 0x4540, 0x91, 0x6b, 0xf1, 0x83, 0xc5, 0x09, 0x3a, 0x4b>,\
	GUID_ContainerFormatDds, <0x9967cb95, 0x2e85, 0x4ac8, 0x8c, 0xa2, 0x83, 0xd7, 0xcc, 0xd4, 0x25, 0xc9>,\
	GUID_ContainerFormatAdng, <0xf3ff6d0d, 0x38c0, 0x41c4, 0xb1, 0xfe, 0x1f, 0x38, 0x24, 0xf1, 0x7b, 0x84>,\
	GUID_ContainerFormatHeif, <0xe1e62521, 0x6787, 0x405b, 0xa3, 0x39, 0x50, 0x07, 0x15, 0xb5, 0x76, 0x3f>,\
	GUID_ContainerFormatWebp, <0xe094b0e2, 0x67f2, 0x45b3, 0xb0, 0xea, 0x11, 0x53, 0x37, 0xca, 0x7c, 0xf3>,\
	GUID_ContainerFormatRaw, <0xfe99ce60, 0xf19c, 0x433c, 0xa3, 0xae, 0x00, 0xac, 0xef, 0xa9, 0xca, 0x21>,\
	CLSID_WICImagingCategories, <0xfae3d380, 0xfea4, 0x4623, 0x8c, 0x75, 0xc6, 0xb6, 0x11, 0x10, 0xb6, 0x81>,\
	CATID_WICBitmapDecoders, <0x7ed96837, 0x96f0, 0x4812, 0xb2, 0x11, 0xf1, 0x3c, 0x24, 0x11, 0x7e, 0xd3>,\
	CATID_WICBitmapEncoders, <0xac757296, 0x3522, 0x4e11, 0x98, 0x62, 0xc1, 0x7b, 0xe5, 0xa1, 0x76, 0x7e>,\
	CATID_WICPixelFormats, <0x2b46e70f, 0xcda7, 0x473e, 0x89, 0xf6, 0xdc, 0x96, 0x30, 0xa2, 0x39, 0x0b>,\
	CATID_WICFormatConverters, <0x7835eae8, 0xbf14, 0x49d1, 0x93, 0xce, 0x53, 0x3a, 0x40, 0x7b, 0x22, 0x48>,\
	CATID_WICMetadataReader, <0x05af94d8, 0x7174, 0x4cd2, 0xbe, 0x4a, 0x41, 0x24, 0xb8, 0x0e, 0xe4, 0xb8>,\
	CATID_WICMetadataWriter, <0xabe3b9a4, 0x257d, 0x4b97, 0xbd, 0x1a, 0x29, 0x4a, 0xf4, 0x96, 0x22, 0x2e>,\
	CLSID_WICDefaultFormatConverter, <0x1a3f11dc, 0xb514, 0x4b17, 0x8c, 0x5f, 0x21, 0x54, 0x51, 0x38, 0x52, 0xf1>,\
	CLSID_WICFormatConverterHighColor, <0xac75d454, 0x9f37, 0x48f8, 0xb9, 0x72, 0x4e, 0x19, 0xbc, 0x85, 0x60, 0x11>,\
	CLSID_WICFormatConverterNChannel, <0xc17cabb2, 0xd4a3, 0x47d7, 0xa5, 0x57, 0x33, 0x9b, 0x2e, 0xfb, 0xd4, 0xf1>,\
	CLSID_WICFormatConverterWMPhoto, <0x9cb5172b, 0xd600, 0x46ba, 0xab, 0x77, 0x77, 0xbb, 0x7e, 0x3a, 0x00, 0xd9>,\
	CLSID_WICPlanarFormatConverter, <0x184132b8, 0x32f8, 0x4784, 0x91, 0x31, 0xdd, 0x72, 0x24, 0xb2, 0x34, 0x38>,\
	GUID_WICPixelFormatDontCare, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x00>,\
	GUID_WICPixelFormat1bppIndexed, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x01>,\
	GUID_WICPixelFormat2bppIndexed, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x02>,\
	GUID_WICPixelFormat4bppIndexed, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x03>,\
	GUID_WICPixelFormat8bppIndexed, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x04>,\
	GUID_WICPixelFormatBlackWhite, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x05>,\
	GUID_WICPixelFormat2bppGray, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x06>,\
	GUID_WICPixelFormat4bppGray, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x07>,\
	GUID_WICPixelFormat8bppGray, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x08>,\
	GUID_WICPixelFormat8bppAlpha, <0xe6cd0116, 0xeeba, 0x4161, 0xaa, 0x85, 0x27, 0xdd, 0x9f, 0xb3, 0xa8, 0x95>,\
	GUID_WICPixelFormat16bppBGR555, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x09>,\
	GUID_WICPixelFormat16bppBGR565, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0a>,\
	GUID_WICPixelFormat16bppBGRA5551, <0x05ec7c2b, 0xf1e6, 0x4961, 0xad, 0x46, 0xe1, 0xcc, 0x81, 0x0a, 0x87, 0xd2>,\
	GUID_WICPixelFormat16bppGray, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0b>,\
	GUID_WICPixelFormat24bppBGR, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0c>,\
	GUID_WICPixelFormat24bppRGB, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0d>,\
	GUID_WICPixelFormat32bppBGR, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0e>,\
	GUID_WICPixelFormat32bppBGRA, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x0f>,\
	GUID_WICPixelFormat32bppPBGRA, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x10>,\
	GUID_WICPixelFormat32bppGrayFloat, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x11>,\
	GUID_WICPixelFormat32bppRGB, <0xd98c6b95, 0x3efe, 0x47d6, 0xbb, 0x25, 0xeb, 0x17, 0x48, 0xab, 0x0c, 0xf1>,\
	GUID_WICPixelFormat32bppRGBA, <0xf5c7ad2d, 0x6a8d, 0x43dd, 0xa7, 0xa8, 0xa2, 0x99, 0x35, 0x26, 0x1a, 0xe9>,\
	GUID_WICPixelFormat32bppPRGBA, <0x3cc4a650, 0xa527, 0x4d37, 0xa9, 0x16, 0x31, 0x42, 0xc7, 0xeb, 0xed, 0xba>,\
	GUID_WICPixelFormat48bppRGB, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x15>,\
	GUID_WICPixelFormat48bppBGR, <0xe605a384, 0xb468, 0x46ce, 0xbb, 0x2e, 0x36, 0xf1, 0x80, 0xe6, 0x43, 0x13>,\
	GUID_WICPixelFormat64bppRGB, <0xa1182111, 0x186d, 0x4d42, 0xbc, 0x6a, 0x9c, 0x83, 0x03, 0xa8, 0xdf, 0xf9>,\
	GUID_WICPixelFormat64bppRGBA, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x16>,\
	GUID_WICPixelFormat64bppBGRA, <0x1562ff7c, 0xd352, 0x46f9, 0x97, 0x9e, 0x42, 0x97, 0x6b, 0x79, 0x22, 0x46>,\
	GUID_WICPixelFormat64bppPRGBA, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x17>,\
	GUID_WICPixelFormat64bppPBGRA, <0x8c518e8e, 0xa4ec, 0x468b, 0xae, 0x70, 0xc9, 0xa3, 0x5a, 0x9c, 0x55, 0x30>,\
	GUID_WICPixelFormat16bppGrayFixedPoint, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x13>,\
	GUID_WICPixelFormat32bppBGR101010, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x14>,\
	GUID_WICPixelFormat48bppRGBFixedPoint, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x12>,\
	GUID_WICPixelFormat48bppBGRFixedPoint, <0x49ca140e, 0xcab6, 0x493b, 0x9d, 0xdf, 0x60, 0x18, 0x7c, 0x37, 0x53, 0x2a>,\
	GUID_WICPixelFormat96bppRGBFixedPoint, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x18>,\
	GUID_WICPixelFormat96bppRGBFloat, <0xe3fed78f, 0xe8db, 0x4acf, 0x84, 0xc1, 0xe9, 0x7f, 0x61, 0x36, 0xb3, 0x27>,\
	GUID_WICPixelFormat128bppRGBAFloat, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x19>,\
	GUID_WICPixelFormat128bppPRGBAFloat, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x1a>,\
	GUID_WICPixelFormat128bppRGBFloat, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x1b>,\
	GUID_WICPixelFormat32bppCMYK, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x1c>,\
	GUID_WICPixelFormat64bppRGBAFixedPoint, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x1d>,\
	GUID_WICPixelFormat64bppBGRAFixedPoint, <0x356de33c, 0x54d2, 0x4a23, 0xbb, 0x4, 0x9b, 0x7b, 0xf9, 0xb1, 0xd4, 0x2d>,\
	GUID_WICPixelFormat64bppRGBFixedPoint, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x40>,\
	GUID_WICPixelFormat128bppRGBAFixedPoint, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x1e>,\
	GUID_WICPixelFormat128bppRGBFixedPoint, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x41>,\
	GUID_WICPixelFormat64bppRGBAHalf, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x3a>,\
	GUID_WICPixelFormat64bppPRGBAHalf, <0x58ad26c2, 0xc623, 0x4d9d, 0xb3, 0x20, 0x38, 0x7e, 0x49, 0xf8, 0xc4, 0x42>,\
	GUID_WICPixelFormat64bppRGBHalf, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x42>,\
	GUID_WICPixelFormat48bppRGBHalf, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x3b>,\
	GUID_WICPixelFormat32bppRGBE, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x3d>,\
	GUID_WICPixelFormat16bppGrayHalf, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x3e>,\
	GUID_WICPixelFormat32bppGrayFixedPoint, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x3f>,\
	GUID_WICPixelFormat32bppRGBA1010102, <0x25238D72, 0xFCF9, 0x4522, 0xb5, 0x14, 0x55, 0x78, 0xe5, 0xad, 0x55, 0xe0>,\
	GUID_WICPixelFormat32bppRGBA1010102XR, <0x00DE6B9A, 0xC101, 0x434b, 0xb5, 0x02, 0xd0, 0x16, 0x5e, 0xe1, 0x12, 0x2c>,\
	GUID_WICPixelFormat32bppR10G10B10A2, <0x604e1bb5, 0x8a3c, 0x4b65, 0xb1, 0x1c, 0xbc, 0x0b, 0x8d, 0xd7, 0x5b, 0x7f>,\
	GUID_WICPixelFormat32bppR10G10B10A2HDR10, <0x9c215c5d, 0x1acc, 0x4f0e, 0xa4, 0xbc, 0x70, 0xfb, 0x3a, 0xe8, 0xfd, 0x28>,\
	GUID_WICPixelFormat64bppCMYK, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x1f>,\
	GUID_WICPixelFormat24bpp3Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x20>,\
	GUID_WICPixelFormat32bpp4Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x21>,\
	GUID_WICPixelFormat40bpp5Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x22>,\
	GUID_WICPixelFormat48bpp6Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x23>,\
	GUID_WICPixelFormat56bpp7Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x24>,\
	GUID_WICPixelFormat64bpp8Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x25>,\
	GUID_WICPixelFormat48bpp3Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x26>,\
	GUID_WICPixelFormat64bpp4Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x27>,\
	GUID_WICPixelFormat80bpp5Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x28>,\
	GUID_WICPixelFormat96bpp6Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x29>,\
	GUID_WICPixelFormat112bpp7Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x2a>,\
	GUID_WICPixelFormat128bpp8Channels, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x2b>,\
	GUID_WICPixelFormat40bppCMYKAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x2c>,\
	GUID_WICPixelFormat80bppCMYKAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x2d>,\
	GUID_WICPixelFormat32bpp3ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x2e>,\
	GUID_WICPixelFormat40bpp4ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x2f>,\
	GUID_WICPixelFormat48bpp5ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x30>,\
	GUID_WICPixelFormat56bpp6ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x31>,\
	GUID_WICPixelFormat64bpp7ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x32>,\
	GUID_WICPixelFormat72bpp8ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x33>,\
	GUID_WICPixelFormat64bpp3ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x34>,\
	GUID_WICPixelFormat80bpp4ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x35>,\
	GUID_WICPixelFormat96bpp5ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x36>,\
	GUID_WICPixelFormat112bpp6ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x37>,\
	GUID_WICPixelFormat128bpp7ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x38>,\
	GUID_WICPixelFormat144bpp8ChannelsAlpha, <0x6fddc324, 0x4e03, 0x4bfe, 0xb1, 0x85, 0x3d, 0x77, 0x76, 0x8d, 0xc9, 0x39>,\
	GUID_WICPixelFormat8bppY, <0x91B4DB54, 0x2DF9, 0x42F0, 0xB4, 0x49, 0x29, 0x09, 0xBB, 0x3D, 0xF8, 0x8E>,\
	GUID_WICPixelFormat8bppCb, <0x1339F224, 0x6BFE, 0x4C3E, 0x93, 0x02, 0xE4, 0xF3, 0xA6, 0xD0, 0xCA, 0x2A>,\
	GUID_WICPixelFormat8bppCr, <0xB8145053, 0x2116, 0x49F0, 0x88, 0x35, 0xED, 0x84, 0x4B, 0x20, 0x5C, 0x51>,\
	GUID_WICPixelFormat16bppCbCr, <0xFF95BA6E, 0x11E0, 0x4263, 0xBB, 0x45, 0x01, 0x72, 0x1F, 0x34, 0x60, 0xA4>,\
	GUID_WICPixelFormat16bppYQuantizedDctCoefficients, <0xA355F433, 0x48E8, 0x4A42, 0x84, 0xD8, 0xE2, 0xAA, 0x26, 0xCA, 0x80, 0xA4>,\
	GUID_WICPixelFormat16bppCbQuantizedDctCoefficients, <0xD2C4FF61, 0x56A5, 0x49C2, 0x8B, 0x5C, 0x4C, 0x19, 0x25, 0x96, 0x48, 0x37>,\
	GUID_WICPixelFormat16bppCrQuantizedDctCoefficients, <0x2FE354F0, 0x1680, 0x42D8, 0x92, 0x31, 0xE7, 0x3C, 0x05, 0x65, 0xBF, 0xC1>

	if used NAME ; :TODO: add conditional literal if building EXE
		extrn `NAME as NAME:16 ; assume COFF object
	end if
end iterate


struct WICRect
	X	dd ?
	Y	dd ?
	Width	dd ?
	Height	dd ?
ends


; enum WICColorContextType
WICColorContextUninitialized	:= 0
WICColorContextProfile		:= 1
WICColorContextExifColorSpace	:= 2

WIC_JPEG_MAX_COMPONENT_COUNT		:= 4
WIC_JPEG_MAX_TABLE_INDEX		:= 3
WIC_JPEG_SAMPLE_FACTORS_ONE		:= 0x11
WIC_JPEG_SAMPLE_FACTORS_THREE_420	:= 0x111122
WIC_JPEG_SAMPLE_FACTORS_THREE_422	:= 0x111121
WIC_JPEG_SAMPLE_FACTORS_THREE_440	:= 0x111112
WIC_JPEG_SAMPLE_FACTORS_THREE_444	:= 0x111111
WIC_JPEG_QUANTIZATION_BASELINE_ONE	:= 0
WIC_JPEG_QUANTIZATION_BASELINE_THREE	:= 0x10100
WIC_JPEG_HUFFMAN_BASELINE_ONE		:= 0
WIC_JPEG_HUFFMAN_BASELINE_THREE		:= 0x111100

; enum WICBitmapCreateCacheOption
WICBitmapNoCache			:= 0
WICBitmapCacheOnDemand			:= 1
WICBitmapCacheOnLoad			:= 2

; enum WICDecodeOptions
WICDecodeMetadataCacheOnDemand	:= 0
WICDecodeMetadataCacheOnLoad	:= 1

; enum WICBitmapEncoderCacheOption
WICBitmapEncoderCacheInMemory	:= 0
WICBitmapEncoderCacheTempFile	:= 1
WICBitmapEncoderNoCache		:= 2

; enum WICComponentType
WICDecoder		:= 0x01
WICEncoder		:= 0x02
WICPixelFormatConverter	:= 0x04
WICMetadataReader	:= 0x08
WICMetadataWriter	:= 0x10
WICPixelFormat		:= 0x20
WICAllComponents	:= 0x3F

; enum WICComponentEnumerateOptions
WICComponentEnumerateDefault	:= 0x00000000
WICComponentEnumerateRefresh	:= 0x00000001
WICComponentEnumerateBuiltInOnly:= 0x20000000
WICComponentEnumerateUnsigned	:= 0x40000000
WICComponentEnumerateDisabled	:= 0x80000000

struct WICBitmapPattern
	Position	dq ?	; ULARGE_INTEGER
	Length		dd ?	; ULONG
		__0	dd ?
	Pattern		dq ?	; BYTE *
	Mask		dq ?	; BYTE *
	EndOfStream	dd ?	; BOOL
		__1	dd ?
ends

; enum WICBitmapInterpolationMode
WICBitmapInterpolationModeNearestNeighbor	= 0
WICBitmapInterpolationModeLinear		= 1
WICBitmapInterpolationModeCubic			= 2
WICBitmapInterpolationModeFant			= 3
WICBitmapInterpolationModeHighQualityCubic	= 4

; enum WICBitmapPaletteType
WICBitmapPaletteTypeCustom		:= 0
WICBitmapPaletteTypeMedianCut		:= 1
WICBitmapPaletteTypeFixedBW		:= 2
WICBitmapPaletteTypeFixedHalftone8	:= 3
WICBitmapPaletteTypeFixedHalftone27	:= 4
WICBitmapPaletteTypeFixedHalftone64	:= 5
WICBitmapPaletteTypeFixedHalftone125	:= 6
WICBitmapPaletteTypeFixedHalftone216	:= 7
WICBitmapPaletteTypeFixedHalftone252	:= 8
WICBitmapPaletteTypeFixedHalftone256	:= 9
WICBitmapPaletteTypeFixedGray4		:= 10
WICBitmapPaletteTypeFixedGray16		:= 11
WICBitmapPaletteTypeFixedGray256	:= 12
WICBitmapPaletteTypeFixedWebPalette	:= WICBitmapPaletteTypeFixedHalftone216

; enum WICBitmapDitherType
WICBitmapDitherTypeNone			= 0
WICBitmapDitherTypeSolid		= 0
WICBitmapDitherTypeOrdered4x4		= 1
WICBitmapDitherTypeOrdered8x8		= 2
WICBitmapDitherTypeOrdered16x16		= 3
WICBitmapDitherTypeSpiral4x4		= 4
WICBitmapDitherTypeSpiral8x8		= 5
WICBitmapDitherTypeDualSpiral4x4	= 6
WICBitmapDitherTypeDualSpiral8x8	= 7
WICBitmapDitherTypeErrorDiffusion	= 8

; enum WICBitmapAlphaChannelOption
WICBitmapUseAlpha		:= 0
WICBitmapUsePremultipliedAlpha	:= 1
WICBitmapIgnoreAlpha		:= 2

; enum WICBitmapTransformOptions
WICBitmapTransformRotate0	:= 0x00
WICBitmapTransformRotate90	:= 0x01
WICBitmapTransformRotate180	:= 0x02
WICBitmapTransformRotate270	:= 0x03
WICBitmapTransformFlipHorizontal:= 0x08
WICBitmapTransformFlipVertical	:= 0x10

; enum WICBitmapLockFlags
WICBitmapLockRead	:= 1
WICBitmapLockWrite	:= 2

; enum WICBitmapDecoderCapabilities
WICBitmapDecoderCapabilitySameEncoder		:= 0x01
WICBitmapDecoderCapabilityCanDecodeAllImages	:= 0x02
WICBitmapDecoderCapabilityCanDecodeSomeImages	:= 0x04
WICBitmapDecoderCapabilityCanEnumerateMetadata	:= 0x08
WICBitmapDecoderCapabilityCanDecodeThumbnail	:= 0x10

; enum WICProgressOperation
WICProgressOperationCopyPixels	:= 0x0001
WICProgressOperationWritePixels	:= 0x0002
WICProgressOperationAll		:= 0xFFFF

; enum WICProgressNotification
WICProgressNotificationBegin	:= 0x00010000
WICProgressNotificationEnd	:= 0x00020000
WICProgressNotificationFrequent	:= 0x00040000
WICProgressNotificationAll	:= 0xFFFF0000

; enum WICComponentSigning
WICComponentSigned	:= 0x00000001
WICComponentUnsigned	:= 0x00000002
WICComponentSafe	:= 0x00000004
WICComponentDisabled	:= 0x80000000

; enum WICGifLogicalScreenDescriptorProperties
WICGifLogicalScreenSignature				:= 1
WICGifLogicalScreenDescriptorWidth			:= 2
WICGifLogicalScreenDescriptorHeight			:= 3
WICGifLogicalScreenDescriptorGlobalColorTableFlag	:= 4
WICGifLogicalScreenDescriptorColorResolution		:= 5
WICGifLogicalScreenDescriptorSortFlag			:= 6
WICGifLogicalScreenDescriptorGlobalColorTableSize	:= 7
WICGifLogicalScreenDescriptorBackgroundColorIndex	:= 8
WICGifLogicalScreenDescriptorPixelAspectRatio		:= 9

; enum WICGifImageDescriptorProperties
WICGifImageDescriptorLeft			:= 1
WICGifImageDescriptorTop			:= 2
WICGifImageDescriptorWidth			:= 3
WICGifImageDescriptorHeight			:= 4
WICGifImageDescriptorLocalColorTableFlag	:= 5
WICGifImageDescriptorInterlaceFlag		:= 6
WICGifImageDescriptorSortFlag			:= 7
WICGifImageDescriptorLocalColorTableSize	:= 8

; enum WICGifGraphicControlExtensionProperties
WICGifGraphicControlExtensionDisposal			:= 1
WICGifGraphicControlExtensionUserInputFlag		:= 2
WICGifGraphicControlExtensionTransparencyFlag		:= 3
WICGifGraphicControlExtensionDelay			:= 4
WICGifGraphicControlExtensionTransparentColorIndex	:= 5

; enum WICGifApplicationExtensionProperties
WICGifApplicationExtensionApplication	:= 1
WICGifApplicationExtensionData		:= 2

; enum WICGifCommentExtensionProperties
WICGifCommentExtensionText	:= 1

; enum WICJpegCommentProperties
WICJpegCommentText	:= 1

; enum WICJpegLuminanceProperties
WICJpegLuminanceTable	:= 1

; enum WICJpegChrominanceProperties
WICJpegChrominanceTable	:= 1

; enum WIC8BIMIptcProperties
WIC8BIMIptcPString	:= 0
WIC8BIMIptcEmbeddedIPTC	:= 1

; enum WIC8BIMResolutionInfoProperties
WIC8BIMResolutionInfoPString		:= 1
WIC8BIMResolutionInfoHResolution	:= 2
WIC8BIMResolutionInfoHResolutionUnit	:= 3
WIC8BIMResolutionInfoWidthUnit		:= 4
WIC8BIMResolutionInfoVResolution	:= 5
WIC8BIMResolutionInfoVResolutionUnit	:= 6
WIC8BIMResolutionInfoHeightUnit		:= 7

; enum WIC8BIMIptcDigestProperties
WIC8BIMIptcDigestPString	:= 1
WIC8BIMIptcDigestIptcDigest	:= 2

; enum WICPngGamaProperties
WICPngGamaGamma	:= 1

; enum WICPngBkgdProperties
WICPngBkgdBackgroundColor	:= 1

; enum WICPngItxtProperties
WICPngItxtKeyword		:= 1
WICPngItxtCompressionFlag	:= 2
WICPngItxtLanguageTag		:= 3
WICPngItxtTranslatedKeyword	:= 4
WICPngItxtText			:= 5

; enum WICPngChrmProperties
WICPngChrmWhitePointX	:= 1
WICPngChrmWhitePointY	:= 2
WICPngChrmRedX		:= 3
WICPngChrmRedY		:= 4
WICPngChrmGreenX	:= 5
WICPngChrmGreenY	:= 6
WICPngChrmBlueX		:= 7
WICPngChrmBlueY		:= 8

; enum WICPngHistProperties
WICPngHistFrequencies	:= 1

; enum WICPngIccpProperties
WICPngIccpProfileName	:= 1
WICPngIccpProfileData	:= 2

; enum WICPngSrgbProperties
WICPngSrgbRenderingIntent	:= 1

; enum WICPngTimeProperties
WICPngTimeYear	:= 1
WICPngTimeMonth	:= 2
WICPngTimeDay	:= 3
WICPngTimeHour	:= 4
WICPngTimeMinute:= 5
WICPngTimeSecond:= 6

; enum WICHeifProperties
WICHeifOrientation	:= 1

; enum WICHeifHdrProperties
WICHeifHdrMaximumLuminanceLevel			:= 1
WICHeifHdrMaximumFrameAverageLuminanceLevel	:= 2
WICHeifHdrMinimumMasteringDisplayLuminanceLevel	:= 3
WICHeifHdrMaximumMasteringDisplayLuminanceLevel	:= 4
WICHeifHdrCustomVideoPrimaries			:= 5

;enum WICWebpAnimProperties
WICWebpAnimLoopCount	:= 1

; enum WICWebpAnmfProperties
WICWebpAnmfFrameDuration	:= 1

; enum WICSectionAccessLevel
WICSectionAccessLevelRead	:= 1
WICSectionAccessLevelReadWrite	:= 3

; enum WICPixelFormatNumericRepresentation
WICPixelFormatNumericRepresentationUnspecified		:= 0
WICPixelFormatNumericRepresentationIndexed		:= 1
WICPixelFormatNumericRepresentationUnsignedInteger	:= 2
WICPixelFormatNumericRepresentationSignedInteger	:= 3
WICPixelFormatNumericRepresentationFixed		:= 4
WICPixelFormatNumericRepresentationFloat		:= 5

; enum WICPlanarOptions
WICPlanarOptionsDefault			:= 0
WICPlanarOptionsPreserveSubsampling	:= 1

; enum WICJpegIndexingOptions
WICJpegIndexingOptionsGenerateOnDemand	:= 0
WICJpegIndexingOptionsGenerateOnLoad	:= 1

; enum WICJpegTransferMatrix
WICJpegTransferMatrixIdentity	:= 0
WICJpegTransferMatrixBT601	:= 1

; enum WICJpegScanType
WICJpegScanTypeInterleaved	:= 0
WICJpegScanTypePlanarComponents	:= 1
WICJpegScanTypeProgressive	:= 2

struct WICImageParameters
	PixelFormat D2D1_PIXEL_FORMAT
	DpiX		dd ?	; FLOAT
	DpiY		dd ?	; FLOAT
	Top		dd ?	; FLOAT
	Left		dd ?	; FLOAT
	PixelWidth	dd ?	; UINT32
	PixelHeight	dd ?	; UINT32
ends

struct WICBitmapPlaneDescription
	_Format		GUID	; WICPixelFormatGUID
	Width		dd ?	; UINT
	Height		dd ?	; UINT
ends

struct WICBitmapPlane
	_Format		GUID	; WICPixelFormatGUID
	pbBuffer	dq ?	;*BYTE
	cbStride	dd ?	; UINT
	cbBufferSize	dd ?	; UINT
ends

struct WICJpegFrameHeader
	Width				dd ?	; UINT
	Height				dd ?	; UINT
	TransferMatrix			dd ?	; WICJpegTransferMatrix
	ScanType			dd ?	; WICJpegScanType
	cComponents			dd ?	; UINT
	ComponentIdentifiers		dd ?
	SampleFactors			dd ?
	QuantizationTableIndices	dd ?
ends

struct WICJpegScanHeader
	cComponents			dd ?	; UINT
	RestartInterval			dd ?	; UINT
	ComponentSelectors		dd ?
	HuffmanTableIndices		dd ?
	StartSpectralSelection		db ?
	EndSpectralSelection		db ?
	SuccessiveApproximationHigh	db ?
	SuccessiveApproximationLow	db ?
ends

struct WICDdsFormatInfo
	DxgiFormat	dd ?	; DXGI_FORMAT
	BytesPerBlock	dd ?	; UINT
	BlockWidth	dd ?	; UINT
	BlockHeight	dd ?	; UINT
ends


FACILITY_WINCODEC_ERR	:= 0x898
WINCODEC_ERR_BASE	:= 0x2000
;#define MAKE_WINCODECHR(sev, code) MAKE_HRESULT(sev, FACILITY_WINCODEC_ERR, (WINCODEC_ERR_BASE + code))
;#define MAKE_WINCODECHR_ERR(code) MAKE_WINCODECHR(1, code)
WINCODEC_ERR_GENERIC_ERROR	:= E_FAIL
WINCODEC_ERR_INVALIDPARAMETER	:= E_INVALIDARG
WINCODEC_ERR_OUTOFMEMORY	:= E_OUTOFMEMORY
WINCODEC_ERR_NOTIMPLEMENTED	:= E_NOTIMPL
WINCODEC_ERR_ABORTED		:= E_ABORT
WINCODEC_ERR_ACCESSDENIED	:= E_ACCESSDENIED
WINCODEC_ERR_VALUEOVERFLOW	:= INTSAFE_E_ARITHMETIC_OVERFLOW

; enum WICTiffCompressionOption
WICTiffCompressionDontCare		:= 0
WICTiffCompressionNone			:= 1
WICTiffCompressionCCITT3		:= 2
WICTiffCompressionCCITT4		:= 3
WICTiffCompressionLZW			:= 4
WICTiffCompressionRLE			:= 5
WICTiffCompressionZIP			:= 6
WICTiffCompressionLZWHDifferencing	:= 7

; enum WICJpegYCrCbSubsamplingOption
WICJpegYCrCbSubsamplingDefault	:= 0
WICJpegYCrCbSubsampling420	:= 1
WICJpegYCrCbSubsampling422	:= 2
WICJpegYCrCbSubsampling444	:= 3
WICJpegYCrCbSubsampling440	:= 4

; enum WICPngFilterOption
WICPngFilterUnspecified	:= 0
WICPngFilterNone	:= 1
WICPngFilterSub		:= 2
WICPngFilterUp		:= 3
WICPngFilterAverage	:= 4
WICPngFilterPaeth	:= 5
WICPngFilterAdaptive	:= 6

; enum WICNamedWhitePoint
WICWhitePointDefault		:= 0x001
WICWhitePointDaylight		:= 0x002
WICWhitePointCloudy		:= 0x004
WICWhitePointShade		:= 0x008
WICWhitePointTungsten		:= 0x010
WICWhitePointFluorescent	:= 0x020
WICWhitePointFlash		:= 0x040
WICWhitePointUnderwater		:= 0x080
WICWhitePointCustom		:= 0x100
WICWhitePointAutoWhiteBalance	:= 0x200
WICWhitePointAsShot := WICWhitePointDefault

; enum WICRawCapabilities
WICRawCapabilityNotSupported	:= 0
WICRawCapabilityGetSupported	:= 1
WICRawCapabilityFullySupported	:= 2

; enum WICRawRotationCapabilities
WICRawRotationCapabilityNotSupported		:= 0
WICRawRotationCapabilityGetSupported		:= 1
WICRawRotationCapabilityNinetyDegreesSupported	:= 2
WICRawRotationCapabilityFullySupported		:= 3

struct WICRawCapabilitiesInfo
	cbSize				dd ?	; UINT
	CodecMajorVersion		dd ?	; UINT
	CodecMinorVersion		dd ?	; UINT
	ExposureCompensationSupport	dd ?	; WICRawCapabilities
	ContrastSupport			dd ?	; WICRawCapabilities
	RGBWhitePointSupport		dd ?	; WICRawCapabilities
	NamedWhitePointSupport		dd ?	; WICRawCapabilities
	NamedWhitePointSupportMask	dd ?	; UINT
	KelvinWhitePointSupport		dd ?	; WICRawCapabilities
	GammaSupport			dd ?	; WICRawCapabilities
	TintSupport			dd ?	; WICRawCapabilities
	SaturationSupport		dd ?	; WICRawCapabilities
	SharpnessSupport		dd ?	; WICRawCapabilities
	NoiseReductionSupport		dd ?	; WICRawCapabilities
	DestinationColorProfileSupport	dd ?	; WICRawCapabilities
	ToneCurveSupport		dd ?	; WICRawCapabilities
	RotationSupport			dd ?	; WICRawRotationCapabilities
	RenderModeSupport		dd ?	; WICRawCapabilities
ends

; enum WICRawParameterSet
WICAsShotParameterSet		:= 1
WICUserAdjustedParameterSet	:= 2
WICAutoAdjustedParameterSet	:= 3

; enum WICRawRenderMode
WICRawRenderModeDraft		:= 1
WICRawRenderModeNormal		:= 2
WICRawRenderModeBestQuality	:= 3

struct WICRawToneCurvePoint
	Input	dq ?	; double
	Output	dq ?	; double
ends

struct WICRawToneCurve
	cPoints	dd ?	; UINT
	__0	dd ?
	aPoints	WICRawToneCurvePoint
ends

WICRawChangeNotification_ExposureCompensation	:=0x00000001
WICRawChangeNotification_NamedWhitePoint	:=0x00000002
WICRawChangeNotification_KelvinWhitePoint	:=0x00000004
WICRawChangeNotification_RGBWhitePoint		:=0x00000008
WICRawChangeNotification_Contrast		:=0x00000010
WICRawChangeNotification_Gamma			:=0x00000020
WICRawChangeNotification_Sharpness		:=0x00000040
WICRawChangeNotification_Saturation		:=0x00000080
WICRawChangeNotification_Tint			:=0x00000100
WICRawChangeNotification_NoiseReduction		:=0x00000200
WICRawChangeNotification_DestinationColorContext:=0x00000400
WICRawChangeNotification_ToneCurve		:=0x00000800
WICRawChangeNotification_Rotation		:=0x00001000
WICRawChangeNotification_RenderMode		:=0x00002000

; enum WICDdsDimension
WICDdsTexture1D		:= 0
WICDdsTexture2D		:= 1
WICDdsTexture3D		:= 2
WICDdsTextureCube	:= 3

; enum WICDdsAlphaMode
WICDdsAlphaModeUnknown		:= 0
WICDdsAlphaModeStraight		:= 1
WICDdsAlphaModePremultiplied	:= 2
WICDdsAlphaModeOpaque		:= 3
WICDdsAlphaModeCustom		:= 4

struct WICDdsParameters
	Width		dd ?	; UINT
	Height		dd ?	; UINT
	Depth		dd ?	; UINT
	MipLevels	dd ?	; UINT
	ArraySize	dd ?	; UINT
	DxgiFormat	dd ?	; DXGI_FORMAT
	Dimension	dd ?	; WICDdsDimension
	AlphaMode	dd ?	; WICDdsAlphaMode
ends

;-------------------------------------------------------------------------------

IWICPalette interface 00000040-A8F2-4877-BA0A-FD2B6645FB94,\
	EXTENDS__IUnknown,\
	InitializePredefined,InitializeCustom,InitializeFromBitmap,InitializeFromPalette,GetType,GetColorCount,GetColors,IsBlackWhite,IsGrayscale,HasAlpha

IWICBitmapSource interface 00000120-A8F2-4877-BA0A-FD2B6645FB94,\
	EXTENDS__IUnknown,\
	GetSize,GetPixelFormat,GetResolution,CopyPalette,CopyPixels

IWICFormatConverter interface 00000301-A8F2-4877-BA0A-FD2B6645FB94,\
	EXTENDS__IWICBitmapSource,\
	Initialize,CanConvert

IWICPlanarFormatConverter interface BEBEE9CB-83B0-4DCC-8132-B0AAA55EAC96,\
	EXTENDS__IWICBitmapSource, Initialize,CanConvert

IWICBitmapScaler interface 00000302-A8F2-4877-BA0A-FD2B6645FB94,\
	EXTENDS__IWICBitmapSource,\
	Initialize

IWICBitmapClipper interface E4FBCF03-223D-4E81-9333-D635556DD1B5,\
	EXTENDS__IWICBitmapSource,\
	Initialize

IWICBitmapFlipRotator interface 5009834F-2D6A-41CE-9E1B-17C5AFF7A782,\
	EXTENDS__IWICBitmapSource,\
	Initialize

IWICBitmapLock interface 00000123-A8F2-4877-BA0A-FD2B6645FB94,\
	EXTENDS__IUnknown,\
	GetSize,GetStride,GetDataPointer,GetPixelFormat

IWICBitmap interface 00000121-A8F2-4877-BA0A-FD2B6645FB94,\
	EXTENDS__IWICBitmapSource,\
	Lock,SetPalette,SetResolution

IWICColorContext interface 3C613A02-34B2-44EA-9A7C-45AEA9C6FD6D,\
	EXTENDS__IUnknown,\
	InitializeFromFilename,InitializeFromMemory,InitializeFromExifColorSpace,GetType,GetProfileBytes,GetExifColorSpace

IWICColorTransform interface B66F034F-D0E2-40ab-B436-6DE39E321A94,\
	EXTENDS__IWICBitmapSource,\
	Initialize

IWICFastMetadataEncoder interface B84E2C09-78C9-4AC4-8BD3-524AE1663A2F,\
	EXTENDS__IUnknown,\
	Commit,GetMetadataQueryWriter

IWICStream interface 135FF860-22B7-4DDF-B0F6-218F4F299A43,\
	EXTENDS__IStream,\
	InitializeFromIStream,InitializeFromFilename,InitializeFromMemory,InitializeFromIStreamRegion

IWICEnumMetadataItem interface DC2BB46D-3F07-481E-8625-220C4AEDBB33,\
	EXTENDS__IUnknown,\
	Next,Skip,Reset,Clone

IWICMetadataQueryReader interface 30989668-E1C9-4597-B395-458EEDB808DF,\
	EXTENDS__IUnknown,\
	GetContainerFormat,GetLocation,GetMetadataByName,GetEnumerator

IWICMetadataQueryWriter interface A721791A-0DEF-4d06-BD91-2118BF1DB10B,\
	EXTENDS__IWICMetadataQueryReader,\
	SetMetadataByName,RemoveMetadataByName

IWICBitmapEncoder interface 00000103-A8F2-4877-BA0A-FD2B6645FB94,\
	EXTENDS__IUnknown,\
	Initialize,GetContainerFormat,GetEncoderInfo,SetColorContexts,SetPalette,SetThumbnail,SetPreview,CreateNewFrame,Commit,GetMetadataQueryWriter

IWICBitmapFrameEncode interface 00000105-A8F2-4877-BA0A-FD2B6645FB94,\
	EXTENDS__IUnknown,\
	Initialize,SetSize,SetResolution,SetPixelFormat,SetColorContexts,SetPalette,SetThumbnail,WritePixels,WriteSource,Commit,GetMetadataQueryWriter

IWICPlanarBitmapFrameEncode interface F928B7B8-2221-40C1-B72E-7E82F1974D1A,\
	EXTENDS__IUnknown,\
	WritePixels,WriteSource

IWICImageEncoder interface 04C75BF8-3CE1-473B-ACC5-3CC4F5E94999,\
	EXTENDS__IUnknown,\
	WriteFrame,WriteFrameThumbnail,WriteThumbnail

IWICBitmapDecoder interface 9EDDE9E7-8DEE-47ea-99DF-E6FAF2ED44BF,\
	EXTENDS__IUnknown,\
	QueryCapability,Initialize,GetContainerFormat,GetDecoderInfo,CopyPalette,GetMetadataQueryReader,GetPreview,GetColorContexts,GetThumbnail,GetFrameCount,GetFrame

IWICBitmapSourceTransform interface 3B16811B-6A43-4ec9-B713-3D5A0C13B940,\
	EXTENDS__IUnknown,\
	CopyPixels,GetClosestSize,GetClosestPixelFormat,DoesSupportTransform

IWICPlanarBitmapSourceTransform interface 3AFF9CCE-BE95-4303-B927-E7D16FF4A613,\
	EXTENDS__IUnknown,\
	DoesSupportTransform,CopyPixels

IWICBitmapFrameDecode interface 3B16811B-6A43-4ec9-A813-3D930C13B940,\
	EXTENDS__IWICBitmapSource,\
	GetMetadataQueryReader,GetColorContexts,GetThumbnail

IWICProgressiveLevelControl interface DAAC296F-7AA5-4dbf-8D15-225C5976F891,\
	EXTENDS__IUnknown,\
	GetLevelCount,GetCurrentLevel,SetCurrentLevel

IWICProgressCallback interface 4776F9CD-9517-45FA-BF24-E89C5EC5C60C,\
	EXTENDS__IUnknown,\
	Notify

IWICBitmapCodecProgressNotification interface 64C1024E-C3CF-4462-8078-88C2B11C46D9,\
	EXTENDS__IUnknown,\
	RegisterProgressNotification

IWICComponentInfo interface 23BC3F0A-698B-4357-886B-F24D50671334,\
	EXTENDS__IUnknown,\
	GetComponentType,GetCLSID,GetSigningStatus,GetAuthor,GetVendorGUID,GetVersion,GetSpecVersion,GetFriendlyName

IWICFormatConverterInfo interface 9F34FB65-13F4-4f15-BC57-3726B5E53D9F,\
	EXTENDS__IWICComponentInfo,\
	GetPixelFormats,CreateInstance

IWICBitmapCodecInfo interface E87A44C4-B76E-4c47-8B09-298EB12A2714,\
	EXTENDS__IWICComponentInfo,\
	GetContainerFormat,GetPixelFormats,GetColorManagementVersion,GetDeviceManufacturer,GetDeviceModels,GetMimeTypes,GetFileExtensions,DoesSupportAnimation,DoesSupportChromakey,DoesSupportLossless,DoesSupportMultiframe,MatchesMimeType

IWICBitmapEncoderInfo interface 94C9B4EE-A09F-4f92-8A1E-4A9BCE7E76FB,\
	EXTENDS__IWICBitmapCodecInfo,\
	CreateInstance

IWICBitmapDecoderInfo interface D8CD007F-D08F-4191-9BFC-236EA7F0E4B5,\
	EXTENDS__IWICBitmapCodecInfo,\
	GetPatterns,MatchesPattern,CreateInstance

IWICPixelFormatInfo interface E8EDA601-3D48-431a-AB44-69059BE88BBE,\
	EXTENDS__IWICComponentInfo,\
	GetFormatGUID,GetColorContext,GetBitsPerPixel,GetChannelCount,GetChannelMask

IWICPixelFormatInfo2 interface A9DB33A2-AF5F-43C7-B679-74F5984B5AA4,\
	EXTENDS__IWICPixelFormatInfo,\
	SupportsTransparency,GetNumericRepresentation

IWICImagingFactory interface EC5EC8A9-C395-4314-9C77-54D7A935FF70,\
	EXTENDS__IUnknown,\
	CreateDecoderFromFilename,CreateDecoderFromStream,CreateDecoderFromFileHandle,CreateComponentInfo,CreateDecoder,CreateEncoder,CreatePalette,CreateFormatConverter,CreateBitmapScaler,CreateBitmapClipper,CreateBitmapFlipRotator,CreateStream,CreateColorContext,CreateColorTransformer,CreateBitmap,CreateBitmapFromSource,CreateBitmapFromSourceRect,CreateBitmapFromMemory,CreateBitmapFromHBITMAP,CreateBitmapFromHICON,CreateComponentEnumerator,CreateFastMetadataEncoderFromDecoder,CreateFastMetadataEncoderFromFrameDecode,CreateQueryWriter,CreateQueryWriterFromReader

IWICImagingFactory2 interface 7B816B45-1996-4476-B132-DE9E247C8AF0,\
	EXTENDS__IWICImagingFactory,\
	CreateImageEncoder

IWICDevelopRawNotificationCallback interface 95C75A6E-3E8C-4EC2-85A8-AEBCC551E59B,\
	EXTENDS__IUnknown,\
	Notify

IWICDevelopRaw interface FBEC5E44-F7BE-4B65-B7F8-C0C81FEF026D,\
	EXTENDS__IWICBitmapFrameDecode,\
	QueryRawCapabilitiesInfo,LoadParameterSet,GetCurrentParameterSet,SetExposureCompensation,GetExposureCompensation,SetWhitePointRGB,GetWhitePointRGB,SetNamedWhitePoint,GetNamedWhitePoint,SetWhitePointKelvin,GetWhitePointKelvin,GetKelvinRangeInfo,SetContrast,GetContrast,SetGamma,GetGamma,SetSharpness,GetSharpness,SetSaturation,GetSaturation,SetTint,GetTint,SetNoiseReduction,GetNoiseReduction,SetDestinationColorContext,SetToneCurve,GetToneCurve,SetRotation,GetRotation,SetRenderMode,GetRenderMode,SetNotificationCallback

IWICDdsDecoder interface 409cd537-8532-40cb-9774-e2feb2df4e9c,\
	EXTENDS__IUnknown,\
	GetParameters,GetFrame

IWICDdsEncoder interface 5cacdb4c-407e-41b3-b936-d0f010cd6732,\
	EXTENDS__IUnknown,\
	SetParameters,GetParameters,CreateNewFrame

IWICDdsFrameDecode interface 3d4c0c61-18a4-41e4-bd80-481a4fc9f464,\
	EXTENDS__IUnknown,\
	GetSizeInBlocks,GetFormatInfo,CopyBlocks

IWICJpegFrameDecode interface 8939F66E-C46A-4c21-A9D1-98B327CE1679,\
	EXTENDS__IUnknown,\
	DoesSupportIndexing,SetIndexing,ClearIndexing,GetAcHuffmanTable,GetDcHuffmanTable,GetQuantizationTable,GetFrameHeader,GetScanHeader,CopyScan,CopyMinimalStream

IWICJpegFrameEncode interface 2F0C601F-D2C6-468C-ABFA-49495D983ED1,\
	EXTENDS__IUnknown,\
	GetAcHuffmanTable,GetDcHuffmanTable,GetQuantizationTable,WriteScan
