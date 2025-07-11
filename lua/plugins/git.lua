return {
	-- Git signs in the gutter
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Git: Next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Git: Previous hunk" })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk, { desc = "Git: Stage hunk" })
					map("n", "<leader>hr", gs.reset_hunk, { desc = "Git: Reset hunk" })
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Git: Stage selected hunk" })
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Git: Reset selected hunk" })
					map("n", "<leader>hS", gs.stage_buffer, { desc = "Git: Stage buffer" })
					map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git: Undo stage hunk" })
					map("n", "<leader>hR", gs.reset_buffer, { desc = "Git: Reset buffer" })
					map("n", "<leader>hp", gs.preview_hunk, { desc = "Git: Preview hunk" })
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end, { desc = "Git: Blame line" })
					map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Git: Toggle line blame" })
					map("n", "<leader>hd", gs.diffthis, { desc = "Git: Diff this" })
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end, { desc = "Git: Diff this ~" })
					map("n", "<leader>td", gs.toggle_deleted, { desc = "Git: Toggle deleted" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git: Select hunk" })
				end,
			})
		end,
	},

	-- Interactive Git commands
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
			{ "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff" },
			{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
			{ "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
		},
	},

	-- GitHub integration
	{
		"tpope/vim-rhubarb",
		dependencies = { "tpope/vim-fugitive" },
	},

	-- Magit-like interface for Git
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Git: Open diff view" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git: File history" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Git: Close diff view" },
		},
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				use_icons = true,
				icons = {
					folder_closed = "",
					folder_open = "",
				},
				signs = {
					fold_closed = "",
					fold_open = "",
					done = "✓",
				},
				view = {
					merge_tool = {
						layout = "diff3_mixed",
						disable_diagnostics = true,
					},
				},
				file_panel = {
					listing_style = "tree",
					tree_options = {
						flatten_dirs = true,
						folder_statuses = "only_folded",
					},
				},
				file_history_panel = {
					log_options = {
						git = {
							single_file = {
								diff_merges = "combined",
								follow = true,
							},
							multi_file = {
								diff_merges = "first-parent",
							},
						},
					},
				},
			})
		end,
	},
}
