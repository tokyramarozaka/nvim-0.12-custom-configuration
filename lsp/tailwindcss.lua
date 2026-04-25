return {
  filetypes = {
    "html", "css", "svelte",
    "javascript", "typescript",
    "javascriptreact", "typescriptreact",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "clsx\\(([^)]*)\\)", "\"([^\"]*)\"" },
          { "cn\\(([^)]*)\\)", "\"([^\"]*)\"" },
          { "cva\\(([^)]*)\\)", "\"([^\"]*)\"" },
        },
      },
    },
  },
}
