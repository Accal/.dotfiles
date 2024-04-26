return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        opts = {
            flavour = "macchiato",
            integrations = {
                treesitter = true,
                telescope = { enabled = true },
                harpoon = true,
                gitsigns = true,
                which_key = true,
                mason = true,
                blink_cmp = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin-macchiato")
        end,
    },
}
