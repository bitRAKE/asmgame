; largely undocumented, but based on:
; \Windows Kits\10\Include\10.0.22621.0\um\TOM.h

if ~ definite __tom_g__
__tom_g__:=1

; find logical grouping ...

tomFalse:=0
tomTrue:=-1
tomUndefined:=-9999999
tomToggle:=-9999998
tomAutoColor:=-9999997
tomDefault:=-9999996
tomSuspend:=-9999995
tomResume:=-9999994
tomApplyNow:=0
tomApplyLater:=1
tomTrackParms:=2
tomCacheParms:=3
tomApplyTmp:=4
tomDisableSmartFont:=8
tomEnableSmartFont:=9
tomUsePoints:=10
tomUseTwips:=11
tomBackward:=$C0000001
tomForward:=$3FFFFFFF
tomMove:=0
tomExtend:=1
tomNoSelection:=0
tomSelectionIP:=1
tomSelectionNormal:=2
tomSelectionFrame:=3
tomSelectionColumn:=4
tomSelectionRow:=5
tomSelectionBlock:=6
tomSelectionInlineShape:=7
tomSelectionShape:=8
tomSelStartActive:=1
tomSelAtEOL:=2
tomSelOvertype:=4
tomSelActive:=8
tomSelReplace:=16
tomSelMathZone:=$20
tomSelIpAtRange:=$40
tomEnd:=0
tomStart:=$20
tomCollapseEnd:=0
tomCollapseStart:=1
tomClientCoord:=$100
tomAllowOffClient:=$200
tomTransform:=$400
tomObjectArg:=$800
tomAtEnd:=$1000
tomUseXamlRect:=$2000
tomImageTypeMask:=$E0
tomInlineImage:=0
tomBackgroundImage:=$20
tomWrapTextAround:=$40
tomNoWrapSides:=$60
tomNone:=0
tomSingle:=1
tomWords:=2
tomDouble:=3
tomDotted:=4
tomDash:=5
tomDashDot:=6
tomDashDotDot:=7
tomWave:=8
tomThick:=9
tomHair:=10
tomDoubleWave:=11
tomHeavyWave:=12
tomLongDash:=13
tomThickDash:=14
tomThickDashDot:=15
tomThickDashDotDot:=16
tomThickDotted:=17
tomThickLongDash:=18
tomLineSpaceSingle:=0
tomLineSpace1pt5:=1
tomLineSpaceDouble:=2
tomLineSpaceAtLeast:=3
tomLineSpaceExactly:=4
tomLineSpaceMultiple:=5
tomLineSpacePercent:=6
tomAlignLeft:=0
tomAlignCenter:=1
tomAlignRight:=2
tomAlignJustify:=3
tomAlignDecimal:=3
tomAlignBar:=4
tomDefaultTab:=5
tomAlignInterWord:=3
tomAlignNewspaper:=4
tomAlignInterLetter:=5
tomAlignScaled:=6
tomSpaces:=0
tomDots:=1
tomDashes:=2
tomLines:=3
tomThickLines:=4
tomEquals:=5
tomTabBack:=-3
tomTabNext:=-2
tomTabHere:=-1
tomListNone:=0
tomListBullet:=1
tomListNumberAsArabic:=2
tomListNumberAsLCLetter:=3
tomListNumberAsUCLetter:=4
tomListNumberAsLCRoman:=5
tomListNumberAsUCRoman:=6
tomListNumberAsSequence:=7
tomListNumberedCircle:=8
tomListNumberedBlackCircleWingding:=9
tomListNumberedWhiteCircleWingding:=10
tomListNumberedArabicWide:=11
tomListNumberedChS:=12
tomListNumberedChT:=13
tomListNumberedJpnChS:=14
tomListNumberedJpnKor:=15
tomListNumberedArabic1:=16
tomListNumberedArabic2:=17
tomListNumberedHebrew:=18
tomListNumberedThaiAlpha:=19
tomListNumberedThaiNum:=20
tomListNumberedHindiAlpha:=21
tomListNumberedHindiAlpha1:=22
tomListNumberedHindiNum:=23
tomListParentheses:=$10000
tomListPeriod:=$20000
tomListPlain:=$30000
tomListNoNumber:=$40000
tomListMinus:=$80000
tomIgnoreNumberStyle:=$1000000
tomParaStyleNormal:=-1
tomParaStyleHeading1:=-2
tomParaStyleHeading2:=-3
tomParaStyleHeading3:=-4
tomParaStyleHeading4:=-5
tomParaStyleHeading5:=-6
tomParaStyleHeading6:=-7
tomParaStyleHeading7:=-8
tomParaStyleHeading8:=-9
tomParaStyleHeading9:=-10
tomCharacter:=1
tomWord:=2
tomSentence:=3
tomParagraph:=4
tomLine:=5
tomStory:=6
tomScreen:=7
tomSection:=8
tomTableColumn:=9
tomColumn:=9
tomRow:=10
tomWindow:=11
tomCell:=12
tomCharFormat:=13
tomParaFormat:=14
tomTable:=15
tomObject:=16
tomPage:=17
tomHardParagraph:=18
tomCluster:=19
tomInlineObject:=20
tomInlineObjectArg:=21
tomLeafLine:=22
tomLayoutColumn:=23
tomInlineObjectArgDelim:=24
tomSmartLink:=25
tomProcessId:=$40000001
tomMatchWord:=2
tomMatchCase:=4
tomMatchPattern:=8
tomUnknownStory:=0
tomMainTextStory:=1
tomFootnotesStory:=2
tomEndnotesStory:=3
tomCommentsStory:=4
tomTextFrameStory:=5
tomEvenPagesHeaderStory:=6
tomPrimaryHeaderStory:=7
tomEvenPagesFooterStory:=8
tomPrimaryFooterStory:=9
tomFirstPageHeaderStory:=10
tomFirstPageFooterStory:=11
tomScratchStory:=$7F
tomFindStory:=$80
tomReplaceStory:=$81
tomStoryInactive:=0
tomStoryActiveDisplay:=1
tomStoryActiveUI:=2
tomStoryActiveDisplayUI:=3
tomNoAnimation:=0
tomLasVegasLights:=1
tomBlinkingBackground:=2
tomSparkleText:=3
tomMarchingBlackAnts:=4
tomMarchingRedAnts:=5
tomShimmer:=6
tomWipeDown:=7
tomWipeRight:=8
tomAnimationMax:=8
tomLowerCase:=0
tomUpperCase:=1
tomTitleCase:=2
tomSentenceCase:=4
tomToggleCase:=5
tomReadOnly:=$100
tomShareDenyRead:=$200
tomShareDenyWrite:=$400
tomPasteFile:=$1000
tomCreateNew:=16
tomCreateAlways:=$20
tomOpenExisting:=$30
tomOpenAlways:=$40
tomTruncateExisting:=$50
tomRTF:=1
tomText:=2
tomHTML:=3
tomWordDocument:=4

