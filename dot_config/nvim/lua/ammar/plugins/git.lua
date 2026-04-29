return {
    -- Full git workflow in vim
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G" },
        keys = {
            { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
        },
    },

    -- Richer diff viewer and merge tool
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>",       desc = "Diff view" },
            { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
        },
    },

    -- Inline signs, blame, and hunk actions
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add          = { text = "▎" },
                change       = { text = "▎" },
                delete       = { text = "" },
                topdelete    = { text = "" },
                changedelete = { text = "▎" },
                untracked    = { text = "▎" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local map = function(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then vim.cmd.normal({ "]c", bang = true })
                    else gs.next_hunk() end
                end, "Next hunk")
                map("n", "[c", function()
                    if vim.wo.diff then vim.cmd.normal({ "[c", bang = true })
                    else gs.prev_hunk() end
                end, "Prev hunk")

                -- Hunk actions
                map("n", "<leader>hs", gs.stage_hunk,                "Stage hunk")
                map("n", "<leader>hr", gs.reset_hunk,                "Reset hunk")
                map("n", "<leader>hS", gs.stage_buffer,              "Stage buffer")
                map("n", "<leader>hu", gs.undo_stage_hunk,           "Undo stage hunk")
                map("n", "<leader>hp", gs.preview_hunk,              "Preview hunk")
                map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
                map("n", "<leader>hd", gs.diffthis,                  "Diff this")
            end,
        },
    },
}
