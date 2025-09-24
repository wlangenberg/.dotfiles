local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    defaults = { lazy = true },
    performance = {
        cache = {
            enabled = true,
        },
        rtp = {
            disabled_plugins = {
                "netrwPlugin",
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    debug = false,
    {
        'hrsh7th/nvim-cmp',
        Lazy = false,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons", }
    },
    {
        'junegunn/fzf',
        run = function() vim.fn['fzf#install']() end
    },
    "chomosuke/typst-preview.nvim",
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
    'junegunn/fzf.vim',
    "tpope/vim-obsession",
    "tpope/vim-repeat",
    {
        "tpope/vim-surround",
        event = "VeryLazy"
    },
    "tpope/vim-dadbod",
    'kristijanhusak/vim-dadbod-ui',
    {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true
    },
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    },
    'nvim-telescope/telescope-symbols.nvim',
    "benfowler/telescope-luasnip.nvim",
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme tokyonight")
        end
    },
    'mfussenegger/nvim-lint',
    "sindrets/diffview.nvim",
    'tpope/vim-fugitive',
    'tpope/vim-commentary',
    'windwp/nvim-autopairs',
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            CustomOilBar = function()
                local path = vim.fn.expand "%"
                path = path:gsub("oil://", "")

                return "  " .. vim.fn.fnamemodify(path, ":.")
            end

            require("oil").setup {
                columns = { "icon" },
                keymaps = {
                    -- ["<C-h>"] = false,
                    -- ["<C-l>"] = false,
                    -- ["<C-k>"] = false,
                    -- ["<C-j>"] = false,
                    ["<M-h>"] = "actions.select_split",
                },
                win_options = {
                    winbar = "%{v:lua.CustomOilBar()}",
                },
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name, _)
                        local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
                        return vim.tbl_contains(folder_skip, name)
                    end,
                },
            }

            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            vim.keymap.set("n", "<space>-", require("oil").toggle_float)
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        }
    },
})
