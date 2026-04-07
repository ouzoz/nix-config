return {
    filetypes = { 'rust' },
    cmd = { 'rust-analyzer' },
    root_markers = {
        'Cargo.toml',
        '.git'
    },
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            checkOnSave = true,
            check = {
                command = "clippy",
            },
            procMacro = {
                enable = true
            },
            diagnostic = {
                enable = true,
            }
        }
    }
}
