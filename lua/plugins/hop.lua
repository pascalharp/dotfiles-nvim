local gen_keybinds = function()
    local kb = require('config.keybinds').Groups.hop

    local hop = require('hop')
    local dir = require('hop.hint').HintDirection

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
        kb:bind('w', function() hop.hint_words(forwards_full) end, '[w]ord (forward)'),
        kb:bind('W', function() hop.hint_words(backwards_full) end, '[W]ord (backwards)'),
        kb:bind('c', function() hop.hint_char2(forwards_full) end, '[c]har (forward)'),
        kb:bind('C', function() hop.hint_char2(backwards_full) end, '[C]har (backwards)'),
        kb:bind('f', function() hop.hint_char1(basic_line) end, '[f]ind in line'),
        kb:bind('j', function() hop.hint_vertical(forwards_full) end, '[j]ump line (forwards)'),
        kb:bind('k', function() hop.hint_vertical(backwards_full) end, '[j]ump line (backwards)'),
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
