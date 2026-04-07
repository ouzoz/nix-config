local next = next
local con = table.concat
local align = '%='
local sev = vim.diagnostic.severity
local diag_count = vim.diagnostic.count
local get_clients = vim.lsp.get_clients
local name_modify = vim.fn.fnamemodify
local get_mode = vim.api.nvim_get_mode
local get_current_buf = vim.api.nvim_get_current_buf
local get_bufs = vim.fn.getbufinfo
local u = UTILS
local col = function (color) return con { '%#', color, '#' } end
local sym = function (color, num) return not num and '' or con { col(color), '🞄', num, ' ' } end

vim.opt.laststatus = 3
vim.opt.statusline = '%!v:lua.OzStatusline()'
vim.api.nvim_create_autocmd({
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

local function mode()
    return modes[get_mode().mode]
        or modes.n
end

local function position()
    return '%*%L:%l-%{strdisplaywidth(getline(\'.\'))}:%v'
end

local function diagnostics()
    local bufnr = get_current_buf()
    if #get_clients { bufnr = bufnr } < 1 then return '' end

    local diags = diag_count(bufnr)
    if not next(diags) then return sym('DiagnosticOk', '') end

    return con {
        sym('DiagnosticError', diags[sev.ERROR]),
        sym('DiagnosticWarn', diags[sev.WARN]),
        sym('DiagnosticInfo', diags[sev.INFO]),
        sym('DiagnosticHint', diags[sev.HINT])
    }
end

local function buffers()
    local res = {}
    for i, b in ipairs(get_bufs { buflisted = 1 }) do
        res[i] = con {
            col 'OzBuf',
            ' ', b.bufnr, ':',
            col(u.get_buf_color(b)),
            name_modify(b.name, ':p:.')
        }
    end
    return con(res)
end

function OzStatusline()
    return con {
        buffers(),
        align,
        align,
        diagnostics(),
        position(),
        mode()
    }
end
