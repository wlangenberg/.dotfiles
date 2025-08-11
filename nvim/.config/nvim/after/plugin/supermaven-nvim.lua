local ok, supermaven = pcall(require, "supermaven-nvim")
if not ok then
    return
end

supermaven.setup({
    keymaps = {
        accept_suggestion = "<C-k>",
        clear_suggestion = "<C-l>",
        accept_word = "<C-j>",
    },
    ignore_filetypes = { cpp = true },
    log_level = "off",
    disable_inline_completion = false,
    disable_keymaps = false,
})
