vim.cmd 'hi clear'
vim.cmd 'filetype on'
vim.cmd 'syntax clear'
vim.cmd 'syntax on'

vim.g.colors_name = 'poz'
vim.opt.background = 'light'
vim.opt.termguicolors = false

local c = {
  t  = 'NONE',
  b1 = 15,
  b2 = 254,
  b3 = 251,
  f3 = 246,
  f2 = 241,
  f1 = 0,
  p1 = 9,
  p3 = 10,
  p2 = 11,
  p5 = 12,
  p6 = 13,
  p4 = 14,
}

local shl = vim.api.nvim_set_hl
local hl = function (hlg, link) shl(0, hlg, { link = link }) end
local h = function (hlg, bg, fg) shl (0, hlg, { ctermbg = bg, ctermfg = fg, force = true }) end
local ht = function (hlg, bg, fg, term) shl (0, hlg, { ctermbg = bg, ctermfg = fg, cterm = term, force = true }) end
local italic = { italic = true }
local bold = { bold = true }
local underline = { underline = true }
local strikethrough = { strikethrough = true }
local underline_italic = { underline = true, italic = true }


local is_transparent = false
local function toggle_background()
  h('Normal', (is_transparent and c.t) or c.b1, c.f1)
  is_transparent = not is_transparent
end
vim.api.nvim_create_user_command('ToggleBackground', toggle_background, {})
toggle_background()


hl('NormalNC', 'Normal')
h('StatusLine', c.t, c.t)
h('MsgArea', c.t, c.t)
h('Cursor', c.t, c.t)
ht('LineNr', c.t, c.f3, bold)
ht('CursorLineNr', c.t, c.f2, bold)
h('CursorLine', c.b3, c.t)
h('Menu', c.b2, c.t)
h('WinSeparator', c.t, c.b2)
h('MsgSeparator', c.t, c.t)
ht('QuickFixLine', c.t, c.p4, bold)

h('OzStatModeI', c.t, c.p4)
h('OzStatModeV', c.t, c.p6)
h('OzStatModeC', c.t, c.p1)
h('OzStatModeN', c.t, c.f2)

h('OzBuf', c.t, c.t)
h('OzBufHidden', c.t, c.f2)
ht('OzBufChanged', c.t, c.p4, bold)
ht('OzBufHiddenChanged', c.t, c.p1, bold)

ht('Underlined', c.t, c.t, underline)
ht('Bold', c.t, c.t, bold)
ht('Italic', c.t, c.t, italic)

h('Ok', c.t, c.p3)
h('Error', c.t, c.p1)
h('Warning', c.t, c.p2)
h('Info', c.t, c.p4)
h('Hint', c.t, c.p5)
h('Extra', c.t, c.p6)
h('Secondary', c.t, c.f2)
h('Disabled', c.t, c.f3)

ht('Title', c.t, c.p1, bold)
h('MoreMsg', c.t, c.p4)
h('Question', c.t, c.p4)
h('Directory', c.t, c.p4)
ht('MatchParen', c.b3, c.t, bold)
h('SpecialKey', c.t, c.t)
hl('Folded', 'Disabled')
hl('NonText', 'Disabled')
hl('Whitespace', 'Disabled')
hl('Todo', 'Extra')
hl('Debug', 'Error')
hl('ComplHint', 'Hint')
hl('ComplHintMore', 'Info')

hl('debugPC', 'Warning')
hl('debugBreakpoint', 'Extra')

hl('DiagnosticOk', 'Ok')
hl('DiagnosticError', 'Error')
hl('DiagnosticWarn', 'Warning')
hl('DiagnosticInfo', 'Info')
hl('DiagnosticHint', 'Hint')
hl('DiagnosticUnnecessary', 'Disabled')


h('NormalFloat', c.b2, c.t)
h('FloatBorder', c.b2, c.b2)
hl('FloatTitle', 'Title')
hl('FloatFooter', 'Title')

h('WildMenu', c.t, c.t)

