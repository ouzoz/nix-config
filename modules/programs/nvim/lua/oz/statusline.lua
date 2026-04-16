local next, con, u, v, api, sev = next, table.concat, UTILS, vim, vim.api, vim.diagnostic.severity
local col = function (color) return con { '%#', color, '#' } end
local sym = function (color, num) return not num and '' or con { col(color), '🞄', num, ' ' } end

v.opt.laststatus = 3
v.opt.statusline = '%!v:lua.OzStatusline()'
api.nvim_create_autocmd({
  'WinEnter', 'BufEnter', 'BufWritePost', 'LspAttach', 'LspDetach', 'DiagnosticChanged', 'VimResized'
}, { callback = function() vim.cmd 'redrawstatus' end })

local modes = {
  i       = con { col 'OzStatModeI', ' I ' },
  ic      = con { col 'OzStatModeI', ' I ' },
  v       = con { col 'OzStatModeV', ' V ' },
  V       = con { col 'OzStatModeV', ' V ' },
  ['\22'] = con { col 'OzStatModeV', ' V ' },
  c       = con { col 'OzStatModeC', ' C ' },
  n       = con { col 'OzStatModeN', ' N ' }
}

local function diagnostics(bufnr)
  if #v.lsp.get_clients { bufnr = bufnr } < 1 then return '' end

  local diags = v.diagnostic.count(bufnr)
  return next(diags) and con {
    sym('DiagnosticError', diags[sev.ERROR]),
    sym('DiagnosticWarn', diags[sev.WARN]),
    sym('DiagnosticInfo', diags[sev.INFO]),
    sym('DiagnosticHint', diags[sev.HINT])
  } or sym('DiagnosticOk', '')
end

function OzStatusline()
  local bufnr = api.nvim_get_current_buf()

  local buffers = {}
  for i, b in ipairs(v.fn.getbufinfo { buflisted = 1 }) do
    buffers[i] = con {
      col 'OzBuf', ' ', b.bufnr, ':',
      col(u.get_buf_color(b)), v.fn.fnamemodify(b.name, ':p:.')
    }
  end

  return con {
    con(buffers),
    v.diagnostic.status(bufnr),
    '%=%=',
    diagnostics(bufnr),
    '%*%L:%l-%{strdisplaywidth(getline(\'.\'))}:%v',
    modes[api.nvim_get_mode().mode] or modes.n
  }
end
