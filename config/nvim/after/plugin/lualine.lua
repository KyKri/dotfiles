-- Fugitive-based git segment for lualine
local function fugitive_branch()
  if vim.fn.exists("*FugitiveHead") == 0 then return "" end
  local head = vim.fn.FugitiveHead()
  if not head or head == "" then return "" end
  return " " .. head
end

local function fugitive_status()
  if vim.fn.exists("*FugitiveStatusline") == 0 then return "" end
  local s = vim.fn.FugitiveStatusline() or ""
  if s == "" then return "" end

  local parts = {}
  if s:find("!") then table.insert(parts, "") end  -- conflict
  if s:find("%*") then table.insert(parts, "●") end -- unstaged
  if s:find("%+") then table.insert(parts, "") end -- staged
  if s:find("%?") then table.insert(parts, "") end -- untracked

  if #parts == 0 then
    return ""
  end
  return table.concat(parts, " ")
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    globalstatus = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { fugitive_branch, fugitive_status },
    lualine_c = { "filename" },
    lualine_x = { "diagnostics", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

