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
			-- Pickers
			kb.find:set("n", "f", function() snacks.picker.files() end, { desc = "Files" })
			kb.find:set("n", "p", function() snacks.picker() end, { desc = "Pickers" })
			kb.find:set("n", "b", function() snacks.picker.buffers() end, { desc = "Buffers" })
			kb.find:set("n", "/", function() snacks.picker.grep() end, { desc = "Grep" })
		end
	}
}
