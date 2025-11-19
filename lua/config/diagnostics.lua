local opts = {
  virtual_lines = true,
  virtual_text = true,
}

local M = {}

function M:setup()
  local conf = vim.tbl_extend("force", vim.diagnostic.config(), opts)
  vim.diagnostic.config(conf)

  local kb = require("utils/keybinds")

  kb.diagnostics:set("n", "t", function()
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
  end, { desc = "Toggle virtual [T]ext" })

  kb.diagnostics:set("n", "l", function()
    vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
  end, { desc = "Toggle virtual [L]ines" })
end

return M
