vim.g.mapleader = " "

-- File explorer
vim.keymap.set("n", "-", vim.cmd.Ex, { desc = "Open explorer (current dir)" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "File explorer" })

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

-- Scroll and keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search: keep match centered, show context
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clipboard: yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]],  { desc = "Yank to clipboard" })
vim.keymap.set("n",          "<leader>Y", [["+Y]],   { desc = "Yank line to clipboard" })

-- Delete without clobbering clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void" })

-- Paste over selection without clobbering clipboard
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Ctrl-C as Esc in insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Open tmux sessionizer in a new window
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Quickfix navigation
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next loclist" })
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz", { desc = "Prev loclist" })

-- Rename word under cursor (interactive substitution)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename word" })

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod +x" })

-- Source current file (useful when editing config)
vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>", { desc = "Source file" })
