-- lua/plugins/database.lua
return {
	-- Database Explorer and Query Tool
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod" },
			{ "kristijanhusak/vim-dadbod-completion" },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		keys = {
			{ "<leader>ab", "<cmd>DBUIToggle<cr>", desc = "DB: Toggle UI" },
			{ "<leader>af", "<cmd>DBUIFindBuffer<cr>", desc = "DB: Find buffer" },
			{ "<leader>ar", "<cmd>DBUIRenameBuffer<cr>", desc = "DB: Rename buffer" },
			{ "<leader>al", "<cmd>DBUILastQueryInfo<cr>", desc = "DB: Last query info" },
		},
		config = function()
			-- Database connection configurations
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_execute_on_save = 0
			vim.g.db_ui_show_database_icon = 1

			-- Auto-completion setup
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					require("cmp").setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
						},
					})
				end,
			})
		end,
	},

	-- SQL Language Server
	{
		"nanotee/sqls.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		ft = { "sql", "mysql", "pgsql" },
		config = function()
			-- Setup SQL language server
			local lspconfig = require("lspconfig")

			vim.lsp.config("sqls", {
				on_attach = function(client, bufnr)
					require("sqls").on_attach(client, bufnr)

					-- SQL-specific keymaps
					local opts = { buffer = bufnr, silent = true }
					vim.keymap.set("n", "<leader>sq", "<cmd>SqlsExecuteQuery<cr>", opts)
					vim.keymap.set("v", "<leader>sq", "<cmd>SqlsExecuteQuery<cr>", opts)
					vim.keymap.set("n", "<leader>sf", "<cmd>SqlsShowSchemas<cr>", opts)
					vim.keymap.set("n", "<leader>sd", "<cmd>SqlsShowDatabases<cr>", opts)
					vim.keymap.set("n", "<leader>st", "<cmd>SqlsShowTables<cr>", opts)
					vim.keymap.set("n", "<leader>sc", "<cmd>SqlsShowColumns<cr>", opts)

					-- Status line indicator for connected SQL server
					vim.api.nvim_buf_set_var(bufnr, "sqls_connected", true)
				end,
				settings = {
					sqls = {
						connections = {
							-- These are just examples - you'll need to define your own connections
							-- {
							--   driver = 'postgresql',
							--   dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=password dbname=mydb sslmode=disable',
							-- },
							-- {
							--   driver = 'mysql',
							--   dataSourceName = 'root:password@tcp(127.0.0.1:3306)/mydb',
							-- },
							-- {
							--	driver = "sqlite3",
							--	dataSourceName = "./contacts.sqlite3",
							--},
						},
					},
				},
			})
		end,
	},
}
