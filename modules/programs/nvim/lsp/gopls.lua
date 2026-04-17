return {
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  cmd = { 'gopls' },
  root_markers = {
    'go.mod',
    '.git',
    'Makefile'
  },
  settings = {
    gopls = {
      semanticTokens = true,
      usePlaceholders = true,
      staticcheck = true,
      gofumpt = true,
      analyses = { unusedparams = true },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
