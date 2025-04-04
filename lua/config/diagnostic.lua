local options = {
    config = {
        virtual_lines = true,
    }
}

local M = {}

M.setup = function()
    for option, value in pairs(options) do
        vim.diagnostic[option] = value
    end
end

return M
