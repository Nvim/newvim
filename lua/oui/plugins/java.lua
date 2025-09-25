local j = {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	config = function()
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = "/home/naim/Code/Epita/JAVA/jdtls-data/" .. project_name
		local cfg = {
			root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
			cmd = {
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",

				-- I should replace this with some hook to read the path
				"-jar",
				"/home/naim/Code/Epita/JAVA/jdtls-jars/equinox/equinox.jar",
				"-configuration",
				"/home/naim/Code/Epita/JAVA/jdtls-jars/configuration",

				"-data",
				workspace_dir,
			},
		}
		require("jdtls").start_or_attach(cfg)
	end,
}
return {}
