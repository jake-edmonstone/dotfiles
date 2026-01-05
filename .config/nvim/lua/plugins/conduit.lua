return {
  "kitallen23/conduit.nvim",
  keys = {
    {
      "<leader>ai",
      function()
        require("conduit").ask()
      end,
      desc = "Generate conduit prompt",
    },
    {
      "<leader>ac",
      function()
        require("conduit").ask("@cursor: ")
      end,
      desc = "Generate conduit prompt at cursor",
    },
    {
      "<leader>ai",
      function()
        require("conduit").ask("@selection: ")
      end,
      desc = "Generate conduit prompt about selection",
    },
    {
      "<leader>ap",
      function()
        require("conduit").select_prompt()
      end,
      desc = "Select conduit prompt",
    },
    {
      "<leader>ad",
      function()
        require("conduit").select_prompt("fix_line")
      end,
      desc = "Get diagnostic prompt",
    },
  },
}
