return {
	filetypes = { "html", "svelte" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
		autoClosingTags = false,
	},
	settings = {
		html = {
			suggest = {
				html5 = true,
			},
			autoClosingTags = false,
		},
	},
}
