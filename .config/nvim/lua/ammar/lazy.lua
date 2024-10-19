local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        lazy = false,
        priority = 1000, 
        config = function()
            vim.cmd([[colorscheme catppuccin-macchiato]])
        end,
    },
    {'nvim-lua/plenary.nvim'}, 
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter", 
        build = ":TsUpdate",
        lazy = false
    },
    {
        'VonHeikemen/lsp-zero.nvim', 
        branch = 'v4.x'
    },
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {
        'L3MON4D3/LuaSnip',
        version = "v2.*", 
        build = "make install_jsregexp"
    },
    {'saadparwaiz1/cmp_luasnip'},
    { "rafamadriz/friendly-snippets" },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {'mbbill/undotree'},
    {'tpope/vim-fugitive'},
    {'tpope/vim-commentary'},
    {'tpope/vim-vinegar'},
    {'tpope/vim-surround'},
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    }
})
