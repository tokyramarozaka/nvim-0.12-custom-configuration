return {
  filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "svelte" },
  init_options = {
    plugins = {
      {
        name = "typescript-svelte-plugin",
        location = vim.fn.expand("$HOME/.npm-packages/lib/node_modules/typescript-svelte-plugin"),
      },
    },
    preferences = {
      importModuleSpecifierPreference = "relative",
    },
  },
}
