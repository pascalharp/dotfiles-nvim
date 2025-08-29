local function keybinds()
  local kb     = require('config.keybinds')
  local find   = kb.Groups.find
  local root   = kb.Groups.root
  local snacks = require('snacks')

  return {
    -- find
    find:gen('f', function() snacks.picker.files() end, "[F]iles"),
    find:gen('g', function() snacks.picker.grep() end, "[G]rep"),
    find:gen('b', function() snacks.picker.buffers() end, "[B]uffers"),
    find:gen('c', function() snacks.picker.command_history() end, "[C]ommand history"),
    find:gen('C', function() snacks.picker.commands() end, "[C]ommands"),
    find:gen('j', function() snacks.picker.jumps() end, "[J]umplist"),
    find:gen('k', function() snacks.picker.keymaps() end, "[k]keymaps"),
    find:gen('H', function() snacks.picker.help() end, "[H]help"),
    find:gen('m', function() snacks.picker.marks() end, "[M]arks"),
    find:gen('i', function() snacks.picker.icons() end, "[I]cons"),
    find:gen('p', function() snacks.picker() end, "[P]icker"),
    -- explorer
    root:gen('\\', function() snacks.explorer() end, "Explorer"),
    -- terminal
    root:gen('t<cr>', function() snacks.terminal.toggle() end, "Toggle Terminal"),
  }
end

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
    terminal = { enabled = true },
  },
  keys = keybinds,
}
