
MAX_DEFAULTCHAR	:=2
MAX_LEADBYTES	:=12

struct CPINFOEXW
	MaxCharSize		dd ?			; UINT
	DefaultChar		rb MAX_DEFAULTCHAR	; WCHAR[]
	LeadByte		rb MAX_LEADBYTES	; WCHAR[]
	UnicodeDefaultChar	dw ?			; WCHAR
	CodePage		dd ?			; UINT
	CodePageName		rw MAX_PATH		; WCHAR[]
ends


; Flags for MultiByteToWideChar/WideCharToMultiByte
MB_PRECOMPOSED		:=0x00000001
MB_COMPOSITE		:=0x00000002
MB_USEGLYPHCHARS	:=0x00000004
MB_ERR_INVALID_CHARS	:=0x00000008
WC_DISCARDNS		:=0x00000010
WC_SEPCHARS		:=0x00000020
WC_DEFAULTCHAR		:=0x00000040
WC_DEFAULTCHECK		:=0x00000100
WC_COMPOSITECHECK	:=0x00000200

; winnls.h

LOCALE_NAME_MAX_LENGTH := 85

LOCALE_ALL			:=0x0000
LOCALE_WINDOWS			:=0x0001
LOCALE_SUPPLEMENTAL		:=0x0002
LOCALE_ALTERNATE_SORTS		:=0x0004
LOCALE_REPLACEMENT		:=0x0008
LOCALE_NEUTRALDATA		:=0x0010
LOCALE_SPECIFICDATA		:=0x0020

LOCALE_INVARIANT		:=0x007F
LOCALE_USER_DEFAULT		:=0x0400
LOCALE_SYSTEM_DEFAULT		:=0x0800
LOCALE_CUSTOM_DEFAULT		:=0x0c00
LOCALE_CUSTOM_UNSPECIFIED	:=0x1000
LOCALE_CUSTOM_UI_DEFAULT	:=0x1400

; Locale Flags
LOCALE_ALLOW_NEUTRAL_NAMES	:=0x08000000
LOCALE_RETURN_GENITIVE_NAMES	:=0x10000000
LOCALE_RETURN_NUMBER		:=0x20000000
LOCALE_USE_CP_ACP		:=0x40000000
LOCALE_NOUSEROVERRIDE		:=0x80000000

