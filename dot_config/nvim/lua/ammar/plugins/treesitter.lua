return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        lazy = false,
        init = function()
            local query = vim.treesitter and vim.treesitter.query
            if not query or query._ammar_all_compat_shim then
                return
            end

            local function to_single_capture_match(match)
                local single = {}
                for id, nodes in pairs(match) do
                    if type(id) == "number" then
                        if type(nodes) == "table" then
                            single[id] = nodes[#nodes]
                        else
                            single[id] = nodes
                        end
                    end
                end
                return single
            end

            local add_predicate = query.add_predicate
            query.add_predicate = function(name, handler, opts)
                local use_single_capture = type(opts) == "table" and opts.all == false
                if not use_single_capture then
                    return add_predicate(name, handler, opts)
                end

                local wrapped = function(match, ...)
                    return handler(to_single_capture_match(match), ...)
                end
                return add_predicate(name, wrapped, opts)
            end

            local add_directive = query.add_directive
            query.add_directive = function(name, handler, opts)
                local use_single_capture = type(opts) == "table" and opts.all == false
                if not use_single_capture then
                    return add_directive(name, handler, opts)
                end

                local wrapped = function(match, ...)
                    return handler(to_single_capture_match(match), ...)
                end
                return add_directive(name, wrapped, opts)
            end

            query._ammar_all_compat_shim = true
        end,
        main = "nvim-treesitter.configs",
        opts = function()
            local parser_install_dir = vim.fn.stdpath("data") .. "/site"
            if not vim.tbl_contains(vim.opt.runtimepath:get(), parser_install_dir) then
                vim.opt.runtimepath:prepend(parser_install_dir)
            end

            return {
                parser_install_dir = parser_install_dir,
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
            }
        end,
    },
}
