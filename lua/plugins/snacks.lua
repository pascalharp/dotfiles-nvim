return {
  src = "https://github.com/folke/snacks.nvim",
  data = {
    setup = function()
      require("snacks").setup({
        bigfile = { enable = true },
        explorer = { enable = true },
        indent = { enable = true },
        input = { enable = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = { enbled = true }
      })

      local kb = require("utils/keybinds")
      local snacks = require("snacks")

      -- Explorer
      kb.root:set("n", "e", function() snacks.explorer() end, { desc = "Explorer" })
      -- Terminal
      kb.root:set("n", "<cr>", function() snacks.terminal.toggle() end, { desc = "Terminal" })
      -- Pickers
      kb.find:set("n", "f", function() snacks.picker.files() end, { desc = "Files" })
      kb.find:set("n", "p", function() snacks.picker() end, { desc = "Pickers" })
      kb.find:set("n", "b", function() snacks.picker.buffers() end, { desc = "Buffers" })
      kb.find:set("n", "/", function() snacks.picker.grep() end, { desc = "Grep" })

      -- LSP
      local misc = require("utils/misc")
      misc:on_lsp_attach("lsp_snacks", function(args)
        kb.lsp:set("n", "s", function() snacks.picker.lsp_symbols() end, { desc = "Symbols", buffer = args.buf })
        kb.lsp:set("n", "d", function() snacks.picker.lsp_definitions() end, { desc = "Definitions", buffer = args.buf })
        kb.lsp:set("n", "D", function() snacks.picker.lsp_declarations() end,
          { desc = "Declarations", buffer = args.buf })
        kb.lsp:set("n", "R", function() snacks.picker.lsp_references() end, { desc = "References", buffer = args.buf })
        kb.lsp:set("n", "i", function() snacks.picker.lsp_implementations() end,
          { desc = "Implementations", buffer = args.buf })
      end)
    end
  }
}
