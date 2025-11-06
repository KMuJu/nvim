return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local map = require("helpers.keys").dap_map
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
				map("n", "<leader>so", function()
					dap.step_over()
				end, "Step over line")
				map("n", "<leader>si", function()
					dap.step_into()
				end, "Step into line")
				map("n", "<leader>su", function()
					dap.step_out()
				end, "Step out")
				map("n", "<leader>sc", function()
					dap.continue()
				end, "Continue")
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
			map("n", "<leader>bp", "<cmd> DapToggleBreakpoint <CR>", "Create breakpoint")
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			-- require("core.utils").load_mappings("dap_python")
			local map = require("helpers.keys").map
			map("n", "<leader>br", function()
				require("dap-python").test_method()
			end, "Run debugpy")
		end,
	},
}
