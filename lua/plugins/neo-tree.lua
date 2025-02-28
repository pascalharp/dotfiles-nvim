local nt_exec = function(opts)
  require("neo-tree.command").execute(opts)
end

local keybinds = {
  { "<leader>\\", function() nt_exec({toggle = true }) end, desc = "Togge NeoTree"}
}

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = keybinds,
}