tomBold:=$80000001
tomItalic:=$80000002
tomUnderline:=$80000004
tomStrikeout:=$80000008
tomProtected:=$80000010
tomLink:=$80000020
tomSmallCaps:=$80000040
tomAllCaps:=$80000080
tomHidden:=$80000100
tomOutline:=$80000200
tomShadow:=$80000400
tomEmboss:=$80000800
tomImprint:=$80001000
tomDisabled:=$80002000
tomRevised:=$80004000
tomSubscriptCF:=$80010000
tomSuperscriptCF:=$80020000
tomFontBound:=$80100000
tomLinkProtected:=$80800000
tomInlineObjectStart:=$81000000
tomExtendedChar:=$82000000
tomAutoBackColor:=$84000000
tomMathZoneNoBuildUp:=$88000000
tomMathZone:=$90000000
tomMathZoneOrdinary:=$A0000000
tomAutoTextColor:=$C0000000
tomMathZoneDisplay:=$40000

tomParaEffectRTL:=1
tomParaEffectKeep:=2
tomParaEffectKeepNext:=4
tomParaEffectPageBreakBefore:=8
tomParaEffectNoLineNumber:=16
tomParaEffectNoWidowControl:=$20
tomParaEffectDoNotHyphen:=$40
tomParaEffectSideBySide:=$80
tomParaEffectCollapsed:=$100
tomParaEffectOutlineLevel:=$200
tomParaEffectBox:=$400
tomParaEffectTableRowDelimiter:=$1000
tomParaEffectTable:=$4000
tomModWidthPairs:=1
tomModWidthSpace:=2
tomAutoSpaceAlpha:=4
tomAutoSpaceNumeric:=8
tomAutoSpaceParens:=16
tomEmbeddedFont:=$20
tomDoublestrike:=$40
tomOverlapping:=$80
tomNormalCaret:=0
tomKoreanBlockCaret:=1
tomNullCaret:=2
tomIncludeInset:=1
tomUnicodeBiDi:=1
tomMathCFCheck:=4
tomUnlink:=8
tomUnhide:=16
tomCheckTextLimit:=$20
tomDontSelectText:=$40
tomIgnoreCurrentFont:=0
tomMatchCharRep:=1
tomMatchFontSignature:=2
tomMatchAscii:=4
tomGetHeightOnly:=8
tomMatchMathFont:=16
tomCharset:=$80000000
tomCharRepFromLcid:=$40000000
tomAnsi:=0
tomEastEurope:=1
tomCyrillic:=2
tomGreek:=3
tomTurkish:=4
tomHebrew:=5
tomArabic:=6
tomBaltic:=7
tomVietnamese:=8
tomDefaultCharRep:=9
tomSymbol:=10
tomThai:=11
tomShiftJIS:=12
tomGB2312:=13
tomHangul:=14
tomBIG5:=15
tomPC437:=16
tomOEM:=17
tomMac:=18
tomArmenian:=19
tomSyriac:=20
tomThaana:=21
tomDevanagari:=22
tomBengali:=23
tomGurmukhi:=24
tomGujarati:=25
tomOriya:=$1A
tomTamil:=$1B
tomTelugu:=$1C
tomKannada:=$1D
tomMalayalam:=$1E
tomSinhala:=$1F
tomLao:=$20
tomTibetan:=$21
tomMyanmar:=$22
tomGeorgian:=$23
tomJamo:=$24
tomEthiopic:=$25
tomCherokee:=$26
tomAboriginal:=$27
tomOgham:=$28
tomRunic:=$29
tomKhmer:=$2A
tomMongolian:=$2B
tomBraille:=$2C
tomYi:=$2D
tomLimbu:=$2E
tomTaiLe:=$2F
tomNewTaiLue:=$30
tomSylotiNagri:=$31
tomKharoshthi:=$32
tomKayahli:=$33
tomUsymbol:=$34
tomEmoji:=$35
tomGlagolitic:=$36
tomLisu:=$37
tomVai:=$38
tomNKo:=$39
tomOsmanya:=$3A
tomPhagsPa:=$3B
tomGothic:=$3C
tomDeseret:=$3D
tomTifinagh:=$3E
tomCharRepMax:=$3F
tomRE10Mode:=1
tomUseAtFont:=2
tomTextFlowMask:=12
tomTextFlowES:=0
tomTextFlowSW:=4
tomTextFlowWN:=8
tomTextFlowNE:=12
tomNoIME:=$80000
tomSelfIME:=$40000
tomNoUpScroll:=$10000
tomNoVpScroll:=$40000
tomNoLink:=0
tomClientLink:=1
tomFriendlyLinkName:=2
tomFriendlyLinkAddress:=3
tomAutoLinkURL:=4
tomAutoLinkEmail:=5
tomAutoLinkPhone:=6
tomAutoLinkPath:=7
tomCompressNone:=0
tomCompressPunctuation:=1
tomCompressPunctuationAndKana:=2
tomCompressMax:=2
tomUnderlinePositionAuto:=0
tomUnderlinePositionBelow:=1
tomUnderlinePositionAbove:=2
tomUnderlinePositionMax:=2
tomFontAlignmentAuto:=0
tomFontAlignmentTop:=1
tomFontAlignmentBaseline:=2
tomFontAlignmentBottom:=3
tomFontAlignmentCenter:=4
tomFontAlignmentMax:=4
tomRubyBelow:=$80
tomRubyAlignCenter:=0
tomRubyAlign010:=1
tomRubyAlign121:=2
tomRubyAlignLeft:=3
tomRubyAlignRight:=4
tomLimitsDefault:=0
tomLimitsUnderOver:=1
tomLimitsSubSup:=2
tomUpperLimitAsSuperScript:=3
tomLimitsOpposite:=4
tomShowLLimPlaceHldr:=8
tomShowULimPlaceHldr:=16
tomDontGrowWithContent:=$40
tomGrowWithContent:=$80
tomSubSupAlign:=1
tomLimitAlignMask:=3
tomLimitAlignCenter:=0
tomLimitAlignLeft:=1
tomLimitAlignRight:=2
tomShowDegPlaceHldr:=8
tomAlignDefault:=0
tomAlignMatchAscentDescent:=2
tomMathVariant:=$20
tomStyleDefault:=0
tomStyleScriptScriptCramped:=1
tomStyleScriptScript:=2
tomStyleScriptCramped:=3
tomStyleScript:=4
tomStyleTextCramped:=5
tomStyleText:=6
tomStyleDisplayCramped:=7
tomStyleDisplay:=8
tomMathRelSize:=$40
tomDecDecSize:=$FE
tomDecSize:=$FF
tomIncSize:=$41
tomIncIncSize:=$42
tomGravityUI:=0
tomGravityBack:=1
tomGravityFore:=2
tomGravityIn:=3
tomGravityOut:=4
tomGravityBackward:=$20000000
tomGravityForward:=$40000000
tomTeX:=1
tomNeedTermOp:=2
tomOmitRubyText:=2
tomMathAlphabetics:=4
tomMathSingleChar:=8
tomPlain:=16
tomHaveDelimiter:=$20
tomUseOperandPrec:=$40
tomMathCollapseSel:=$80
tomMathAutoCorrect:=$100
tomMathBuildUpArgOrZone:=$200
tomMathBuildUpRecurse:=$400
tomMathBuildDownOutermost:=$800
tomChemicalFormula:=$1000
tomMathBuildDown:=$2000
tomMathApplyTemplate:=$4000
tomMathRemoveOutermost:=$8000
tomMathChangeMask:=$1F0000
tomMathInsRowBefore:=$10000
tomMathInsRowAfter:=$20000
tomMathInsColBefore:=$30000
tomMathInsColAfter:=$40000
tomMathDeleteRow:=$50000
tomMathDeleteCol:=$60000
tomMathDeleteArg:=$70000
tomMathDeleteArg1:=$80000
tomMathDeleteArg2:=$90000
tomMathMakeFracLinear:=$A0000
tomMathMakeFracStacked:=$B0000
tomMathMakeFracSlashed:=$C0000
tomMathMakeLeftSubSup:=$D0000
tomMathMakeSubSup:=$E0000
tomMathBackspace:=$100000
tomMathEnter:=$110000
tomMathShiftTab:=$120000
tomMathTab:=$130000
tomMathAlignBreakLeft:=$140000
tomMathAlignBreakCenter:=$150000
tomMathAlignBreakRight:=$160000
tomMathSubscript:=$170000
tomMathSuperscript:=$180000
tomBrailleIn:=$400000
tomMathArabicAlphabetics:=$800000
tomMathAutoCorrectOpPairs:=$1000000
tomMathAutoCorrectExt:=$2000000
tomShowEmptyArgPlaceholders:=$4000000
tomMathAutoComplete:=$8000000
tomMathSpeech:=$10000000
tomMathRichEdit:=$40000000
tomSpecialChar:=$80000000

