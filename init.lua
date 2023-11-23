require("core/settings")
require("core/keymappings")
require("plugins/treesitter")
require("plugins")

require"nvim-treesitter.configs".setup {
    ensure_installed = {
        "python",
        "lua",
        "javascript",
    },
    highlight = {
        enable = true,
    }
}
