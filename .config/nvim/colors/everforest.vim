" Initialization: {{{
let s:configuration = everforest#get_configuration()
let s:palette = everforest#get_palette(s:configuration.background, s:configuration.colors_override)
let s:path = expand('<sfile>:p') " the path of this script
let s:last_modified = '2025年 06月 22日 星期日 06:02:12 UTC'
let g:everforest_loaded_file_types = []

if !(exists('g:colors_name') && g:colors_name ==# 'everforest' && s:configuration.better_performance)
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'everforest'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif
" }}}
" Common Highlight Groups: {{{
" UI: {{{
if s:configuration.transparent_background >= 1
  call everforest#highlight('Normal', s:palette.fg, s:palette.none)
  call everforest#highlight('NormalNC', s:palette.fg, s:palette.none)
  call everforest#highlight('Terminal', s:palette.fg, s:palette.none)
  if s:configuration.show_eob
    call everforest#highlight('EndOfBuffer', s:palette.bg4, s:palette.none)
  else
    call everforest#highlight('EndOfBuffer', s:palette.bg0, s:palette.none)
  endif
  if s:configuration.ui_contrast ==# 'low'
    call everforest#highlight('FoldColumn', s:palette.bg5, s:palette.none)
  else
    call everforest#highlight('FoldColumn', s:palette.grey0, s:palette.none)
  endif
  call everforest#highlight('Folded', s:palette.grey1, s:palette.none)
  call everforest#highlight('SignColumn', s:palette.fg, s:palette.none)
  call everforest#highlight('ToolbarLine', s:palette.fg, s:palette.none)
else
  call everforest#highlight('Normal', s:palette.fg, s:palette.bg0)
  if s:configuration.dim_inactive_windows
    call everforest#highlight('NormalNC', s:palette.fg, s:palette.bg_dim)
  else
    call everforest#highlight('NormalNC', s:palette.fg, s:palette.bg0)
  endif
  call everforest#highlight('Terminal', s:palette.fg, s:palette.bg0)
  if s:configuration.show_eob
    call everforest#highlight('EndOfBuffer', s:palette.bg4, s:palette.none)
  else
    call everforest#highlight('EndOfBuffer', s:palette.bg0, s:palette.none)
  endif
  call everforest#highlight('Folded', s:palette.grey1, s:palette.bg1)
  call everforest#highlight('ToolbarLine', s:palette.fg, s:palette.bg2)
  if s:configuration.sign_column_background ==# 'grey'
    call everforest#highlight('SignColumn', s:palette.fg, s:palette.bg1)
    call everforest#highlight('FoldColumn', s:palette.grey2, s:palette.bg1)
  else
    call everforest#highlight('SignColumn', s:palette.fg, s:palette.none)
    if s:configuration.ui_contrast ==# 'low'
      call everforest#highlight('FoldColumn', s:palette.bg5, s:palette.none)
    else
      call everforest#highlight('FoldColumn', s:palette.grey0, s:palette.none)
    endif
  endif
endif
if has('nvim')
  call everforest#highlight('IncSearch', s:palette.bg0, s:palette.red)
  call everforest#highlight('Search', s:palette.bg0, s:palette.green)
else
  call everforest#highlight('IncSearch', s:palette.red, s:palette.bg0, 'reverse')
  call everforest#highlight('Search', s:palette.green, s:palette.bg0, 'reverse')
endif
highlight! link CurSearch IncSearch
call everforest#highlight('ColorColumn', s:palette.none, s:palette.bg1)
if s:configuration.ui_contrast ==# 'low'
  call everforest#highlight('Conceal', s:palette.bg5, s:palette.none)
else
  call everforest#highlight('Conceal', s:palette.grey0, s:palette.none)
endif
if s:configuration.cursor ==# 'auto'
  call everforest#highlight('Cursor', s:palette.none, s:palette.none, 'reverse')
else
  call everforest#highlight('Cursor', s:palette.bg0, s:palette[s:configuration.cursor])
endif
highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
if &diff
  call everforest#highlight('CursorLine', s:palette.none, s:palette.none, 'underline')
  call everforest#highlight('CursorColumn', s:palette.none, s:palette.none, 'bold')
else
  call everforest#highlight('CursorLine', s:palette.none, s:palette.bg1)
  call everforest#highlight('CursorColumn', s:palette.none, s:palette.bg1)
endif
if s:configuration.ui_contrast ==# 'low'
  call everforest#highlight('LineNr', s:palette.bg5, s:palette.none)
  if &diff
    call everforest#highlight('CursorLineNr', s:palette.grey1, s:palette.none, 'underline')
  elseif (&relativenumber == 1 && &cursorline == 0) || s:configuration.sign_column_background ==# 'none'
    call everforest#highlight('CursorLineNr', s:palette.grey1, s:palette.none)
  else
    call everforest#highlight('CursorLineNr', s:palette.grey1, s:palette.bg1)
  endif
else
  call everforest#highlight('LineNr', s:palette.grey0, s:palette.none)
  if &diff
    call everforest#highlight('CursorLineNr', s:palette.grey2, s:palette.none, 'underline')
  elseif (&relativenumber == 1 && &cursorline == 0) || s:configuration.sign_column_background ==# 'none'
    call everforest#highlight('CursorLineNr', s:palette.grey2, s:palette.none)
  else
    call everforest#highlight('CursorLineNr', s:palette.grey2, s:palette.bg1)
  endif
endif
call everforest#highlight('DiffAdd', s:palette.none, s:palette.bg_green)
call everforest#highlight('DiffChange', s:palette.none, s:palette.bg_blue)
call everforest#highlight('DiffDelete', s:palette.none, s:palette.bg_red)
if has('nvim')
  call everforest#highlight('DiffText', s:palette.bg0, s:palette.blue)
else
  call everforest#highlight('DiffText', s:palette.blue, s:palette.bg0, 'reverse')
endif
call everforest#highlight('Directory', s:palette.green, s:palette.none)
call everforest#highlight('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call everforest#highlight('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call everforest#highlight('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call everforest#highlight('MoreMsg', s:palette.yellow, s:palette.none, 'bold')
call everforest#highlight('MatchParen', s:palette.none, s:palette.bg4)
call everforest#highlight('NonText', s:palette.bg4, s:palette.none)
if has('nvim')
  call everforest#highlight('Whitespace', s:palette.bg4, s:palette.none)
  call everforest#highlight('SpecialKey', s:palette.yellow, s:palette.none)
else
  call everforest#highlight('SpecialKey', s:palette.bg3, s:palette.none)
endif
call everforest#highlight('Pmenu', s:palette.fg, s:palette.bg2)
call everforest#highlight('PmenuSbar', s:palette.none, s:palette.bg2)
call everforest#highlight('PmenuSel', s:palette.bg0, s:palette.statusline1)
call everforest#highlight('PmenuKind', s:palette.green, s:palette.bg2)
call everforest#highlight('PmenuExtra', s:palette.grey2, s:palette.bg2)
highlight! link WildMenu PmenuSel
call everforest#highlight('PmenuThumb', s:palette.none, s:palette.grey0)
if s:configuration.float_style ==# 'dim'
  call everforest#highlight('NormalFloat', s:palette.fg, s:palette.bg_dim)
  call everforest#highlight('FloatBorder', s:palette.grey1, s:palette.bg_dim)
  call everforest#highlight('FloatTitle', s:palette.fg, s:palette.bg_dim, 'bold')
else
  call everforest#highlight('NormalFloat', s:palette.fg, s:palette.bg2)
  call everforest#highlight('FloatBorder', s:palette.grey1, s:palette.bg2)
  call everforest#highlight('FloatTitle', s:palette.fg, s:palette.bg2, 'bold')
endif
call everforest#highlight('Question', s:palette.yellow, s:palette.none)
if s:configuration.spell_foreground ==# 'none'
  call everforest#highlight('SpellBad', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call everforest#highlight('SpellCap', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call everforest#highlight('SpellLocal', s:palette.none, s:palette.none, 'undercurl', s:palette.aqua)
  call everforest#highlight('SpellRare', s:palette.none, s:palette.none, 'undercurl', s:palette.purple)
else
  call everforest#highlight('SpellBad', s:palette.red, s:palette.none, 'undercurl', s:palette.red)
  call everforest#highlight('SpellCap', s:palette.blue, s:palette.none, 'undercurl', s:palette.blue)
  call everforest#highlight('SpellLocal', s:palette.aqua, s:palette.none, 'undercurl', s:palette.aqua)
  call everforest#highlight('SpellRare', s:palette.purple, s:palette.none, 'undercurl', s:palette.purple)
endif
if s:configuration.transparent_background == 2
  call everforest#highlight('StatusLine', s:palette.grey1, s:palette.none)
  call everforest#highlight('StatusLineTerm', s:palette.grey1, s:palette.none)
  call everforest#highlight('StatusLineNC', s:palette.grey0, s:palette.none)
  call everforest#highlight('StatusLineTermNC', s:palette.grey0, s:palette.none)
  call everforest#highlight('TabLine', s:palette.grey2, s:palette.bg3)
  call everforest#highlight('TabLineFill', s:palette.grey1, s:palette.none)
  call everforest#highlight('TabLineSel', s:palette.bg0, s:palette.statusline1)
  if has('nvim')
    call everforest#highlight('WinBar', s:palette.grey1, s:palette.none, 'bold')
    call everforest#highlight('WinBarNC', s:palette.grey0, s:palette.none)
  endif
else
  call everforest#highlight('StatusLine', s:palette.grey1, s:palette.bg2)
  call everforest#highlight('StatusLineTerm', s:palette.grey1, s:palette.bg1)
  call everforest#highlight('StatusLineNC', s:palette.grey1, s:palette.bg1)
  call everforest#highlight('StatusLineTermNC', s:palette.grey1, s:palette.bg0)
  call everforest#highlight('TabLine', s:palette.grey2, s:palette.bg3)
  call everforest#highlight('TabLineFill', s:palette.grey1, s:palette.bg1)
  call everforest#highlight('TabLineSel', s:palette.bg0, s:palette.statusline1)
  if has('nvim')
    call everforest#highlight('WinBar', s:palette.grey1, s:palette.bg2, 'bold')
    call everforest#highlight('WinBarNC', s:palette.grey1, s:palette.bg1)
  endif
endif
if s:configuration.dim_inactive_windows
  call everforest#highlight('VertSplit', s:palette.bg4, s:palette.bg_dim)
else
  call everforest#highlight('VertSplit', s:palette.bg4, s:palette.none)
endif
highlight! link WinSeparator VertSplit
call everforest#highlight('Visual', s:palette.none, s:palette.bg_visual)
call everforest#highlight('VisualNOS', s:palette.none, s:palette.bg_visual)
call everforest#highlight('QuickFixLine', s:palette.purple, s:palette.none, 'bold')
call everforest#highlight('Debug', s:palette.orange, s:palette.none)
call everforest#highlight('debugPC', s:palette.bg0, s:palette.green)
call everforest#highlight('debugBreakpoint', s:palette.bg0, s:palette.red)
call everforest#highlight('ToolbarButton', s:palette.bg0, s:palette.green)
if has('nvim')
  call everforest#highlight('Substitute', s:palette.bg0, s:palette.yellow)
  if s:configuration.diagnostic_text_highlight
    call everforest#highlight('DiagnosticError', s:palette.red, s:palette.bg_red)
    call everforest#highlight('DiagnosticUnderlineError', s:palette.none, s:palette.bg_red, 'undercurl', s:palette.red)
    call everforest#highlight('DiagnosticWarn', s:palette.yellow, s:palette.bg_yellow)
    call everforest#highlight('DiagnosticUnderlineWarn', s:palette.none, s:palette.bg_yellow, 'undercurl', s:palette.yellow)
    call everforest#highlight('DiagnosticInfo', s:palette.blue, s:palette.bg_blue)
    call everforest#highlight('DiagnosticUnderlineInfo', s:palette.none, s:palette.bg_blue, 'undercurl', s:palette.blue)
    call everforest#highlight('DiagnosticHint', s:palette.green, s:palette.bg_green)
    call everforest#highlight('DiagnosticUnderlineHint', s:palette.none, s:palette.bg_green, 'undercurl', s:palette.green)
  else
    call everforest#highlight('DiagnosticError', s:palette.red, s:palette.none)
    call everforest#highlight('DiagnosticUnderlineError', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
    call everforest#highlight('DiagnosticWarn', s:palette.yellow, s:palette.none)
    call everforest#highlight('DiagnosticUnderlineWarn', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
    call everforest#highlight('DiagnosticInfo', s:palette.blue, s:palette.none)
    call everforest#highlight('DiagnosticUnderlineInfo', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
    call everforest#highlight('DiagnosticHint', s:palette.green, s:palette.none)
    call everforest#highlight('DiagnosticUnderlineHint', s:palette.none, s:palette.none, 'undercurl', s:palette.green)
  endif
  highlight! link DiagnosticFloatingError ErrorFloat
  highlight! link DiagnosticFloatingWarn WarningFloat
  highlight! link DiagnosticFloatingInfo InfoFloat
  highlight! link DiagnosticFloatingHint HintFloat
  highlight! link DiagnosticVirtualTextError VirtualTextError
  highlight! link DiagnosticVirtualTextWarn VirtualTextWarning
  highlight! link DiagnosticVirtualTextInfo VirtualTextInfo
  highlight! link DiagnosticVirtualTextHint VirtualTextHint
  highlight! link DiagnosticSignError RedSign
  highlight! link DiagnosticSignWarn YellowSign
  highlight! link DiagnosticSignInfo BlueSign
  highlight! link DiagnosticSignHint GreenSign
  highlight! link LspDiagnosticsFloatingError DiagnosticFloatingError
  highlight! link LspDiagnosticsFloatingWarning DiagnosticFloatingWarn
  highlight! link LspDiagnosticsFloatingInformation DiagnosticFloatingInfo
  highlight! link LspDiagnosticsFloatingHint DiagnosticFloatingHint
  highlight! link LspDiagnosticsDefaultError DiagnosticError
  highlight! link LspDiagnosticsDefaultWarning DiagnosticWarn
  highlight! link LspDiagnosticsDefaultInformation DiagnosticInfo
  highlight! link LspDiagnosticsDefaultHint DiagnosticHint
  highlight! link LspDiagnosticsVirtualTextError DiagnosticVirtualTextError
  highlight! link LspDiagnosticsVirtualTextWarning DiagnosticVirtualTextWarn
  highlight! link LspDiagnosticsVirtualTextInformation DiagnosticVirtualTextInfo
  highlight! link LspDiagnosticsVirtualTextHint DiagnosticVirtualTextHint
  highlight! link LspDiagnosticsUnderlineError DiagnosticUnderlineError
  highlight! link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn
  highlight! link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo
  highlight! link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint
  highlight! link LspDiagnosticsSignError DiagnosticSignError
  highlight! link LspDiagnosticsSignWarning DiagnosticSignWarn
  highlight! link LspDiagnosticsSignInformation DiagnosticSignInfo
  highlight! link LspDiagnosticsSignHint DiagnosticSignHint
  highlight! link LspReferenceText CurrentWord
  highlight! link LspReferenceRead CurrentWord
  highlight! link LspReferenceWrite CurrentWord
  highlight! link LspInlayHint InlayHints
  highlight! link LspCodeLens VirtualTextInfo
  highlight! link LspCodeLensSeparator VirtualTextHint
  highlight! link LspSignatureActiveParameter Search
  highlight! link TermCursor Cursor
  highlight! link healthError Red
  highlight! link healthSuccess Green
  highlight! link healthWarning Yellow
endif
" }}}
" Syntax: {{{
call everforest#highlight('Boolean', s:palette.purple, s:palette.none)
call everforest#highlight('Number', s:palette.purple, s:palette.none)
call everforest#highlight('Float', s:palette.purple, s:palette.none)
if s:configuration.enable_italic
  call everforest#highlight('PreProc', s:palette.purple, s:palette.none, 'italic')
  call everforest#highlight('PreCondit', s:palette.purple, s:palette.none, 'italic')
  call everforest#highlight('Include', s:palette.purple, s:palette.none, 'italic')
  call everforest#highlight('Define', s:palette.purple, s:palette.none, 'italic')
  call everforest#highlight('Conditional', s:palette.red, s:palette.none, 'italic')
  call everforest#highlight('Repeat', s:palette.red, s:palette.none, 'italic')
  call everforest#highlight('Keyword', s:palette.red, s:palette.none, 'italic')
  call everforest#highlight('Typedef', s:palette.red, s:palette.none, 'italic')
  call everforest#highlight('Exception', s:palette.red, s:palette.none, 'italic')
  call everforest#highlight('Statement', s:palette.red, s:palette.none, 'italic')
else
  call everforest#highlight('PreProc', s:palette.purple, s:palette.none)
  call everforest#highlight('PreCondit', s:palette.purple, s:palette.none)
  call everforest#highlight('Include', s:palette.purple, s:palette.none)
  call everforest#highlight('Define', s:palette.purple, s:palette.none)
  call everforest#highlight('Conditional', s:palette.red, s:palette.none)
  call everforest#highlight('Repeat', s:palette.red, s:palette.none)
  call everforest#highlight('Keyword', s:palette.red, s:palette.none)
  call everforest#highlight('Typedef', s:palette.red, s:palette.none)
  call everforest#highlight('Exception', s:palette.red, s:palette.none)
  call everforest#highlight('Statement', s:palette.red, s:palette.none)
endif
call everforest#highlight('Error', s:palette.red, s:palette.none)
call everforest#highlight('StorageClass', s:palette.orange, s:palette.none)
call everforest#highlight('Tag', s:palette.orange, s:palette.none)
call everforest#highlight('Label', s:palette.orange, s:palette.none)
call everforest#highlight('Structure', s:palette.orange, s:palette.none)
call everforest#highlight('Operator', s:palette.orange, s:palette.none)
call everforest#highlight('Title', s:palette.orange, s:palette.none, 'bold')
call everforest#highlight('Special', s:palette.yellow, s:palette.none)
call everforest#highlight('SpecialChar', s:palette.yellow, s:palette.none)
call everforest#highlight('Type', s:palette.yellow, s:palette.none)
call everforest#highlight('Function', s:palette.green, s:palette.none)
call everforest#highlight('String', s:palette.green, s:palette.none)
call everforest#highlight('Character', s:palette.green, s:palette.none)
call everforest#highlight('Constant', s:palette.aqua, s:palette.none)
call everforest#highlight('Macro', s:palette.aqua, s:palette.none)
call everforest#highlight('Identifier', s:palette.blue, s:palette.none)
call everforest#highlight('Todo', s:palette.bg0, s:palette.blue, 'bold')
if s:configuration.disable_italic_comment
  call everforest#highlight('Comment', s:palette.grey1, s:palette.none)
  call everforest#highlight('SpecialComment', s:palette.grey1, s:palette.none)
else
  call everforest#highlight('Comment', s:palette.grey1, s:palette.none, 'italic')
  call everforest#highlight('SpecialComment', s:palette.grey1, s:palette.none, 'italic')
endif
call everforest#highlight('Delimiter', s:palette.fg, s:palette.none)
call everforest#highlight('Ignore', s:palette.grey1, s:palette.none)
call everforest#highlight('Underlined', s:palette.none, s:palette.none, 'underline')
" }}}
" Predefined Highlight Groups: {{{
call everforest#highlight('Fg', s:palette.fg, s:palette.none)
call everforest#highlight('Grey', s:palette.grey1, s:palette.none)
call everforest#highlight('Red', s:palette.red, s:palette.none)
call everforest#highlight('Orange', s:palette.orange, s:palette.none)
call everforest#highlight('Yellow', s:palette.yellow, s:palette.none)
call everforest#highlight('Green', s:palette.green, s:palette.none)
call everforest#highlight('Aqua', s:palette.aqua, s:palette.none)
call everforest#highlight('Blue', s:palette.blue, s:palette.none)
call everforest#highlight('Purple', s:palette.purple, s:palette.none)
if s:configuration.enable_italic
  call everforest#highlight('RedItalic', s:palette.red, s:palette.none, 'italic')
  call everforest#highlight('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
  call everforest#highlight('YellowItalic', s:palette.yellow, s:palette.none, 'italic')
  call everforest#highlight('GreenItalic', s:palette.green, s:palette.none, 'italic')
  call everforest#highlight('AquaItalic', s:palette.aqua, s:palette.none, 'italic')
  call everforest#highlight('BlueItalic', s:palette.blue, s:palette.none, 'italic')
  call everforest#highlight('PurpleItalic', s:palette.purple, s:palette.none, 'italic')
else
  call everforest#highlight('RedItalic', s:palette.red, s:palette.none)
  call everforest#highlight('OrangeItalic', s:palette.orange, s:palette.none)
  call everforest#highlight('YellowItalic', s:palette.yellow, s:palette.none)
  call everforest#highlight('GreenItalic', s:palette.green, s:palette.none)
  call everforest#highlight('AquaItalic', s:palette.aqua, s:palette.none)
  call everforest#highlight('BlueItalic', s:palette.blue, s:palette.none)
  call everforest#highlight('PurpleItalic', s:palette.purple, s:palette.none)
endif
if s:configuration.transparent_background || s:configuration.sign_column_background ==# 'none'
  call everforest#highlight('RedSign', s:palette.red, s:palette.none)
  call everforest#highlight('OrangeSign', s:palette.orange, s:palette.none)
  call everforest#highlight('YellowSign', s:palette.yellow, s:palette.none)
  call everforest#highlight('GreenSign', s:palette.green, s:palette.none)
  call everforest#highlight('AquaSign', s:palette.aqua, s:palette.none)
  call everforest#highlight('BlueSign', s:palette.blue, s:palette.none)
  call everforest#highlight('PurpleSign', s:palette.purple, s:palette.none)
else
  call everforest#highlight('RedSign', s:palette.red, s:palette.bg1)
  call everforest#highlight('OrangeSign', s:palette.orange, s:palette.bg1)
  call everforest#highlight('YellowSign', s:palette.yellow, s:palette.bg1)
  call everforest#highlight('GreenSign', s:palette.green, s:palette.bg1)
  call everforest#highlight('AquaSign', s:palette.aqua, s:palette.bg1)
  call everforest#highlight('BlueSign', s:palette.blue, s:palette.bg1)
  call everforest#highlight('PurpleSign', s:palette.purple, s:palette.bg1)
endif
highlight! link Added Green
highlight! link Removed Red
highlight! link Changed Blue
if s:configuration.diagnostic_text_highlight
  call everforest#highlight('ErrorText', s:palette.none, s:palette.bg_red, 'undercurl', s:palette.red)
  call everforest#highlight('WarningText', s:palette.none, s:palette.bg_yellow, 'undercurl', s:palette.yellow)
  call everforest#highlight('InfoText', s:palette.none, s:palette.bg_blue, 'undercurl', s:palette.blue)
  call everforest#highlight('HintText', s:palette.none, s:palette.bg_green, 'undercurl', s:palette.green)
else
  call everforest#highlight('ErrorText', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call everforest#highlight('WarningText', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
  call everforest#highlight('InfoText', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call everforest#highlight('HintText', s:palette.none, s:palette.none, 'undercurl', s:palette.green)
endif
if s:configuration.diagnostic_line_highlight
  call everforest#highlight('ErrorLine', s:palette.none, s:palette.bg_red)
  call everforest#highlight('WarningLine', s:palette.none, s:palette.bg_yellow)
  call everforest#highlight('InfoLine', s:palette.none, s:palette.bg_blue)
  call everforest#highlight('HintLine', s:palette.none, s:palette.bg_green)
else
  highlight clear ErrorLine
  highlight clear WarningLine
  highlight clear InfoLine
  highlight clear HintLine
endif
if s:configuration.diagnostic_virtual_text ==# 'grey'
  highlight! link VirtualTextWarning Grey
  highlight! link VirtualTextError Grey
  highlight! link VirtualTextInfo Grey
  highlight! link VirtualTextHint Grey
elseif s:configuration.diagnostic_virtual_text ==# 'colored'
  highlight! link VirtualTextWarning Yellow
  highlight! link VirtualTextError Red
  highlight! link VirtualTextInfo Blue
  highlight! link VirtualTextHint Green
else
  call everforest#highlight('VirtualTextWarning', s:palette.yellow, s:palette.bg_yellow)
  call everforest#highlight('VirtualTextError', s:palette.red, s:palette.bg_red)
  call everforest#highlight('VirtualTextInfo', s:palette.blue, s:palette.bg_blue)
  call everforest#highlight('VirtualTextHint', s:palette.green, s:palette.bg_green)
endif
call everforest#highlight('ErrorFloat', s:palette.red, s:palette.none)
call everforest#highlight('WarningFloat', s:palette.yellow, s:palette.none)
call everforest#highlight('InfoFloat', s:palette.blue, s:palette.none)
call everforest#highlight('HintFloat', s:palette.green, s:palette.none)
if &diff
  call everforest#highlight('CurrentWord', s:palette.bg0, s:palette.green)
elseif s:configuration.current_word ==# 'grey background'
  call everforest#highlight('CurrentWord', s:palette.none, s:palette.bg2)
elseif s:configuration.current_word ==# 'high contrast background'
  call everforest#highlight('CurrentWord', s:palette.none, s:palette.bg3)
else
  call everforest#highlight('CurrentWord', s:palette.none, s:palette.none, s:configuration.current_word)
endif
if s:configuration.inlay_hints_background ==# 'none'
  highlight! link InlayHints LineNr
else
  call everforest#highlight('InlayHints', s:palette.grey1, s:palette.bg_dim)
endif
" Define a color for each LSP item kind to create highlights for nvim-cmp, aerial.nvim, nvim-navic and coc.nvim
let g:everforest_lsp_kind_color = [
      \ ["Array", "Aqua"],
      \ ["Boolean", "Aqua"],
      \ ["Class", "Red"],
      \ ["Class", "Yellow"],
      \ ["Color", "Aqua"],
      \ ["Constant", "Blue"],
      \ ["Constructor", "Green"],
      \ ["Default", "Aqua"],
      \ ["Enum", "Yellow"],
      \ ["EnumMember", "Purple"],
      \ ["Event", "Orange"],
      \ ["Field", "Green"],
      \ ["File", "Green"],
      \ ["Folder", "Aqua"],
      \ ["Function", "Green"],
      \ ["Interface", "Yellow"],
      \ ["Key", "Red"],
      \ ["Keyword", "Red"],
      \ ["Method", "Green"],
      \ ["Module", "Yellow"],
      \ ["Namespace", "Purple"],
      \ ["Null", "Aqua"],
      \ ["Number", "Aqua"],
      \ ["Object", "Aqua"],
      \ ["Operator", "Orange"],
      \ ["Package", "Purple"],
      \ ["Property", "Blue"],
      \ ["Reference", "Aqua"],
      \ ["Snippet", "Aqua"],
      \ ["String", "Aqua"],
      \ ["Struct", "Yellow"],
      \ ["Text", "Fg"],
      \ ["TypeParameter", "Yellow"],
      \ ["Unit", "Purple"],
      \ ["Value", "Purple"],
      \ ["Variable", "Blue"],
      \ ]
" }}}
" }}}
" Terminal: {{{
if ((has('termguicolors') && &termguicolors) || has('gui_running')) && !s:configuration.disable_terminal_colors
  " Definition
  let s:terminal = {
        \ 'black':    &background ==# 'dark' ? s:palette.bg3 : s:palette.fg,
        \ 'red':      s:palette.red,
        \ 'yellow':   s:palette.yellow,
        \ 'green':    s:palette.green,
        \ 'cyan':     s:palette.aqua,
        \ 'blue':     s:palette.blue,
        \ 'purple':   s:palette.purple,
        \ 'white':    &background ==# 'dark' ? s:palette.fg : s:palette.bg3,
        \ }
  " Implementation: {{{
  if !has('nvim')
    let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
          \ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
          \ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]
  else
    let g:terminal_color_0 = s:terminal.black[0]
    let g:terminal_color_1 = s:terminal.red[0]
    let g:terminal_color_2 = s:terminal.green[0]
    let g:terminal_color_3 = s:terminal.yellow[0]
    let g:terminal_color_4 = s:terminal.blue[0]
    let g:terminal_color_5 = s:terminal.purple[0]
    let g:terminal_color_6 = s:terminal.cyan[0]
    let g:terminal_color_7 = s:terminal.white[0]
    let g:terminal_color_8 = s:terminal.black[0]
    let g:terminal_color_9 = s:terminal.red[0]
    let g:terminal_color_10 = s:terminal.green[0]
    let g:terminal_color_11 = s:terminal.yellow[0]
    let g:terminal_color_12 = s:terminal.blue[0]
    let g:terminal_color_13 = s:terminal.purple[0]
    let g:terminal_color_14 = s:terminal.cyan[0]
    let g:terminal_color_15 = s:terminal.white[0]
  endif
  " }}}
