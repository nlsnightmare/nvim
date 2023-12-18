local function dd(arg)
	print(vim.inspect(arg))
end

local function get_namespace(config)
	local file = config.filename
	if string.match(file, ".php$") then
		local folder = vim.split(file, "/app/")
		local ns = string.gsub(folder[2], "/[^/]*.php", "")

		ns = string.gsub(ns, "/[a-zA-Z]*.php", "")
		ns = string.gsub(ns, "/", "\\")
		return "App\\" .. ns
	end

	return "PLACEHOLDER_NAMESPACE"
end
require("skel-nvim").setup({
	mappings = {
		["*.php"] = "php.skel",
	},
	substitutions = {
		["NAMESPACE"] = get_namespace,
	},
})
