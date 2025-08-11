local ok_ts, treesitter = pcall(require, "nvim-treesitter.configs")
if ok_ts then
  treesitter.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
  }
end

local ok_ctx, treesitter_context = pcall(require, "treesitter-context")
if ok_ctx then
  treesitter_context.setup{
    enable = true,
    throttle = true,
  }
end
