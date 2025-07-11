-- Main Neovim config entry point

-- Load core config modules
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Setup plugin management with lazy.vim
local layzypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(layzypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		layzypath,
	})
end
vim.opt.rtp:prepend(layzypath)

-- Configure plugings
require("lazy").setup({
	require("core.themes"),
	require("plugins.lsp"),
	require("plugins.completion"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.git"),
	require("plugins.ui_improvements"),
	require("plugins.formatting"),
	"LazyVim/LazyVim",
	optional = true,
	opts = {
		format = { enabled = true },
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		local registry = require("mason-registry")
		local function ensure_installed()
			for _, tool in ipairs({
				"stylua",
				"prettier",
				"isort",
				"black",
				"prettierd",
			}) do
				if not registry.is_installed(tool) then
					vim.cmd("MasonInstall " .. tool)
				end
			end
		end

		if registry.refresh then
			registry.refresh(ensure_installed)
		else
			ensure_installed()
		end
	end,
})