; Locale Information Types
LOCALE_ILANGUAGE		:=0x0001
LOCALE_SLANGUAGE		:=0x0002
LOCALE_SLOCALIZEDDISPLAYNAME	:=0x0002
LOCALE_SENGLANGUAGE		:=0x1001
LOCALE_SENGLISHLANGUAGENAME	:=0x1001
LOCALE_SABBREVLANGNAME		:=0x0003
LOCALE_SNATIVELANGNAME		:=0x0004
LOCALE_SNATIVELANGUAGENAME	:=0x0004
LOCALE_ICOUNTRY			:=0x0005
LOCALE_SCOUNTRY			:=0x0006
LOCALE_SLOCALIZEDCOUNTRYNAME	:=0x0006
LOCALE_SENGCOUNTRY		:=0x1002
LOCALE_SENGLISHCOUNTRYNAME	:=0x1002
LOCALE_SABBREVCTRYNAME		:=0x0007
LOCALE_SNATIVECTRYNAME		:=0x0008
LOCALE_SNATIVECOUNTRYNAME	:=0x0008
LOCALE_IDEFAULTLANGUAGE		:=0x0009
LOCALE_IDEFAULTCOUNTRY		:=0x000A
LOCALE_IDEFAULTCODEPAGE		:=0x000B
LOCALE_IDEFAULTANSICODEPAGE	:=0x1004
LOCALE_IDEFAULTMACCODEPAGE	:=0x1011
LOCALE_SLIST			:=0x000C
LOCALE_IMEASURE			:=0x000D
LOCALE_SDECIMAL			:=0x000E
LOCALE_STHOUSAND		:=0x000F
LOCALE_SGROUPING		:=0x0010
LOCALE_IDIGITS			:=0x0011
LOCALE_ILZERO			:=0x0012
LOCALE_INEGNUMBER		:=0x1010
LOCALE_SNATIVEDIGITS		:=0x0013
LOCALE_SCURRENCY		:=0x0014
LOCALE_SINTLSYMBOL		:=0x0015
LOCALE_SMONDECIMALSEP		:=0x0016
LOCALE_SMONTHOUSANDSEP		:=0x0017
LOCALE_SMONGROUPING		:=0x0018
LOCALE_ICURRDIGITS		:=0x0019
LOCALE_IINTLCURRDIGITS		:=0x001A
LOCALE_ICURRENCY		:=0x001B
LOCALE_INEGCURR			:=0x001C
LOCALE_SDATE			:=0x001D
LOCALE_STIME			:=0x001E
LOCALE_SSHORTDATE		:=0x001F
LOCALE_SLONGDATE		:=0x0020
LOCALE_STIMEFORMAT		:=0x1003
LOCALE_IDATE			:=0x0021
LOCALE_ILDATE			:=0x0022
LOCALE_ITIME			:=0x0023
LOCALE_ITIMEMARKPOSN		:=0x1005
LOCALE_ICENTURY			:=0x0024
LOCALE_ITLZERO			:=0x0025
LOCALE_IDAYLZERO		:=0x0026
LOCALE_IMONLZERO		:=0x0027
LOCALE_S1159			:=0x0028
LOCALE_S2359			:=0x0029
LOCALE_ICALENDARTYPE		:=0x1009
LOCALE_IOPTIONALCALENDAR	:=0x100B
LOCALE_IFIRSTDAYOFWEEK		:=0x100C
LOCALE_IFIRSTWEEKOFYEAR		:=0x100D
LOCALE_SDAYNAME1		:=0x002A
LOCALE_SDAYNAME2		:=0x002B
LOCALE_SDAYNAME3		:=0x002C
LOCALE_SDAYNAME4		:=0x002D
LOCALE_SDAYNAME5		:=0x002E
LOCALE_SDAYNAME6		:=0x002F
LOCALE_SDAYNAME7		:=0x0030
LOCALE_SABBREVDAYNAME1		:=0x0031
LOCALE_SABBREVDAYNAME2		:=0x0032
LOCALE_SABBREVDAYNAME3		:=0x0033
LOCALE_SABBREVDAYNAME4		:=0x0034
LOCALE_SABBREVDAYNAME5		:=0x0035
LOCALE_SABBREVDAYNAME6		:=0x0036
LOCALE_SABBREVDAYNAME7		:=0x0037
LOCALE_SMONTHNAME1		:=0x0038
LOCALE_SMONTHNAME2		:=0x0039
LOCALE_SMONTHNAME3		:=0x003A
LOCALE_SMONTHNAME4		:=0x003B
LOCALE_SMONTHNAME5		:=0x003C
LOCALE_SMONTHNAME6		:=0x003D
LOCALE_SMONTHNAME7		:=0x003E
LOCALE_SMONTHNAME8		:=0x003F
LOCALE_SMONTHNAME9		:=0x0040
LOCALE_SMONTHNAME10		:=0x0041
LOCALE_SMONTHNAME11		:=0x0042
LOCALE_SMONTHNAME12		:=0x0043
LOCALE_SMONTHNAME13		:=0x100E
LOCALE_SABBREVMONTHNAME1	:=0x0044
LOCALE_SABBREVMONTHNAME2	:=0x0045
LOCALE_SABBREVMONTHNAME3	:=0x0046
LOCALE_SABBREVMONTHNAME4	:=0x0047
LOCALE_SABBREVMONTHNAME5	:=0x0048
LOCALE_SABBREVMONTHNAME6	:=0x0049
LOCALE_SABBREVMONTHNAME7	:=0x004A
LOCALE_SABBREVMONTHNAME8	:=0x004B
LOCALE_SABBREVMONTHNAME9	:=0x004C
LOCALE_SABBREVMONTHNAME10	:=0x004D
LOCALE_SABBREVMONTHNAME11	:=0x004E
LOCALE_SABBREVMONTHNAME12	:=0x004F
LOCALE_SABBREVMONTHNAME13	:=0x100F
LOCALE_SPOSITIVESIGN		:=0x0050
LOCALE_SNEGATIVESIGN		:=0x0051
LOCALE_IPOSSIGNPOSN		:=0x0052
LOCALE_INEGSIGNPOSN		:=0x0053
LOCALE_IPOSSYMPRECEDES		:=0x0054
LOCALE_IPOSSEPBYSPACE		:=0x0055
LOCALE_INEGSYMPRECEDES		:=0x0056
LOCALE_INEGSEPBYSPACE		:=0x0057
LOCALE_FONTSIGNATURE		:=0x0058
LOCALE_SISO639LANGNAME		:=0x0059
LOCALE_SISO3166CTRYNAME		:=0x005A
LOCALE_IGEOID			:=0x005B
LOCALE_SNAME			:=0x005C
LOCALE_SDURATION		:=0x005D
LOCALE_SKEYBOARDSTOINSTALL	:=0x005E
LOCALE_SSHORTESTDAYNAME1	:=0x0060
LOCALE_SSHORTESTDAYNAME2	:=0x0061
LOCALE_SSHORTESTDAYNAME3	:=0x0062
LOCALE_SSHORTESTDAYNAME4	:=0x0063
LOCALE_SSHORTESTDAYNAME5	:=0x0064
LOCALE_SSHORTESTDAYNAME6	:=0x0065
LOCALE_SSHORTESTDAYNAME7	:=0x0066
LOCALE_SISO639LANGNAME2		:=0x0067
LOCALE_SISO3166CTRYNAME2	:=0x0068
LOCALE_SNAN			:=0x0069
LOCALE_SPOSINFINITY		:=0x006A
LOCALE_SNEGINFINITY		:=0x006B
LOCALE_SSCRIPTS			:=0x006C
LOCALE_SPARENT			:=0x006D
LOCALE_SCONSOLEFALLBACKNAME	:=0x006E
LOCALE_SLANGDISPLAYNAME		:=0x006F
LOCALE_SLOCALIZEDLANGUAGENAME	:=0x006F
LOCALE_IREADINGLAYOUT		:=0x0070
LOCALE_INEUTRAL			:=0x0071
LOCALE_SENGLISHDISPLAYNAME	:=0x0072
LOCALE_SNATIVEDISPLAYNAME	:=0x0073
LOCALE_INEGATIVEPERCENT		:=0x0074
LOCALE_IPOSITIVEPERCENT		:=0x0075
LOCALE_SPERCENT			:=0x0076
LOCALE_SPERMILLE		:=0x0077
LOCALE_SMONTHDAY		:=0x0078
LOCALE_SSHORTTIME		:=0x0079
LOCALE_SOPENTYPELANGUAGETAG	:=0x007A
LOCALE_SSORTLOCALE		:=0x007B

