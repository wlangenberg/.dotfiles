local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

-- Custom on_attach for nvim-tree
local function nvim_tree_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.del("n", "<C-]>", { buffer = bufnr })
    vim.keymap.del("n", "C", { buffer = bufnr })
    vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
end

nvim_tree.setup({
    on_attach = nvim_tree_on_attach,
    sort = { sorter = "case_sensitive" },
    view = {
        centralize_selection = true,
        number = true,
        relativenumber = true,
        width = { min = 30, max = -1, padding = 1 },
    },
    actions = {
        change_dir = {
            enable = true,
            global = true,
            restrict_above_cwd = false,
        },
    },
    renderer = { group_empty = true },
    filters = { dotfiles = true },
    live_filter = { always_show_folders = false },
})
