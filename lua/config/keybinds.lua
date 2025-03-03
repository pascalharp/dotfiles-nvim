local M = {}

-- Keybind Groups accessed thorough leader
M.Groups = {
    lsp = { key = 'l', desc = '[L]sp' },
    find = { key = 'f', desc = '[F]ind' },
    hop = { key = '<leader>', desc = '[H]op'},
}

--@type group M.Groups
--@type key string
--@type fn function
--@type desc string
function M.group_bind(group, key, fn, desc, mode)
    return { '<leader>' .. group.key .. key, fn, mode = mode or 'n', desc = desc or "" }
end

function M.setup()
end

-- add enum functions for convenience
for _, group in pairs(M.Groups) do
    group.bind = function(self, key, fn, desc, mode)
        return M.group_bind(self, key, fn, desc, mode)
    end
    group.spec = function(self)
        return { '<leader>' .. self.key, desc = self.desc }
    end
end

return M
