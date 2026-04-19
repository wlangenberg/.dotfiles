local ok_ts, treesitter = pcall(require, "nvim-treesitter")
if ok_ts then
  treesitter.setup {
    install_dir = vim.fn.stdpath('data') .. '/site',
  }

  treesitter.install {
    'lua',
    'vim',
    'vimdoc',
    'javascript',
    'typescript',
    'python',
    'go',
    'templ',
    'rust',
    'c',
    'cpp',
    'html',
    'css',
    'json',
    'yaml',
    'toml',
    'bash',
    'markdown',
    'sql',
    'regex',
    'tsx',
  }
end

-- Enable treesitter highlighting via Neovim's built-in mechanism
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'lua',
    'vim',
    'javascript',
    'typescript',
    'python',
    'go',
    'templ',
    'rust',
    'c',
    'cpp',
    'html',
    'css',
    'json',
    'yaml',
    'toml',
    'sh',
    'bash',
    'markdown',
    'sql',
    'tsx',
  },
  callback = function()
    vim.treesitter.start()
  end,
})

local ok_ctx, treesitter_context = pcall(require, "treesitter-context")
if ok_ctx then
  treesitter_context.setup{
    enable = true,
    throttle = true,
  }
end
