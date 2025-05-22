-- Show the diagnostic source (which server) for each line
function PrintDiagnosticsSource()
    for _, d in ipairs(vim.diagnostic.get(0)) do
        print("Line " .. (d.lnum + 1) .. ": " .. (d.source or "unknown"))
    end
end

vim.api.nvim_create_user_command("PrintDiagnosticsSource", function()
    PrintDiagnosticsSource()
end, {})
