local api = vim.api

UTILS = {}
local M = UTILS


function M.get_buf_color(buf)
    return buf.hidden == 1
        and (buf.changed == 1 and 'OzBufHiddenChanged' or 'OzBufHidden')
        or buf.changed == 1 and 'OzBufChanged' or 'OzBuf'
end


M.Float = setmetatable({
    conf = {
        pad = { x = 5, y = 1 }
    }
}, {
    __call = function(self, name)
        local float = setmetatable({
            name = name,
            state = { buf = -1, win = -1, win_caller = -1, buf_caller = -1 }
        }, {
            __index = self
        })

        api.nvim_create_user_command( 'Tog' .. name, function() float:tog() end, {})
        return float
    end
})

function M.Float:tog()
    if self:win_close() then return end

    self.state.win_caller = api.nvim_get_current_win()
    self.state.buf_caller = api.nvim_get_current_buf()

    if not api.nvim_buf_is_valid(self.state.buf) then
        self.state.buf = api.nvim_create_buf(false, true)

        local map_opts = { noremap = true, nowait = true, silent = true, buffer = self.state.buf }
        vim.keymap.set('n', '<ESC>', function() self:win_close() end, map_opts)
        api.nvim_set_option_value('filetype', self.name, { buf = self.state.buf })

        if self.on_init then
            self:on_init()
        end
    end

    self:win_create()

    if self.on_open then
        self:on_open()
    end
end

function M.Float:win_close()
    if api.nvim_win_is_valid(self.state.win) then
        api.nvim_win_close(self.state.win, true)
        return true
    end

    return false
end

function M.Float:win_create()
    self.state.win = api.nvim_open_win(self.state.buf, true, {
        relative = 'editor',
        width = vim.o.columns - self.conf.pad.x * 2 - 2,
        height = vim.o.lines - self.conf.pad.y * 2 - 4,
        col = self.conf.pad.x,
        row = self.conf.pad.y,
        border = 'single',
    })

    api.nvim_set_option_value('number', false, { win = self.state.win })
    api.nvim_set_option_value('relativenumber', false, { win = self.state.win })
    api.nvim_set_option_value('cursorlineopt', 'line', { win = self.state.win })
end


require 'oz.set'
require 'oz.colorscheme'
require 'oz.statusline'
require 'oz.pattern'
require 'oz.explorer'
