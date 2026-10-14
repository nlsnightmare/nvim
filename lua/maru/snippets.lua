-- Helpers for the snipmate snippets in snippets/, called from the templates
-- through `v:lua.require'maru.snippets'....` backticks, and from
-- lua/plugins/skel.lua for the skeleton files.
local M = {}

-- snake_case name as a PascalCase class name, defaulting to the filename of
-- the buffer being edited: user_profile_card.dart -> UserProfileCard
function M.class_name(name)
	name = name or vim.fn.expand("%:t:r")

	return (name:gsub("(%a)([^_]*)_?", function(head, rest)
		return head:upper() .. rest
	end))
end

-- MSBuild turns anything that is not a valid identifier character into "_",
-- and prefixes a leading digit: "day-1" -> "day_1", "2d" -> "_2d". Dots
-- survive as namespace separators, so each part is sanitized on its own.
local function identifier(name)
	local parts = {}
	for part in name:gmatch("[^.]+") do
		part = part:gsub("[^%w_]", "_")
		table.insert(parts, part:match("^%d") and "_" .. part or part)
	end

	return table.concat(parts, ".")
end

-- The namespace roslyn would expect for a C# file: <RootNamespace> of the
-- nearest .csproj (defaulting to the project file's own name) followed by the
-- folders between that .csproj and the file.
function M.namespace(file)
	file = file or vim.fn.expand("%:p")
	local dir = vim.fs.dirname(file)

	local csproj = vim.fs.find(function(name)
		return name:match("%.csproj$")
	end, { path = dir, upward = true, type = "file" })[1]

	if not csproj then
		return identifier(vim.fn.fnamemodify(dir, ":t"))
	end

	local msbuild = vim.system({ "dotnet", "msbuild", csproj, "-getProperty:RootNamespace" }):wait(10000)
	local root = vim.trim(msbuild.stdout)
	if msbuild.code ~= 0 or root == "" then
		root = vim.fn.fnamemodify(csproj, ":t:r")
	end

	local parts = { identifier(root) }
	local relative = dir:sub(#vim.fs.dirname(csproj) + 2)
	for part in relative:gmatch("[^/]+") do
		table.insert(parts, identifier(part))
	end

	return table.concat(parts, ".")
end

return M
