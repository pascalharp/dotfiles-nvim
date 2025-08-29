local current_adapter = 'qwen_coder'

---Returns a list of available adapter names.
---@return string[]
local function adapter_list()
  return {
    'qwen3',
    'qwen_coder',
    'gemini_flash',
    'gemini_pro',
  }
end

---Sets the current adapter to be used by CodeCompanion.
---@param adapter string The name of the adapter to set.  Must be one of the values returned by `adapter_list()`.
local function adapter_set(adapter)
  local available = adapter_list()
  for _, name in ipairs(available) do
    if name == adapter then
      current_adapter = name
      return
    end
  end
  error("Adapter not found: " .. adapter)
end

---Presents a picker to the user to select an AI model.
---The selected model is then set as the current adapter.
local function adapter_get()
  return current_adapter
end

---Presents a picker to the user to select an AI model.
---The selected model is then set as the current adapter.
local function pick_adapter()
  local picker = require('snacks').picker
  local items = {}
  for i, adap in ipairs(adapter_list()) do
    table.insert(items, { text = adap, idx = i, score = i, preview = { text = "TODO" } })
  end
  picker({
    items = items,
    title = "  Select AI model",
    preview = "preview",
    format = function(item)
      return { { item.text, 'SnacksPickerLabel' } }
    end,
    confirm = function(pick, item)
      pick:close()
      if item then
        adapter_set(item.text)
      end
    end
  })
end

-- Adapted to toggle with current selected adapter
local function toggle_chat()
  local cc = require("codecompanion")
  local chat = cc.last_chat()

  if chat and chat.ui:is_visible() then
    return chat.ui:hide()
  end

  if chat and chat.adapter.name == adapter_get() then
    return chat.ui:open({ toggled = true })
  end

  cc.chat({ fargs = { current_adapter } })
end

local function binds()
  local kb = require("config.keybinds")
  local root = kb.Groups.root
  return {
    root:gen('a', pick_adapter, "[S]elect AI model"),
    root:gen('h', toggle_chat, " Ai chat"),
  }
end

local function get_gemini_key()
  local home = os.getenv("HOME")
  local file_path = home .. "/.secrets/gemini.key"
  local file, err = io.open(file_path, 'rb')
  if not file then
    print("Error opening file: " .. (err or "unknown error"))
    return nil
  end
  local content = file:read('*a')
  file:close()
  local key = content:match("^%s*(.-)%s*$")
  return key
end

return {
  "olimorris/codecompanion.nvim",
  config = function(_, opts)
    vim.adapter_set = adapter_set
    vim.adapter_list = adapter_list
    vim.adapter_get = adapter_get
    require('codecompanion').setup(opts)
  end,
  lazy = false,
  opts = {
    display = {
      action_pallete = {
        provider = 'snacks',
      }
    },
    strategies = {
      chat = { adapter = "qwen_coder" },
      inline = { adapter = "qwen_coder" },
      cmd = { adapter = "qwen_coder" },
    },
    adapters = {
      qwen3 = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'qwen3',
          schema = {
            model = {
              default = 'qwen3:4b'
            },
          },
        })
      end,
      qwen_coder = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'qwen2.5-coder',
          schema = {
            model = {
              default = 'qwen2.5-coder:3b'
            },
          },
        })
      end,
      gemini_flash = function()
        return require('codecompanion.adapters').extend("gemini", {
          name = 'gemini-2.0-flash',
          env = {
            api_key = get_gemini_key
          },
          schema = {
            model = {
              default = "gemini-2.0-flash"
            },
          }
        })
      end,
      gemini_pro = function()
        return require('codecompanion.adapters').extend("gemini", {
          name = 'gemini-2.5-pro',
          env = {
            api_key = get_gemini_key
          },
          schema = {
            model = {
              default = "gemini-2.5-pro"
            },
          }
        })
      end,
    },
    opts = {
      log_level = 'DEBUG'
    }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = binds,
}
