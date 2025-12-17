return {
  '504sarwarerror/DOTNVIM',
  config = function()
    -- Stack Visualization
    require('stack_visualization').setup({
      auto_start = true,
      keybindings = {
        toggle = '<leader>sv',
      },
      filetypes = { 'asm', 'nasm' },
    })
    
    -- ObjDump Mapping
    require('objdump_mapping').setup({
      auto_start = false,
      keybindings = {
        toggle = '<leader>om',      -- Toggle objdump mapping
        refresh = '<leader>or',     -- Refresh mapping
        select_exe = '<leader>oe',  -- Select executable
      },
      filetypes = { 'asm', 'nasm', 's' },
      objdump_cmd = 'objdump',      -- or 'llvm-objdump'
      objdump_flags = '-d -M intel',
      address_format = 'short',     -- 'short' or 'full'
    })
  end,
  ft = { 'asm', 'nasm', 's' },
}
