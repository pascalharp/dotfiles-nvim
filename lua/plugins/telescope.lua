local tb       = function() return require("telescope.builtin") end

local find     = "<leader>f"
local lsp      = "<leader>l"

local keybinds = {
    -- find
    { find .. "f", function() tb().find_files() end,      desc = "[F]iles" },
    { find .. "g", function() tb().grep_string() end,     desc = "[G]rep" },
    { find .. "b", function() tb().buffers() end,         desc = "[B]uffers" },
    { find .. "c", function() tb().commands() end,        desc = "[C]ommands" },
    { find .. "j", function() tb().jumplist() end,        desc = "[J]umplist" },
    { find .. "k", function() tb().keymaps() end,         desc = "[k]keymaps" },
    { find .. "H", function() tb().help_tags() end,       desc = "[H]help tags" },
    -- LSP
    { lsp .. "r",  function() tb().lsp_references() end,  desc = "[R]eferences" },
    { lsp .. "d",  function() tb().lsp_definitions() end, desc = "[D]efinitions" },
    { lsp .. "D",  function() tb().lsp_diagnostics() end, desc = "[D]iagnostics" },
}

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = keybinds,
}
