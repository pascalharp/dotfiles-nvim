local M = {}

local lsp_list = {
  "lua_ls",
  "rust_analyzer",
  "tinymist",
}

function M:setup()
  vim.lsp.enable(lsp_list)

  local kb = require("utils/keybinds")
  local misc = require("utils/misc")

  misc:on_lsp_attach("lsp_core", function(args)
    kb.lsp:set("n", "r", function() vim.lsp.buf.rename() end, { desc = "Rename", buffer = args.buf })
    kb.lsp:set("n", "f", function() vim.lsp.buf.format() end, { desc = "Format", buffer = args.buf })
    kb.lsp:set("n", "a", function() vim.lsp.buf.code_action() end, { desc = "Action", buffer = args.buf })
  end)
end

return M
