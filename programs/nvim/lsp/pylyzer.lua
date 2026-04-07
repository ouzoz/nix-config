return {
    filetypes = {'python'},
    cmd = {'pylyzer', '--server'},
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace"
            },
            diagnostics = true,
            inlayHints = true,
            smartCompletion = true,
            checkOnType = false,
        },
    },
    root_markers = {
        'setup.py',
        'tox.ini',
        'requirements.txt',
        'Pipfile',
        'pyproject.toml',
        '.git',
        'Makefile'
    }
}
