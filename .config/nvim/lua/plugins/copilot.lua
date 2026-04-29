return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require("copilot").setup({
      panel = {
        enabled = false, -- i will check it out later
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = "<C-W>",
          next = "<C-D>",
          prev = "<C-A>",
          dismiss = "<C-S>",
        },
      }, 
    })
  end,
}
