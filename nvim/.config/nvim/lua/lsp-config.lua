-- LSP settings
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local luasnip = require('luasnip')
local lsp_util = require('lspconfig.util')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(_, _)
end

vim.lsp.enable({
    "gopls", "rust_analyzer", "tsserver",
    "cssls", "jsonls", "lua_ls", "templ_ls", "html",
    "htmx", "svelte", "ruff"
})

-- Ruff LSP
lspconfig.ruff.setup({
    init_options = {
        settings = {
            args = {
                "--config", vim.fn.expand("~/.config/ruff/pyproject.toml"),
            },
            logLevel = 'debug',
        }
    }
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == 'ruff' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
        end
    end,
    desc = 'LSP: Disable hover capability from Ruff',
})

-- OmniSharp
lspconfig.omnisharp.setup {
    cmd = { "/usr/local/bin/omnisharp", "--languageserver" },
    enable_import_completion = true,
    settings = {
        FormattingOptions = {
            EnableEditorConfigSupport = true,
            EnableFormatting = true,
            OrganizeImports = false,
        },
        MsBuild = { LoadProjectsOnDemand = false },
        RoslynExtensionsOptions = {
            EnableDecompilationSupport = true,
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = false,
        },
        Sdk = { IncludePrereleases = true },
    },
    on_attach = function(_, bufnr)
        local buf_set_keymap = function(mode, key, action, desc)
            vim.api.nvim_buf_set_keymap(bufnr, mode, key, action, { noremap = true, silent = true, desc = desc })
        end

        buf_set_keymap('n', 'gd', "<cmd>lua require('omnisharp_extended').lsp_definition()<CR>", "Go to Definition")
        buf_set_keymap('n', 'gi', "<cmd>lua require('omnisharp_extended').lsp_implementation()<CR>",
            "Go to Implementation")
        buf_set_keymap('n', '<leader>K', "<cmd>lua require('omnisharp_extended').lsp_type_definition()<CR>",
            "Type Definition")
        buf_set_keymap('n', 'gr', "<cmd>lua require('omnisharp_extended').telescope_lsp_references()<CR>",
            "Find References")
        print("OmniSharp LSP attached for buffer " .. bufnr)
    end,
    capabilities = capabilities
}

-- Other LSP servers
lspconfig.clangd.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.volar.setup { on_attach = on_attach, capabilities = capabilities }
lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "javascript", "typescript", "vue" },
    settings = { format = { enable = false }, logLevel = "debug" }
}
lspconfig.sqlls.setup {
    on_attach = on_attach,
    filetypes = { "sql", "mysql" },
    root_dir = function() return vim.loop.cwd() end,
}
lspconfig.templ.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "templ" } }
lspconfig.html.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "html", "templ" } }
lspconfig.htmx.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "html", "templ" } }
lspconfig.ts_ls.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { "typescript", "javascript", "svelte" } }
lspconfig.emmet_language_server.setup {
    filetypes = { "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "htmx", "templ" },
    init_options = {},
}
lspconfig.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "astro", "javascript", "typescript", "react", "vue", "svelte", "templ", "htmlangular" },
    init_options = { userLanguages = { templ = "html" } },
}
lspconfig.angularls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
    root_dir = lsp_util.root_pattern('angular.json', 'nx.json')
}

vim.filetype.add({ extension = { templ = "templ" } })

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

vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function() vim.bo.commentstring = "--%s" end,
})

-- Make autopairs and completion work together
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
