-- plugin setup
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