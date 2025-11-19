return {
  src = "https://github.com/Saghen/blink.cmp",
  data = {
    setup = function()
      require("blink.cmp").setup({
        completion = {
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
          menu = {
            draw = {
              columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } }
            }
          },
          ghost_text = {
            enabled = true
          }
        }
      })
    end
  }
}
