-- import Rust for treesitter
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.cargo/bin")

-- PLUGINS
vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/echasnovski/mini.statusline",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/akinsho/toggleterm.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/echasnovski/mini.pairs",
	"https://github.com/echasnovski/mini.surround",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/olivercederborg/poimandres.nvim",
	"https://github.com/mfussenegger/nvim-jdtls",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/goolord/alpha-nvim",
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/olimorris/onedarkpro.nvim", name = "onedarkpro" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1.x") },
})

-- start up screen with alpha nvim
require("alpha-config")

-- default color scheme
vim.cmd("colorscheme onedark")

-- indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map jk to escape
vim.keymap.set("i", "jk", "<ESC>")

-- relative line numbers
vim.o.relativenumber = true
vim.o.number = true

-- ignore case when searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- sync filesystem clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- confirm dialog if unsaved buffer
vim.o.confirm = true

-- snappy escape
vim.o.ttimeoutlen = 1

-- vim diagnostics
vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = { source = "if_many" },
	jump = { float = true },
})

-- show diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "show diagnostics" })

-- move between windows with ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<leader>sv", "<cmd>vsp<cr><C-w>l", { desc = "Vertical split and focus" })
vim.keymap.set("n", "<leader>sh", "<cmd>sp<cr><C-w>j", { desc = "Horizontal split and focus" })

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- PLUGIN CONFIG
-- config: fzf-lua
require("fzf-lua").setup({
	keymap = {
		builtin = {
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
		},
	},
})
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Find live grep" })

-- config: LSP
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<CR>"] = { "accept", "fallback" },
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		transform_items = function(_, items)
			return vim.tbl_filter(function(item)
				return not item.label:match("^</")
			end, items)
		end,
	},
	completion = {
		menu = {
			auto_show = true,
		},
		list = {
			selection = {
				preselect = true,
			},
		},
	},
})

-- config: LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end
		map("gd", vim.lsp.buf.definition, "Go to definition")
		map("gr", vim.lsp.buf.references, "Go to references")
		map("gI", vim.lsp.buf.implementation, "Go to implementation")
		map("gy", vim.lsp.buf.type_definition, "Go to type definition")
		map("K", vim.lsp.buf.hover, "Hover documentation")
		map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", "Find document symbols")
	end,
})

vim.lsp.enable({
	"ts_ls",
	"svelte",
	"html",
	"cssls",
	"tailwindcss",
	"emmet_language_server",
	"lua_ls",
})
vim.o.signcolumn = "yes"

-- config: neoscroll
require("neoscroll").setup({
	hide_cursor = false,
	stop_eof = true,
	easing = "quadratic",
	duration_multiplier = 0.30,
})

-- config: oil
require("oil").setup({
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Kanagawa colorscheme
require("kanagawa").setup({
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
})

-- Catppuccin colorcheme
require("catppuccin").setup({
	flavour = "auto",
})

-- config: treesitter
require("nvim-treesitter").setup({
	ensure_installed = {
		"javascript",
		"typescript",
		"svelte",
		"css",
		"lua",
		"java",
	},
	auto_install = true,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "svelte", "javascript", "typescript", "html", "css", "lua", "java" },
	callback = function()
		vim.treesitter.start()
	end,
})

-- config: toggleterm
require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	shade_terminals = false,
})
local Terminal = require("toggleterm.terminal").Terminal
local horizontal = Terminal:new({ direction = "horizontal", hidden = true })
local vertical = Terminal:new({ direction = "vertical", hidden = true })
local floating = Terminal:new({
	direction = "float",
	hidden = true,
	float_opts = {
		border = "rounded",
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.8),
	},
})
vim.keymap.set({ "n", "t" }, "<M-h>", function()
	horizontal:toggle()
end, { desc = "Toggle horizontal terminal" })
vim.keymap.set({ "n", "t" }, "<M-v>", function()
	vertical:toggle()
end, { desc = "Toggle vertical terminal" })
vim.keymap.set({ "n", "t" }, "<M-f>", function()
	floating:toggle()
end, { desc = "Toggle floating terminal" })

-- config: conform
require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		svelte = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		java = { "google-java-format" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer" })

-- theme picker
vim.keymap.set("n", "<leader>th", function()
	require("fzf-lua").colorschemes({
		live_preview = true,
		winopts = {
			height = 0.5,
			width = 0.3,
		},
	})
end, { desc = "Theme picker" })

-- config: gitsigns
require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
	},
})
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })
vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })

-- config: which-key
require("which-key").setup()

-- config: todo-comments
require("todo-comments").setup()
vim.keymap.set("n", "<leader>ft", "<cmd>FzfLua todo_comments<cr>", { desc = "Find TODOs" })

-- config: mini.pairs
require("mini.pairs").setup()

-- config: mini.surround
require("mini.surround").setup()

-- config: mini-icons
require("mini.icons").setup()

-- config: mini.statusline
require("mini.statusline").setup({
	use_icons = true,
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode:upper() } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
})

-- config: bufferline
require("bufferline").setup({
	options = {
		mode = "buffers",
		separator_style = "thin",
		show_buffer_close_icons = true,
		show_close_icon = false,
		color_icons = true,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		offsets = {
			{
				filetype = "oil",
				text = "File Explorer",
				highlight = "Directory",
				separator = true,
			},
		},
	},
})
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close buffer" })
