return {
    -- LSP server installer
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
        opts = {},
    },

    -- Lua LSP extras (vim API completions, type annotations)
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    -- Core LSP setup
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            -- Keymaps on LSP attach
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    map("gd",         vim.lsp.buf.definition,                                "Go to definition")
                    map("gD",         vim.lsp.buf.declaration,                               "Go to declaration")
                    map("gi",         vim.lsp.buf.implementation,                            "Go to implementation")
                    map("gr",         vim.lsp.buf.references,                                "Go to references")
                    map("K",          vim.lsp.buf.hover,                                     "Hover docs")
                    map("<leader>rn", vim.lsp.buf.rename,                                    "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action,                               "Code action")
                    map("<leader>vd", vim.diagnostic.open_float,                             "View diagnostic")
                    map("[d",         function() vim.diagnostic.jump({ count = -1 }) end,    "Prev diagnostic")
                    map("]d",         function() vim.diagnostic.jump({ count = 1 }) end,     "Next diagnostic")
                end,
            })

            -- Diagnostic display
            vim.diagnostic.config({
                float = { border = "rounded", source = true },
                virtual_text = { prefix = "●" },
                signs = true,
                underline = true,
                update_in_insert = false,
            })

            -- Hover border
            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "gopls",
                    "ruby_lsp",
                    "terraformls",
                    "cssls",
                },
                handlers = {
                    -- Default: set up each installed server with blink capabilities
                    function(server)
                        require("lspconfig")[server].setup({ capabilities = capabilities })
                    end,

                    -- Lua: suppress false-positive "vim is undefined" warnings
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = { globals = { "vim" } },
                                    workspace = { checkThirdParty = false },
                                    telemetry = { enable = false },
                                },
                            },
                        })
                    end,
                },
            })
        end,
    },
}
