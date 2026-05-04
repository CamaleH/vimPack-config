local M = {
	repo = "L3MON4D3/LuaSnip",
}

function M.setup()
	require("luasnip").config.set_config({
		region_check_events = "CursorHold,InsertLeave",
		delete_check_events = "TextChanged,InsertEnter",
		update_events = "TextChanged,TextChangedI",
	})
end

return M