tomAdjustCRLF:=1
tomUseCRLF:=2
tomTextize:=4
tomAllowFinalEOP:=8
tomFoldMathAlpha:=16
tomNoHidden:=$20
tomIncludeNumbering:=$40
tomTranslateTableCell:=$80
tomNoMathZoneBrackets:=$100
tomConvertMathChar:=$200
tomNoUCGreekItalic:=$400
tomAllowMathBold:=$800
tomLanguageTag:=$1000
tomConvertRTF:=$2000
tomApplyRtfDocProps:=$4000
tomGetTextForSpell:=$8000
tomConvertMathML:=$10000
tomGetUtf16:=$20000
tomConvertLinearFormat:=$40000
tomConvertUnicodeMath:=$40000
tomConvertOMML:=$80000
tomConvertMask:=$F00000
tomConvertRuby:=$100000
tomConvertTeX:=$200000
tomConvertMathSpeech:=$300000
tomConvertSpeechTokens:=$400000
tomConvertNemeth:=$500000
tomConvertNemethAscii:=$600000
tomConvertNemethNoItalic:=$700000
tomConvertNemethDefinition	:=0x00800000
tomConvertHtml			:=0x00900000	; Office, readonly?
tomConvertCRtoLF		:=0x01000000
tomGetUtf8			:=0x08000000
; https://devblogs.microsoft.com/math-in-office/richedit-html-support/