endif
" }}}
" Plugins: {{{
if has('nvim')
" Saghen/blink.cmp {{{
call everforest#highlight('BlinkCmpLabelMatch', s:palette.green, s:palette.none, 'bold')
for kind in g:everforest_lsp_kind_color
  execute "highlight! link BlinkCmpKind" . kind[0] . " " . kind[1]
endfor
" }}}
" folke/trouble.nvim {{{
highlight! link TroubleText Fg
highlight! link TroubleSource Grey
highlight! link TroubleCode Grey
" }}}
" echasnovski/mini.nvim {{{
call everforest#highlight('MiniAnimateCursor', s:palette.none, s:palette.none, 'reverse,nocombine')
call everforest#highlight('MiniFilesFile', s:palette.fg, s:palette.none)
if s:configuration.float_style ==# 'dim'
  call everforest#highlight('MiniFilesTitleFocused', s:palette.green, s:palette.bg_dim, 'bold')
else
  call everforest#highlight('MiniFilesTitleFocused', s:palette.green, s:palette.bg2, 'bold')
endif
call everforest#highlight('MiniHipatternsFixme', s:palette.bg0, s:palette.red, 'bold')
call everforest#highlight('MiniHipatternsHack', s:palette.bg0, s:palette.yellow, 'bold')
call everforest#highlight('MiniHipatternsNote', s:palette.bg0, s:palette.blue, 'bold')
call everforest#highlight('MiniHipatternsTodo', s:palette.bg0, s:palette.green, 'bold')
call everforest#highlight('MiniIconsAzure', s:palette.blue, s:palette.none)
call everforest#highlight('MiniIconsBlue', s:palette.blue, s:palette.none)
call everforest#highlight('MiniIconsCyan', s:palette.aqua, s:palette.none)
call everforest#highlight('MiniIconsGreen', s:palette.green, s:palette.none)
call everforest#highlight('MiniIconsGrey', s:palette.grey2, s:palette.none)
call everforest#highlight('MiniIconsOrange', s:palette.orange, s:palette.none)
call everforest#highlight('MiniIconsPurple', s:palette.purple, s:palette.none)
call everforest#highlight('MiniIconsRed', s:palette.red, s:palette.none)
call everforest#highlight('MiniIconsYellow', s:palette.yellow, s:palette.none)
call everforest#highlight('MiniIndentscopePrefix', s:palette.none, s:palette.none, 'nocombine')
call everforest#highlight('MiniJump2dSpot', s:palette.orange, s:palette.none, 'bold,nocombine')
call everforest#highlight('MiniJump2dSpotAhead', s:palette.aqua, s:palette.none, 'nocombine')
call everforest#highlight('MiniJump2dSpotUnique', s:palette.yellow, s:palette.none, 'bold,nocombine')
if s:configuration.float_style ==# 'dim'
  call everforest#highlight('MiniPickPrompt', s:palette.blue, s:palette.bg_dim)
