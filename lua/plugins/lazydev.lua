return {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      integration = {
        lspconfig = false,
        cmp = false,
        coc = false,
      },
      enabled = function (root)
        local exists, err = vim.uv.fs_access(root .. '/init.vim', 'F')
        return exists
      end
    },
}
