local minis = {
    'ai',
    'surround',
    'align',
    'comment',
    'pairs',
}

return {
    'echasnovski/mini.nvim',
    version = false,
    config = function ()
        for _, value in pairs(minis) do
            require('mini.' .. value).setup({})
        end
    end
}
