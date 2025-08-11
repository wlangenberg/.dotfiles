local function buffer_name_generator(opts)
    vim.notify(vim.inspect(opts), vim.log.levels.INFO)
    if not opts.table or opts.table == '' then
        return 'query-' .. os.time() .. '.sql'
    end
    return 'query-table-' .. opts.table .. '-' .. os.time() .. '.sql'
end
vim.g.Db_ui_buffer_name_generator = buffer_name_generator
