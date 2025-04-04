local kb       = require('config.keybinds')
local find     = kb.Groups.find
local lsp      = kb.Groups.lsp
local root     = kb.Groups.root

local keybinds = {
    -- find
    find:bind('f', function() Snacks.picker.files() end, "[F]iles"),
    find:bind('g', function() Snacks.picker.grep() end, "[G]rep"),
    find:bind('b', function() Snacks.picker.buffers() end, "[B]uffers"),
    find:bind('c', function() Snacks.picker.command_history() end, "[C]ommand history"),
    find:bind('C', function() Snacks.picker.commands() end, "[C]ommands"),
    find:bind('j', function() Snacks.picker.jumps() end, "[J]umplist"),
    find:bind('k', function() Snacks.picker.keymaps() end, "[k]keymaps"),
    find:bind('H', function() Snacks.picker.help() end, "[H]help"),
    find:bind('m', function() Snacks.picker.marks() end, "[M]arks"),
    find:bind('i', function() Snacks.picker.icons() end, "[I]cons"),
    -- LSP
    lsp:bind('r', function() Snacks.picker.lsp_references() end, "[R]eferences"),
    lsp:bind('d', function() Snacks.picker.lsp_definitions() end, "[D]efinitions"),
    lsp:bind('D', function() Snacks.picker.lsp_declarations() end, "[D]eclarations"),
    -- explorer
    root:bind('\\', function() Snacks.explorer() end, "Explorer"),
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
  },
  keys = keybinds,
}
