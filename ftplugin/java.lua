local java_home = "/Users/test/Library/Java/JavaVirtualMachines/openjdk-23.0.2/Contents/Home"
local lombok_path = vim.fn.expand("~/.local/share/lombok/lombok.jar")
local jdtls_path = "/opt/homebrew/opt/jdtls/libexec"

local config = {
	cmd = {
		java_home .. "/bin/java",
		"-javaagent:" .. lombok_path,
		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		jdtls_path .. "/config_mac",
		"-data",
		vim.fn.expand("~/.cache/jdtls/workspace"),
	},
	root_dir = vim.fs.dirname(
		vim.fs.find({ "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" }, { upward = true })[1]
	),
	settings = {
		java = {
			completion = {
				importOrder = { "java", "javax", "com", "org" },
			},
		},
	},
}

require("jdtls").start_or_attach(config)

-- organize imports
vim.keymap.set("n", "<leader>oi", function()
	require("jdtls").organize_imports()
end, { desc = "Organize imports", buffer = true })

-- run current test class via toggleterm
vim.keymap.set("n", "<leader>tt", function()
	local class = vim.fn.expand("%:t:r")
	local package = ""
	for line in io.lines(vim.fn.expand("%:p")) do
		local match = line:match("^package%s+([%w%.]+)")
		if match then
			package = match
			break
		end
	end
	local fqcn = package ~= "" and (package .. "." .. class) or class
	require("toggleterm.terminal").Terminal
		:new({
			cmd = "./gradlew test --tests '" .. fqcn .. "' -x jacocoTestCoverageVerification",
			direction = "horizontal",
			close_on_exit = false,
		})
		:toggle()
end, { desc = "Run current test class", buffer = true })
