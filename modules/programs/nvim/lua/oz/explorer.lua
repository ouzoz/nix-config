local u = UTILS
local api = vim.api
local uv = vim.uv
local fs = vim.fs
local fn = vim.fn
local key = vim.keymap.set
local con = table.concat

local M = u.Float('Explorer')
M.ns = api.nvim_create_namespace('ExLine')

function M:add_line(text, color)
  local line = #self.lines
  self.lines[line+1] = text
  self.hls[#self.hls+1] = {
    row = line,
    col = 0,
    opts = {
      end_row = line,
      end_col = #self.lines[line+1],
      hl_group = color
    }
  }
end

function M:on_init()
  local map_opts = { noremap = true, nowait = true, silent = true, buffer = self.state.buf }
  key('n', '<CR>', function() self:open_clicked() end, map_opts)
  key('n', '<RightMouse>', function()
    api.nvim_feedkeys(api.nvim_replace_termcodes('<LeftMouse>', true, false, true), 'n', false)
    vim.defer_fn(function() self:open_clicked() end, 10)
  end, map_opts)
  key('n', 'q', function() self:del_clicked() end, map_opts)
end

function M:on_open()
  api.nvim_set_option_value('readonly', false, { buf = self.state.buf })
  api.nvim_set_option_value('modifiable', true, { buf = self.state.buf })

  api.nvim_buf_clear_namespace(self.state.buf, self.ns, 0, -1)
  self.hls = {}
  self.lines = {}

  self:get_bufs()
  self.lines[#self.lines+1] = ''
  self:get_files()

  api.nvim_buf_set_lines(self.state.buf, 0, -1, false, self.lines)
  for _, hl in ipairs(self.hls) do
    api.nvim_buf_set_extmark(self.state.buf, self.ns, hl.row, hl.col, hl.opts)
  end

  api.nvim_set_option_value('modifiable', false, { buf = self.state.buf })
  api.nvim_set_option_value('readonly', true, { buf = self.state.buf })
end

function M:open_clicked()
  local line, _ = unpack(api.nvim_win_get_cursor(self.state.win))
  if line < #self.bufs + 1 then
    api.nvim_win_set_buf(self.state.win_caller, self.bufs[line].bufnr)
    self:tog()
  elseif line > #self.bufs + 1 then
    local file, _ = self:find_file(line - 2 - #self.bufs, 0, self.files)
    if file == nil then return end
    if file.is_dir then
      file.is_opened = not file.is_opened
      self:on_open()
    else
      if file.is_opened then return end
      vim.cmd('badd ' .. file.path)
      self:on_open()
      local row, col = unpack(api.nvim_win_get_cursor(self.state.win))
      if row < #self.lines then
        api.nvim_win_set_cursor(self.state.win, { row + 1, col })
      end
    end
  end
end

function M:del_clicked()
  local line, _ = unpack(api.nvim_win_get_cursor(self.state.win))
  if line > #self.bufs then return end

  api.nvim_buf_delete(self.bufs[line].bufnr, { force = false })
  self:on_open()
end

function M:get_bufs()
  self.bufs = fn.getbufinfo { buflisted = 1 }
  for _, buf in ipairs(self.bufs) do
    self:add_line(
      string.format('%-4d%-24s%-6d%s',
      buf.bufnr,
      fs.basename(buf.name),
      buf.linecount,
      fn.fnamemodify(buf.name, ':~:.')
    ),
    u.get_buf_color(buf)
  )
end
end

function M:print_file(file, indent)
  local type_data = file.is_dir and '* ' or ''
  self:add_line(
    con { string.rep(' ', indent * 2), type_data, ' ', file.name },
    u.get_buf_color { changed = file.is_dir and 1 or 0, hidden = file.is_opened and 0 or 1 }
  )
end

function M:get_files()
  local old = self.files
  local path = uv.cwd()
  self.files = {
    path = path,
    name = path,
    type = 'directory',
    is_dir = true,
    is_opened = (old == nil) or old.is_opened,
  }
  self:print_file(self.files, 0)
  self:file_tree(self.files, old, 1)
end

function M:file_tree(dir, old, indent)
  dir.dirs = {}
  dir.childs = {}
  local dir_data = uv.fs_scandir(dir.path)
  if not dir_data then return end
  while true do
    local name, type = uv.fs_scandir_next(dir_data)
    if not name then break end

    local child = {
      path = dir.path .. '/' .. name,
      name = name,
      type = type,
      is_dir = type == 'directory'
    }
    dir.childs[#dir.childs+1] = child

    if child.is_dir then
      dir.dirs[name] = child
      child.is_opened =
      (old ~= nil)
      and (old.dirs ~= nil)
      and (old.dirs[child.name] ~= nil)
      and (old.dirs[child.name].is_opened == true)
    else
      local bufnr = fn.bufnr(child.path)
      child.is_opened = bufnr ~= -1 and api.nvim_get_option_value('buflisted', { buf = bufnr }) == 1
    end
  end

  table.sort(dir.childs, function(a, b)
    if a.type ~= b.type then
      if a.is_dir then return true end
      if b.is_dir then return false end
      if not a.type then return false end
      if not b.type then return true end
      return a.type:lower() < b.type:lower()
    end
    return a.name:lower() < b.name:lower()
  end)

  for _, v in ipairs(dir.childs) do
    self:print_file(v, indent)
    if v.is_dir and v.is_opened then
      self:file_tree(v, old and old.dirs and old.dirs[v.name], indent + 1)
    end
  end
end

function M:find_file(index, depth, current)
  if index == depth then return current, depth end
  if current.is_opened then
    for _, cur_child in ipairs(current.childs) do
      local file
      file, depth = self:find_file(index, depth + 1, cur_child)
      if file ~= nil then return file, depth end
    end
  end
  return nil, depth
end
