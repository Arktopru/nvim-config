-- Set our leader keybinding to space
-- Anywhere you see <leader> in a keymapping specifies the space key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remove search highlights after searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

-- Exit Vim's terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- OPTIONAL: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Better window navigation
vim.keymap.set("n", "<C-h>", ":wincmd h<cr>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", ":wincmd l<cr>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", ":wincmd j<cr>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", ":wincmd k<cr>", { desc = "Move focus to the upper window" })

-- vim.keymap.set("n", "<leader>tc", ":tabnew<cr>", { desc = "[T]ab [C]reat New" })
-- vim.keymap.set("n", "<leader>tn", ":tabnext<cr>", { desc = "[T]ab [N]ext" })
-- vim.keymap.set("n", "<leader>tp", ":tabprevious<cr>", { desc = "[T]ab [P]revious" })

-- Easily split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left in visual mode" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right in visual mode" })

-- Move to previous/next
vim.keymap.set("n", "<leader>b,", "<Cmd>BufferPrevious<CR>", { desc = "[B]uffer previous [,]" })
vim.keymap.set("n", "<leader>b.", "<Cmd>BufferNext<CR>", { desc = "[B]uffer next [.]" })

-- Re-order to previous/next
vim.keymap.set("n", "<leader>b<", "<Cmd>BufferMovePrevious<CR>", { desc = "[B]uffer reorder to previous [<]" })
vim.keymap.set("n", "<leader>b>", "<Cmd>BufferMoveNext<CR>", { desc = "[B]uffer reorder to next [>]" })

-- Goto buffer in position...
vim.keymap.set("n", "<leader>b1", "<Cmd>BufferGoto 1<CR>", { desc = "[B]uffer go to [1]" })
vim.keymap.set("n", "<leader>b2", "<Cmd>BufferGoto 2<CR>", { desc = "[B]uffer go to [2]" })
vim.keymap.set("n", "<leader>b3", "<Cmd>BufferGoto 3<CR>", { desc = "[B]uffer go to [3]" })
vim.keymap.set("n", "<leader>b4", "<Cmd>BufferGoto 4<CR>", { desc = "[B]uffer go to [4]" })
vim.keymap.set("n", "<leader>b5", "<Cmd>BufferGoto 5<CR>", { desc = "[B]uffer go to [5]" })
vim.keymap.set("n", "<leader>b6", "<Cmd>BufferGoto 6<CR>", { desc = "[B]uffer go to [6]" })
vim.keymap.set("n", "<leader>b7", "<Cmd>BufferGoto 7<CR>", { desc = "[B]uffer go to [7]" })
vim.keymap.set("n", "<leader>b8", "<Cmd>BufferGoto 8<CR>", { desc = "[B]uffer go to [8]" })
vim.keymap.set("n", "<leader>b9", "<Cmd>BufferGoto 9<CR>", { desc = "[B]uffer go to [9]" })
vim.keymap.set("n", "<leader>b0", "<Cmd>BufferLast<CR>", { desc = "[B]uffer go to [0]" })

-- Pin/unpin buffer
vim.keymap.set("n", "<leader>bp", "<Cmd>BufferPin<CR>", { desc = "[B]uffer [P]in / unpin buffer" })

-- Goto pinned/unpinned buffer
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned

-- Close buffer
vim.keymap.set("n", "<leader>bc", "<Cmd>BufferClose<CR>", { desc = "[B]uffer [C]lose" })

-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- Magic buffer-picking mode
-- vim.keymap.set('n', '<C-p>',   '<Cmd>BufferPick<CR>', {desc = "[B]uffer []"})
-- vim.keymap.set('n', '<C-s-p', '<Cmd>BufferPickDelete<CR>', {desc = "[B]uffer []"})

-- Sort automatically by...
vim.keymap.set("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", { desc = "[B]uffer by [B]uffer number" })
vim.keymap.set("n", "<leader>bn", "<Cmd>BufferOrderByName<CR>", { desc = "[B]uffer by [N]ame" })
vim.keymap.set("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", { desc = "[B]uffer by [D]irectory" })
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", { desc = "[B]uffer by [L]nguage" })
vim.keymap.set("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", { desc = "[B]uffer by [W]indow number" })

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
--
vim.keymap.set("n", "<leader>tc", function()
    if vim.bo.filetype == "java" then
        require("jdtls").test_class()
    end
end, {desc = "[T]est [C]lass"})

vim.keymap.set("n", "<leader>tm", function()
    if vim.bo.filetype == "java" then
        require("jdtls").test_nearest_method()
    end
end, {desc = "[T]est [M]ethod"})

-- Diff keymaps
vim.keymap.set("n", "<leader>qc", ":diffput<CR>", {desc = "[Q] diff from [C]urrent to other"}) -- put diff from current to other during diff
vim.keymap.set("n", "<leader>qj", ":diffget 1<CR>", {desc = "[Q] [J] diff from left (local) during merge"}) -- get diff from left (local) during merge
vim.keymap.set("n", "<leader>qk", ":diffget 3<CR>", {desc = "[Q] [K] diff from right (remote) during merge"}) -- get diff from right (remote) during merge
vim.keymap.set("n", "<leader>qn", "]c", {desc = "[Q] [N]ext diff hunk"}) -- next diff hunk
vim.keymap.set("n", "<leader>qp", "[c", {desc = "[Q] [P]revious diff hunk"}) -- previous diff hunk

