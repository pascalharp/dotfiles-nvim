local fkb = require("config.keybinds").Groups.flash

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    fkb:gen('j', function() require("flash").jump() end, "[J]ump"),
    fkb:gen('t', function() require("flash").treesitter() end, "[T]reesitter"),
    fkb:gen('r', function() require("flash").remote() end, "[R]emote"),
    fkb:gen('T', function() require("flash").treesitter_search() end, "[T]reesitter Search"),
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
