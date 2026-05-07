local ok, neotest = pcall(require, "neotest")

if not ok then
    return
end

neotest.setup({
    adapters = {
        require("neotest-go")({
            experimental = {
                test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
        }),
    },
})

-- Keymaps
local map = vim.keymap.set

map("n", "<leader>tt", function() neotest.run.run() end, { noremap = true, silent = true, desc = "Test: Run nearest" })
map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { noremap = true, silent = true, desc = "Test: Run file" })
map("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, { noremap = true, silent = true, desc = "Test: Debug nearest" })
map("n", "<leader>tD", function() neotest.run.run({ vim.fn.expand("%"), strategy = "dap" }) end, { noremap = true, silent = true, desc = "Test: Debug file" })
map("n", "<leader>ts", function() neotest.summary.toggle() end, { noremap = true, silent = true, desc = "Test: Toggle summary" })
map("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { noremap = true, silent = true, desc = "Test: Open output" })
map("n", "<leader>tO", function() neotest.output_panel.toggle() end, { noremap = true, silent = true, desc = "Test: Toggle output panel" })
map("n", "<leader>tw", function() neotest.watch.toggle() end, { noremap = true, silent = true, desc = "Test: Toggle watch" })
map("n", "<leader>tW", function() neotest.watch.toggle(vim.fn.expand("%")) end, { noremap = true, silent = true, desc = "Test: Toggle watch file" })
map("n", "<leader>tl", function() neotest.run.run_last() end, { noremap = true, silent = true, desc = "Test: Run last" })
map("n", "<leader>ta", function() neotest.run.attach() end, { noremap = true, silent = true, desc = "Test: Attach to process" })
map("n", "<leader>tx", function() neotest.run.stop() end, { noremap = true, silent = true, desc = "Test: Stop" })
