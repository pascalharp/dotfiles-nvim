local fkb = require("config.keybinds").Groups.flash

local function jump_line(forward)
  require("flash").jump({
    search = {
      mode = "search",
      max_length = 0,
      forward = forward,
      wrap = false
    },
    label = { after = { 0, 0 } },
    pattern = "^"
  })
end

local function jump_line_forward() jump_line(true) end
local function jump_line_backward() jump_line(false) end

---@param opts Flash.Format
local function format(opts)
  -- always show first and second label
  return {
---@diagnostic disable-next-line: undefined-field
    { opts.match.label1, "FlashMatch" },
---@diagnostic disable-next-line: undefined-field
    { opts.match.label2, "FlashLabel" },
  }
end

local function two_word_jump(forward)
  local Flash = require("flash")
  Flash.jump({
    search = { mode = "search", forward = forward },
    label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
    pattern = [[\<]],
    action = function(match, state)
      state:hide()
      Flash.jump({
        search = { max_length = 0 },
        highlight = { matches = false },
        label = { format = format },
        matcher = function(win)
          -- limit matches to the current label
          return vim.tbl_filter(function(m)
            return m.label == match.label and m.win == win
          end, state.results)
        end,
        labeler = function(matches)
          for _, m in ipairs(matches) do
---@diagnostic disable-next-line: undefined-field
            m.label = m.label2 -- use the second label
          end
        end,
      })
    end,
    labeler = function(matches, state)
      local labels = state:labels()
      for m, match in ipairs(matches) do
---@diagnostic disable-next-line: inject-field
        match.label1 = labels[math.floor((m - 1) / #labels) + 1]
---@diagnostic disable-next-line: inject-field
        match.label2 = labels[(m - 1) % #labels + 1]
        match.label = match.label1
      end
    end,
  })
end

local function two_word_jump_forward() two_word_jump(true) end
local function two_word_jump_backward() two_word_jump(false) end

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = true
      }
    }
  },
  keys = {
    fkb:gen('j', jump_line_forward, " Line Jump"),
    fkb:gen('k', jump_line_backward, " Line Jump"),
    fkb:gen('w', two_word_jump_forward, "󰁔 Word Jump"),
    fkb:gen('b', two_word_jump_backward, "󰁍 Word Jump"),
    fkb:gen('<leader>', function () require('flash').jump() end, "Search"),
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
