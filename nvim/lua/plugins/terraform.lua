return {
  -- Mason (required)
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Mason LSP bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "terraformls" },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("terraformls", {})
      vim.lsp.enable("terraformls")
    end,
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
