local v, api, opt, key, con = vim, vim.api, vim.opt, vim.keymap.set, table.concat

v.g.mapleader = " "
v.g.maplocalleader = " "
key({ "n", "v" }, "<leader>", "<Nop>", { silent = true })
local float_set = { max_width = 72, border = "single" }
local opts = { noremap = true, silent = true, nowait = true }

key("n", "<Leader>a", ":!just<CR>")
key("n", "<Leader><CR>", ":!just<CR>")

key("n", "<leader><Tab>", "<cmd>b#<CR>")
key("n", "<leader>n", "<cmd>bn<CR>")
key("n", "<leader>p", "<cmd>bp<CR>")
for i = 1, 9, 1 do
  key("n", con { "<leader>", i }, con { "<cmd>b", i, "<CR>" }, opts)
end

key("n", "<leader>h", "<C-w><C-h>")
key("n", "<leader>j", "<C-w><C-j>")
key("n", "<leader>k", "<C-w><C-k>")
key("n", "<leader>l", "<C-w><C-l>")
key("n", "<leader>v", "<C-w><C-v>")

key("v", "<leader>s", ":sort<CR>", opts)
key("n", "<leader>s", "<cmd>w<CR>", opts)
key("n", "<leader>q", "<cmd>bd<CR>", opts)
key("n", "<leader>x", "<cmd>qa<CR>", opts)
key("n", "<leader>w", "<cmd>set spell!<CR>", opts)
key("n", "<leader>t", "<cmd>ToggleBackground<CR>", opts)

key("n", "<leader>gd", v.lsp.buf.definition, opts)
key("n", "<leader>gt", v.lsp.buf.type_definition, opts)
key("n", "<leader>gr", v.lsp.buf.references, opts)
key("n", "<leader>gi", v.lsp.buf.implementation, opts)
key("n", "<leader>gk", function () v.lsp.buf.hover(float_set) end, opts)
key("n", "<leader>gh", v.lsp.buf.signature_help, opts)
key("n", "<leader>gc", v.lsp.buf.rename, opts)
key("n", "<leader>ga", v.lsp.buf.code_action, opts)
key("n", "<leader>f", "<cmd>FormatBuf<CR>", opts)
key("n", "<leader>ge", function () v.diagnostic.open_float(float_set) end, opts)
key("n", "<leader>gp", function () v.diagnostic.jump { count = -1, float = true } end, opts)
key("n", "<leader>gn", function () v.diagnostic.jump { count = 1, float = true } end, opts)

key("n", "<Esc>", "<cmd>nohlsearch<CR>", { nowait = true })
