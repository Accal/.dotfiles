-- UI
vim.opt.guicursor    = ""           -- block cursor in all modes
vim.opt.nu           = true
vim.opt.relativenumber = true
vim.opt.signcolumn   = "yes"        -- always show, prevents layout shifts
vim.opt.termguicolors = true
vim.opt.scrolloff    = 8            -- keep 8 lines visible around cursor
vim.opt.wrap         = false

-- Indentation (4 spaces)
vim.opt.tabstop      = 4
vim.opt.softtabstop  = 4
vim.opt.shiftwidth   = 4
vim.opt.expandtab    = true
vim.opt.smartindent  = true

-- Search
vim.opt.hlsearch     = false        -- don't keep highlights after search
vim.opt.incsearch    = true

-- Files
vim.opt.swapfile     = false
vim.opt.backup       = false
vim.opt.undofile     = true
vim.opt.undodir      = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.updatetime   = 50           -- faster CursorHold (affects gitsigns, LSP)

-- Misc
vim.opt.isfname:append("@-@")       -- treat @ as part of filenames (for imports)

-- Custom file-type detection
vim.filetype.add({ extension = { jenkinsfile = "groovy" } })

-- Comment strings for HCL/Terraform (default is //)
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("CustomCommentStrings", { clear = true }),
    pattern = { "terraform", "hcl" },
    callback = function() vim.opt_local.commentstring = "#%s" end,
})
