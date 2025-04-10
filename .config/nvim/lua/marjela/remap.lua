-- moving selected items up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- center cursor while navigating
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

-- keeps searching results in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- pasting without loosing yanked content
vim.keymap.set("x", "<leader>p", "\"_dP")

-- yanking in system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- pasting from system clipboard
vim.keymap.set("n", "<leader>P", "\"+p")
vim.keymap.set("v", "<leader>P", "\"+p")

-- deleting in void reg
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>d", "\"_d")

-- close buf
vim.keymap.set("n", "<leader>q", ":bd<CR>")

-- between tabs for neogit
vim.keymap.set("n", "]t", ":tabnext<CR>")
vim.keymap.set("n", "[t", ":tabprev<CR>")
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>")

-- quickfix list
vim.keymap.set("n", "<leader>co", ":copen<CR><C-w>k")
vim.keymap.set("n", "<leader>cc", ":ccl<CR>")
vim.keymap.set("n", "<C-j>", ":cnext<CR>")
vim.keymap.set("n", "<C-k>", ":cprev<CR>")


-- exit terminal mode
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
