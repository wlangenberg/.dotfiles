-- LSP settings
local cmp = require('cmp')
local luasnip = require('luasnip')

vim.lsp.enable({
    "gopls", "rust_analyzer",
    "cssls", "jsonls", "lua_ls", "html",
    "htmx", "svelte", "ruff"
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client == nil then
--             return
--         end
--         if client.name == 'ruff' then
--             -- Disable hover in favor of Pyright
--             client.server_capabilities.hoverProvider = false
--         end
--     end,
--     desc = 'LSP: Disable hover capability from Ruff',
-- })

-- lspconfig.templ.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "templ" } }
-- lspconfig.html.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "html", "templ" } }
-- lspconfig.htmx.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "html", "templ" } }
-- lspconfig.ts_ls.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "typescript", "javascript", "svelte" } }
-- lspconfig.emmet_language_server.setup {
--     filetypes = { "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "htmx", "templ" },
--     init_options = {},
-- }
-- lspconfig.tailwindcss.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { "html", "astro", "javascript", "typescript", "react", "vue", "svelte", "templ", "htmlangular" },
--     init_options = { userLanguages = { templ = "html" } },
-- }
-- vim.filetype.add({ extension = { templ = "templ" } })

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
