return {
    -- Auto-close brackets, quotes, etc.
    {
        "echasnovski/mini.pairs",
        version = false,
        event = "InsertEnter",
        opts = {},
    },

    -- Surround text objects: ys, ds, cs  (lua rewrite of vim-surround)
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    -- Visual undo history
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
        },
    },

    -- Keymap hints popup (press leader and wait)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = { delay = 500 },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>p", group = "Files/Find" },
                { "<leader>g", group = "Git" },
                { "<leader>h", group = "Hunk (git)" },
                { "<leader>r", group = "Rename" },
                { "<leader>c", group = "Claude" },
                { "<leader>v", group = "View" },
            })
        end,
    },

    -- Highlight TODO / FIXME / HACK / NOTE / WARN in comments
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
            { "<leader>pt", "<cmd>TodoTelescope<cr>", desc = "TODOs" },
        },
        opts = {},
    },

    -- Tmux/vim split navigation
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        cmd = {
            "TmuxNavigateLeft", "TmuxNavigateDown",
            "TmuxNavigateUp", "TmuxNavigateRight", "TmuxNavigatePrevious",
        },
        -- <C-h> intentionally omitted — harpoon uses it for buffer 1
        keys = {
            { "<C-j>", "<cmd>TmuxNavigateDown<cr>",     desc = "Navigate down" },
            { "<C-k>", "<cmd>TmuxNavigateUp<cr>",       desc = "Navigate up" },
            { "<C-l>", "<cmd>TmuxNavigateRight<cr>",    desc = "Navigate right" },
            { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate previous" },
        },
    },
}
