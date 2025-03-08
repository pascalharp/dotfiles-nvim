local default_opts = {
    silent = true,
    noremap = true,
}

-- Core, non plugins speciic, keybinds
local binds = {
    -- swap between windows
    { lhs = '<C-h>', rhs = '<C-w>h' },
    { lhs = '<C-j>', rhs = '<C-w>j' },
    { lhs = '<C-k>', rhs = '<C-w>k' },
    { lhs = '<C-l>', rhs = '<C-w>l' },
    -- split windows
    {lhs = '<leader>wv', rhs = '<cmd>vsplit<cr>', opts = { desc = '[V]ertical split'}},
    {lhs = '<leader>wh', rhs = '<cmd>split<cr>', opts = { desc = '[H]orizontal split'}},
    {lhs = '<leader>wq', rhs = '<cmd>q<cr>', opts = { desc = '[Q]uit window'}},
}

local M = {}

-- Keybind Groups accessed thorough leader
M.Groups = {
    lsp = { key = 'l', desc = '[L]sp' },
    find = { key = 'f', desc = '[F]ind' },
    hop = { key = '<leader>', desc = '[H]op' },
    window = { key = 'w', desc = '[W]indows'},
}

--@type group M.Groups
--@type key string
--@type fn function
--@type desc string
function M.group_bind(group, key, fn, desc, mode)
    return { '<leader>' .. group.key .. key, fn, mode = mode or 'n', desc = desc or "" }
end

-- setup core keybinds
function M.setup()
    for _, v in pairs(binds) do
        M.set_from_dict(v)
    end
end

-- helper function to set keymap from dict
-- format: {
-- mode = str or string[],      default 'n'
-- lhs = string,                default ''
-- rhs = string or function,    default '<cmd>lua print("Keybind empty")'
-- opts = vim.keymaps.set.Opts, extends default { silent = true, noremap = true }
-- }
function M.set_from_dict(tbl)
    local mode = tbl.mode or 'n'
    local lhs = tbl.lhs or ''
    local rhs = tbl.rhs or '<cmd>lua print("Keybind empty")'
    local opts = vim.tbl_extend('force', default_opts, tbl.opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- add enum functions for convenience
for _, group in pairs(M.Groups) do
    group.bind = function(self, key, fn, desc, mode)
        return M.group_bind(self, key, fn, desc, mode)
    end
    group.spec = function(self)
        return { '<leader>' .. self.key, desc = self.desc }
    end
end

return M
