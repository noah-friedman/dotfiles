function Insp(...)
    print(vim.inspect(...))
end

vim.api.nvim_create_user_command("Insp", function(opts)
    Insp(table.unpack(opts))
end, {})
