local v, api, opt, key, con = vim, vim.api, vim.opt, vim.keymap.set, table.concat

require('vim._core.ui2').enable({})

-- options
opt.cpoptions = 'aABceFs_'
opt.autoread = true
opt.splitright = true
opt.shortmess = 'aoOstTIcCF'
opt.whichwrap = 'hlbs<>[]'
opt.clipboard = 'unnamedplus'
opt.lazyredraw = true
-- opt.guicursor = 'a:block'
opt.mouse = 'ar'
opt.mousefocus = true
opt.confirm = true
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true
opt.showmode = false
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = 'number'
opt.scrolloff = 3
opt.sidescrolloff = 12

-- tab
opt.smartindent = true
opt.shiftround = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- search
opt.inccommand = 'split'

-- completion
opt.autocomplete = true
opt.pumheight = 6
opt.complete = { '.', 'w', 'b', 'kspell', 'i', 't', 'f' } -- '.,w,b'
opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' } -- fuzzy.nosort
opt.wildoptions = { 'pum', 'tagfile', 'fuzzy' }
opt.wildignorecase = true
opt.wildignore = '*.o,*.obj,*.exe,*.pdf'

local has_word = function()
  local line, col = unpack(api.nvim_win_get_cursor(0))
  return col ~= 0 and api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

key('i', '<Tab>', function()
  if v.fn.pumvisible() == 1 then return '<C-n>'
  elseif has_word() then
    if v.bo.omnifunc ~= '' then return '<C-x><C-o>'
    else return '<C-n>' end
  else return '<Tab>' end
end, { expr = true, silent = true })

-- symbols
opt.list = true
opt.showbreak = '¬'
opt.listchars = { tab = '› ', trail = '🞄', nbsp = '␣' }
opt.fillchars = { eob = ' ', fold = ' ', lastline = ' ' }
-- opt.fillchars = { vert = ' ', vertleft = ' ', vertright = ' ', verthoriz = ' ', horiz = ' ', horizup = ' ', horizdown = ' ' }

opt.swapfile = false
opt.updatecount = 0
opt.shada = ''
opt.shadafile = ''
opt.backup = false
opt.undoreload = 0
opt.undofile = false

-- Spell
opt.spelllang = { 'tr', 'en_us', 'en_gb' }
opt.spelloptions = { 'camel' }
opt.spellsuggest = { 'best', '6' }
opt.spellcapcheck = ''
opt.spell = false

-- fold
opt.foldmethod = 'indent'
opt.foldlevelstart = 99
opt.foldtext = 'v:lua.OzFold()'
function OzFold()
  return con {
    api.nvim_buf_get_lines(0, v.v.foldstart - 1, v.v.foldstart, false)[1],
    ' => ',
    v.v.foldend - v.v.foldstart + 1
  }
end


-- keymaps
v.g.mapleader = ' '
v.g.maplocalleader = ' '
key({ 'n', 'v' }, '<leader>', '<Nop>', { silent = true })
local float_set = { max_width = 72, border = 'single' }
local opts = { noremap = true, silent = true, nowait = true }

key('n', '<leader><Tab>', '<cmd>b#<CR>')
key('n', '<leader>n', '<cmd>bn<CR>')
key('n', '<leader>p', '<cmd>bp<CR>')
for i=1, 9, 1 do key('n', con{ '<leader>', i }, con{ '<cmd>b', i, '<CR>' }, opts) end

key('n', '<leader>h', '<C-w><C-h>')
key('n', '<leader>j', '<C-w><C-j>')
key('n', '<leader>k', '<C-w><C-k>')
key('n', '<leader>l', '<C-w><C-l>')
key('n', '<leader>v', '<C-w><C-v>')

key('n', '<leader>s', '<cmd>w<CR>', opts)
key('n', '<leader>q', '<cmd>bd<CR>', opts)
key('n', '<leader>e', '<cmd>TogExplorer<CR>', opts)
key('n', '<leader>w', '<cmd>set spell!<CR>', opts )
key('n', '<leader>t', '<cmd>ToggleBackground<CR>', opts)

key('n', '<leader>gd', v.lsp.buf.definition, opts)
key('n', '<leader>gt', v.lsp.buf.type_definition, opts)
key('n', '<leader>gr', v.lsp.buf.references, opts)
key('n', '<leader>gi', v.lsp.buf.implementation, opts)
key('n', '<leader>gk', function() v.lsp.buf.hover(float_set) end, opts)
key('n', '<leader>gh', v.lsp.buf.signature_help, opts)
key('n', '<leader>gc', v.lsp.buf.rename, opts)
key('n', '<leader>ga', v.lsp.buf.code_action, opts)
key('n', '<leader>gf', '<cmd>FormatBuf<CR>', opts)
key('n', '<leader>ge', function() v.diagnostic.open_float(float_set) end, opts)
key('n', '<leader>gp', function() v.diagnostic.jump({ count = -1, float = true }) end, opts)
key('n', '<leader>gn', function() v.diagnostic.jump({ count = 1, float = true }) end, opts)

key('n', '<Esc>', '<cmd>nohlsearch<CR>', { nowait = true })


-- lsp
v.lsp.enable {
  'bashls',
  'clangd',
  'cssls',
  'dockerls',
  'eslint',
  'gopls',
  'html',
  'jsonls',
  'just',
  'luals',
  'marksman',
  'nixd',
  'rust-analyzer',
  'sqls',
  'texlab',
  'tsls',
  'ty',
  'yamlls',
}

v.diagnostic.config({
  update_in_insert = false,
  underline = true,
  signs = false,
  severity_sort = true,
  float = { source = 'if_many' },
  virtual_text = {
    severity = { min = v.diagnostic.severity.WARN },
    spacing = 2,
    source = 'if_many',
    prefix = '🞄',
  }
})

api.nvim_create_autocmd('LspAttach', {
  group = api.nvim_create_augroup('my.lsp', { clear = true }),
  callback = function(args)
    local client = v.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end

    if client:supports_method 'textDocument/completion' then
      v.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method 'textDocument/foldingRange' then
      v.opt_local.foldmethod = 'expr'
      v.opt_local.foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    if client:supports_method 'textDocument/formatting'
      and not client:supports_method 'textDocument/willSaveWaitUntil' then
      api.nvim_buf_create_user_command( args.buf, 'FormatBuf', function()
        v.lsp.buf.format { bufnr = args.buf, id = client.id, timeout_ms = 1000 }
      end, {})
    end
  end,
})


-- tree-sitter
api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local has_ts, _ = pcall(v.treesitter.start, args.buf)
    if has_ts then
      v.opt_local.foldmethod = 'expr'
      v.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  end
})

local reg = v.treesitter.language.register
reg('bash', { 'sh' })
reg('json', { 'jsonc' })
reg('sway', { 'swayconfig' })
reg('ini', { 'dosini', 'conf' })
