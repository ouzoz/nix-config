return {
    filetypes = { 'go', 'gomod', 'gowwork', 'gotmpl' },
    cmd = { 'gopls' },
    root_markers = {
        'go.mod',
        '.git',
        'Makefile'
    },
    settings = {
        gopls = {
            semanticTokens = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
}
