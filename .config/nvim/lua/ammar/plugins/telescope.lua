return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function() return vim.fn.executable("make") == 1 end,
            },
        },
        keys = {
            { "<leader>pf", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
            { "<C-p>",      "<cmd>Telescope git_files<cr>",   desc = "Git files" },
            { "<leader>ps", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
            { "<leader>pb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
            { "<leader>ph", "<cmd>Telescope help_tags<cr>",   desc = "Help" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    path_display = { "smart" },
                    layout_strategy = "horizontal",
                    layout_config = { preview_width = 0.55 },
                },
            })
            pcall(telescope.load_extension, "fzf")
        end,
    },
}
