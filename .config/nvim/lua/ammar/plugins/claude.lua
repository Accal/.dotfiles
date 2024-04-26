-- return {
--     {
--         "greggh/claude-code.nvim",
--         dependencies = { "nvim-lua/plenary.nvim" },
--         keys = {
--             { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
--         },
--         opts = {
--             window = {
--                 position = "botright vsplit",
--                 split_ratio = 0.5,
--             },
--         },
--     },
-- }

return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			terminal = {
				split_side = "right",
				split_width_percentage = 0.38,
				provider = "native",
			},
			diff_opts = {
				layout = "vertical",
				open_in_new_tab = false,
				keep_terminal_focus = false,
				hide_terminal_in_new_tab = false,
			},
		},
		config = function(_, opts)
			require("claudecode").setup(opts)

			local profiles = {
				{ label = "Work",     dir = "~/.claude-work" },
				{ label = "Personal", dir = "~/.claude-personal" },
			}

			local function switch_profile(dir)
				vim.fn.setenv("CLAUDE_CONFIG_DIR", vim.fn.expand(dir))
				vim.cmd("ClaudeCodeStop")
				vim.cmd("ClaudeCode")
			end

			local function pick_profile()
				vim.ui.select(profiles, {
					prompt = "Claude profile:",
					format_item = function(p) return p.label end,
				}, function(choice)
					if choice then switch_profile(choice.dir) end
				end)
			end

			vim.api.nvim_create_user_command("ClaudeWork",     function() switch_profile("~/.claude-work")     end, { desc = "Claude: work profile" })
			vim.api.nvim_create_user_command("ClaudePersonal", function() switch_profile("~/.claude-personal") end, { desc = "Claude: personal profile" })
			vim.api.nvim_create_user_command("ClaudePick",     pick_profile,                                       { desc = "Claude: pick profile" })
		end,
		keys = {
			{ "<leader>cc", "<cmd>ClaudePick<cr>",      desc = "Claude: pick profile" },
			{ "<leader>cw", "<cmd>ClaudeWork<cr>",      desc = "Claude: work profile" },
			{ "<leader>cp", "<cmd>ClaudePersonal<cr>",  desc = "Claude: personal profile" },
		},
	},
}
