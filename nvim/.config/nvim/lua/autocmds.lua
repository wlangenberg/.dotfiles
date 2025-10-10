-- Highlighting yanked text
vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#FFA500', fg = '#000000' })
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yanked text',
    group = vim.api.nvim_create_augroup('YankHighlightGroup', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 200 })
    end,
})

-- Prepend jira ticket number from branch name to commit message
local gitcommit_augroup = vim.api.nvim_create_augroup("GitCommitBranchPrefix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  desc = "Prepend ticket number from branch name to commit message",
  callback = function()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("^%s*(.-)%s*$", "%1")
    local pattern = "([A-Za-z]+%-%d+)"
    local prefix = branch:match(pattern)
    if prefix and prefix ~= "HEAD" then
      local new_line = prefix .. ": "
      vim.api.nvim_buf_set_lines(0, 0, 0, false, {new_line})
      vim.api.nvim_win_set_cursor(0, {1, #new_line + 1})
    end
  end,
  group = gitcommit_augroup,
})
