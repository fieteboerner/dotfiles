local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- bootstrap lazy.nvim!
if not uv.fs_stat(lazypath) then
    require("flitzfiete.bootstrap").lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)

require("flitzfiete.plugins")
require("flitzfiete.options")
require("flitzfiete.keymaps").setup()
require("flitzfiete.lsp.native").setup()
require("flitzfiete.utils.coderabbit").setup()
