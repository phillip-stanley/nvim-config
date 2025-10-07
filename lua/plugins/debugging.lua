-- lua/plugins/debugging.lua
return {
	-- Debug Adapter Protocol
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- DAP UI components
			"rcarriga/nvim-dap-ui",
			-- Virtual text
			"theHamsta/nvim-dap-virtual-text",
			-- Async IO library
			"nvim-neotest/nvim-nio",
			-- Python DAP
			"mfussenegger/nvim-dap-python",
			-- JS/TS DAP
			"microsoft/vscode-js-debug",
			"mxsdev/nvim-dap-vscode-js",
			-- Testing
			"nvim-neotest/neotest",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup the UI
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				-- Expand lines larger than the window
				-- Requires >= 0.7
				expand_lines = vim.fn.has("nvim-0.7") == 1,
				-- Layouts define sections of the screen to place windows.
				-- The position can be "left", "right", "top" or "bottom".
				-- The size specifies the height/width depending on position.
				-- Elements are the elements shown in the layout (in order).
				-- Layouts are opened in order so that earlier layouts take priority.
				layouts = {
					{
						elements = {
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "single", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
					max_value_lines = 100, -- Can be integer or nil.
				},
			})

			-- Setup virtual text
			require("nvim-dap-virtual-text").setup()

			-- Listeners to auto-open UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Python setup
			require("dap-python").setup("python")

			-- JavaScript/TypeScript setup
			require("dap-vscode-js").setup({
				-- Path to the adapter
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
				-- Path to the debugger
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
			})

			-- Configure JavaScript/TypeScript adapters
			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				dap.configurations[language] = {
					-- Node.js
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Node.js",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
					},
					-- Jest
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug Jest Tests",
						runtimeExecutable = "node",
						runtimeArgs = {
							"./node_modules/jest/bin/jest.js",
							"--runInBand",
						},
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
					-- Chrome
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Chrome",
						url = "http://localhost:3000",
						webRoot = "${workspaceFolder}",
						userDataDir = "${workspaceFolder}/.vscode/chrome-debug-profile",
					},
				}
			end

			-- Testing with Neotest
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
						args = { "--verbose" },
						runner = "pytest",
					}),
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = "jest.config.js",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
				},
				summary = {
					open = "botright vsplit | vertical resize 50",
				},
			})

			-- Keymaps
			-- DAP
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
			vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
			vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Debug: Terminate" })

			-- Testing
			vim.keymap.set("n", "<leader>tt", function()
				neotest.run.run()
			end, { desc = "Test: Run Nearest" })
			vim.keymap.set("n", "<leader>tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Test: Run File" })
			vim.keymap.set("n", "<leader>td", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "Test: Debug Nearest" })
			vim.keymap.set("n", "<leader>ts", function()
				neotest.summary.toggle()
			end, { desc = "Test: Toggle Summary" })
			vim.keymap.set("n", "<leader>to", function()
				neotest.output.open()
			end, { desc = "Test: Show Output" })
		end,
	},
}
