# asmgame

Assembly experiments for Windows graphics/game-style building blocks using
[fasm2](https://github.com/tgrysztar/fasm2) plus a small set of local Win32,
WIC, GDI+, console, and helper includes.

## Repository map

- `include/` - project include files for Win32 APIs, calling helpers, console
  helpers, debug helpers, WIC/GDI+ declarations, and fasm2 support macros.
- `library/stb_image.c` - trimmed `stb_image` wrapper used to build
  `library/stb_image.lib` for PNG-only image loading.
- `test/stbi_png.asm` - sample that embeds one of the PNG files from `test/`
  into the executable and displays it with transparency handling.
- `test/stbi_png.mak` - NMAKE build script for `stbi_png.exe` and the optimized
  `stb_image.lib` dependency.
- `tools/as32bmp.asm` - WIC-based utility that converts an image to a 32-bit BMP
  suitable for compile-time pixel-data manipulation by fasmg/fasm2 code.
- `fasm2.cmd` - wrapper that prepends this repository's `include/` directory and
  the `fasm2/include/` submodule directory before invoking `fasm2\fasmg.exe`.

## Submodules

This repository records two submodules:

```cmd
git submodule update --init --recursive
```

- `fasm2/` from `tgrysztar/fasm2`
- `ext/stb/` from `nothings/stb`

The checked-in build scripts expect those directories to exist locally.

## Building the PNG transparency sample

From a Windows developer shell with MSVC tools (`cl`, `lib`, `link`, and `nmake`)
available:

```cmd
git submodule update --init --recursive
cd test
nmake /f stbi_png.mak
```

`test/stbi_png.mak` invokes `..\fasm2.cmd`, builds `library\stb_image.lib` from
`library\stb_image.c`, links `stbi_png.exe`, and then removes intermediate
`.obj` and `.response` files via the `tidy` target. The `clean` target also
removes local executable/library/package outputs.

The sample image embedded by default is selected in `test/stbi_png.asm`; the
nearby commented `file` lines show the other PNG fixtures available in `test/`.

## Building the image conversion helper

`tools/as32bmp.asm` documents its direct build commands at the top of the source:

```cmd
cd tools
..\fasm2.cmd -e 50 as32bmp.asm
link @as32bmp.response as32bmp.obj
```

The resulting `as32bmp.exe` uses Windows Imaging Component (WIC) to write a
32-bit BMP output file for an input image.

## Notes

- The current build entry points are Windows-oriented; there is no repo-wide
  Linux build/test command checked in.
- Generated objects, response files, executables, local libraries, and package
  archives are ignored by `.gitignore` so local NMAKE/link runs do not dirty the
  tree.
