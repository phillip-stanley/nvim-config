return {
	"ThePrimeagen/harpoon",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = true,
	keys = {
		{ "<leader>h", "<cms>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
	},
}