else
  call everforest#highlight('MiniPickPrompt', s:palette.blue, s:palette.bg2)
endif
call everforest#highlight('MiniStarterCurrent', s:palette.none, s:palette.none, 'nocombine')
call everforest#highlight('MiniStatuslineDevinfo', s:palette.grey2, s:palette.bg3)
call everforest#highlight('MiniStatuslineFilename', s:palette.grey1, s:palette.bg1)
call everforest#highlight('MiniStatuslineModeCommand', s:palette.bg0, s:palette.aqua, 'bold')
call everforest#highlight('MiniStatuslineModeInsert', s:palette.bg0, s:palette.statusline2, 'bold')
call everforest#highlight('MiniStatuslineModeNormal', s:palette.bg0, s:palette.statusline1, 'bold')
call everforest#highlight('MiniStatuslineModeOther', s:palette.bg0, s:palette.purple, 'bold')
call everforest#highlight('MiniStatuslineModeReplace', s:palette.bg0, s:palette.orange, 'bold')
call everforest#highlight('MiniStatuslineModeVisual', s:palette.bg0, s:palette.statusline3, 'bold')
call everforest#highlight('MiniTablineCurrent', s:palette.fg, s:palette.bg4)
call everforest#highlight('MiniTablineHidden', s:palette.grey1, s:palette.bg2)
call everforest#highlight('MiniTablineModifiedCurrent', s:palette.blue, s:palette.bg4)
call everforest#highlight('MiniTablineModifiedHidden', s:palette.grey1, s:palette.bg2)
call everforest#highlight('MiniTablineModifiedVisible', s:palette.blue, s:palette.bg2)
call everforest#highlight('MiniTablineTabpagesection', s:palette.bg0, s:palette.statusline1, 'bold')
call everforest#highlight('MiniTablineVisible', s:palette.fg, s:palette.bg2)
call everforest#highlight('MiniTestEmphasis', s:palette.none, s:palette.none, 'bold')
call everforest#highlight('MiniTestFail', s:palette.red, s:palette.none, 'bold')
call everforest#highlight('MiniTestPass', s:palette.green, s:palette.none, 'bold')
call everforest#highlight('MiniTrailspace', s:palette.none, s:palette.red)
highlight! link MiniAnimateNormalFloat NormalFloat
highlight! link MiniClueBorder FloatBorder
highlight! link MiniClueDescGroup DiagnosticFloatingWarn
highlight! link MiniClueDescSingle NormalFloat
highlight! link MiniClueNextKey DiagnosticFloatingHint
highlight! link MiniClueNextKeyWithPostkeys DiagnosticFloatingError
highlight! link MiniClueSeparator DiagnosticFloatingInfo
highlight! link MiniClueTitle FloatTitle
highlight! link MiniCompletionActiveParameter LspSignatureActiveParameter
highlight! link MiniCursorword CurrentWord
highlight! link MiniCursorwordCurrent CurrentWord
highlight! link MiniDepsChangeAdded Added
highlight! link MiniDepsChangeRemoved Removed
highlight! link MiniDepsHint DiagnosticHint
highlight! link MiniDepsInfo DiagnosticInfo
highlight! link MiniDepsMsgBreaking DiagnosticWarn
highlight! link MiniDepsPlaceholder Comment
highlight! link MiniDepsTitle Title
highlight! link MiniDepsTitleError DiffDelete
highlight! link MiniDepsTitleSame DiffChange
highlight! link MiniDepsTitleUpdate DiffAdd
highlight! link MiniDiffOverAdd DiffAdd
highlight! link MiniDiffOverChange DiffText
highlight! link MiniDiffOverContext DiffChange
highlight! link MiniDiffOverDelete DiffDelete
highlight! link MiniDiffSignAdd GreenSign
highlight! link MiniDiffSignChange BlueSign
highlight! link MiniDiffSignDelete RedSign
highlight! link MiniFilesBorder FloatBorder
highlight! link MiniFilesBorderModified DiagnosticFloatingWarn
highlight! link MiniFilesCursorLine CursorLine
highlight! link MiniFilesDirectory Directory
highlight! link MiniFilesNormal NormalFloat
highlight! link MiniFilesTitle FloatTitle
highlight! link MiniIndentscopeSymbol Grey
highlight! link MiniJump Search
highlight! link MiniJump2dDim Comment
highlight! link MiniMapNormal NormalFloat
highlight! link MiniMapSymbolCount Special
highlight! link MiniMapSymbolLine Title
highlight! link MiniMapSymbolView Delimiter
highlight! link MiniNotifyBorder FloatBorder
highlight! link MiniNotifyNormal NormalFloat
highlight! link MiniNotifyTitle FloatTitle
highlight! link MiniOperatorsExchangeFrom IncSearch
highlight! link MiniPickBorder FloatBorder
highlight! link MiniPickBorderBusy DiagnosticFloatingWarn
highlight! link MiniPickBorderText FloatTitle
highlight! link MiniPickHeader DiagnosticFloatingHint
highlight! link MiniPickIconDirectory Directory
highlight! link MiniPickIconFile MiniPickNormal
highlight! link MiniPickMatchCurrent CursorLine
highlight! link MiniPickMatchMarked Visual
highlight! link MiniPickMatchRanges DiagnosticFloatingHint
highlight! link MiniPickNormal NormalFloat
highlight! link MiniPickPreviewLine CursorLine
highlight! link MiniPickPreviewRegion IncSearch
highlight! link MiniStarterFooter Orange
highlight! link MiniStarterHeader Yellow
highlight! link MiniStarterInactive Comment
highlight! link MiniStarterItem Normal
highlight! link MiniStarterItemBullet Grey
highlight! link MiniStarterItemPrefix Yellow
highlight! link MiniStarterQuery Blue
highlight! link MiniStarterSection Title
highlight! link MiniStatuslineFileinfo MiniStatuslineDevinfo
highlight! link MiniStatuslineInactive Grey
highlight! link MiniSurround IncSearch
highlight! link MiniTablineFill TabLineFill
" }}}
endif
" }}}
" Extended File Types: {{{
" Whitelist: {{{ File type optimizations that will always be loaded.
" diff {{{
highlight! link diffAdded Added
highlight! link diffRemoved Removed
highlight! link diffChanged Changed
highlight! link diffOldFile Yellow
highlight! link diffNewFile Orange
highlight! link diffFile Aqua
highlight! link diffLine Grey
highlight! link diffIndexLine Purple
" }}}
" }}}
" Generate the `after/syntax` directory based on the comment tags in this file.
" For example, the content between `syn_begin: sh/zsh` and `syn_end` will be placed in `after/syntax/sh/everforest.vim` and `after/syntax/zsh/everforest.vim`.
if everforest#syn_exists(s:path) " If the syntax files exist.
  if s:configuration.better_performance
    if !everforest#syn_newest(s:path, s:last_modified) " Regenerate if it's not up to date.
      call everforest#syn_clean(s:path, 0)
      call everforest#syn_gen(s:path, s:last_modified, 'update')
    endif
    finish
  else
    call everforest#syn_clean(s:path, 1)
  endif
