local ok, undotree = pcall(require, "undotree")
if not ok then
    return
end

undotree.setup()
