return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
    'htmlangular',
  },
  root_markers = {
    'package-lock.json',
    'yarn.lock',
    'pnpm-lock.yaml',
    'bun.lockb',
    'bun.lock'
  },
  settings = {
    validate = 'on',
    packageManager = nil,
    useESLintClass = false,
    codeActionOnSave = { enable = false, mode = 'all', },
    format = true,
    quiet = false,
    onIgnoredFiles = 'off',
    run = 'onType',
    problems = { shortenToSingleLine = false, },
    nodePath = '',
    workingDirectory = { mode = 'auto' },
    codeAction = {
      disableRuleComment = { enable = true, location = 'separateLine', },
      showDocumentation = { enable = true, },
    },
  },
}