tomLaTeXDelim:=$2000000
tomPhantomShow:=1
tomPhantomZeroWidth:=2
tomPhantomZeroAscent:=4
tomPhantomZeroDescent:=8
tomPhantomTransparent:=16
tomPhantomASmash:=5
tomPhantomDSmash:=9
tomPhantomHSmash:=3
tomPhantomSmash:=13
tomPhantomHorz:=12
tomPhantomVert:=2
tomBoxHideTop:=1
tomBoxHideBottom:=2
tomBoxHideLeft:=4
tomBoxHideRight:=8
tomBoxStrikeH:=16
tomBoxStrikeV:=$20
tomBoxStrikeTLBR:=$40
tomBoxStrikeBLTR:=$80
tomRoundedBoxDashStyleMask:=7
tomRoundedBoxHideBorder:=8
tomRoundedBoxCapStyleMask:=$30
tomRoundedBoxNullRadius:=$40
tomRoundedBoxCompact:=$80
tomBoxAlignCenter:=1
tomSpaceMask:=$1C
tomSpaceDefault:=0
tomSpaceUnary:=4
tomSpaceBinary:=8
tomSpaceRelational:=12
tomSpaceSkip:=16
tomSpaceOrd:=20
tomSpaceDifferential:=24
tomSizeText:=$20
tomSizeScript:=$40
tomSizeScriptScript:=$60
tomNoBreak:=$80
tomTransparentForPositioning:=$100
tomTransparentForSpacing:=$200
tomStretchCharBelow:=0
tomStretchCharAbove:=1
tomStretchBaseBelow:=2
tomStretchBaseAbove:=3
tomMatrixAlignMask:=3
tomMatrixAlignCenter:=0
tomMatrixAlignTopRow:=1
tomMatrixAlignBottomRow:=3
tomShowMatPlaceHldr:=8
tomEqArrayLayoutWidth:=1
tomEqArrayAlignMask:=12
tomEqArrayAlignCenter:=0
tomEqArrayAlignTopRow:=4
tomEqArrayAlignBottomRow:=12
tomMathManualBreakMask:=$7F
tomMathBreakLeft:=$7D
tomMathBreakCenter:=$7E
tomMathBreakRight:=$7F
tomMathEqAlign:=$80
tomMathArgShadingStart:=$251
tomMathArgShadingEnd:=$252
tomMathObjShadingStart:=$253
tomMathObjShadingEnd:=$254
tomFunctionTypeNone:=0
tomFunctionTypeTakesArg:=1
tomFunctionTypeTakesLim:=2
tomFunctionTypeTakesLim2:=3
tomFunctionTypeIsLim:=4
tomMathParaAlignDefault:=0
tomMathParaAlignCenterGroup:=1
tomMathParaAlignCenter:=2
tomMathParaAlignLeft:=3
tomMathParaAlignRight:=4
tomMathDispAlignMask:=3
tomMathDispAlignCenterGroup:=0
tomMathDispAlignCenter:=1
tomMathDispAlignLeft:=2
tomMathDispAlignRight:=3
tomMathDispIntUnderOver:=4
tomMathDispFracTeX:=8
tomMathDispNaryGrow:=16
tomMathDocEmptyArgMask:=$60
tomMathDocEmptyArgAuto:=0
tomMathDocEmptyArgAlways:=$20
tomMathDocEmptyArgNever:=$40
tomMathDocSbSpOpUnchanged:=$80
tomMathDocDiffMask:=$300
tomMathDocDiffDefault:=0
tomMathDocDiffUpright:=$100
tomMathDocDiffItalic:=$200
tomMathDocDiffOpenItalic:=$300
tomMathDispNarySubSup:=$400
tomMathDispDef:=$800
tomMathEnableRtl:=$1000
tomMathBrkBinMask:=$30000
tomMathBrkBinBefore:=0
tomMathBrkBinAfter:=$10000
tomMathBrkBinDup:=$20000
tomMathBrkBinSubMask:=$C0000
tomMathBrkBinSubMM:=0
tomMathBrkBinSubPM:=$40000
tomMathBrkBinSubMP:=$80000
tomSelRange:=$255
tomHstring:=$254
tomTeXBuildDown:=$257
tomFontPropTeXStyle:=$33C
tomFontPropAlign:=$33D
tomFontStretch:=$33E
tomFontStyle:=$33F
tomFontStyleUpright:=0
tomFontStyleOblique:=1
tomFontStyleItalic:=2
tomFontStretchDefault:=0
tomFontStretchUltraCondensed:=1
tomFontStretchExtraCondensed:=2
tomFontStretchCondensed:=3
tomFontStretchSemiCondensed:=4
tomFontStretchNormal:=5
tomFontStretchSemiExpanded:=6
tomFontStretchExpanded:=7
tomFontStretchExtraExpanded:=8
tomFontStretchUltraExpanded:=9
tomFontWeightDefault:=0
tomFontWeightThin:=$64
tomFontWeightExtraLight:=$C8
tomFontWeightLight:=$12C
tomFontWeightNormal:=$190
tomFontWeightRegular:=$190
tomFontWeightMedium:=$1F4
tomFontWeightSemiBold:=$258
tomFontWeightBold:=$2BC
tomFontWeightExtraBold:=$320
tomFontWeightBlack:=$384
tomFontWeightHeavy:=$384
tomFontWeightExtraBlack:=$3B6
tomFontWeightMax:=$3B6
tomParaPropMathAlign:=$437
tomDocMathBuild:=$80
tomMathLMargin:=$81
tomMathRMargin:=$82
tomMathWrapIndent:=$83
tomMathWrapRight:=$84
tomMathPostSpace:=$86
tomMathPreSpace:=$85
tomMathInterSpace:=$87
tomMathIntraSpace:=$88
tomCanCopy:=$89
tomCanRedo:=$8A
tomCanUndo:=$8B
tomUndoLimit:=$8C
tomDocAutoLink:=$8D
tomEllipsisMode:=$8E
tomEllipsisState:=$8F
tomMathZoneSurround:=$90
tomUnderlineTrailSpace:=$91
tomAlignWithTrailSpace:=$92
tomEncloseSurroundSpacing:=$93
tomRichText:=$94
tomIgnoreTrailSpacing:=$95
tomStoryLength:=$A40
tomEllipsisNone:=0
tomEllipsisEnd:=1
tomEllipsisWord:=3
tomEllipsisPresent:=1
tomVTopCell:=1
tomVLowCell:=2
tomHStartCell:=4
tomHContCell:=8
tomRowUpdate:=1
tomRowApplyDefault:=0
tomCellStructureChangeOnly:=1
tomRowHeightActual:=$80B;
tomImageFlipH:=1
tomImageFlipV:=2
tomImageRotate0:=0
tomImageRotate90:=1
tomImageRotate180:=2
tomImageRotate270:=3


