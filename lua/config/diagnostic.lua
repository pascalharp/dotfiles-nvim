local opts = {
    virtual_lines = true,
    virtual_text = true,
}

local M = {}

M.setup = function()
    local conf = vim.tbl_extend("force", vim.diagnostic.config(), opts)
    vim.diagnostic.config(conf)

    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {
        desc = '[D]iagnostics hover',
        noremap = true,
        silent = true,
    })

    local picker_ok, picker = pcall(require, 'snacks.picker')
    if picker_ok then
        vim.keymap.set('n', '<leader>D', picker.diagnostics,
            {
                desc = '[D]diagnostics overview',
                noremap = true,
                silent = true
            }
        )
    else
        print("Oh no, no picker")
    end

    vim.keymap.set('n', '<leader>tl', function()
        vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
    end, {
        desc = 'Toggle virtual [l]ines',
        noremap = true,
        silent = true,
    })

    vim.keymap.set('n', '<leader>tt', function()
        vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
    end, {
        desc = 'Toggle virtual [t]ext',
        noremap = true,
        silent = true,
    })
end

return M
