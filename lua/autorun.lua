local autorun_enable_command = "AutoRunEnable"
local autorun_disable_command = "AutoRunDisable"
local autorun_group_name = "autorun"

local autosave = function(bufnr, pattern)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup(autorun_group_name, { clear = true }),
        pattern = pattern,
        callback = function()
            local update_buf = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
                end
            end

            local command = {"python", vim.api.nvim_buf_get_name(0)}
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Output:" })
            vim.fn.jobstart(
                command,
                {
                    stdout_buffered = true,
                    on_stdout = update_buf,
                    on_stderr = update_buf,
                }
            )
        end
    })
end

local autorun_bufnr = 0

vim.api.nvim_create_user_command(autorun_enable_command, function ()
    autorun_bufnr = vim.api.nvim_create_buf(false, true)
    if autorun_bufnr == 0 then
        return
    end

    vim.cmd("vsplit")
    vim.api.nvim_set_current_buf(autorun_bufnr)
    vim.cmd({ cmd = "wincmd", args = { "p" }})

    autosave(autorun_bufnr, "*.py")
end,
{}
)

vim.api.nvim_create_user_command(autorun_disable_command, function ()
    vim.api.nvim_del_augroup_by_name(autorun_group_name)
end,
{}
)

vim.keymap.set("n", "<leader>ar", function ()
    vim.cmd(autorun_enable_command)
end)
vim.keymap.set("n", "<leader>ard", function ()
    vim.cmd(autorun_disable_command)
end)

