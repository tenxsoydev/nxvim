vim.cmd([[
	" Toggle between normal and fullscreen
	" FVimToggleFullScreen

	" Cursor tweaks
	FVimCursorSmoothMove v:true
	FVimCursorSmoothBlink v:true

	" Background composition
	" 'none', 'transparent', 'blur' or 'acrylic'
	FVimBackgroundComposition 'acrylic'   
	FVimBackgroundOpacity 0.85           
	FVimBackgroundAltOpacity 0.85

	" Debug UI overlay
	" FVimDrawFPS v:true

	" Font tweaks
	FVimFontAntialias v:true
	FVimFontAutohint v:true
	FVimFontHintLevel 'full'
	FVimFontLigature v:true
	" can be 'default', '14.0', '-1.0' etc.
	FVimFontLineHeight '+2.0'
	FVimFontSubpixel v:true
	" Disable built-in Nerd font symbols
	FVimFontNoBuiltinSymbols v:true 

	" Try to snap the fonts to the pixels, reduces blur
	" in some situations (e.g. 100% DPI).
	FVimFontAutoSnap v:true

	" Font weight tuning, possible valuaes are 100..900
	FVimFontNormalWeight 400
	FVimFontBoldWeight 700

	" Font debugging -- draw bounds around each glyph
	" FVimFontDrawBounds v:true

	" UI options (all default to v:false)
	" FVimUIPopupMenu v:true      " external popup menu
	" FVimUIWildMenu v:false      " external wildmenu -- work in progress
]])
