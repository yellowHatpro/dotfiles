local default_plugins = {
    "wakatime/vim-wakatime",
    "nvim-lua/plenary.nvim",
    {
      "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "yellowhatpro.plugins.configs.mason"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("yellowhatpro.core.utils").lazy_load "nvim-lspconfig"
    end,
    config = function()
      require "yellowhatpro.plugins.configs.lspconfig"
    end,
  },
}
  return default_plugins
