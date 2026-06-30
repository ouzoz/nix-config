-- tree-sitter
api.nvim_create_autocmd("FileType", {
  callback = function (args)
    local has_ts, _ = pcall(v.treesitter.start, args.buf)
    if has_ts then
      v.opt_local.foldmethod = "expr"
      v.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})

local reg = v.treesitter.language.register
reg("bash", { "sh" })
reg("json", { "jsonc" })
reg("sway", { "swayconfig" })
reg("ini", { "dosini", "conf" })
