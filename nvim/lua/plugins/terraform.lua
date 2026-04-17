return {
  -- LSP (Neovim 0.11+ style)
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("terraformls", {
        settings = {},
      })

      vim.lsp.enable("terraformls")
    end,
  },

  -- Mason (auto-install LSP)
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "terraformls" },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
      },
    },
  },
}
