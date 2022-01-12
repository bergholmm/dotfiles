local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
   return
end

ts_config.setup {
   ensure_installed = {
      "lua",
      "vim",
      "css",
      "bash",
      "dockerfile",
      "fish",
      "go",
      "html",
      "javascript",
      "json",
      "markdown",
      "python",
      "rust",
      "scss",
      "toml",
      "typescript",
      "yaml",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
}