h('PMenu', c.b2, c.f2) -- Normal item.
h('PMenuSel', c.b3, c.t) -- Selected item. Combined with |hl-Pmenu|.
ht('PmenuKind', c.b2, c.f2, italic) -- Normal item 'kind'.
ht('PmenuKindSel', c.b3, c.f2, italic) -- Selected item 'kind'.
ht('PmenuExtra', c.b2, c.f2, italic) -- Normal item 'extra text'.
ht('PmenuExtraSel', c.b3, c.f2, italic) -- Selected item 'extra text'.
h('PMenuSbar', c.b2, c.b2) -- Scrollbar.
h('PmenuThumb', c.b3, c.b3) -- Thumb of the scrollbar.
h('PmenuMatch', c.t, c.f1) -- Matched text in normal item. Combined with |hl-Pmenu|.
h('PmenuMatchSel', c.t, c.f1)
h('ComplMatchIns', c.t, c.f3)
hl('PreInsert', 'ComplMatchIns')



h('Visual', c.b3, c.t)
ht('Search', c.b3, c.t, bold)
ht('CurSearch', c.f3, c.t, bold)
ht('IncSearch', c.f3, c.t)
ht('Substitute', c.b3, c.t, bold)

ht('SpellBad', c.t, c.t, underline_italic)
ht('SpellCap', c.t, c.t, underline)
ht('SpellLocal', c.t, c.t, underline)
ht('SpellRare', c.t, c.t, underline)

hl('ErrorMsg', 'Error')
hl('WarningMsg', 'Warning')


hl('@error', 'Error')

ht('Comment', c.t, c.f3, italic)
hl('@comment', 'Comment')
hl('@comment.documentation', '@comment')
ht('@comment.error', c.t, c.p1, bold)
ht('@comment.warning', c.t, c.p2, bold)
ht('@comment.hint', c.t, c.p5, bold)
ht('@comment.todo', c.t, c.p6, bold)
ht('@comment.note', c.t, c.p4, bold)

h('Special', c.t, c.t)
hl('SpecialComment', 'Special')
hl('SpecialChar', 'Special')
hl('@character.special', 'SpecialChar')
hl('Operator', 'Special')
hl('@operator', 'Operator')
hl('Delimiter', 'Special')
hl('@punctuation.delimiter', 'Delimiter')
hl('@punctuation.bracket', 'Special')
hl('@punctuation.special', 'Special')
hl('@string.special', 'Special')
hl('@string.regexp', '@string.special')
hl('@string.escape', '@string.special')
hl('@string.special.symbol', 'string.special')
hl('@string.special.path', '@string.special')
ht('@string.special.url', c.t, c.t, underline)
hl('@label', 'Special')
hl('@constructor', 'Special')

h('Macro', c.t, c.p3)
hl('PreProc', 'Macro')
hl('PreCondit', 'Macro')
hl('@attribute', 'Macro')
hl('@attribute.builtin', '@attribute')
hl('@constant.macro', 'Macro')
hl('@function.macro', 'Macro')
hl('Tag', 'PreProc')
hl('@tag', 'Tag')
hl('@tag.builtin', '@tag')
hl('@tag.delimiter', '@tag')
hl('@lsp.type.macro', 'Macro')
hl('@keyword.directive', 'Macro')

h('Statement', c.t, c.p6)
hl('Structure', 'Statement')
hl('StorageClass', 'Statement')
hl('Label', 'Statement')
hl('Repeat', 'Statement')
hl('Conditional', 'Statement')
hl('Exception', 'Statement')
hl('Tyepedef', 'Statement')
hl('Keyword', 'Statement')
hl('@keyword', 'Keyword')
hl('@keyword.coroutine', '@keyword')
hl('@keyword.function', '@keyword')
hl('@keyword.operator', '@keyword')
hl('@keyword.import', '@keyword')
hl('@keyword.type', '@keyword')
hl('@keyword.modifier', '@keyword')
hl('@keyword.repeat', '@keyword')
hl('@keyword.return', '@keyword')
hl('@keyword.debug', '@keyword')
hl('@keyword.exception', '@keyword')
hl('@keyword.conditional', '@keyword')
hl('@keyword.conditional.ternary', '@keyword')
hl('@keyword.export', '@keyword')
hl('Include', 'Statement')
hl('Define', 'Include')
hl('@keyword.directive.define', 'Include') -- define, include => can be preproc
hl('sqlKeyword', 'Statement')

