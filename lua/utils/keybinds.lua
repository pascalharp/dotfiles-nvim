local KeybindGroup = {}
KeybindGroup.__index = KeybindGroup

function KeybindGroup:new(prefix, name, opts)
  local new_group = {
    prefix = prefix,
    name = name or prefix,
    opts = opts or {}
  }
  setmetatable(new_group, self)
  return new_group
end

function KeybindGroup:set(mode, lhs, rhs, opts)
  local final_lhs = self.prefix .. lhs
  local final_opts = vim.tbl_deep_extend("force", self.opts, opts or {})
  vim.keymap.set(mode, final_lhs, rhs, final_opts)
end

local default_opts = {
  noremap = true,
  silent = true,
}

local M = {}

M.core = KeybindGroup:new('', 'Core', default_opts)
M.root = KeybindGroup:new('<leader>', 'Root', default_opts)
M.find = KeybindGroup:new('<leader>f', 'Find', default_opts)
M.flash = KeybindGroup:new('<leader><leader>', 'Flash', default_opts)
M.windows = KeybindGroup:new('<leader>w', 'Windows', default_opts)
M.diagnostics = KeybindGroup:new('<leader>d', 'Diagnostics', default_opts)
M.lsp = KeybindGroup:new('<leader>l', 'Language Support', default_opts)

return M
