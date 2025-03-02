local icons = {
    Snippet = "",
    Function = "󰊕",
    Keyword = "",
    Variable = "󰇂",
    Class = "󰋴",
    Constructor = "",
    Method = "󰊕",
    Module = "",
    Text = "󰊄",
}

local mappings = function()
    local luasnip = require('luasnip')
    local cmp = require('cmp')
    return {
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 1 }),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 1 }),

        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Accept completion
        ['<C-Space>'] = cmp.mapping.confirm { select = true },

        -- Move between snippet expansions
        ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { 'i', 's' }),
    }
end

return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local luasnip = require('luasnip')
        local cmp = require('cmp')

        luasnip.config.setup {}

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert,noselect' },
            window = {
                completion = cmp.config.window.bordered({
                    winhighlight = "Normal:NonText,FloatBorder:NonText,CursorLine:CurSearch",
                }),
                documentation = cmp.config.window.bordered()
            },
            mapping = mappings(),
            sources = cmp.config.sources({
                { name = 'lazydev' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
                { name = 'buffer' },
                { name = 'cmdline' },
                { name = 'nvim_lsp_signature_help' },
            }),
            preselect = cmp.PreselectMode.None,
            formatting = {
                fields = { 'abbr', 'kind' },
                expandable_indicator = true,
                format = function(_, vim_item)
                    vim_item.kind = (icons[vim_item.kind] or "?") .. " " .. vim_item.kind
                    return vim_item
                end
            },
            experimental = {
                ghost_text = true,
            }
        }
    end,
}
