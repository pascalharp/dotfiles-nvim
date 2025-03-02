local lsp_pre  = "<leader>l"

local keybinds = {
    { lsp_pre .. 'f', function() vim.lsp.buf.format() end, desc = "[F]ormat" }
}

return {
    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = true,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp"
        },
        main = "lspconfig",
        config = function()
            require("mason-lspconfig").setup_handlers {
                function(server_name)  -- default handler
                    local capabilities = require('cmp_nvim_lsp').default_capabilities()
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
            }
        end,
        keys = keybinds,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    }
}
