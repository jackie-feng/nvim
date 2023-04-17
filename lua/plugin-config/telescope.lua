require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { height = 0.8, width = 0.8, prompt_position = 'top' },
      -- center = { height = 0.6, width = 0.8, prompt_position = 'top', preview_cutoff = 20 }
      -- other layout configuration here
    },
    sorting_strategy = 'ascending',
    pickers = {},
    -- other defaults configuration here
  },
  -- other configuration values here
})
