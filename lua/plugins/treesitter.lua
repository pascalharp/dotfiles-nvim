return {
  src = "https://github.com/nvim-treesitter/nvim-treesitter",
  data = {
    setup = function()
      local ts = require("nvim-treesitter.configs")
      ts.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