h('Function', c.t, c.p1)
hl('@function', 'Function')
hl('@function.builtin', '@function')
hl('@function.call', '@function')
hl('@function.method', '@function')
hl('@function.method.call', '@function')
hl('@tag.attribute', '@function')

h('Identifier', c.t, c.t)
hl('@variable', 'Identifier')
hl('@variable.builtin', '@variable')
hl('@variable.parameter', '@variable')
hl('@variable.parameter.builtin', '@variable')
hl('@variable.member', '@variable')
hl('@property', '@variable')
hl('@lsp.type.selfKeyword', 'Identifier')
hl('@lsp.type.static', 'Identifier')

h('Constant', c.t, c.p4)
hl('@constant', 'Constant')
hl('@constant.builtin', '@constant')
hl('@constant.builtin.macro', '@constant')
hl('Boolean', 'Constant')
hl('@boolean', 'Boolean')
hl('Number', 'Constant')
hl('@number', 'Number')
hl('Float', 'Constant')
hl('@number.float', 'Float')
hl('Character', 'Constant')
hl('@character', 'Character')
hl('String', 'Constant')
hl('@string', 'String')
hl('@string.documentation', '@string')

h('Type', c.t, c.p5)
hl('@type', 'Type')
hl('@type.builtin', '@type')
hl('@type.definition', '@type')
hl('@lsp.type.namespace', 'Type')
hl('@module', 'Type')
hl('@module.builtin', '@module')

h('DiffText', c.t, c.t)
h('DiffAdd', c.b3, c.p3)
h('DiffDelete', c.b3, c.p1)
h('DiffChange', c.b3, c.p5)
hl('@diff.plus', 'DiffAdd')
hl('@diff.minus', 'DiffDelete')
hl('@diff.delta', 'DiffChange')

h('@markup', c.t, c.t)
ht('@markup.strong', c.t, c.t, bold)
ht('@markup.italic', c.t, c.t, italic)
ht('@markup.strikethrough', c.t, c.t, strikethrough)
ht('@markup.underline', c.t, c.t, underline)
ht('@markup.heading', c.t, c.t, bold)
hl('@markup.heading.1', '@markup.heading')
hl('@markup.heading.2', '@markup.heading')
hl('@markup.heading.3', '@markup.heading')
hl('@markup.heading.4', '@markup.heading')
hl('@markup.heading.5', '@markup.heading')
hl('@markup.heading.6', '@markup.heading')
h('@markup.quote', c.t, c.t)
h('@markup.math', c.t, c.t)
hl('@markup.link.label', '@markup')
ht('@markup.link', c.t, c.t, underline)
hl('@markup.link.url', '@markup.link')
h('@markup.raw', c.t, c.t)
h('@markup.raw.block', c.t, c.t)
h('@markup.list', c.t, c.t)
h('@markup.list.checked', c.t, c.f3)
h('@markup.list.unchecked', c.t, c.t)
hl('@markup.environment', '@markup')
hl('@markup.environment.name', '@markup')

hl('@markup.heading.html', '@markup')
hl('@markup.heading.1.html', '@markup')
hl('@markup.heading.2.html', '@markup')
hl('@markup.heading.3.html', '@markup')
hl('@markup.heading.4.html', '@markup')
hl('@markup.heading.5.html', '@markup')
hl('@markup.heading.6.html', '@markup')

hl('@markup.heading.markdown', '@markup.heading')
hl('@markup.heading.1.markdown', '@markup.heading.markdown')
hl('@markup.heading.2.markdown', '@markup.heading.markdown')
hl('@markup.heading.3.markdown', '@markup.heading.markdown')
hl('@markup.heading.4.markdown', '@markup.heading.markdown')
hl('@markup.heading.5.markdown', '@markup.heading.markdown')
hl('@markup.heading.6.markdown', '@markup.heading.markdown')
ht('@markup.list.markdown', c.t, c.p6, bold)
h('@markup.raw.markdown_inline', c.t, c.p4)
ht('@markup.strong.markdown_inline', c.t, c.p3, bold)
ht('@markup.italic.markdown_inline', c.t, c.p5, italic)


--customs
hl('@property.css', '@keyword')
hl('@property.json', '@keyword')