; OBJECTTYPE
tomSimpleText:=0
tomRuby:=1
tomHorzVert:=2
tomWarichu:=3
tomEq:=4
tomMath:=10
tomAccent:=10
tomBox:=11
tomBoxedFormula:=12
tomBrackets:=13
tomBracketsWithSeps:=14
tomEquationArray:=15
tomFraction:=16
tomFunctionApply:=17
tomLeftSubSup:=18
tomLowerLimit:=19
tomMatrix:=20
tomNary:=21
tomOpChar:=22
tomOverbar:=23
tomPhantom:=24
tomRadical:=25
tomSlashedFraction:=26
tomStack:=27
tomStretchStack:=28
tomSubscript:=29
tomSubSup:=30
tomSuperscript:=31
tomUnderbar:=32
tomUpperLimit:=33
tomObjectMax:=33

; MANCODE
MROMN:=0
MSCRP:=1
MFRAK:=2
MOPEN:=3
MSANS:=4
MMONO:=5
MMATH:=6
MISOL:=7
MINIT:=8
MTAIL:=9
MSTRCH:=10
MLOOP:=11
MOPENA:=12
MBOLD:=16
MITAL:=32
MGREEK:=64


; interfaces:

ITextDocument	interface	8CC497C0-A1DF-11CE-8098-00AA0047BE5D,\
	EXTENDS__IDispatch,\
	GetName,GetSelection,GetStoryCount,GetStoryRanges,GetSaved,SetSaved,GetDefaultTabStop,SetDefaultTabStop,New,Open,Save,Freeze,Unfreeze,BeginEditCollection,EndEditCollection,Undo,Redo,Range,RangeFromPoint

