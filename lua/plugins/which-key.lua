return {
  src = "https://github.com/folke/which-key.nvim",
  data = {
    setup = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern"
      })
      local kb = require("utils/keybinds")
      for _, v in pairs(kb) do
        if type(v) == "table" then
          wk.add({ v.prefix, group = v.name })
        end
      end

      kb.root:set("n", "?", function() wk.show({ global = false }) end, { desc = "Buffer local maps" })
    end
  }
}
