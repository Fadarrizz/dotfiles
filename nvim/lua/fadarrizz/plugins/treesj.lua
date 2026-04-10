return {
    "Wansmer/treesj",
    keys = { "<Leader>s" },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require("treesj").setup({ use_default_keymaps = false })

        -- Walk up from cursor: if we hit a treesj-handled PHP node before a
        -- member_call_expression, let treesj handle it (e.g. split arguments).
        -- If we hit a member_call_expression first, handle it as a chain.
        -- Returns false if treesj should handle it, true if chain was toggled.
        local function try_php_chain_toggle()
            local node = vim.treesitter.get_node()
            if not node then return false end

            local treesj_nodes = {
                arguments = true,
                array_creation_expression = true,
                formal_parameters = true,
                compound_statement = true,
            }

            local n = node
            while n do
                local t = n:type()
                if treesj_nodes[t] then return false end
                if t == "member_call_expression" then break end
                n = n:parent()
            end
            if not n then return false end

            -- Walk up to find the root of the chain
            local root = n
            while root:parent() and root:parent():type() == "member_call_expression" do
                root = root:parent()
            end

            -- Collect chain parts from outermost call inward
            local chain = {}
            local current = root
            while current:type() == "member_call_expression" do
                local name_node = current:field("name")[1]
                local args_node = current:field("arguments")[1]
                local obj_node = current:field("object")[1]
                if not name_node or not args_node or not obj_node then break end
                table.insert(chain, 1, {
                    name = vim.treesitter.get_node_text(name_node, 0),
                    args = vim.treesitter.get_node_text(args_node, 0),
                })
                current = obj_node
            end

            -- Single calls (no chain) are handled fine by treesj already
            if #chain < 2 then return false end

            local base = vim.treesitter.get_node_text(current, 0)
            local start_row, start_col, end_row, end_col = root:range()
            local is_multiline = start_row ~= end_row

            local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]
            local base_indent = line:match("^(%s*)") or ""
            local method_indent = base_indent .. string.rep(" ", vim.bo.shiftwidth)

            if is_multiline then
                local parts = { base }
                for _, call in ipairs(chain) do
                    parts[#parts + 1] = "->" .. call.name .. call.args
                end
                vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { table.concat(parts, "") })
            else
                local lines = { base }
                for _, call in ipairs(chain) do
                    lines[#lines + 1] = method_indent .. "->" .. call.name .. call.args
                end
                vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, lines)
            end

            return true
        end

        vim.keymap.set("n", "<Leader>s", function()
            local ft = vim.bo.filetype
            if (ft == "php" or ft == "blade") and try_php_chain_toggle() then
                return
            end
            require("treesj").toggle()
        end)
    end,
}
