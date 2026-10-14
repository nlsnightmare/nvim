-- File Templates
return {
	"motosir/skel-nvim",
	opts = {
		mappings = {
			["*.php"] = "php.skel",
			["*.cs"] = "cs.skel",
		},
		substitutions = {
			["NAMESPACE"] = function(config)
				local file = config.filename
				if file:match("%.cs$") then
					return require("maru.snippets").namespace(file)
				end

				if string.match(file, "/app/.*.php$") then
					local folder = vim.split(file, "/app/")
					local ns = string.gsub(folder[2], "/[^/]*.php", "")

					ns = string.gsub(ns, "/[a-zA-Z]*.php", "")
					ns = string.gsub(ns, "/", "\\")
					return "App\\" .. ns
				end

				return "PLACEHOLDER_NAMESPACE"
			end,
		},
	},
}
