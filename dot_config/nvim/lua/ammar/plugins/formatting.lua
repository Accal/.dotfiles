return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
                desc = "Format buffer",
            },
        },
        opts = {
            -- Install formatters via Mason: :MasonInstall stylua black isort prettier goimports
            formatters_by_ft = {
                lua        = { "stylua" },
                python     = { "isort", "black" },
                go         = { "goimports", "gofmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                tsx        = { "prettier" },
                css        = { "prettier" },
                html       = { "prettier" },
                json       = { "prettier" },
                yaml       = { "prettier" },
                markdown   = { "prettier" },
                terraform  = { "terraform_fmt" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },
}
