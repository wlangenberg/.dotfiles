local ok, dap_go = pcall(require, "dap-go")

if not ok then
    return
end

dap_go.setup({
    delve = {
        path = "dlv",
        initialize_timeout_sec = 20,
        args = {},
        build_flags = "",
        detached = true,
        cwd = nil,
    },
    tests = {
        verbose = false,
    },
})

-- Additional Go-specific keymaps
local map = vim.keymap.set

map("n", "<leader>dgt", function()
    require("dap-go").debug_test()
end, { noremap = true, silent = true, desc = "Debug: Go test (nearest)" })

map("n", "<leader>dgl", function()
    require("dap-go").debug_last_test()
end, { noremap = true, silent = true, desc = "Debug: Go test (last)" })
