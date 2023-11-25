require"nvim-treesitter.configs".setup {
    ensure_installed = {
        "css",
        "dockerfile",
        "hcl",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "terraform",
        "typescript",
    },
    highlight = {
        enable = true,
    }
}
