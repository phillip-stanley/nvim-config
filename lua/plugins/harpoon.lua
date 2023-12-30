--local harpoon = require("harpoon")

-- REQUIRED
--harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>"

--vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu() end)


--vim.keymap.set('n', '<C-e>', '<cmd>lua harpoon.ui:toggle_quick_menu()<cr>')

-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu() end)
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

