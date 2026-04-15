return {
  filetypes = {
    'c',
    'cpp',
    'cuda',
  },
  cmd = { 'clangd' },
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true
      }
    }
  },
  get_language_id = function(_, ftype)
    local t = { objc = 'objective-c', objcpp = 'objective-cpp', cuda = 'cuda-cpp' }
    return t[ftype] or ftype
  end,
  root_markers = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git',
    'Makefile'
  },
}
