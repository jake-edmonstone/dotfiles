local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- build n×n of [] cells
local function grid_n(args)
  local n = tonumber(args[1][1]) or 1
  local nodes = {}
  for r = 1, n do
    local cells = {}
    for _ = 1, n do
      cells[#cells + 1] = "[]"
    end
    local line = "  " .. table.concat(cells, ", ")
    if r < n then
      nodes[#nodes + 1] = t({ line .. ",", "" })
    else
      nodes[#nodes + 1] = t(line)
    end
  end
  return sn(nil, nodes)
end

ls.add_snippets("typst", {
  -- preamble snippet
  s("pre", {
    t('#import "preamble.typ" : *'),
    t({ "", "#show: preamble" }),
  }),

  -- math block snippet
  s("mb", {
    t("$$"),
    t({ "", "" }),
    i(0),
    t({ "", "$$" }),
  }),

  -- cayley table
  s("ctable", {
    t("#cayley-table(columns: "),
    i(1, "1"),
    t({ ",", "" }),
    d(2, grid_n, { 1 }),
    t({ "", ")" }),
  }),
})
