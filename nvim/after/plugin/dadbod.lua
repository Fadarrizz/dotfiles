vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_auto_execute_table_helpers = 1

vim.keymap.set("n", "<leader>du", vim.cmd.DBUIToggle);
vim.keymap.set("n", "<leader>df", vim.cmd.DBUIFindBuffer);
vim.keymap.set("n", "<leader>dr", vim.cmd.DBUIRenameBuffer);
vim.keymap.set("n", "<leader>dl", vim.cmd.DBUILastQueryInfo);
