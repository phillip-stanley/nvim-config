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
    },
    {
        defaults = { lazy = true },
        checker = { enabled = true },
    }
)
