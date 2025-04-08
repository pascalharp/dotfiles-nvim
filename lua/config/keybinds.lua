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

-- Keybind Groups
-- These should have which key tbl setup
M.Groups = {
    root = { '<leader>', group = 'root' },
    lsp = {
        '<leader>l',
        group = '[L]sp',
        cond = function ()
            return true
        end},
    find = { '<leader>f', group = '[F]ind' },
    flash = { '<leader><leader>', group = 'Flash' },
    window = { '<leader>w', group = '[W]indows'},
}

function M.group_bind(group, key, fn, mode, desc)
    return { group[1] .. key, fn, mode = mode or 'n', desc = desc or "" }
end

function M.group_gen_from_tbl(group, params)
    params[1] = group[1] .. params[1]
    return params
end

function M.group_gen_from_fn(group, lhs, rhs, desc, opts)
    local params = {}
    params[1] = group[1] .. lhs
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
        params = M.group_gen_from_tbl(group, args)
    elseif type(args[1]) == "string" then
        lhs = args[1] or error("Empty left-hand side")
        rhs = args[2] or ':lua print("no rhs for keybind")'
        desc = args[3] or ''
        opts = args[4] or {}
        params = M.group_gen_from_fn(group, lhs, rhs, desc, opts)
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
        local tbl = vim.deepcopy(self)
        tbl.bind = nil
        tbl.gen = nil
        tbl.spec = nil
        return tbl
    end
end

return M
