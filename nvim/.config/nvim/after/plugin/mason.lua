local ok, mason = pcall(require, "mason")
if ok then
    mason.setup()
end

local ok_lspconfig, mason_lsp = pcall(require, "mason-lspconfig")
if ok_lspconfig then
    mason_lsp.setup({
        ensure_installed = { "eslint", "ruff", "tailwindcss", "html", "templ", "gopls", "lua_ls", "ts_ls", "emmet_language_server", "cssls" },
        automatic_installation = true,
    })
end
