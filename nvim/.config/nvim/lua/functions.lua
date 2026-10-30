function Open_jira_ticket()
  local base_url = vim.env.JIRA_BASE_URL

  if not base_url or base_url == "" then
    vim.notify("JIRA_BASE_URL environment variable is not set", vim.log.levels.ERROR)
    return
  end

  if not base_url:find("/$") then
    base_url = base_url .. "/"
  end

  local mode = vim.api.nvim_get_mode().mode
  local ticket

  -- Check if currently in any Visual mode variant (char, line, block)
  if mode:match("[vV\22]") then
    vim.cmd('normal! "vy')
    ticket = vim.fn.getreg('v'):gsub("^%s*(.-)%s*$", "%1")
  else
    local word = vim.fn.expand('<cWORD>')
    ticket = word:match("([A-Za-z0-9_]+%-%d+)")
  end

  if ticket and #ticket > 0 then
    vim.ui.open(base_url .. ticket)
  else
    vim.notify("No valid Jira ticket ID found", vim.log.levels.WARN)
  end
end
