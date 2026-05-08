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
    dap_configurations = {
        {
            type = "go",
            name = "Debug muninn",
            request = "launch",
            program = "./cmd/server/main.go",
            args = { "-config", "local" },
        },
        {
            type = "go",
            name = "Attach Remote",
            mode = "remote",
            request = "attach",
            port = 2345,
            substitutePath = {
              {
                from = "${workspaceFolder}",
                to = "${workspaceFolder}",
              },
            },
        },
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