else
  if s:configuration.better_performance
    call everforest#syn_gen(s:path, s:last_modified, 'generate')
    finish
  endif
endif
" syn_begin: markdown {{{
" builtin: {{{
call everforest#highlight('markdownH1', s:palette.red, s:palette.none, 'bold')
call everforest#highlight('markdownH2', s:palette.orange, s:palette.none, 'bold')
call everforest#highlight('markdownH3', s:palette.yellow, s:palette.none, 'bold')
call everforest#highlight('markdownH4', s:palette.green, s:palette.none, 'bold')
call everforest#highlight('markdownH5', s:palette.blue, s:palette.none, 'bold')
call everforest#highlight('markdownH6', s:palette.purple, s:palette.none, 'bold')
call everforest#highlight('markdownItalic', s:palette.none, s:palette.none, 'italic')
call everforest#highlight('markdownBold', s:palette.none, s:palette.none, 'bold')
call everforest#highlight('markdownItalicDelimiter', s:palette.grey1, s:palette.none, 'italic')
highlight! link markdownUrl TSURI
highlight! link markdownCode Green
highlight! link markdownCodeBlock Aqua
highlight! link markdownCodeDelimiter Aqua
highlight! link markdownBlockquote Grey
highlight! link markdownListMarker Red
highlight! link markdownOrderedListMarker Red
highlight! link markdownRule Purple
highlight! link markdownHeadingRule Grey
highlight! link markdownUrlDelimiter Grey
highlight! link markdownLinkDelimiter Grey
highlight! link markdownLinkTextDelimiter Grey
highlight! link markdownHeadingDelimiter Grey
highlight! link markdownLinkText Purple
highlight! link markdownUrlTitleDelimiter Green
highlight! link markdownIdDeclaration markdownLinkText
highlight! link markdownBoldDelimiter Grey
highlight! link markdownId Yellow
" }}}
" vim-markdown: https://github.com/gabrielelana/vim-markdown {{{
call everforest#highlight('mkdURL', s:palette.blue, s:palette.none, 'underline')
call everforest#highlight('mkdInlineURL', s:palette.purple, s:palette.none, 'underline')
call everforest#highlight('mkdItalic', s:palette.grey1, s:palette.none, 'italic')
highlight! link mkdCodeDelimiter Aqua
highlight! link mkdBold Grey
highlight! link mkdLink Purple
highlight! link mkdHeading Grey
highlight! link mkdListItem Red
highlight! link mkdRule Purple
highlight! link mkdDelimiter Grey
highlight! link mkdId Yellow
" }}}
" nvim-treesitter/nvim-treesitter {{{
if has('nvim-0.8')
  highlight! link @markup.heading.1.markdown markdownH1
  highlight! link @markup.heading.2.markdown markdownH2
  highlight! link @markup.heading.3.markdown markdownH3
  highlight! link @markup.heading.4.markdown markdownH4
  highlight! link @markup.heading.5.markdown markdownH5
  highlight! link @markup.heading.6.markdown markdownH6
  highlight! link @markup.heading.1.marker.markdown @conceal
  highlight! link @markup.heading.2.marker.markdown @conceal
  highlight! link @markup.heading.3.marker.markdown @conceal
  highlight! link @markup.heading.4.marker.markdown @conceal
  highlight! link @markup.heading.5.marker.markdown @conceal
  highlight! link @markup.heading.6.marker.markdown @conceal
  if !has('nvim-0.10')
    call everforest#highlight('@markup.italic', s:palette.none, s:palette.none, 'italic')
    call everforest#highlight('@markup.strikethrough', s:palette.none, s:palette.none, 'strikethrough')
  endif
