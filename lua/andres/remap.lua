local opts = { noremap = true, silent = true }

vim.keymap.set("i", "jj", "<ESC>", opts)
vim.keymap.set("n", "<leader>V", ":vsplit<CR>", opts)

vim.keymap.set("n", "<leader>s", ":w<CR>", opts)
vim.keymap.set("n", "<leader>w", ":q<CR>", opts)

--
vim.keymap.set("n", "<leader>so", ":source<CR>")
-- maps for navigate in code
vim.keymap.set("n", "<leader>l", "%")
vim.keymap.set("n", "<leader>h", "0")

-- fast navigate
vim.keymap.set("n", "s", "5<c-e>", opts)
vim.keymap.set("n", "f", "5<c-y>", opts)

-- CLEAR SEARCH HIGHLIGHT
vim.keymap.set("n", "<esc>", ":noh<return><esc>", opts)

--COMMAND FOR EXECUTING NODE SCRIPT
--

vim.keymap.set("n", "<leader>x", ":!node %<CR>", opts)
