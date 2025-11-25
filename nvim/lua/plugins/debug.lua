return {
	"mfussenegger/nvim-dap",

	dependencies = {
		-- UI for the debugger
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",

		-- Installs debug adapters automatically
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Extra debuggers
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Setup automatic debugger installation
		require("mason-nvim-dap").setup({
			automatic_setup = true,        -- auto-configure debuggers
			automatic_installation = true, -- install missing debuggers

			handlers = {},                 -- extra config if needed

			-- Make sure these debuggers are installed
			ensure_installed = {
				-- Add more here if needed
				"debugpy",
			},
		})

		-- ===========================
		-- Debugging Keymaps
		-- ===========================

		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start or Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Conditional Breakpoint" })

		-- ===========================
		-- DAP UI Setup
		-- ===========================

		dapui.setup({
			-- Simple icons that work in almost all terminals
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },

			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		-- Shortcut to open/close debug result window
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: Toggle Result Window" })

		-- Auto open/close the UI during debugging
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Python debugger setup
		require("dap-python").setup()
	end,
}