endif
" }}}
" syn_end }}}
" syn_begin: vimwiki {{{
call everforest#highlight('VimwikiHeader1', s:palette.red, s:palette.none, 'bold')
call everforest#highlight('VimwikiHeader2', s:palette.orange, s:palette.none, 'bold')
call everforest#highlight('VimwikiHeader3', s:palette.yellow, s:palette.none, 'bold')
call everforest#highlight('VimwikiHeader4', s:palette.green, s:palette.none, 'bold')
call everforest#highlight('VimwikiHeader5', s:palette.blue, s:palette.none, 'bold')
call everforest#highlight('VimwikiHeader6', s:palette.purple, s:palette.none, 'bold')
call everforest#highlight('VimwikiLink', s:palette.blue, s:palette.none, 'underline')
call everforest#highlight('VimwikiItalic', s:palette.none, s:palette.none, 'italic')
call everforest#highlight('VimwikiBold', s:palette.none, s:palette.none, 'bold')
call everforest#highlight('VimwikiUnderline', s:palette.none, s:palette.none, 'underline')
highlight! link VimwikiList Red
highlight! link VimwikiTag Aqua
highlight! link VimwikiCode Green
highlight! link VimwikiHR Yellow
highlight! link VimwikiHeaderChar Grey
highlight! link VimwikiMarkers Grey
highlight! link VimwikiPre Green
highlight! link VimwikiPreDelim Green
highlight! link VimwikiNoExistsLink Red
" syn_end }}}
" syn_begin: xml {{{
" builtin: https://github.com/chrisbra/vim-xml-ftplugin {{{
highlight! link xmlTag Green
highlight! link xmlEndTag Blue
highlight! link xmlTagName OrangeItalic
highlight! link xmlEqual Orange
highlight! link xmlAttrib Aqua
highlight! link xmlEntity Red
highlight! link xmlEntityPunct Red
highlight! link xmlDocTypeDecl Grey
highlight! link xmlDocTypeKeyword PurpleItalic
highlight! link xmlCdataStart Grey
highlight! link xmlCdataCdata Purple
" }}}
" syn_end }}}
" syn_begin: css/scss/sass/less {{{
" builtin: https://github.com/JulesWang/css.vim {{{
highlight! link cssAttrComma Fg
highlight! link cssBraces Fg
highlight! link cssTagName PurpleItalic
highlight! link cssClassNameDot Red
highlight! link cssClassName RedItalic
highlight! link cssFunctionName Yellow
highlight! link cssAttr Orange
highlight! link cssProp Aqua
highlight! link cssCommonAttr Yellow
highlight! link cssPseudoClassId Blue
highlight! link cssPseudoClassFn Green
highlight! link cssPseudoClass Purple
highlight! link cssImportant RedItalic
highlight! link cssSelectorOp Orange
highlight! link cssSelectorOp2 Orange
highlight! link cssColor Green
highlight! link cssAttributeSelector Aqua
highlight! link cssUnitDecorators Orange
highlight! link cssValueLength Green
highlight! link cssValueInteger Green
highlight! link cssValueNumber Green
highlight! link cssValueAngle Green
highlight! link cssValueTime Green
highlight! link cssValueFrequency Green
highlight! link cssVendor Grey
highlight! link cssNoise Grey
" }}}
" syn_end }}}
" syn_begin: less {{{
" vim-less: https://github.com/groenewege/vim-less {{{
highlight! link lessMixinChar Grey
highlight! link lessClass RedItalic
highlight! link lessVariable Blue
highlight! link lessAmpersandChar Orange
highlight! link lessFunction Yellow
" }}}
" syn_end }}}
" syn_begin: python {{{
" builtin: {{{
highlight! link pythonBuiltin Yellow
highlight! link pythonExceptions Purple
highlight! link pythonDecoratorName Blue
" }}}
" python-syntax: https://github.com/vim-python/python-syntax {{{
highlight! link pythonExClass Purple
highlight! link pythonBuiltinType Yellow
highlight! link pythonBuiltinObj Blue
highlight! link pythonDottedName PurpleItalic
highlight! link pythonBuiltinFunc Green
highlight! link pythonFunction Aqua
highlight! link pythonDecorator Orange
highlight! link pythonInclude Include
highlight! link pythonImport PreProc
highlight! link pythonRun Blue
highlight! link pythonCoding Grey
highlight! link pythonOperator Orange
highlight! link pythonConditional RedItalic
highlight! link pythonRepeat RedItalic
highlight! link pythonException RedItalic
highlight! link pythonNone Aqua
highlight! link pythonDot Grey
" }}}
" semshi: https://github.com/numirias/semshi {{{
call everforest#highlight('semshiUnresolved', s:palette.yellow, s:palette.none, 'undercurl')
highlight! link semshiImported TSInclude
highlight! link semshiParameter TSParameter
highlight! link semshiParameterUnused Grey
highlight! link semshiSelf TSVariableBuiltin
highlight! link semshiGlobal TSType
highlight! link semshiBuiltin TSTypeBuiltin
highlight! link semshiAttribute TSAttribute
highlight! link semshiLocal TSKeyword
highlight! link semshiFree TSKeyword
highlight! link semshiSelected CurrentWord
highlight! link semshiErrorSign RedSign
highlight! link semshiErrorChar RedSign
" }}}
" syn_end }}}
" syn_begin: lua {{{
" builtin: {{{
highlight! link luaFunc Green
highlight! link luaFunction Aqua
highlight! link luaTable Fg
highlight! link luaIn RedItalic
" }}}
" vim-lua: https://github.com/tbastos/vim-lua {{{
highlight! link luaFuncCall Green
highlight! link luaLocal Orange
highlight! link luaSpecialValue Green
highlight! link luaBraces Fg
highlight! link luaBuiltIn Purple
highlight! link luaNoise Grey
highlight! link luaLabel Purple
highlight! link luaFuncTable Yellow
highlight! link luaFuncArgName Blue
highlight! link luaEllipsis Orange
highlight! link luaDocTag Green
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link luaTSConstructor luaBraces
if has('nvim-0.8')
  highlight! link @constructor.lua luaTSConstructor
