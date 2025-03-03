local gen_keybinds = function()
    local kb = require('config.keybinds').Groups.hop

    local hop = require('hop')
    local dir = require('hop.hint').HintDirection

    local mode = { 'n', 'v' }

    local basic_line = {
        current_line_only = true,
        hint_offset = 0,
        hint_position = 1,
    }

    local forwards_full = {
        direction = dir.AFTER_CURSOR,
        hint_position = dir.BEFORE_CURSOR,
        current_line_only = false,
        hint_offset = 0,
    }

    local backwards_full = {
        direction = dir.BEFORE_CURSOR,
        hint_position = dir.BEFORE_CURSOR,
        current_line_only = false,
        hint_offset = 0,
    }

    return {
        kb:bind('w', function() hop.hint_words(forwards_full) end,     '[w]ord (forward)',        mode),
        kb:bind('W', function() hop.hint_words(backwards_full) end,    '[W]ord (backwards)',      mode),
        kb:bind('c', function() hop.hint_char2(forwards_full) end,     '[c]har (forward)',        mode),
        kb:bind('C', function() hop.hint_char2(backwards_full) end,    '[C]har (backwards)',      mode),
        kb:bind('f', function() hop.hint_char1(basic_line) end,        '[f]ind in line',          mode),
        kb:bind('j', function() hop.hint_vertical(forwards_full) end,  '[j]ump line (forwards)',  mode),
        kb:bind('k', function() hop.hint_vertical(backwards_full) end, '[j]ump line (backwards)', mode),
    }
end

return {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'etovxqpdygfblzhckisuran'
    },
    keys = gen_keybinds,
}
