local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- All plugin specs live in lua/ammar/plugins/*.lua
-- Each file returns a table (or list of tables) of lazy plugin specs
require("lazy").setup({
    { import = "ammar.plugins" },
}, {
    change_detection = { notify = false },
    ui = { border = "rounded" },
})
