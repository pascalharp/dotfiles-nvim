local M = {}

local kb = require("config.keybinds")
local win = kb.Groups.window

local binds = {
    -- swap between windows
    { '<C-h>', '<C-w>h', desc = "Switch to left split" },
    { '<C-j>', '<C-w>j', desc = "Switch to bottom split" },
    { '<C-k>', '<C-w>k', desc = "Switch to top split" },
    { '<C-l>', '<C-w>l', desc = "Switch to right split" },
    -- split windows
    win:gen({'v','<cmd>vsplit<cr>', desc = '[V]ertical split'}),
    win:gen({'h','<cmd>split<cr>',desc = '[H]orizontal split'}),
    win:gen({'q','<cmd>q<cr>', desc = '[Q]uit window'}),
}

function M.setup()
    for _, value in pairs(binds) do
        kb.set(value)
    end
end

return M
