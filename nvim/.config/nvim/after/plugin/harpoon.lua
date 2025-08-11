local ok, harpoon = pcall(require, "harpoon")
if not ok then
    return
end

harpoon.setup()

local map = vim.keymap.set
map("n", "<leader>aa", function() harpoon:list():add() print("Added to harpoon") end)
map("n", "<leader>al", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
map("n", "<leader>aj", function() harpoon:list():select(1) print("Go to harpoon 1") end)
map("n", "<leader>ak", function() harpoon:list():select(2) print("Go to harpoon 2") end)
map("n", "<leader>au", function() harpoon:list():select(3) print("Go to harpoon 3") end)
map("n", "<leader>ai", function() harpoon:list():select(4) print("Go to harpoon 4") end)
map("n", "<leader>ao", function() harpoon:list():select(5) print("Go to harpoon 5") end)
map("n", "<leader>ap", function() harpoon:list():prev() end)
map("n", "<leader>an", function() harpoon:list():next() end)
