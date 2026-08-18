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

return M