LOCALE_SYEARMONTH		:=0x1006
LOCALE_SENGCURRNAME		:=0x1007
LOCALE_SNATIVECURRNAME		:=0x1008
LOCALE_IPAPERSIZE		:=0x100A
LOCALE_IDEFAULTEBCDICCODEPAGE	:=0x1012
LOCALE_SSORTNAME		:=0x1013
LOCALE_IDIGITSUBSTITUTION	:=0x1014




; Unicode char type flags
CT_CTYPE1:=0x0001	; usual ctype
CT_CTYPE2:=0x0002	; bidirectional layout info
CT_CTYPE3:=0x0004	; textprocessing info

; Type 1 Flags
C1_UPPER	:=0x0001
C1_LOWER	:=0x0002
C1_DIGIT	:=0x0004
C1_SPACE	:=0x0008
C1_PUNCT	:=0x0010
C1_CNTRL	:=0x0020
C1_BLANK	:=0x0040
C1_XDIGIT	:=0x0080
C1_ALPHA	:=0x0100
C1_DEFINED	:=0x0200

; Type 2 Flags
C2_LEFTTORIGHT		:=0x0001
C2_RIGHTTOLEFT		:=0x0002
C2_EUROPENUMBER		:=0x0003
C2_EUROPESEPARATOR	:=0x0004
C2_EUROPETERMINATOR	:=0x0005
C2_ARABICNUMBER		:=0x0006
C2_COMMONSEPARATOR	:=0x0007
C2_BLOCKSEPARATOR	:=0x0008
C2_SEGMENTSEPARATOR	:=0x0009
C2_WHITESPACE		:=0x000A
C2_OTHERNEUTRAL		:=0x000B
C2_NOTAPPLICABLE	:=0x0000

; Type 3 Flags
C3_NONSPACING		:=0x0001
C3_DIACRITIC		:=0x0002
C3_VOWELMARK		:=0x0004
C3_SYMBOL		:=0x0008
C3_KATAKANA		:=0x0010
C3_HIRAGANA		:=0x0020
C3_HALFWIDTH		:=0x0040
C3_FULLWIDTH		:=0x0080
C3_IDEOGRAPH		:=0x0100
C3_KASHIDA		:=0x0200
C3_LEXICAL		:=0x0400
C3_HIGHSURROGATE	:=0x0800
C3_LOWSURROGATE		:=0x1000
C3_ALPHA		:=0x8000
C3_NOTAPPLICABLE	:=0x0000