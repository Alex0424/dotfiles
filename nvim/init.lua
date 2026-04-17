require("config.lazy")

vim.opt.clipboard = "unnamedplus" -- copy to clipboard

vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#000000', bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })

vim.opt.shiftwidth = 2   -- 2 spaces for autoindent
vim.opt.tabstop = 2      -- \t = 2 spaces
vim.opt.softtabstop = 2  -- 2 spaces when you hit tab
vim.opt.expandtab = true -- spaces instead of tab character