ITextRange	interface	8CC497C2-A1DF-11CE-8098-00AA0047BE5D,\
	EXTENDS__IDispatch,\
	GetText,SetText,GetChar,SetChar,GetDuplicate,GetFormattedText,SetFormattedText,GetStart,SetStart,GetEnd,SetEnd,GetFont,SetFont,GetPara,SetPara,GetStoryLength,GetStoryType,Collapse,Expand,GetIndex,SetIndex,SetRange,InRange,InStory,IsEqual,Select,StartOf,EndOf,Move,MoveStart,MoveEnd,MoveWhile,MoveStartWhile,MoveEndWhile,MoveUntil,MoveStartUntil,MoveEndUntil,FindText,FindTextStart,FindTextEnd,Delete,Cut,Copy,Paste,CanPaste,CanEdit,ChangeCase,GetPoint,SetPoint,ScrollIntoView,GetEmbeddedObject

ITextSelection	interface	8CC497C1-A1DF-11CE-8098-00AA0047BE5D,\
	EXTENDS__ITextRange,\
	GetFlags,SetFlags,GetType,MoveLeft,MoveRight,MoveUp,MoveDown,HomeKey,EndKey,TypeText

ITextFont	interface	8CC497C3-A1DF-11CE-8098-00AA0047BE5D,\
	EXTENDS__IDispatch,\
	GetDuplicate,SetDuplicate,CanChange,IsEqual,Reset,GetStyle,SetStyle,GetAllCaps,SetAllCaps,GetAnimation,SetAnimation,GetBackColor,SetBackColor,GetBold,SetBold,GetEmboss,SetEmboss,GetForeColor,SetForeColor,GetHidden,SetHidden,GetEngrave,SetEngrave,GetItalic,SetItalic,GetKerning,SetKerning,GetLanguageID,SetLanguageID,GetName,SetName,GetOutline,SetOutline,GetPosition,SetPosition,GetProtected,SetProtected,GetShadow,SetShadow,GetSize,SetSize,GetSmallCaps,SetSmallCaps,GetSpacing,SetSpacing,GetStrikeThrough,SetStrikeThrough,GetSubscript,SetSubscript,GetSuperscript,SetSuperscript,GetUnderline,SetUnderline,GetWeight,SetWeight

