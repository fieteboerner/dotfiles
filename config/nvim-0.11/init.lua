local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
    require("flitzfiete.bootstrap").lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)

require("flitzfiete.plugins")
require("flitzfiete.options")
require("flitzfiete.keymaps").setup()
