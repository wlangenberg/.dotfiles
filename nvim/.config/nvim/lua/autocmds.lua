-- Highlighting yanked text
vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#FFA500', fg = '#000000' })
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yanked text',
    group = vim.api.nvim_create_augroup('YankHighlightGroup', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 200 })
    end,
})

