local ok, mason = pcall(require, "mason")
if ok then
    mason.setup()
end

local ok_lspconfig, mason_lsp = pcall(require, "mason-lspconfig")
if ok_lspconfig then
    mason_lsp.setup({
        ensure_installed = { "tailwindcss", "html", "htmx", "templ", "gopls", "lua_ls", "ts_ls", "emmet_language_server", "cssls", "eslint", "ruff" },
        automatic_installation = true,
    })
end
