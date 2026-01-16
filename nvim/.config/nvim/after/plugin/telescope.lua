local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

telescope.setup {
    defaults = {
        file_ignore_patterns = { "undodir/*", ".git/", "%.min%.js$", "vendor" },
        preview = {
            timeout = 200,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'luasnip')

local telescope_builtin = require('telescope.builtin')

local my_find_files
my_find_files = function(opts, no_ignore)
    opts = opts or {}
    no_ignore = vim.F.if_nil(no_ignore, false)
    opts.attach_mappings = function(_, map)
        map({ "n", "i" }, "<C-h>", function(prompt_bufnr)
            local prompt = require("telescope.actions.state").get_current_line()
            require("telescope.actions").close(prompt_bufnr)
            no_ignore = not no_ignore
            my_find_files({ default_text = prompt }, no_ignore)
        end)
        return true
    end

    if no_ignore then
        opts.no_ignore = true
        opts.hidden = true
        opts.prompt_title = "Find Files <ALL>"
        telescope_builtin.find_files(opts)
    else
        opts.prompt_title = "Find Files"
        opts.hidden = true
        telescope_builtin.find_files(opts)
    end
end

local my_live_grep
my_live_grep = function(opts, no_ignore)
    opts = opts or {}
    no_ignore = vim.F.if_nil(no_ignore, false)

    opts.attach_mappings = function(_, map)
        map({ "n", "i" }, "<C-h>", function(prompt_bufnr)
            local prompt = require("telescope.actions.state").get_current_line()
            require("telescope.actions").close(prompt_bufnr)
            no_ignore = not no_ignore
            my_live_grep({ default_text = prompt }, no_ignore)
        end)
        return true
    end

    if no_ignore then
        opts.no_ignore = true
        opts.hidden = true
        opts.prompt_title = "Live Grep <ALL>"
        opts.additional_args = { "--hidden", "--no-ignore" }
        telescope_builtin.live_grep(opts)
    else
        opts.prompt_title = "Live Grep"
        opts.hidden = true
        telescope_builtin.live_grep(opts)
    end
end

local map = vim.keymap.set
map("n", "<leader>ff", my_find_files, { noremap = true, silent = true })
map("n", "<leader>fg", my_live_grep, { noremap = true, silent = true })
map("n", "<leader>fb", telescope_builtin.buffers, { noremap = true, silent = true })
map("n", "<leader>fh", telescope_builtin.help_tags, { noremap = true, silent = true })
map("v", "<leader>qq", '"zy:Telescope live_grep default_text=<C-r>z<CR>', { noremap = true, silent = true })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { noremap = true, silent = true })
map("n", "gd", telescope_builtin.lsp_definitions)
map("n", "gi", telescope_builtin.lsp_implementations)
map("n", "gr", telescope_builtin.lsp_references)
map("n", "<leader>K", telescope_builtin.lsp_type_definitions)

vim.keymap.del('n', 'grr')
vim.keymap.del('n', 'grn')
vim.keymap.del('n', 'grt')
vim.keymap.del('n', 'gri')
vim.keymap.del('n', 'gra')
