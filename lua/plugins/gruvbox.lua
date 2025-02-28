return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function(opts)
        require("gruvbox").setup(opts)
        vim.cmd("colorscheme gruvbox")
    end,
}
