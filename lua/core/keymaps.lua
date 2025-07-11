-- Custom key mappings

-- Set leader key to space
vim.g.mapleader = " "

-- Normal mode key mappings
local keymap = vim.keymap

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sV", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split window" })

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })

-- Misc convenience
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Visual mode mappings
-- Move selected lines up and down
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })

