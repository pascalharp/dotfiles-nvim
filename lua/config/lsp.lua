local M = {}

local lsp_list = {
    'lua_ls',
    'rust_analyzer',
    'bashls',
    'ts_ls',
    'jsonls',
}

local function on_attach(_, bufnr)
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = desc,
        })
    end

    local wk_ok, wk = pcall(require, 'which-key')
    local picker_ok, picker = pcall(require, 'snacks.picker')
    if wk_ok and picker_ok then
        wk.add({ '<leader>c', group = 'Code', mode = 'n', buffer = bufnr })
    else
        return
    end

    map('n', 'K', vim.lsp.buf.hover, 'lsp documentation')
    map('n', '<leader>ca', vim.lsp.buf.code_action, '[A]ctions')
    map('n', '<leader>cd', picker.lsp_definitions, '[D]efinitions')
    map('n', '<leader>cD', picker.lsp_declarations, '[D]eclarations')
    map('n', '<leader>ci', picker.lsp_implementations, '[I]mplementations')
    map('n', '<leader>cr', picker.lsp_references, '[R]eferences')
    map('n', '<leader>ct', picker.lsp_type_definitions, '[T]ype definitions')
    map('n', '<leader>cs', picker.lsp_symbols, '[S]ymbols')
    map('n', '<leader>cs', picker.lsp_symbols, '[S]ymbols')
    map('n', '<leader>cf', vim.lsp.buf.format, '[f]ormat')
    map('n', '<leader>ccr', vim.lsp.buf.rename, '[R]ename')

    map('n', '<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        'Toggle Inlay [H]ints')
end

function M.setup()
    vim.lsp.enable(lsp_list)
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = on_attach,
    })
end

return M
