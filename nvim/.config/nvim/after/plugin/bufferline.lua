local ok, bufferline = pcall(require, "bufferline")
if not ok then
    return
end

bufferline.setup {
    options = {
        mode = "tabs",
        show_buffer_icons = false,
        indicator = {
            icon = '|',
            style = 'icon',
        },
        separator_style = { '', '' },
        max_name_length = 28,
        max_prefix_length = 25,
        truncate_names = true,
        tab_size = 28,
    }
}