ITextPara	interface	8CC497C4-A1DF-11CE-8098-00AA0047BE5D,\
	EXTENDS__IDispatch,\
	GetDuplicate,SetDuplicate,CanChange,IsEqual,Reset,GetStyle,SetStyle,GetAlignment,SetAlignment,GetHyphenation,SetHyphenation,GetFirstLineIndent,GetKeepTogether,SetKeepTogether,GetKeepWithNext,SetKeepWithNext,GetLeftIndent,GetLineSpacing,GetLineSpacingRule,GetListAlignment,SetListAlignment,GetListLevelIndex,SetListLevelIndex,GetListStart,SetListStart,GetListTab,SetListTab,GetListType,SetListType,GetNoLineNumber,SetNoLineNumber,GetPageBreakBefore,SetPageBreakBefore,GetRightIndent,SetRightIndent,SetIndents,SetLineSpacing,GetSpaceAfter,SetSpaceAfter,GetSpaceBefore,SetSpaceBefore,GetWidowControl,SetWidowControl,GetTabCount,AddTab,ClearAllTabs,DeleteTab,GetTab

ITextStoryRanges interface	8CC497C5-A1DF-11CE-8098-00AA0047BE5D,\
	EXTENDS__IDispatch,\
	_NewEnum,Item,GetCount


ITextDocument2	interface	C241F5E0-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__ITextDocument,\
	GetCaretType,SetCaretType,GetDisplays,GetDocumentFont,SetDocumentFont,GetDocumentPara,SetDocumentPara,GetEastAsianFlags,GetGenerator,SetIMEInProgress,GetNotificationMode,SetNotificationMode,GetSelection2,GetStoryRanges2,GetTypographyOptions,GetVersion,GetWindow,AttachMsgFilter,CheckTextLimit,GetCallManager,GetClientRect,GetEffectColor,GetImmContext,GetPreferredFont,GetProperty,GetStrings,Notify,Range2,RangeFromPoint2,ReleaseCallManager,ReleaseImmContext,SetEffectColor,SetProperty,SetTypographyOptions,SysBeep,Update,UpdateWindow,GetMathProperties,SetMathProperties,GetActiveStory,SetActiveStory,GetMainStory,GetNewStory,GetStory

ITextRange2	interface	C241F5E2-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__ITextSelection,\
	GetCch,GetCells,GetColumn,GetCount,GetDuplicate2,GetFont2,SetFont2,GetFormattedText2,SetFormattedText2,GetGravity,SetGravity,GetPara2,SetPara2,GetRow,GetStartPara,GetTable,GetURL,SetURL,AddSubrange,BuildUpMath,DeleteSubrange,Find,GetChar2,GetDropCap,GetInlineObject,GetProperty,GetRect,GetSubrange,GetText2,HexToUnicode,InsertTable,Linearize,SetActiveSubrange,SetDropCap,SetProperty,SetText2,UnicodeToHex,SetInlineObject,GetMathFunctionType,InsertImage