endif
if has('nvim-0.9')
  call everforest#highlight('@lsp.type.variable.lua', s:palette.none, s:palette.none)
endif
" }}}
" syn_end }}}
" syn_begin: java {{{
" builtin: {{{
highlight! link javaClassDecl RedItalic
highlight! link javaMethodDecl RedItalic
highlight! link javaVarArg Green
highlight! link javaAnnotation Blue
highlight! link javaUserLabel Purple
highlight! link javaTypedef Aqua
highlight! link javaParen Fg
highlight! link javaParen1 Fg
highlight! link javaParen2 Fg
highlight! link javaParen3 Fg
highlight! link javaParen4 Fg
highlight! link javaParen5 Fg
" }}}
" syn_end }}}
" syn_begin: go {{{
" builtin: https://github.com/fatih/vim-go {{{
highlight! link goPackage Define
highlight! link goImport Include
highlight! link goVar OrangeItalic
highlight! link goConst goVar
highlight! link goType Yellow
highlight! link goSignedInts goType
highlight! link goUnsignedInts goType
highlight! link goFloats goType
highlight! link goComplexes goType
highlight! link goVarDefs Aqua
highlight! link goDeclType OrangeItalic
highlight! link goFunctionCall Function
highlight! link goPredefinedIdentifiers Aqua
highlight! link goBuiltins Function
highlight! link goVarArgs Grey
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link goTSInclude Purple
highlight! link goTSNamespace Fg
highlight! link goTSConstBuiltin AquaItalic
if has('nvim-0.8')
  highlight! link @include.go goTSInclude
  highlight! link @namespace.go goTSNamespace
  highlight! link @module.go goTSNamespace
  highlight! link @constant.builtin.go goTSConstBuiltin
