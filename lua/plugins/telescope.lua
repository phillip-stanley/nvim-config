return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require("telescope").setup({
            -- basic configuration
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    ".venv",
                    "__pycache__"
                }
            }
        })

        -- Telescope key mappings
        vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "Search files"})
        vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>sj", require("telescope.builtin").buffers, { desc = "Search buffers" })
        vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Search help_tags" })

        -- Telescope Git key mappings
        vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
        vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
        vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git status" })
    end
}
