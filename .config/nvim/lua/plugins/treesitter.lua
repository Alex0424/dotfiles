return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      configs.setup({
        ensure_installed = {
          "html",
          "css",
          "javascript",
          "typescript",
          "python",
          "bash",
          "lua",
          "java",
          "c_sharp",
          "c",
          "cpp",
          "rust",

          "markdown",
          "yaml",
          "json",
          "toml",
          "gitignore",
          --- "query", --- only needed for treesitter dev

          "dockerfile",

          "terraform",
          "hcl",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