endif
if has('nvim-0.9')
  highlight! link @lsp.typemod.variable.defaultLibrary.go goTSConstBuiltin
  highlight! link @lsp.type.namespace.go goTSNamespace
endif
" }}}
" syn_end }}}
" syn_begin: rust {{{
" builtin: https://github.com/rust-lang/rust.vim {{{
highlight! link rustStructure Orange
highlight! link rustIdentifier Purple
highlight! link rustModPath Orange
highlight! link rustModPathSep Grey
highlight! link rustSelf Blue
highlight! link rustSuper Blue
highlight! link rustDeriveTrait PurpleItalic
highlight! link rustEnumVariant Purple
highlight! link rustMacroVariable Blue
highlight! link rustAssert Aqua
highlight! link rustPanic Aqua
highlight! link rustPubScopeCrate PurpleItalic
" }}}
" coc-rust-analyzer: https://github.com/fannheyward/coc-rust-analyzer {{{
highlight! link CocRustChainingHint Grey
highlight! link CocRustTypeHint Grey
" }}}
" syn_end }}}
" syn_begin: php {{{
" builtin: https://jasonwoof.com/gitweb/?p=vim-syntax.git;a=blob;f=php.vim;hb=HEAD {{{
highlight! link phpVarSelector Blue
highlight! link phpDefine OrangeItalic
highlight! link phpStructure RedItalic
highlight! link phpSpecialFunction Green
highlight! link phpInterpSimpleCurly Yellow
highlight! link phpComparison Orange
highlight! link phpMethodsVar Aqua
highlight! link phpMemberSelector Green
" }}}
" php.vim: https://github.com/StanAngeloff/php.vim {{{
highlight! link phpParent Fg
highlight! link phpNowDoc Green
highlight! link phpFunction Green
highlight! link phpMethod Green
highlight! link phpClass Orange
highlight! link phpSuperglobals Purple
" }}}
" syn_end }}}
" syn_begin: ruby {{{
" builtin: https://github.com/vim-ruby/vim-ruby {{{
highlight! link rubyKeywordAsMethod Green
highlight! link rubyInterpolation Yellow
highlight! link rubyInterpolationDelimiter Yellow
highlight! link rubyStringDelimiter Green
highlight! link rubyBlockParameterList Blue
highlight! link rubyDefine RedItalic
highlight! link rubyModuleName Purple
highlight! link rubyAccess Orange
highlight! link rubyAttribute Yellow
highlight! link rubyMacro RedItalic
" }}}
" syn_end }}}
" syn_begin: haskell {{{
" haskell-vim: https://github.com/neovimhaskell/haskell-vim {{{
highlight! link haskellBrackets Blue
highlight! link haskellIdentifier Yellow
highlight! link haskellAssocType Aqua
highlight! link haskellQuotedType Aqua
highlight! link haskellType Aqua
highlight! link haskellDeclKeyword RedItalic
highlight! link haskellWhere RedItalic
highlight! link haskellDeriving PurpleItalic
highlight! link haskellForeignKeywords PurpleItalic
" }}}
" syn_end }}}
" syn_begin: ocaml {{{
" builtin: https://github.com/rgrinberg/vim-ocaml {{{
highlight! link ocamlArrow Orange
highlight! link ocamlEqual Orange
highlight! link ocamlOperator Orange
highlight! link ocamlKeyChar Orange
highlight! link ocamlModPath Green
highlight! link ocamlFullMod Green
highlight! link ocamlModule Purple
highlight! link ocamlConstructor Aqua
highlight! link ocamlFuncWith Yellow
highlight! link ocamlWith Yellow
highlight! link ocamlModParam Fg
highlight! link ocamlModParam1 Fg
highlight! link ocamlAnyVar Blue
highlight! link ocamlPpxEncl Orange
highlight! link ocamlPpxIdentifier Blue
highlight! link ocamlSigEncl Orange
highlight! link ocamlStructEncl Aqua
highlight! link ocamlModParam1 Blue
" }}}
" syn_end }}}
" syn_begin: vim {{{
call everforest#highlight('vimCommentTitle', s:palette.grey1, s:palette.none, 'bold')
highlight! link vimLet Orange
highlight! link vimFunction Green
highlight! link vimIsCommand Fg
highlight! link vimUserFunc Green
highlight! link vimFuncName Green
highlight! link vimMap PurpleItalic
highlight! link vimNotation Aqua
highlight! link vimMapLhs Green
highlight! link vimMapRhs Green
highlight! link vimSetEqual Yellow
highlight! link vimSetSep Fg
highlight! link vimOption Aqua
highlight! link vimUserAttrbKey Yellow
highlight! link vimUserAttrb Green
highlight! link vimAutoCmdSfxList Aqua
highlight! link vimSynType Orange
highlight! link vimHiBang Orange
highlight! link vimSet Yellow
highlight! link vimSetSep Grey
highlight! link vimContinue Grey
" syn_end }}}
" syn_begin: make {{{
highlight! link makeIdent Aqua
highlight! link makeSpecTarget Yellow
highlight! link makeTarget Blue
highlight! link makeCommands Orange
" syn_end }}}
" syn_begin: cmake {{{
highlight! link cmakeCommand Orange
highlight! link cmakeKWconfigure_package_config_file Yellow
highlight! link cmakeKWwrite_basic_package_version_file Yellow
highlight! link cmakeKWExternalProject Aqua
highlight! link cmakeKWadd_compile_definitions Aqua
highlight! link cmakeKWadd_compile_options Aqua
highlight! link cmakeKWadd_custom_command Aqua
highlight! link cmakeKWadd_custom_target Aqua
highlight! link cmakeKWadd_definitions Aqua
highlight! link cmakeKWadd_dependencies Aqua
highlight! link cmakeKWadd_executable Aqua
highlight! link cmakeKWadd_library Aqua
highlight! link cmakeKWadd_link_options Aqua
highlight! link cmakeKWadd_subdirectory Aqua
highlight! link cmakeKWadd_test Aqua
highlight! link cmakeKWbuild_command Aqua
highlight! link cmakeKWcmake_host_system_information Aqua
highlight! link cmakeKWcmake_minimum_required Aqua
highlight! link cmakeKWcmake_parse_arguments Aqua
highlight! link cmakeKWcmake_policy Aqua
highlight! link cmakeKWconfigure_file Aqua
highlight! link cmakeKWcreate_test_sourcelist Aqua
highlight! link cmakeKWctest_build Aqua
highlight! link cmakeKWctest_configure Aqua
highlight! link cmakeKWctest_coverage Aqua
highlight! link cmakeKWctest_memcheck Aqua
highlight! link cmakeKWctest_run_script Aqua
highlight! link cmakeKWctest_start Aqua
highlight! link cmakeKWctest_submit Aqua
highlight! link cmakeKWctest_test Aqua
highlight! link cmakeKWctest_update Aqua
highlight! link cmakeKWctest_upload Aqua
highlight! link cmakeKWdefine_property Aqua
highlight! link cmakeKWdoxygen_add_docs Aqua
highlight! link cmakeKWenable_language Aqua
highlight! link cmakeKWenable_testing Aqua
highlight! link cmakeKWexec_program Aqua
highlight! link cmakeKWexecute_process Aqua
highlight! link cmakeKWexport Aqua
highlight! link cmakeKWexport_library_dependencies Aqua
highlight! link cmakeKWfile Aqua
highlight! link cmakeKWfind_file Aqua
highlight! link cmakeKWfind_library Aqua
highlight! link cmakeKWfind_package Aqua
highlight! link cmakeKWfind_path Aqua
highlight! link cmakeKWfind_program Aqua
highlight! link cmakeKWfltk_wrap_ui Aqua
highlight! link cmakeKWforeach Aqua
highlight! link cmakeKWfunction Aqua
highlight! link cmakeKWget_cmake_property Aqua
highlight! link cmakeKWget_directory_property Aqua
highlight! link cmakeKWget_filename_component Aqua
highlight! link cmakeKWget_property Aqua
highlight! link cmakeKWget_source_file_property Aqua
highlight! link cmakeKWget_target_property Aqua
highlight! link cmakeKWget_test_property Aqua
highlight! link cmakeKWif Aqua
highlight! link cmakeKWinclude Aqua
highlight! link cmakeKWinclude_directories Aqua
highlight! link cmakeKWinclude_external_msproject Aqua
highlight! link cmakeKWinclude_guard Aqua
highlight! link cmakeKWinstall Aqua
highlight! link cmakeKWinstall_files Aqua
highlight! link cmakeKWinstall_programs Aqua
highlight! link cmakeKWinstall_targets Aqua
highlight! link cmakeKWlink_directories Aqua
highlight! link cmakeKWlist Aqua
highlight! link cmakeKWload_cache Aqua
highlight! link cmakeKWload_command Aqua
highlight! link cmakeKWmacro Aqua
highlight! link cmakeKWmark_as_advanced Aqua
highlight! link cmakeKWmath Aqua
highlight! link cmakeKWmessage Aqua
highlight! link cmakeKWoption Aqua
highlight! link cmakeKWproject Aqua
highlight! link cmakeKWqt_wrap_cpp Aqua
highlight! link cmakeKWqt_wrap_ui Aqua
highlight! link cmakeKWremove Aqua
highlight! link cmakeKWseparate_arguments Aqua
highlight! link cmakeKWset Aqua
highlight! link cmakeKWset_directory_properties Aqua
highlight! link cmakeKWset_property Aqua
highlight! link cmakeKWset_source_files_properties Aqua
highlight! link cmakeKWset_target_properties Aqua
highlight! link cmakeKWset_tests_properties Aqua
highlight! link cmakeKWsource_group Aqua
highlight! link cmakeKWstring Aqua
highlight! link cmakeKWsubdirs Aqua
highlight! link cmakeKWtarget_compile_definitions Aqua
highlight! link cmakeKWtarget_compile_features Aqua
highlight! link cmakeKWtarget_compile_options Aqua
highlight! link cmakeKWtarget_include_directories Aqua
highlight! link cmakeKWtarget_link_directories Aqua
highlight! link cmakeKWtarget_link_libraries Aqua
highlight! link cmakeKWtarget_link_options Aqua
highlight! link cmakeKWtarget_precompile_headers Aqua
highlight! link cmakeKWtarget_sources Aqua
highlight! link cmakeKWtry_compile Aqua
highlight! link cmakeKWtry_run Aqua
highlight! link cmakeKWunset Aqua
highlight! link cmakeKWuse_mangled_mesa Aqua
highlight! link cmakeKWvariable_requires Aqua
highlight! link cmakeKWvariable_watch Aqua
highlight! link cmakeKWwrite_file Aqua
" syn_end }}}
" syn_begin: json {{{
" builtin {{{
highlight! link jsonKeyword Green
highlight! link jsonString Fg
highlight! link jsonQuote Grey
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link jsonTSLabel jsonKeyword
highlight! link jsonTSString jsonString
highlight! link jsonTSStringEscape SpecialChar
if has('nvim-0.8')
  highlight! link @label.json jsonTSLabel
  highlight! link @string.json jsonTSString
  highlight! link @string.escape.json jsonTSStringEscape
