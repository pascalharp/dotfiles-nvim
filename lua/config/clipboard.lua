local kb = require("utils/keybinds")

local M = {}

function M:setup()
  -- System clipboard
  kb.root:set({ "v" }, "y", '"+y', { desc = "Copy to system clipboard" })
  kb.root:set({ "n" }, "y", '"+yy', { desc = "Copy Line to system clipboard" })
  kb.root:set({ "n", "v" }, "p", '"+p', { desc = "Paste from system clipboard" })
  kb.root:set({ "n", "v" }, "P", '"+P', { desc = "Paste from system clipboard" })
end

return M
