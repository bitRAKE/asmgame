/*
  Predisposed to a single executable image, common build options remove
  features and error checking - relying on known/static state.
*/
#define STB_IMAGE_IMPLEMENTATION
#define STBI_NO_STDIO
#define STBI_NO_FAILURE_STRINGS
#define STBI_NO_THREAD_LOCALS
#define STBI_ONLY_PNG
#define STBI_MAX_DIMENSIONS 4096 // TODO: calculate at build-time

void* GetProcessHeap();
void* HeapAlloc (void* hHeap, int dwFlags, size_t dwBytes);
void* HeapReAlloc (void* hHeap, int dwFlags, void* lpMem, size_t dwBytes);
int HeapFree (void* hHeap, int dwFlags, void* lpMem);

#define STBI_ASSERT(x)
#define STBI_MALLOC(sz) ((void*)HeapAlloc(GetProcessHeap(), 0, (size_t)(sz)))
#define STBI_FREE(p) (HeapFree(GetProcessHeap(), 0, (void *)(p)))
#define STBI_REALLOC(p,newsz) ((p) ? \
	(void*)HeapReAlloc(GetProcessHeap(), 0, (void *)(p), (size_t)(newsz)) : \
	(void*)HeapAlloc(GetProcessHeap(), 0, (size_t)(newsz)))

#include "..\ext\stb\stb_image.h"