endif
" }}}
" syn_end }}}
" syn_begin: yaml {{{
" builtin {{{
highlight! link yamlBlockMappingKey Green
highlight! link yamlString Fg
highlight! link yamlConstant OrangeItalic
highlight! link yamlKeyValueDelimiter Grey
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link yamlTSField yamlBlockMappingKey
highlight! link yamlTSString yamlString
highlight! link yamlTSStringEscape SpecialChar
highlight! link yamlTSBoolean yamlConstant
highlight! link yamlTSConstBuiltin yamlConstant
if has('nvim-0.8')
  highlight! link @field.yaml yamlTSField
  highlight! link @string.yaml yamlTSString
  highlight! link @string.escape.yaml yamlTSStringEscape
  highlight! link @boolean.yaml yamlTSBoolean
  highlight! link @constant.builtin.yaml yamlTSConstBuiltin
endif
highlight! link yamlKey yamlBlockMappingKey  " stephpy/vim-yaml
" }}}
" syn_end }}}
" syn_begin: toml {{{
" builtin: https://github.com/cespare/vim-toml {{{
call everforest#highlight('tomlTable', s:palette.orange, s:palette.none, 'bold')
highlight! link tomlKey Green
highlight! link tomlString Fg
highlight! link tomlDate Special
highlight! link tomlBoolean Aqua
highlight! link tomlTableArray tomlTable
" }}}
" nvim-treesitter/nvim-treesitter {{{
highlight! link tomlTSProperty tomlKey
highlight! link tomlTSString tomlString
if has('nvim-0.8')
  highlight! link @property.toml tomlTSProperty
  highlight! link @string.toml tomlTSString
endif
" }}}
" syn_end }}}
" syn_begin: gitcommit {{{
" builtin {{{
highlight! link gitcommitSummary Green
highlight! link gitcommitUntracked Grey
highlight! link gitcommitDiscarded Grey
highlight! link gitcommitSelected Grey
highlight! link gitcommitUnmerged Grey
highlight! link gitcommitOnBranch Grey
highlight! link gitcommitArrow Grey
highlight! link gitcommitFile Green
" }}}
" nvim-treesitter/nvim-treesitter {{{
if has('nvim-0.8')
  highlight! link @text.gitcommit TSNone
endif
" }}}
" syn_end }}}
" syn_begin: help {{{
call everforest#highlight('helpNote', s:palette.purple, s:palette.none, 'bold')
call everforest#highlight('helpHeadline', s:palette.red, s:palette.none, 'bold')
call everforest#highlight('helpHeader', s:palette.orange, s:palette.none, 'bold')
call everforest#highlight('helpURL', s:palette.green, s:palette.none, 'underline')
call everforest#highlight('helpHyperTextEntry', s:palette.yellow, s:palette.none, 'bold')
highlight! link helpHyperTextJump Yellow
highlight! link helpCommand Aqua
highlight! link helpExample Green
highlight! link helpSpecial Blue
highlight! link helpSectionDelim Grey
" syn_end }}}
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
