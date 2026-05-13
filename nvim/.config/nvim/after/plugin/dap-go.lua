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

-- Load project-local dap config
local project_dap = vim.fn.getcwd() .. "/.nvim_debug_cfg/dap.lua"

if vim.fn.filereadable(project_dap) == 1 then
    dofile(project_dap)
end

-- Additional Go-specific keymaps
local map = vim.keymap.set

map("n", "<leader>dgt", function()
    require("dap-go").debug_test()
end, { noremap = true, silent = true, desc = "Debug: Go test (nearest)" })

map("n", "<leader>dgl", function()
    require("dap-go").debug_last_test()
end, { noremap = true, silent = true, desc = "Debug: Go test (last)" })
