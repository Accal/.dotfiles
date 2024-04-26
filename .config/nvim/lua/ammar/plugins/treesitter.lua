return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = {
                "bash", "hcl", "javascript", "typescript", "tsx",
                "python", "groovy", "java", "lua", "vim", "vimdoc",
                "query", "rust", "go", "ruby", "html", "css",
                "json", "yaml", "toml", "markdown", "markdown_inline",
            },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}
