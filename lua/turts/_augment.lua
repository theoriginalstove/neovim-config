-- Augment Code sign-in helper.
-- The plugin's :Augment signin drops the auth URL into a blocking inputsecret()
-- prompt that can't be selected or clicked. This talks to the running Augment
-- LSP directly: requests augment/login, opens the URL in a browser (and saves it
-- to a file), then sends augment/token back on the same client so the server's
-- PKCE state stays valid.
vim.api.nvim_create_user_command("AugmentSignInBrowser", function()
    local get = vim.lsp.get_clients or vim.lsp.get_active_clients
    local client = get({ name = "Augment Server" })[1]
    if not client then
        vim.notify(
            "Augment LSP not running yet — open a file so the plugin starts, then retry.",
            vim.log.levels.WARN
        )
        return
    end

    client.request("augment/login", vim.empty_dict(), function(err, result)
        vim.schedule(function()
            if err then
                vim.notify("Augment login error: " .. vim.inspect(err), vim.log.levels.ERROR)
                return
            end
            if result and result.loggedIn then
                vim.notify("Augment: Already logged in.")
                return
            end

            local url = result.url
            local path = vim.fn.expand("~/.augment_login_url.txt")
            vim.fn.writefile({ url }, path)
            vim.fn.jobstart({ "xdg-open", url }, { detach = true })
            vim.notify("Augment URL opened in browser (also saved to " .. path .. ")")

            local code = vim.fn.inputsecret("After authenticating, paste the code here: ")
            if code ~= "" then
                client.request("augment/token", { code = code }, function(terr)
                    vim.schedule(function()
                        if terr then
                            vim.notify("Augment sign-in failed: " .. vim.inspect(terr), vim.log.levels.ERROR)
                        else
                            vim.notify("Augment: sign in successful.")
                        end
                    end)
                end)
            end
        end)
    end)
end, { desc = "Augment sign-in via browser (auto-open + file fallback)" })
