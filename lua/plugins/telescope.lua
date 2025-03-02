local tb       = function() return require("telescope.builtin") end

local kb       = require('config.keybinds')
local find     = kb.Groups.find
local lsp      = kb.Groups.lsp

local keybinds = {
    -- find
    find:bind('f', function() tb().find_files() end, "[F]iles"),
    find:bind('g', function() tb().grep_string() end, "[G]rep"),
    find:bind('b', function() tb().buffers() end, "[B]uffers"),
    find:bind('c', function() tb().commands() end, "[C]ommands"),
    find:bind('j', function() tb().jumplist() end, "[J]umplist"),
    find:bind('k', function() tb().keymaps() end, "[k]keymaps"),
    find:bind('H', function() tb().help_tags() end, "[H]help tags"),
    -- LSP
    lsp:bind('r', function() tb().lsp_references() end, "[R]eferences"),
    lsp:bind('d', function() tb().lsp_definitions() end, "[D]efinitions"),
    lsp:bind('D', function() tb().lsp_diagnostics() end, "[D]iagnostics"),
}

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = keybinds,
}