ITextSelection2	interface	C241F5E1-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__ITextRange2

ITextFont2	interface	C241F5E3-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__ITextFont,\
	GetCount,GetAutoLigatures,SetAutoLigatures,GetAutospaceAlpha,SetAutospaceAlpha,GetAutospaceNumeric,SetAutospaceNumeric,GetAutospaceParens,SetAutospaceParens,GetCharRep,SetCharRep,GetCompressionMode,SetCompressionMode,GetCookie,SetCookie,GetDoubleStrike,SetDoubleStrike,GetDuplicate2,SetDuplicate2,GetLinkType,GetMathZone,SetMathZone,GetModWidthPairs,SetModWidthPairs,GetModWidthSpace,SetModWidthSpace,GetOldNumbers,SetOldNumbers,GetOverlapping,SetOverlapping,GetPositionSubSuper,SetPositionSubSuper,GetScaling,SetScaling,GetSpaceExtension,SetSpaceExtension,GetUnderlinePositionMode,SetUnderlinePositionMode,GetEffects,GetEffects2,GetProperty,GetPropertyInfo,IsEqual2,SetEffects,SetEffects2,SetProperty

ITextPara2	interface	C241F5E4-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__ITextPara,\
	GetBorders,GetDuplicate2,SetDuplicate2,GetFontAlignment,SetFontAlignment,GetHangingPunctuation,SetHangingPunctuation,GetSnapToGrid,SetSnapToGrid,GetTrimPunctuationAtStart,SetTrimPunctuationAtStart,GetEffects,GetProperty,IsEqual2,SetEffects,SetProperty

ITextStoryRanges2 interface	C241F5E5-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__ITextStoryRanges,\
	Item2


ITextStory	interface	C241F5F3-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__IUnknown,\
	GetActive,SetActive,GetDisplay,GetIndex,GetType,SetType,GetProperty,GetRange,GetText,SetFormattedText,SetProperty,SetText

ITextStrings	interface	C241F5E7-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__IDispatch,\
	Item,GetCount,Add,Append,Cat2,CatTop2,DeleteRange,EncodeFunction,GetCch,InsertNullStr,MoveBoundary,PrefixTop,Remove,SetFormattedText,SetOpCp,SuffixTop,Swap

ITextRow	interface	C241F5EF-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__IDispatch,\
	GetAlignment,SetAlignment,GetCellCount,SetCellCount,GetCellCountCache,SetCellCountCache,GetCellIndex,SetCellIndex,GetCellMargin,SetCellMargin,GetHeight,SetHeight,GetIndent,SetIndent,GetKeepTogether,SetKeepTogether,GetKeepWithNext,SetKeepWithNext,GetNestLevel,GetRTL,SetRTL,GetCellAlignment,SetCellAlignment,GetCellColorBack,SetCellColorBack,GetCellColorFore,SetCellColorFore,GetCellMergeFlags,SetCellMergeFlags,GetCellShading,SetCellShading,GetCellVerticalText,SetCellVerticalText,GetCellWidth,SetCellWidth,GetCellBorderColors,GetCellBorderWidths,SetCellBorderColors,SetCellBorderWidths,Apply,CanChange,GetProperty,Insert,IsEqual,Reset,SetProperty

ITextDisplays	interface	C241F5F2-7206-11D8-A2C7-00A0D1D6C6B3,\
	EXTENDS__IDispatch


ITextDocument2Old interface	01C25500-4268-11D1-883A-3C8B00C10000,\
	EXTENDS__ITextDocument,\
	AttachMsgFilter,SetEffectColor,GetEffectColor,GetCaretType,SetCaretType,GetImmContext,ReleaseImmContext,GetPreferredFont,GetNotificationMode,SetNotificationMode,GetClientRect,GetSelection2,GetWindow,GetFEFlags,UpdateWindow,CheckTextLimit,IMEInProgress,SysBeep,Update,Notify,GetDocumentFont,GetDocumentPara,GetCallManager,ReleaseCallManager


; --- undocumented --- undocumented --- undocumented --- undocumented ---




end if ;~ definite __tom_g__
