
" ============================================================================
" Custom Colorscheme
" ============================================================================
"
" Compatible with:
"   - Vim 8/9
"   - Neovim
"
" Save as:
"   ~/.vim/colors/custom.vim
"
" Then use:
"   colorscheme custom
"
" ============================================================================

if exists("syntax_on")
  syntax reset
endif

hi clear

if exists("g:colors_name")
  unlet g:colors_name
endif

let g:colors_name = "custom"

set background=dark

" ============================================================================
" Palette
" ============================================================================

let s:bg             = "#2d2f33"
let s:bg_code        = "#2d2f33"
let s:fg             = "#dddddd"

let s:keyword        = "#eeeeee"
let s:string         = "#22ee55"
let s:builtin        = "#ff894c"
let s:comment        = "#aaaa77"
let s:function       = "#B1A0F8"
let s:type           = "#6688ff"
let s:number         = "#ff8080"
let s:null           = "#ff8080"

let s:cursorline     = "#36383d"
let s:selection      = "#4c4c4c"
let s:border         = "#444444"
let s:line_nr        = "#666666"
let s:line_nr_active = "#dddddd"
let s:status_nc      = "#777777"
let s:escape         = "#ff894c"

" ============================================================================
" Editor / UI
" ============================================================================

hi Normal       guifg=#dddddd guibg=NONE ctermfg=white ctermbg=NONE

"hi NormalFloat  guifg=#dddddd guibg=NONE ctermfg=white ctermbg=NONE
"
"hi LineNr       guifg=#666666 guibg=NONE ctermfg=241 ctermbg=NONE
"hi CursorLineNr guifg=#dddddd guibg=NONE ctermfg=white ctermbg=NONE
"
"hi StatusLine   guifg=#dddddd guibg=NONE ctermfg=white ctermbg=NONE
"hi StatusLineNC guifg=#777777 guibg=NONE ctermfg=243 ctermbg=NONE
"
"hi VertSplit    guifg=#444444 guibg=NONE ctermfg=238 ctermbg=NONE
"hi WinSeparator guifg=#444444 guibg=NONE ctermfg=238 ctermbg=NONE

hi Special      guifg=#dddddd guibg=#2d2f33

hi Visual       guibg=#4c4c4c
hi Directory    guifg=#6688ff

hi CursorLine   guibg=#36383d
hi CursorColumn guibg=#36383d
hi ColorColumn  guibg=#36383d

hi Search       guifg=#2d2f33 guibg=#6688ff
hi IncSearch    guifg=#2d2f33 guibg=#ff894c
hi CurSearch    guifg=#2d2f33 guibg=#ff894c

hi NormalFloat  guifg=#dddddd guibg=#2d2f33
hi FloatBorder  guifg=#444444 guibg=#2d2f33

hi LineNr       guifg=#666666 guibg=#2d2f33
hi CursorLineNr guifg=#dddddd guibg=#2d2f33 gui=bold

hi StatusLine   guifg=#dddddd guibg=#2d2f33
hi StatusLineNC guifg=#777777 guibg=#2d2f33

" Vim uses VertSplit; newer Vim/Neovim versions also support WinSeparator.
hi VertSplit    guifg=#444444 guibg=#2d2f33
hi WinSeparator guifg=#444444 guibg=#2d2f33

hi Pmenu        guifg=#dddddd guibg=#2d2f33
hi PmenuSel     guifg=#2d2f33 guibg=#6688ff
hi PmenuSbar    guibg=#4c4c4c
hi PmenuThumb   guibg=#666666

hi MatchParen   guifg=#ff894c gui=bold

hi QuickFixLine guifg=#dddddd

" ============================================================================
" Generic Vim syntax
" ============================================================================

hi Comment       guifg=#aaaa77 gui=italic
hi SpecialComment guifg=#aaaa77 gui=italic

hi Constant      guifg=#ff8080
hi String        guifg=#22ee55
hi Character     guifg=#22ee55
hi Number        guifg=#ff8080
hi Boolean       guifg=#ff8080
hi Float         guifg=#ff8080

hi Identifier    guifg=#dddddd
hi Function      guifg=#B1A0F8 gui=bold

hi Statement     guifg=#eeeeee gui=bold
hi Conditional   guifg=#eeeeee gui=bold
hi Repeat        guifg=#eeeeee gui=bold
hi Label         guifg=#eeeeee gui=bold
hi Operator      guifg=#dddddd
hi Keyword       guifg=#eeeeee gui=bold
hi Exception     guifg=#eeeeee gui=bold

hi Type          guifg=#6688ff gui=bold
hi Structure     guifg=#6688ff gui=bold
hi StorageClass  guifg=#eeeeee gui=bold
hi Typedef       guifg=#6688ff gui=bold

hi PreProc       guifg=#ff894c
hi PreCondit     guifg=#ff894c
hi Define        guifg=#ff894c
hi Include       guifg=#ff894c
hi Macro         guifg=#ff894c

hi Error         guifg=#ff8080
hi Todo          guifg=#ff894c gui=bold

" ============================================================================
" C / C++
" ============================================================================

hi cPreProc       guifg=#ff894c
hi cPreCondit     guifg=#ff894c
hi cDefine        guifg=#ff894c
hi cInclude       guifg=#ff894c

