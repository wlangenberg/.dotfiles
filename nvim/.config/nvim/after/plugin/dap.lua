local ok_dap, dap = pcall(require, "dap")
local ok_dapui, dapui = pcall(require, "dapui")

if not ok_dap then
    return
end

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>dc", dap.continue, { noremap = true, silent = true, desc = "Debug: Continue/Start" })
map("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, silent = true, desc = "Debug: Toggle breakpoint" })
map("n", "<leader>do", dap.step_over, { noremap = true, silent = true, desc = "Debug: Step over" })
map("n", "<leader>di", dap.step_into, { noremap = true, silent = true, desc = "Debug: Step into" })
map("n", "<leader>dO", dap.step_out, { noremap = true, silent = true, desc = "Debug: Step out" })
map("n", "<leader>dr", dap.repl.open, { noremap = true, silent = true, desc = "Debug: Open REPL" })
map("n", "<leader>dl", dap.run_last, { noremap = true, silent = true, desc = "Debug: Run last" })
map("n", "<leader>dx", dap.terminate, { noremap = true, silent = true, desc = "Debug: Terminate" })

-- Dap UI
if ok_dapui then
    dapui.setup({
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 1 },
                },
                size = 0.3,
                position = "bottom",
            },
        },
        floating = {
            max_height = nil,
            max_width = nil,
            border = "single",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil,
            max_value_lines = 100,
        },
    })

    -- Toggle UI keymap
    map("n", "<leader>du", dapui.toggle, { noremap = true, silent = true, desc = "Debug: Toggle UI" })

    -- Automatically open/close UI when debugging starts/stops
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end
