local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	"                                                     ",
	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                     ",
}

dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", "<cmd>ene<cr>"),
	dashboard.button("f", "  Find file", "<cmd>FzfLua files<cr>"),
	dashboard.button("r", "  Recent files", "<cmd>FzfLua oldfiles<cr>"),
	dashboard.button("g", "  Live grep", "<cmd>FzfLua live_grep<cr>"),
	dashboard.button("t", "  Theme picker", "<cmd>lua require('fzf-lua').colorschemes({ live_preview = true })<cr>"),
	dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
}

local function footer()
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	local version = vim.version()
	local nvim_version = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
	return datetime .. nvim_version
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "alpha",
	callback = function()
		vim.opt_local.foldenable = false
	end,
})
