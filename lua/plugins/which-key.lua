local gen_specs = function()
  local kb = require('config.keybinds')
  local specs = {}
  for _, val in pairs(kb.Groups) do
    table.insert(specs, val:spec())
  end
  return specs
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = gen_specs()
  },
}
