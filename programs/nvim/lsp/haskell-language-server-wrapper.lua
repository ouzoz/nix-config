return {
    filetypes = { 'haskell', 'lhaskell' },
    cmd = { 'haskell-language-server-wrapper', '--lsp' },
    root_markers = {
        'hie.yaml',
        'stack.yaml',
        'cabal.project',
        '*.cabal',
        'package.yaml',
        '.git',
        'Makefile'
    },
    settings = {
        haskell = {
            formattingProvider = "ormolu",
            plugin = {
                class = { globalOn = true },
                importLens = { codeActionsOn = true },
                rename = { globalOn = true },
            },
        },
    },
}
