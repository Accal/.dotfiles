return {
    {
        "saghen/blink.cmp",
        -- Use a stable release. Check https://github.com/Saghen/blink.cmp/releases for latest.
        version = "1.*",
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
            -- Default keymap preset:
            --   <C-space>  trigger completion
            --   <C-e>      cancel
            --   <CR>       accept
            --   <Tab>/<S-Tab> navigate items or snippet placeholders
            --   <C-b>/<C-f> scroll docs
            keymap = { preset = "default" },

            appearance = {
                -- Use "mono" for Nerd Font Mono, "normal" for standard Nerd Fonts
                nerd_font_variant = "mono",
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            -- Show function signature while typing arguments
            signature = { enabled = true },

            completion = {
                menu = {
                    border = "rounded",
                    draw = {
                        -- Show kind icon + label + kind name
                        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = "rounded" },
                },
            },
        },
    },
}
