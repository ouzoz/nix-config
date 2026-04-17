return {
  filetypes = { 'lua' },
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
    },
  },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
    'Makefile',
  },
}
