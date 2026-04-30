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
		end,
		keys = {
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Claude Code" },
		},
	},
}
