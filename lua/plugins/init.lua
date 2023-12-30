
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(   
    {
        {
            "ellisonleao/gruvbox.nvim",
            lazy = false,
            priority = 1000,
        },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            lazy = false,
            priority = 1000,
            config = function()
              -- load the colorscheme here
              vim.cmd([[colorscheme catppuccin]])
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            name = "treesitter",
            lazy = false,
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
        {
            "ThePrimeagen/harpoon",
            lazy = false,
            dependencies = { "nvim-lua/plenary.nvim" },
            config = true,
            keys = {
                { "<leader>h", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
                { "<leader>hf", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Go to file one" },
                { "<leader>hd", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Go to file two" },
                { "<leader>hs", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Go to file three" },
                { "<leader>ha", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Go to file four" },
                { "<leader>hj", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
                { "<leader>hk", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },
                { "<leader>hg", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
            }
        },
        -- LSP plugings
        {
            "neovim/nvim-lspconfig",
            name = "lspconfig",
        },
        {
            "williamboman/mason.nvim",
            name = "mason",
        },
        {
            "williamboman/mason-lspconfig.nvim",
            name = "mason lspconfig",
        },
        {
            "hrsh7th/nvim-cmp",
            name = "nvim cmp",
        },
        {
            "hrsh7th/cmp-nvim-lsp",
            name = "cmp nvim lsp",
        },
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
    },
    {
        defaults = { lazy = true },
        checker = { enabled = true },
    }
)
