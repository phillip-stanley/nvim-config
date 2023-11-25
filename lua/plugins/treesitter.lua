require"nvim-treesitter.configs".setup {
    ensure_installed = {
        "python",
        "lua",
        "javascript",
        "dockerfile",
        "hcl",
    },
    highlight = {
        enable = true,
    }
}
