vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_auto_execute_table_helpers = 1

vim.keymap.set("n", "<leader>du", vim.cmd.DBUIToggle, { desc = '[DBUI] toggle' });
vim.keymap.set("n", "<leader>df", vim.cmd.DBUIFindBuffer, { desc = '[DBUI] find' });
vim.keymap.set("n", "<leader>dr", vim.cmd.DBUIRenameBuffer, { desc = '[DBUI] rename' });
vim.keymap.set("n", "<leader>dl", vim.cmd.DBUILastQueryInfo, { desc = '[DBUI] last query' });
