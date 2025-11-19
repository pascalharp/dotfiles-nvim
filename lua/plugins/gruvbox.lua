return {
  src = "https://github.com/ellisonleao/gruvbox.nvim",
  data = {
    setup = function()
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end
  }
}
