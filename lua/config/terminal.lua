local terminal_state = {
    buf = nil,
    win = nil,
    is_open = false
}

local function floatingTerminal()
    -- toggle terminal
    if terminal_state.is_open and vim.api.nvim_win_is_avalid(terminal_state.wim) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
        return
    end

    if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
        terminal_state.buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(terminal_state.buf, 'bufhidden', 'hide')
    end

    terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
        relative = 'editor',
        style = 'minimal',
        border = 'rounded'
    })

    local has_terminal = false
    local line = vi.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, fasle)
    for _, line in ipairs(lines) do
        if line ~= "" then
            has_terminal = true
            break
        end
    end

    if not has_terminal then
        vim.fn.termopen(os.getenv("SHELL"))
    end

    terminal_state.is_open = true
    vim.cmd("startinsert")

    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = terminal_state.buf,
        callback = function()
            if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
                vim.api.nvim_win_close(terminal_state.win, fasle)
                terminal_state.is_open = false
            end
        end,
        once = true
    })
end
