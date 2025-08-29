local function current_adatper()
    return '  ' .. vim.adapter_get();
end

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            theme = 'gruvbox-material',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { current_adatper, 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
}
