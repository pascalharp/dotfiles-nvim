return {
  src = "https://github.com/rmagatti/logger.nvim",
  setup = function()
    local logger = require("logger"):new({ log_level = "info", prefix = "my_prefix", echo_messages = false })
    vim.logger = logger;
  end
}
