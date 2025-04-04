local default_opts = {
--    mode = "n",
    silent = true,
    noremap = true,
}

-- Core, non plugins specific, keybinds
-- // TODO redo this
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

-- Keybind Groups accessed through leader
M.Groups = {
    root = { key = '', desc = 'root' },
    lsp = { key = 'l', desc = '[L]sp' },
    find = { key = 'f', desc = '[F]ind' },
    hop = { key = '<leader>', desc = '[H]op' },
    window = { key = 'w', desc = '[W]indows'},
}
function M.group_bind(group, key, fn, mode, desc)
    return { '<leader>' .. group.key .. key, fn, mode = mode or 'n', desc = desc or "" }
end

function M.group_gen_from_tbl(group, tbl)
    tbl[1] = '<leader>' .. group.key .. tbl[1]
end

function M.group_gen_from_fn(group, lhs, rhs, desc, opts)
    local params
    params[1] = '<leader>' .. group.key .. lhs
    params[2] = rhs
    params['desc'] = desc or ''
    if opts ~= nil then
        for k, v in pairs(opts) do
            params[k] = v
        end
    end
    return params
end

function M.group_gen(group, ...)
    local args = {...}
    local argCount = #args
    local params = {}
    if argCount == 1 and type(args[1]) == "table" then
        params = M.g
    elseif type(args[1]) == "string" then
        params[1] = args[1]
        params[2] = args[2] or ':lua print("no rhs for keybind")'
    end
    return vim.tbl_extend('force', default_opts, params)
end

-- sets they keybind.
-- Prefers setting via which-key
-- Fallback to core nvim api
function M.set(tbl)
    local ok, wk = pcall(require("which-key"))
    if ok then
        -- let which-key handle it
        wk.add(tbl)
    else
        -- transform to nvim api
        local lhs = tbl[1] or tbl["lhs"] or error("No lhs specified")
        local rhs = tbl[2] or tbl["rhs"] or error("No rhs specified")
        local mode = tbl["mode"] or "n"
        vim.keymap.set(mode, lhs, rhs, tbl)
    end
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
    group.gen = function(self, ...)
        return M.group_gen(self, ...)
    end
    group.spec = function(self)
        return { '<leader>' .. self.key, desc = self.desc }
    end
end

return M
