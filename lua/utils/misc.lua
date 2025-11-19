local M = {}

function M:wildcard_modules(path)
  local full_paths = vim.api.nvim_get_runtime_file("lua/" .. path .. "/*.lua", true)
  local module_paths = {}
  for _, p in ipairs(full_paths) do
    table.insert(module_paths, p:match("lua/(.*)%.lua$"))
  end
  return module_paths
end

function M:on_lsp_attach(group_name, callback)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup(group_name, {}),
    callback = callback
  })
end

return M
