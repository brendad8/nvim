
vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = ""

-- ============================================================================
-- Palette
-- ============================================================================

local c = {
  -- Base
  bg         = "#2d2f33",
  bg_code    = "#2d2f33",
  fg         = "#dddddd",

  -- Syntax
  keyword    = "#eeeeee",
  string     = "#22ee55",
  builtin    = "#ff894c",
  comment    = "#aaaa77",
  function_  = "#B1A0F8",
  type       = "#6688ff",
  number     = "#ff8080",
  null       = "#ff8080",

  -- UI
  cursorline = "#36383d",
  selection  = "#222222",
  border     = "#444444",
  line_nr    = "#666666",
  line_nr_active = "#dddddd",
  status_nc  = "#777777",
  escape     = "#ff894c",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ============================================================================
-- Editor / UI
-- ============================================================================

hi("Normal", { fg = c.fg, bg = c.bg, })
hi("Special", { fg = c.fg, bg = c.bg, })
hi("Visual", { bg = c.selection, })
hi("Directory", { fg = c.type })

hi("CursorLine", { bg = c.cursorline, })
hi("CursorColumn", { bg = c.cursorline, })
hi("ColorColumn", { bg = c.cursorline, })

hi("Search", { fg = c.bg, bg = c.type, })
hi("IncSearch", { fg = c.bg, bg = c.builtin, })
hi("CurSearch", { fg = c.bg, bg = c.builtin, })

hi("NormalFloat", { fg = c.fg, bg = c.bg_code, })
hi("FloatBorder", { fg = c.border, bg = c.bg, })

hi("LineNr", { fg = c.line_nr, bg = c.bg, })
hi("CursorLineNr", { fg = c.line_nr_active, bg = c.bg, bold = true, })

hi("StatusLine", { fg = c.fg, bg = c.bg_code, })
hi("StatusLineNC", { fg = c.status_nc, bg = c.bg_code, })

hi("WinSeparator", { fg = c.border, bg = c.bg, })

hi("Pmenu", { fg = c.fg, bg = c.bg_code, })
hi("PmenuSel", { fg = c.bg, bg = c.type, })
hi("PmenuSbar", { bg = c.selection, })
hi("PmenuThumb", { bg = "#666666", })

hi("MatchParen", { fg = c.builtin, bold = true, })

-- ============================================================================
-- Generic Vim syntax groups
-- ============================================================================

hi("Keyword", { fg = c.keyword, bold = true, })
hi("Statement", { fg = c.keyword, bold = true, })
hi("Conditional", { fg = c.keyword, bold = true, })
hi("Repeat", { fg = c.keyword, bold = true, })
hi("Label", { fg = c.keyword, bold = true, })
hi("Exception", { fg = c.keyword, bold = true, })
hi("Operator", { fg = c.fg, })
hi("String", { fg = c.string, })
hi("Character", { fg = c.string, })

hi("Type", { fg = c.type, bold = true, })
hi("Structure", { fg = c.type, bold = true, })
hi("StorageClass", { fg = c.keyword, bold = true, })
hi("Function", { fg = c.function_, bold = true, })
hi("Identifier", { fg = c.fg, })
hi("Constant", { fg = c.null, })
hi("Number", { fg = c.number, })
hi("Float", { fg = c.number, })
hi("Boolean", { fg = c.null, })

hi("Comment", { fg = c.comment, italic = true, })
hi("SpecialComment", { fg = c.comment, italic = true, })

hi("Error", { fg = c.number, })
hi("Todo", { fg = c.builtin, bold = true, })

-- ============================================================================
-- C / C++ preprocessor
-- ============================================================================

hi("PreProc", { fg = c.builtin, })
hi("PreCondit", { fg = c.builtin, })
hi("Define", { fg = c.builtin, })
hi("Include", { fg = c.builtin, })
hi("Macro", { fg = c.builtin, })

hi("cPreProc", { fg = c.builtin, })
hi("cPreCondit", { fg = c.builtin, })
hi("cDefine", { fg = c.builtin, })
hi("cInclude", { fg = c.builtin, })
hi("cType", { fg = c.type, bold = true, })
hi("cStructure", { fg = c.type, bold = true, })
hi("cStorageClass", { fg = c.keyword, bold = true, })
hi("cTypedef", { fg = c.type, bold = true, })
hi("cEnum", { fg = c.type, bold = true, })
hi("cStruct", { fg = c.type, bold = true, })
hi("cUnion", { fg = c.type, bold = true, })

-- ============================================================================
-- Zig legacy syntax groups
-- ============================================================================

hi("zigKeyword", { fg = c.keyword, bold = true, })
hi("zigConditional", { fg = c.keyword, bold = true, })
hi("zigRepeat", { fg = c.keyword, bold = true, })
hi("zigType", { fg = c.type, bold = true, })
hi("zigBuiltin", { fg = c.builtin, })
hi("zigBuiltinFn", { fg = c.builtin, })
hi("zigString", { fg = c.string, })
hi("zigCharacter", { fg = c.string, })
hi("zigNumber", { fg = c.number, })
hi("zigBoolean", { fg = c.null, })
hi("zigNull", { fg = c.null, })
hi("zigFunction", { fg = c.function_, bold = true, })
hi("zigComment", { fg = c.comment, italic = true, })

-- ============================================================================
-- Treesitter: keywords
-- ============================================================================

hi("@keyword", { fg = c.keyword, bold = true, })
hi("@keyword.zig", { fg = c.keyword, bold = true, })
hi("@keyword.function.zig", { fg = c.keyword, bold = true, })
hi("@keyword.return.zig", { fg = c.keyword, bold = true, })
hi("@keyword.conditional.zig", { fg = c.keyword, bold = true, })
hi("@keyword.repeat.zig", { fg = c.keyword, bold = true, })

-- ============================================================================
-- Treesitter: strings
-- ============================================================================

hi("@string", { fg = c.string, })
hi("@string.zig", { fg = c.string, })
hi("@character", { fg = c.string, })
hi("@character.zig", { fg = c.string, })

hi("@string.escape", { fg = c.escape, })

-- ============================================================================
-- Treesitter: types
-- ============================================================================

hi("@type", { fg = c.fg })

hi("@type.zig", { fg = c.fg, })
hi("@type.builtin.zig", { fg = c.type })
hi("@type.definition.zig", { fg = c.type })

-- C types
hi("@type.c", { fg = c.fg, })
hi("@type.builtin.c", { fg = c.type, })
hi("@type.definition.c", { fg = c.type, })
hi("@type.qualifier.c", { fg = c.keyword, bold = true, })
hi("@storageclass.c", { fg = c.keyword, bold = true, })

-- ============================================================================
-- Treesitter: functions
-- ============================================================================

hi("@function", { fg = c.function_, })
hi("@function.zig", { fg = c.function_, })

hi("@function.call", { fg = c.fg, })
hi("@function.call.zig", { fg = c.fg, })

hi("@function.builtin.zig", { fg = c.builtin, })
hi("@function.macro.zig", { fg = c.builtin, })

-- ============================================================================
-- Treesitter: variables / identifiers
-- ============================================================================

hi("@variable", { fg = c.fg, })
hi("@variable.zig", { fg = c.fg, })
hi("@module.zig", { fg = c.fg, })
hi("@variable.builtin.zig", { fg = c.builtin, })
hi("@keyword.import.zig", { fg = c.builtin, })

-- ============================================================================
-- Treesitter: Zig builtins
-- ============================================================================

hi("@attribute.zig", { fg = c.builtin, })

-- ============================================================================
-- Treesitter: numbers / constants
-- ============================================================================

hi("@number", { fg = c.number, })
hi("@number.zig", { fg = c.number, })
hi("@boolean", { fg = c.null, })
hi("@boolean.zig", { fg = c.null, })
hi("@constant.builtin", { fg = c.null, })
hi("@constant.builtin.zig", { fg = c.null, })

-- ============================================================================
-- Treesitter: comments
-- ============================================================================

hi("@comment", { fg = c.comment, italic = true, })
hi("@comment.zig", { fg = c.comment, italic = true, })
hi("@comment.c", { fg = c.comment, italic = true, })

-- ============================================================================
-- Treesitter: C / C++ preprocessor
-- ============================================================================

hi("@keyword.import.c", { fg = c.builtin, })
hi("@keyword.directive", { fg = c.builtin, })
hi("@keyword.directive.c", { fg = c.builtin, })
hi("@keyword.directive.cpp", { fg = c.builtin, })
hi("@preproc", { fg = c.builtin, })
hi("@preproc.c", { fg = c.builtin })
hi("@preproc.cpp", { fg = c.builtin })

-- ============================================================================
-- Diagnostics
-- ============================================================================

hi("DiagnosticError", { fg = c.number, })
hi("DiagnosticWarn", { fg = c.builtin, })
hi("DiagnosticInfo", { fg = c.type, })
hi("DiagnosticHint", { fg = c.function_, })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.number, })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.builtin, })


-- ============================================================================
-- Treesitter: Lua
-- ============================================================================

hi("@function.builtin.lua", { fg = c.builtin })
hi("@punctuation.bracket.lua", { fg = c.fg })
hi("@constructor.lua", { fg = c.fg })


