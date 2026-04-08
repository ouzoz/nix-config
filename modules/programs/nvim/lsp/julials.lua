return {
    filetypes = { 'julia' },
    cmd = {
        "julia",
        "--project=~/.julia/environments/lsp",
        "--startup-file=no",
        "--history-file=no",
        "-e",
        "using LanguageServer; runserver()",
    },
    settings = {
        julia = {
            format = {
                indent = 4,
            },
        },
    },
    root_markers = {
        'Project.toml',
        'JuliaProject.toml',
        '.git',
        'Makefile'
    }
}
