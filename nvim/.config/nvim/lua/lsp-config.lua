-- LSP settings
local cmp = require('cmp')
local luasnip = require('luasnip')

vim.lsp.enable({
    "eslint", "tsserver", "ts_ls",
    "gopls", "rust_analyzer",
    "cssls", "jsonls", "lua_ls", "html",
    "svelte", "ruff", "openapi", "vacuum",
    "emmet_language_server", "tailwindcss"
})

-- gopls configuration with formatting and analyses
vim.lsp.config("gopls", {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})

-- Emmet language server configuration with templ support
vim.lsp.config("emmet_language_server", {
    filetypes = { "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "htmx", "templ", "go" },
    init_options = {},
})

-- vim.lsp.config("tailwindcss", {
--     filetypes = { "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "htmx", "templ", "go" },
--     init_options = {},
-- })
vim.lsp.config("tailwindcss", {
    filetypes = {
        "eruby", "html", "javascript", "javascriptreact",
        "less", "sass", "scss", "pug", "typescriptreact",
        "htmx", "templ", "go"
    },
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    -- matches class="..."
                    "class\\s*=\\s*\"([^\"]*)\"",
                    -- matches Class("...")
                    "Class\\(\"([^\"]*)\"\\)",
                    -- matches gomponents Attr("class", "...")
                    "Attr\\(\"class\",\\s*\"([^\"]*)\"\\)",
                },
            },
        },
    },
})

-- nvim-cmp setup
cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, { { name = 'buffer' } })
})

-- SQL completion settings
cmp.setup.filetype('sql', {
    sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
    },
})

-- Make autopairs and completion work together
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
