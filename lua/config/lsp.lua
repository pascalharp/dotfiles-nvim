local M = {}

local lsp_list = {
	"lua_ls",
	"rust_analyzer",
}

function M:setup()
	vim.lsp.enable(lsp_list)
end

return M
