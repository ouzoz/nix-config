return {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { '.git' },
  settings = {
    tinymist = {
      formatterMode = "typstyle",
      completion = {
        triggerOnSnippetPlaceholders = true,
      },
      lint = {
        enabled = true,
        when = "onType",
      },
      semanticTokens = "enable",
    },
  }
}
