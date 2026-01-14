return {
  "kitallen23/conduit.nvim",
  config = function()
    vim.keymap.set("n", "<leader>ai", function()
      require("conduit").ask()
    end, { desc = "Generate conduit prompt" })
    vim.keymap.set("n", "<leader>ac", function()
      require("conduit").ask("@cursor: ")
    end, { desc = "Generate conduit prompt at cursor" })
    vim.keymap.set("n", "<leader>ab", function()
      require("conduit").ask("@buffer: ")
    end, { desc = "Generate conduit prompt about open buffer" })
    vim.keymap.set("v", "<leader>ai", function()
      require("conduit").ask("@selection: ")
    end, { desc = "Generate conduit prompt about selection" })
    vim.keymap.set({ "n", "v" }, "<leader>ap", function()
      require("conduit").select_prompt()
    end, { desc = "Select conduit prompt" })
    vim.keymap.set("n", "<leader>ad", function()
      require("conduit").select_prompt("fix_line")
    end, { desc = "Get diagnostic prompt" })
  end,
}