hi cType          guifg=#6688ff gui=bold
hi cStructure     guifg=#6688ff gui=bold
hi cStorageClass  guifg=#eeeeee gui=bold
hi cTypedef       guifg=#6688ff gui=bold
hi cEnum          guifg=#6688ff gui=bold
hi cStruct        guifg=#6688ff gui=bold
hi cUnion         guifg=#6688ff gui=bold

" ============================================================================
" Zig
" ============================================================================

hi zigKeyword      guifg=#eeeeee gui=bold
hi zigConditional  guifg=#eeeeee gui=bold
hi zigRepeat       guifg=#eeeeee gui=bold

hi zigType         guifg=#6688ff gui=bold

hi zigBuiltin      guifg=#ff894c
hi zigBuiltinFn    guifg=#ff894c

hi zigString       guifg=#22ee55
hi zigCharacter    guifg=#22ee55

hi zigNumber       guifg=#ff8080
hi zigBoolean      guifg=#ff8080
hi zigNull         guifg=#ff8080

hi zigFunction     guifg=#B1A0F8 gui=bold
hi zigComment      guifg=#aaaa77 gui=italic

" ============================================================================
" Lua
" ============================================================================

hi luaFunction     guifg=#B1A0F8 gui=bold
hi luaFunc         guifg=#B1A0F8 gui=bold
hi luaBuiltIn      guifg=#ff894c
hi luaSpecialValue guifg=#ff8080

" ============================================================================
" Diagnostics
" ============================================================================
"
" These are primarily useful in Neovim, but defining them here is harmless
" in Vim and allows the same colorscheme to be shared between both.
"

hi DiagnosticError guifg=#ff8080
hi DiagnosticWarn  guifg=#ff894c
hi DiagnosticInfo  guifg=#6688ff
hi DiagnosticHint  guifg=#B1A0F8

hi DiagnosticUnderlineError
      \ guisp=#ff8080
      \ gui=undercurl

hi DiagnosticUnderlineWarn
      \ guisp=#ff894c
      \ gui=undercurl

hi DiagnosticUnderlineInfo
      \ guisp=#6688ff
      \ gui=undercurl

hi DiagnosticUnderlineHint
      \ guisp=#B1A0F8
      \ gui=undercurl

" ============================================================================
" Terminal colors
" ============================================================================
"
" Used by Vim/Neovim terminal buffers and supported terminals.
"

let g:terminal_color_0  = "#2d2f33"
let g:terminal_color_1  = "#ff8080"
let g:terminal_color_2  = "#22ee55"
let g:terminal_color_3  = "#ff894c"
let g:terminal_color_4  = "#6688ff"
let g:terminal_color_5  = "#B1A0F8"
let g:terminal_color_6  = "#22ee55"
let g:terminal_color_7  = "#dddddd"

let g:terminal_color_8  = "#666666"
let g:terminal_color_9  = "#ff8080"
let g:terminal_color_10 = "#22ee55"
let g:terminal_color_11 = "#ff894c"
let g:terminal_color_12 = "#6688ff"
let g:terminal_color_13 = "#B1A0F8"
let g:terminal_color_14 = "#22ee55"
let g:terminal_color_15 = "#eeeeee"

" ============================================================================
" 256-color fallback
" ============================================================================
"
" Vim will use the GUI colors above when true-color is available.
" The cterm values below provide reasonable colors on terminals without
" true-color support.
"

if !has("gui_running")

  hi Normal       ctermfg=white    ctermbg=236
  hi NormalFloat  ctermfg=white    ctermbg=236

  hi Visual       ctermbg=239
  hi CursorLine   ctermbg=237
  hi CursorColumn ctermbg=237
  hi ColorColumn  ctermbg=237

  hi LineNr       ctermfg=241    ctermbg=236
  hi CursorLineNr ctermfg=white  ctermbg=236 cterm=bold

  hi StatusLine   ctermfg=white  ctermbg=236
  hi StatusLineNC ctermfg=243    ctermbg=236

  hi VertSplit    ctermfg=238    ctermbg=236
  hi WinSeparator ctermfg=238    ctermbg=236

  hi Pmenu        ctermfg=white  ctermbg=236
  hi PmenuSel     ctermfg=black  ctermbg=68

  hi Comment      ctermfg=144    cterm=italic

  hi Constant     ctermfg=210
  hi Number       ctermfg=210
  hi Boolean      ctermfg=210
  hi String       ctermfg=46
  hi Character    ctermfg=46

  hi Identifier   ctermfg=white
  hi Function     ctermfg=141   cterm=bold

  hi Keyword      ctermfg=255   cterm=bold
  hi Statement    ctermfg=255   cterm=bold
  hi Conditional  ctermfg=255   cterm=bold
  hi Repeat       ctermfg=255   cterm=bold
  hi Type         ctermfg=69    cterm=bold

  hi PreProc      ctermfg=209
  hi Define       ctermfg=209
  hi Include      ctermfg=209
  hi Macro        ctermfg=209

  hi Error        ctermfg=210
  hi Todo         ctermfg=209   cterm=bold

  hi Search       ctermfg=black ctermbg=69
  hi IncSearch    ctermfg=black ctermbg=209
  hi CurSearch    ctermfg=black ctermbg=209

endif
