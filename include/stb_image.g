; Interface for https://github.com/nothings/stb/blob/master/stb_image.h
;
;
; stbi_info_from_memory *u8 buffer, s32 length, *s32 x, *s32 y, *s32 channels
; stbi_load_from_memory *u8 buffer, s32 length, *s32 x, *s32 y, *s32 channels, s32 desired_channels
; stbi_load_gif_from_memory
; stbi_loadf_from_memory
; stbi_load_16_from_memory
; stbi_is_16_bit_from_memory
; stbi_is_hdr_from_memory
;
;	stbi_info_from_callbacks
;	stbi_load_from_callbacks
;	stbi_loadf_from_callbacks
;	stbi_load_16_from_callbacks
;	stbi_is_16_bit_from_callbacks
;	stbi_is_hdr_from_callbacks
;
;	stbi_convert_iphone_png_to_rgb
;	stbi_set_unpremultiply_on_load
;	stbi_set_flip_vertically_on_load
;	stbi_hdr_to_ldr_gamma
;	stbi_ldr_to_hdr_gamma
;	stbi_hdr_to_ldr_scale
;	stbi_ldr_to_hdr_scale
;	stbi_image_free
;	stbi_failure_reason
;	stbi_zlib_decode_buffer
;	stbi_zlib_decode_malloc
;	stbi_zlib_decode_malloc_guesssize
;	stbi_zlib_decode_malloc_guesssize_headerflag
;	stbi_zlib_decode_noheader_buffer
;	stbi_zlib_decode_noheader_malloc

; Since the disposition is to use a single file, these functions are not
; compiled into the library (ie -DSTBI_NO_STDIO):
;	stbi_info
;	stbi_info_from_file
;	stbi_load
;	stbi_load_from_file
;	stbi_load_16
;	stbi_load_from_file_16
;	stbi_loadf
;	stbi_loadf_from_file
;	stbi_is_16_bit
;	stbi_is_16_bit_from_file
;	stbi_is_hdr
;	stbi_is_hdr_from_file

STBI_default	:= 0	; only used for desired_channels
STBI_grey	:= 1
STBI_grey_alpha	:= 2
STBI_rgb	:= 3
STBI_rgb_alpha	:= 4

struct stbi_io_callbacks ; function pointers
	; fill 'data' with 'size' bytes.  return number of bytes actually read
	read	dq ?	; int (void *user, char *data, int size)

	; skip the next 'n' bytes, or 'unget' the last -n bytes if negative
	skip	dq ?	; void (void *user, int n)

	; returns nonzero if we are at end of file/data
	eof	dq ?	; int (void *user)
ends
