
setclipboard("-- Official Wyborn Script\nloadstring(game:HttpGet('https://raw.githubusercontent.com/ckw69/Wyborn/main/wyborn', true))()")
local wybornsuccess, wyvernerror = pcall(function()
getgenv().wyvern_version = "1.5.6"

local LOAD_TIME = tick()

local defaults = {
    ["Change Log"] = true, ["Home"] = true, ["UGC Limiteds"] = true,
    ["Remotes"] = true, ["Games"] = true, ["Players"] = true,
    ["Network"] = true, ["Input Automations"] = true, ["Purchase Exploits"] = true
}
if getgenv().WyvernConfig == nil then getgenv().WyvernConfig = defaults end
getgenv().WyvernLoaded = false
for i in pairs(defaults) do
    if getgenv().WyvernConfig[i] == nil then getgenv().WyvernConfig[i] = defaults[i] end
end

local queueonteleport = queue_on_teleport or queueonteleport
local setclipboard = toclipboard or setrbxclipboard or setclipboard
local clonefunction = clonefunc or clonefunction
local setthreadidentity = set_thread_identity or setthreadcaps or setthreadidentity
local firetouchinterests = fire_touch_interests or firetouchinterests
if getnamecallmethod then
    local getnamecallmethod = get_namecall_method or getnamecallmethod
end

local a = Instance.new("Part")
for b, c in pairs(getreg()) do
    if type(c) == "table" and #c then
        if rawget(c, "__mode") == "kvs" then
            for d, e in pairs(c) do
                if e == a then getgenv().InstanceList = c; break end
            end
        end
    end
end
local f = {}
function f.invalidate(g)
    if not InstanceList then return end
    for b, c in pairs(InstanceList) do
        if c == g then InstanceList[b] = nil; return g end
    end
end
if not cloneref then getgenv().cloneref = f.invalidate end

getrenv().Visit = cloneref(game:GetService("Visit"))
getrenv().MarketplaceService = cloneref(game:GetService("MarketplaceService"))
getrenv().HttpRbxApiService = cloneref(game:GetService("HttpRbxApiService"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local ContentProvider = cloneref(game:GetService("ContentProvider"))
local RunService = cloneref(game:GetService("RunService"))
local Stats = cloneref(game:GetService("Stats"))
local Players = cloneref(game:GetService("Players"))
local NetworkClient = cloneref(game:GetService("NetworkClient"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))
local ProximityPromptService = cloneref(game:GetService("ProximityPromptService"))
local Lighting = cloneref(game:GetService("Lighting"))
local AssetService = cloneref(game:GetService("AssetService"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local NetworkSettings = settings().Network
local UserGameSettings = UserSettings():GetService("UserGameSettings")
getrenv().getgenv = clonefunction(getgenv)

local message = Instance.new("Message")
message.Text = "loading wyborn (skidded by KW)"
message.Parent = CoreGui

task.wait(0.1)

getgenv().stealth_call = function(script)
    getrenv()._set = clonefunction(setthreadidentity)
    local old
    old = hookmetamethod(game, "__index", function(a, b)
        task.spawn(function()
            _set(7); task.wait(0.1)
            local went, error = pcall(function() loadstring(script)() end)
            print(went, error)
            if went then
                local check = Instance.new("LocalScript")
                check.Parent = Visit
            end
        end)
        hookmetamethod(game, "__index", old)
        return old(a, b)
    end)
end

local function touch(x)
    x = x:FindFirstAncestorWhichIsA("Part")
    if x then
        if firetouchinterest then
            task.spawn(function()
                firetouchinterest(x, Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), 1)
                wait()
                firetouchinterest(x, Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), 0)
            end)
        end
        x.CFrame = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
    end
end

for i, v in pairs(game.RobloxReplicatedStorage:GetDescendants()) do
    pcall(function() v:Destroy() end)
end

task.spawn(function()
    -- ===================== RAYFIELD UI =====================
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "Wyborn " .. getgenv().wyvern_version .. " - KW's edition",
        LoadingTitle = "Wyborn",
        LoadingSubtitle = "by KW | [DylanElHacker = Femboy]",
        ConfigurationSaving = { Enabled = false },
        Discord = { Enabled = false },
        KeySystem = false
    })

    local function notify(title, content)
        Rayfield:Notify({ Title = title, Content = content, Duration = 6 })
    end

    local inputlink = loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/refs/heads/main/main%204", true))()

    -- ===================== CHANGE LOG =====================
    if getgenv().WyvernConfig["Change Log"] then
        local changelog = Window:CreateTab("Change Log", 4483362458)
        changelog:CreateLabel("Join https://discord.gg/NU835A3Bgd for newest Updates!")
        changelog:CreateDivider()
        changelog:CreateButton({
            Name = "NEW Dev Product Purchase",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/refs/heads/main/Dev%20Product%20Purchase"))()
                notify("Wyborn Product Purchase", "Successfully executed!")
            end
        })
        changelog:CreateDivider()
        changelog:CreateLabel("1.5.2/3")
        changelog:CreateLabel("Added NEW Working Dev Product Purchase")
        changelog:CreateLabel("ADDED AUTOSEARCHER")
        changelog:CreateLabel("You can choose what channels you can use!")
    end

    -- ===================== HOME =====================
    if getgenv().WyvernConfig["Home"] then
        local main = Window:CreateTab("Home", 4483362458)
        main:CreateParagraph({
            Title = "Welcome!",
            Content = "Thank you for using Wyborn!\nThe #2 UGC Games Penetration Testing Tool!\nCheck out the other tabs for available tools."
        })
        main:CreateLabel("The most up-to-date Wyborn")
        main:CreateDivider()
        main:CreateToggle({
            Name = "Anti Kick (Client)",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    local kick
                    kick = hookmetamethod(game, "__namecall", function(obj, ...)
                        local args = {...}
                        local method = getnamecallmethod()
                        if method == "Kick" then
                            if args[1] then
                                notify("Kick Attempt", "There was an attempt to kick player from client.")
                            end
                            return nil
                        end
                        return kick(obj, unpack(args))
                    end)
                end
            end
        })
        main:CreateDivider()
        main:CreateButton({
            Name = "Credits",
            Callback = function()
                notify("Credits", "created by chel, skidded by KW from redblue")
            end
        })
        task.spawn(function()
            repeat task.wait() until getgenv().WyvernLoaded == true
            main:CreateLabel("Wyborn loaded in " .. string.format("%.2f seconds.", tostring(tick() - LOAD_TIME)))
        end)
    end

    -- ===================== UGC LIMITEDS =====================
    if getgenv().WyvernConfig["UGC Limiteds"] then
        local ugc = Window:CreateTab("UGC Limiteds", 4483362458)

        ugc:CreateLabel("Looking for Remote Bruteforcing? Check out Remotes tab!")
        ugc:CreateDivider()
        ugc:CreateParagraph({
            Title = "Auto Purchase",
            Content = "This will auto purchase any limited that gets prompted!\nRecommended to use in the rolimons game."
        })
        ugc:CreateLabel("With this, you can get #1 serials of web UGC item drops!")
        ugc:CreateButton({
            Name = "Teleport to Rolimons UGC Game",
            Callback = function()
                TeleportService:Teleport(14056754882, Players.LocalPlayer)
            end
        })

        getgenv().AutoClickerPurchase = false
        ugc:CreateToggle({
            Name = "Enable Auto Click Purchaser",
            CurrentValue = false,
            Callback = function(bool)
                getgenv().AutoClickerPurchase = bool
                while getgenv().AutoClickerPurchase and task.wait() do
                    task.spawn(function()
                        if game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator:FindFirstChild("Prompt") and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt:FindFirstChild("AlertContents") and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents:FindFirstChild("Footer") and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer:FindFirstChild("Buttons") and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons:FindFirstChild("2") and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[2]:FindFirstChild("ButtonContent").ButtonMiddleContent and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[2]:FindFirstChild("ButtonContent").ButtonMiddleContent:FindFirstChildOfClass("TextLabel")
                        then
                            local yes = game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[2].AbsolutePosition
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(yes.X + 55, yes.Y + 65.5, 0, true, game, 1)
                            task.wait()
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(yes.X + 55, yes.Y + 65.5, 0, false, game, 1)
                        end
                    end)
                end
            end
        })

        getgenv().AutoClickerError = false
        ugc:CreateToggle({
            Name = "Enable Auto Click Error Button",
            CurrentValue = false,
            Callback = function(bool)
                getgenv().AutoClickerError = bool
                while getgenv().AutoClickerError and task.wait() do
                    task.spawn(function()
                        if game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator:FindFirstChild("Prompt") and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt:FindFirstChild("AlertContents") and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents:FindFirstChild("Footer") and
                            game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer:FindFirstChild("Buttons") and
                            not game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons:FindFirstChild("2")
                        then
                            if game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons:FindFirstChild("1") then
                                local ye12s = game.CoreGui.PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.AlertContents.Footer.Buttons[1].AbsolutePosition
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(ye12s.X + 55, ye12s.Y + 65.5, 0, true, game, 1)
                                task.wait()
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(ye12s.X + 55, ye12s.Y + 65.5, 0, false, game, 1)
                            end
                        end
                    end)
                end
            end
        })

        ugc:CreateDivider()
        getgenv().openConsole = false
        ugc:CreateToggle({
            Name = "Open Console After Purchase?",
            CurrentValue = false,
            Callback = function(bool) getgenv().openConsole = bool end
        })

        getgenv().BuyPaidItems = false
        ugc:CreateToggle({
            Name = "Auto Purchase Paid Items (For Below)",
            CurrentValue = false,
            Callback = function(bool) getgenv().BuyPaidItems = bool end
        })

        ugc:CreateToggle({
            Name = "Auto Purchaser",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    notify("Waiting", "Waiting for any free UGC item to be prompted...")
                    getrenv()._set = clonefunction(setthreadidentity)
                    local old
                    old = hookmetamethod(game, "__index", function(a, b)
                        task.spawn(function()
                            _set(7); task.wait()
                            getgenv().promptpurchaserequestedv2 = MarketplaceService.PromptPurchaseRequestedV2:Connect(function(...)
                                notify("Prompt Detected", "If this is a UGC item, this script will attempt purchase. Check console.")
                                local startTime = tick()
                                t = {...}
                                local assetId = t[2]
                                local idempotencyKey = t[5]
                                local purchaseAuthToken = t[6]
                                local info = MarketplaceService:GetProductInfo(assetId)
                                local productId = info.ProductId
                                local price = getgenv().BuyPaidItems and info.PriceInRobux or 0
                                local collectibleItemId = info.CollectibleItemId
                                local collectibleProductId = info.CollectibleProductId
                                print("PurchaseAuthToken: " .. purchaseAuthToken)
                                print("IdempotencyKey: " .. idempotencyKey)
                                print("CollectibleItemId: " .. collectibleItemId)
                                print("CollectibleProductId: " .. collectibleProductId)
                                print("ProductId (SHOULD BE 0): " .. productId)
                                print("Price: " .. price)
                                warn("FIRST PURCHASE ATTEMPT")
                                for i, v in pairs(MarketplaceService:PerformPurchase(
                                    Enum.InfoType.Asset, productId, price,
                                    tostring(game:GetService("HttpService"):GenerateGUID(false)),
                                    true, collectibleItemId, collectibleProductId,
                                    idempotencyKey, tostring(purchaseAuthToken)
                                )) do print(i, v) end
                                print("Bought Item! Took " .. tostring(tick() - startTime) .. " seconds")
                                if getgenv().openConsole then inputlink.press(Enum.KeyCode.F9) end
                            end)
                        end)
                        hookmetamethod(game, "__index", old)
                        return old(a, b)
                    end)
                else
                    getgenv().promptpurchaserequestedv2:Disconnect()
                    notify("Stopped", "Stopped waiting for any free UGC item to be prompted.")
                end
            end
        })

        -- _post helper
        getrenv()._set = clonefunction(setthreadidentity)
        local function _post(url, data)
            pcall(function()
                local old1
                old1 = hookmetamethod(game, "__index", function(a, b)
                    task.spawn(function()
                        _set(7); task.wait()
                        game:GetService("HttpRbxApiService"):PostAsyncFullUrl(url, data)
                    end)
                    hookmetamethod(game, "__index", old1)
                    return old1(a, b)
                end)
            end)
        end

        ugc:CreateToggle({
            Name = "Auto Purchaser V2 (WEB ONLY)",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    notify("Waiting", "Waiting for any free UGC item to be prompted...")
                    getrenv()._set = clonefunction(setthreadidentity)
                    local old
                    old = hookmetamethod(game, "__index", function(a, b)
                        task.spawn(function()
                            _set(7); task.wait()
                            getgenv().promptpurchaserequestedv2 = MarketplaceService.PromptPurchaseRequestedV2:Connect(function(...)
                                notify("Prompt Detected", "If this is a UGC item, attempting purchase. Check console.")
                                local startTime = tick()
                                t = {...}
                                local assetId = t[2]
                                local info = MarketplaceService:GetProductInfo(assetId)
                                pcall(function()
                                    local prricee = getgenv().BuyPaidItems and info.PriceInRobux or 0
                                    local data = '{"collectibleItemId":"' .. tostring(info.CollectibleItemId) ..
                                        '","collectibleProductId":"' .. tostring(info.CollectibleProductId) ..
                                        '","expectedCurrency":1,"expectedPrice":' .. tostring(prricee) ..
                                        ',"idempotencyKey":"' .. tostring(game:GetService("HttpService"):GenerateGUID(false)) ..
                                        '","expectedSellerId":' .. tostring(info.Creator.Id) ..
                                        ',"expectedSellerType":"' .. tostring(info.Creator.CreatorType) ..
                                        '","expectedPurchaserType":"User","expectedPurchaserId":' .. tostring(game.Players.LocalPlayer.UserId) .. "}"
                                    print(data)
                                    _post("https://apis.roblox.com/marketplace-sales/v1/item/" .. tostring(info.CollectibleItemId) .. "/purchase-item", data)
                                    print("Bought Item! Took " .. tostring(tick() - startTime) .. " seconds")
                                end)
                            end)
                        end)
                        hookmetamethod(game, "__index", old)
                        return old(a, b)
                    end)
                else
                    getgenv().promptpurchaserequestedv2:Disconnect()
                    notify("Stopped", "Stopped waiting for any free UGC item to be prompted.")
                end
            end
        })

        ugc:CreateToggle({
            Name = "Auto Purchaser (Bulk Purchaser)",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    notify("Waiting", "Waiting for any free UGC item to be prompted...")
                    getrenv()._set = clonefunction(setthreadidentity)
                    local old
                    old = hookmetamethod(game, "__index", function(a, b)
                        task.spawn(function()
                            _set(7); task.wait()
                            getgenv().promptbulkpurchaserequestedv2 = MarketplaceService.PromptBulkPurchaseRequested:Connect(function(...)
                                notify("Bulk Prompt Detected", "If this is a UGC item, attempting purchase. Check console.")
                                local startTime = tick()
                                t = {...}
                                local orderRequest = t[3] or {}
                                local options = t[6] or {}
                                warn("FIRST PURCHASE ATTEMPT")
                                for i, v in pairs(MarketplaceService:PerformBulkPurchase(orderRequest, options)) do print(i, v) end
                                print("Bought Item(s)! Took " .. tostring(tick() - startTime) .. " seconds")
                                if getgenv().openConsole then inputlink.press(Enum.KeyCode.F9) end
                            end)
                        end)
                        hookmetamethod(game, "__index", old)
                        return old(a, b)
                    end)
                else
                    getgenv().promptbulkpurchaserequestedv2:Disconnect()
                    notify("Stopped", "Stopped waiting.")
                end
            end
        })

        ugc:CreateDivider()
        ugc:CreateToggle({
            Name = "Auto Refund (games with refund system)",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    getrenv()._set = clonefunction(setthreadidentity)
                    local old
                    old = hookmetamethod(game, "__index", function(a, b)
                        task.spawn(function()
                            _set(7); task.wait()
                            getgenv().promptpurchaserequestedv2Refund = MarketplaceService.PromptPurchaseRequestedV2:Connect(function(...)
                                notify("Prompt Detected", "If this is a UGC item, this script will attempt to refund.")
                                redblueee = {...}
                                local assetId = redblueee[2]
                                game:GetService("MarketplaceService"):SignalPromptPurchaseFinished(game.Players.LocalPlayer, tonumber(assetId), false)
                                task.wait(0.25)
                                game:GetService("MarketplaceService"):SignalPromptPurchaseFinished(game.Players.LocalPlayer, tostring(assetId), false)
                            end)
                        end)
                        hookmetamethod(game, "__index", old)
                        return old(a, b)
                    end)
                else
                    getgenv().promptpurchaserequestedv2Refund:Disconnect()
                    notify("Stopped", "Stopped.")
                end
            end
        })

        ugc:CreateDivider()
        ugc:CreateParagraph({
            Title = "Fake Prompts! (Requested by @atellie)",
            Content = "Prank people that you got an item!\nThis prompts a UGC item but buying it will error."
        })
        ugc:CreateInput({
            Name = "Fake Prompt Item ID",
            PlaceholderText = "Enter a UGC Item Id...",
            RemoveTextAfterFocusLost = true,
            Callback = function(t)
                local tt = tonumber(t)
                if type(tt) == "number" then
                    local info = MarketplaceService:GetProductInfo(tt)
                    getrenv()._set = clonefunction(setthreadidentity)
                    local old
                    old = hookmetamethod(game, "__index", function(a, b)
                        task.spawn(function()
                            _set(7); task.wait()
                            MarketplaceService:PromptPurchase(Players.LocalPlayer, tt)
                        end)
                        hookmetamethod(game, "__index", old)
                        return old(a, b)
                    end)
                    task.wait(0.2)
                    pcall(function() Visit:FindFirstChild("LocalScript"):Destroy() end)
                else
                    notify("Error", "You must enter an Item ID.")
                end
            end
        })

        ugc:CreateDivider()
        ugc:CreateParagraph({
            Title = "UwU Sniper",
            Content = "No prompt needed and basically instant!\nSkidded by KW, like the good ol' days."
        })

        local snipeid = 123456789
        ugc:CreateInput({
            Name = "Sniper Item ID",
            PlaceholderText = "Enter a UGC Item Id...",
            RemoveTextAfterFocusLost = false,
            Callback = function(t) snipeid = tonumber(t) end
        })
        local snpespeed = 0.15
        ugc:CreateInput({
            Name = "Sniper Speed",
            PlaceholderText = "Enter a Speed... (default 0.15)",
            RemoveTextAfterFocusLost = false,
            Callback = function(t) snpespeed = tonumber(t) end
        })
        local buylimit = 1
        local amountbought = 0
        ugc:CreateInput({
            Name = "Buy Limit",
            PlaceholderText = "Enter a Limit...",
            RemoveTextAfterFocusLost = false,
            Callback = function(t) buylimit = tonumber(t) end
        })
        local freecheck = false
        ugc:CreateToggle({
            Name = "Check if its Free",
            CurrentValue = false,
            Callback = function(bool) freecheck = bool end
        })

        local booleanbooby, info, xd, breakLoopp = false, nil, 0, false
        ugc:CreateToggle({
            Name = "Enable UwU Sniper (No Prompt Needed)",
            CurrentValue = false,
            Callback = function(bool)
                amountbought = 0
                booleanbooby = bool
                breakLoopp = false
                if booleanbooby then
                    xd = 0
                    info = game:GetService("MarketplaceService"):GetProductInfo(snipeid)
                    local output = ""
                    if type(info) == "table" then
                        for i, v in pairs(info) do
                            if type(v) ~= "table" then output = output .. tostring(i) .. ": " .. tostring(v) .. "\n" end
                            if type(v) == "table" then
                                for x, d in pairs(v) do output = output .. tostring(x) .. ": " .. tostring(d) .. "\n" end
                            end
                        end
                    end
                    notify("Wyborn Sniper Started!", "Info:\n" .. tostring(output))
                end
                while booleanbooby and not breakLoopp do
                    info = game:GetService("MarketplaceService"):GetProductInfo(snipeid)
                    pcall(function()
                        xd = xd + 1
                        print("Sniping! Checks: " .. tostring(xd))
                        if info.IsForSale then
                            local starttickxd = tick()
                            local data = '{"collectibleItemId":"' .. tostring(info.CollectibleItemId) ..
                                '","collectibleProductId":"' .. tostring(info.CollectibleProductId) ..
                                '","expectedCurrency":1,"expectedPrice":' .. tostring(info.PriceInRobux) ..
                                ',"idempotencyKey":"' .. tostring(game:GetService("HttpService"):GenerateGUID(false)) ..
                                '","expectedSellerId":' .. tostring(info.Creator.Id) ..
                                ',"expectedSellerType":"' .. tostring(info.Creator.CreatorType) ..
                                '","expectedPurchaserType":"User","expectedPurchaserId":' .. tostring(game.Players.LocalPlayer.UserId) .. "}"
                            print(data)
                            if freecheck then
                                if info.PriceInRobux == 0 then
                                    _post("https://apis.roblox.com/marketplace-sales/v1/item/" .. tostring(info.CollectibleItemId) .. "/purchase-item", data)
                                    amountbought = amountbought + 1
                                end
                            else
                                _post("https://apis.roblox.com/marketplace-sales/v1/item/" .. tostring(info.CollectibleItemId) .. "/purchase-item", data)
                                amountbought = amountbought + 1
                            end
                            wait()
                            print("Bought Item! Took " .. tostring(tick() - starttickxd) .. " seconds")
                            task.wait(1)
                        end
                    end)
                    if amountbought >= buylimit then breakLoopp = true end
                    task.wait(snpespeed)
                end
            end
        })

        ugc:CreateDivider()
        getgenv().AutoSearchWyvern = false
        local latestfreeugcid = nil
        ugc:CreateToggle({
            Name = "Enable Free Web Auto Search",
            CurrentValue = false,
            Callback = function(bool)
                getgenv().AutoSearchWyvern = bool
                pcall(function()
                    local responsePaste = game:HttpGet("https://pastefy.app/Pq7EfNmH/raw")
                    local decodedResponsePaste = game:GetService("HttpService"):JSONDecode(responsePaste)
                    if decodedResponsePaste["Web"] and decodedResponsePaste["Web"]["id"] then
                        latestfreeugcid = tonumber(decodedResponsePaste["Web"]["id"])
                    end
                end)
                while getgenv().AutoSearchWyvern and task.wait(0.5) do
                    task.spawn(function()
                        pcall(function()
                            local responsePaste = game:HttpGet("https://pastefy.app/Pq7EfNmH/raw")
                            local decodedResponsePaste = game:GetService("HttpService"):JSONDecode(responsePaste)
                            if decodedResponsePaste["Web"] and decodedResponsePaste["Web"]["id"] then
                                if latestfreeugcid ~= tonumber(decodedResponsePaste["Web"]["id"]) then
                                    latestfreeugcid = tonumber(decodedResponsePaste["Web"]["id"])
                                    info = game:GetService("MarketplaceService"):GetProductInfo(latestfreeugcid)
                                    local data = '{"collectibleItemId":"' .. tostring(info.CollectibleItemId) ..
                                        '","collectibleProductId":"' .. tostring(info.CollectibleProductId) ..
                                        '","expectedCurrency":1,"expectedPrice":0,"idempotencyKey":"' ..
                                        game:GetService("HttpService"):GenerateGUID(false) ..
                                        '","expectedSellerId":' .. tostring(info.Creator.Id) ..
                                        ',"expectedSellerType":"' .. tostring(info.Creator.CreatorType) ..
                                        '","expectedPurchaserType":"User","expectedPurchaserId":' .. tostring(game.Players.LocalPlayer.UserId) .. "}"
                                    print(data)
                                    _post("https://apis.roblox.com/marketplace-sales/v1/item/" .. tostring(info.CollectibleItemId) .. "/purchase-item", data)
                                    notify("Found Web UGC", "Found Free UGC id: " .. tostring(latestfreeugcid) .. ". Attempting purchase.")
                                end
                            end
                        end)
                    end)
                end
            end
        })
    end

    -- ===================== REMOTES =====================
    if getgenv().WyvernConfig["Remotes"] then
        local remotes = Window:CreateTab("Remotes", 4483362458)
        remotes:CreateParagraph({
            Title = "Remote Bruteforcer",
            Content = "Fires all remotes in the game as an attempt to prompt the item.\nWarning: This can be risky and can fire a decoy remote!"
        })
        remotes:CreateInput({
            Name = "UGC Limited Item ID",
            PlaceholderText = "Enter Item ID to include in arguments...",
            RemoveTextAfterFocusLost = false,
            Callback = function(t)
                local tt = tonumber(t)
                if type(tt) == "number" then
                    getgenv().limitedidforfiringremotewithwyvern = tt
                    notify("Success", "Item ID set to " .. tostring(tt) .. "!")
                else
                    notify("Error", "That's not an Item ID.")
                end
            end
        })
        remotes:CreateToggle({
            Name = "String = ON | Number = OFF (UGC ID Type)",
            CurrentValue = false,
            Callback = function(bool)
                if getgenv().limitedidforfiringremotewithwyvern then
                    if bool then
                        getgenv().limitedidforfiringremotewithwyvern = tostring(getgenv().limitedidforfiringremotewithwyvern)
                    else
                        getgenv().limitedidforfiringremotewithwyvern = tonumber(getgenv().limitedidforfiringremotewithwyvern)
                    end
                end
            end
        })

        local fire = function(args, notification)
            local count = 0
            for i, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
                    count = count + 1
                    task.spawn(function() v:FireServer(args) end)
                elseif v:IsA("RemoteFunction") then
                    count = count + 1
                    task.spawn(function() v:InvokeServer(args) end)
                end
            end
            if notification then notify("Success", "Fired " .. count .. " RemoteEvents and RemoteFunctions") end
        end

        local _fire = function(args, args2, notification)
            local count = 0
            for i, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
                    count = count + 1
                    task.spawn(function() v:FireServer(args, args2) end)
                    pcall(function() v:FireServer(args, args2) end)
                elseif v:IsA("RemoteFunction") then
                    count = count + 1
                    task.spawn(function() v:InvokeServer(args, args2) end)
                end
            end
            if notification then notify("Success", "Fired " .. count .. " RemoteEvents and RemoteFunctions") end
        end

        local __fire = function(args, notification)
            local count = 0
            for i, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
                    count = count + 1
                    task.spawn(function() v:FireServer(unpack(args)) end)
                elseif v:IsA("RemoteFunction") then
                    count = count + 1
                    task.spawn(function() v:InvokeServer(unpack(args)) end)
                end
            end
            if notification then notify("Success", "Fired " .. count .. " RemoteEvents and RemoteFunctions") end
        end

        getgenv().RemoteFireMethod = "No Arguments/Blank"
        remotes:CreateDropdown({
            Name = "Remote Arguments",
            Options = {
                "No Arguments/Blank", "Bulk Purchase Function 1", "LocalPlayer", "Your Username",
                "UGC Item ID", "UGC Item ID, LocalPlayer", "LocalPlayer, UGC Item ID",
                "'UGC' as a string", "UGC Item ID, 'true' boolean", "'true' boolean",
                "literal lua code to prompt item", "loadstring prompt item"
            },
            CurrentOption = {"No Arguments/Blank"},
            Callback = function(x) getgenv().RemoteFireMethod = x end
        })

        local function doFire(notification)
            if not getgenv().limitedidforfiringremotewithwyvern then
                if notification then notify("Error", "Set a Limited Item ID first!") end
                return
            end
            local id = getgenv().limitedidforfiringremotewithwyvern
            local m = getgenv().RemoteFireMethod
            if m == "No Arguments/Blank" then fire(" ", notification)
            elseif m == "Bulk Purchase Function 1" then
                local a = {[1]={{Id=tostring(id),Type=Enum.MarketplaceProductType.AvatarAsset}},[2]={}}
                __fire(a, notification)
            elseif m == "LocalPlayer" then fire(game.Players.LocalPlayer, notification)
            elseif m == "Your Username" then fire(tostring(game.Players.LocalPlayer), notification)
            elseif m == "UGC Item ID" then fire(id, notification)
            elseif m == "UGC Item ID, LocalPlayer" then _fire(id, game.Players.LocalPlayer, notification)
            elseif m == "LocalPlayer, UGC Item ID" then _fire(game.Players.LocalPlayer, id, notification)
            elseif m == "'UGC' as a string" then fire("UGC", notification)
            elseif m == "UGC Item ID, 'true' boolean" then _fire(id, true, notification)
            elseif m == "'true' boolean" then fire(true, notification)
            elseif m == "literal lua code to prompt item" then
                fire('game:GetService("MarketplaceService"):PromptPurchase(game.Players.' .. tostring(game.Players.LocalPlayer) .. ", " .. tostring(id) .. ")", notification)
            elseif m == "loadstring prompt item" then
                fire('loadstring(`game:GetService("MarketplaceService"):PromptPurchase(game.Players.' .. tostring(game.Players.LocalPlayer) .. ", " .. tostring(id) .. ")`)()", notification)
            end
        end

        remotes:CreateButton({ Name = "Fire All Remotes", Callback = function() doFire(true) end })

        getgenv().LoopFiringRemotes = false
        remotes:CreateToggle({
            Name = "Loop Fire All Remotes",
            CurrentValue = false,
            Callback = function(bool)
                getgenv().LoopFiringRemotes = bool
                while getgenv().LoopFiringRemotes and task.wait() do doFire(false) end
            end
        })

        remotes:CreateDivider()
        remotes:CreateParagraph({
            Title = "Block Remotes",
            Content = "This will block client communication with the server.\nUseful for bypassing clientsided anticheats!"
        })
        remotes:CreateToggle({
            Name = "Block All RemoteEvents and RemoteFunctions",
            CurrentValue = false,
            Callback = function(bool)
                local Methods = {"FireServer","fireserver","InvokeServer","invokeserver","Fire","fire","Invoke","invoke"}
                getgenv().Toggleblock = bool
                if bool then
                    local OldNameCall
                    OldNameCall = hookmetamethod(game, "__namecall", newcclosure(function(...)
                        local Self = ...
                        if table.find(Methods, getnamecallmethod()) then
                            if Toggle and Self then return end
                        end
                        return OldNameCall(...)
                    end))
                end
            end
        })

        remotes:CreateDivider()
        remotes:CreateButton({
            Name = "Print All Remotes (Includes Path)",
            Callback = function()
                for i, v in pairs(game:GetDescendants()) do
                    if v:IsA("RemoteEvent") then print("RemoteEvent: " .. v:GetFullName())
                    elseif v:IsA("RemoteFunction") then print("RemoteFunction: " .. v:GetFullName())
                    elseif v:IsA("UnreliableRemoteEvent") then print("UnreliableRemoteEvent: " .. v:GetFullName())
                    end
                end
                notify("Success", "Check console (F9 or /console in chat).")
                if getgenv().openConsole then inputlink.press(Enum.KeyCode.F9) end
            end
        })
    end

    -- ===================== GAMES =====================
    if getgenv().WyvernConfig["Games"] then
        local games = Window:CreateTab("Games", 4483362458)

        local antikickonteleport = false
        games:CreateToggle({
            Name = "Inject Anti Kick on Teleport",
            CurrentValue = false,
            Callback = function(bool) antikickonteleport = bool end
        })

        local chosenversionsubplace = "Teleport"
        games:CreateDropdown({
            Name = "What to do with Subplace",
            Options = {"Teleport", "Copy Script", "Copy Game Link"},
            CurrentOption = {"Teleport"},
            Callback = function(x) chosenversionsubplace = x end
        })

        games:CreateLabel("Below is a list of subplaces of this game.")
        local places, placeids = {}, {}
        local pp = AssetService:GetGamePlacesAsync()
        while true do
            for _, place in pp:GetCurrentPage() do
                table.insert(places, place.Name)
                table.insert(placeids, place.PlaceId)
            end
            if pp.IsFinished then break end
            pp:AdvanceToNextPageAsync()
        end

        games:CreateDropdown({
            Name = "Subplace/Hidden Games List",
            Options = places,
            CurrentOption = {places[1] or ""},
            Callback = function(x)
                local index
                for i, name in ipairs(places) do
                    if name == x then index = i; break end
                end
                if index then
                    local placeId = placeids[index]
                    if chosenversionsubplace == "Teleport" then
                        notify("Teleporting", "Teleporting to " .. x .. "\nGame ID: " .. placeId)
                        if antikickonteleport then
                            pcall(function()
                                queueonteleport('local kick; kick = hookmetamethod(game, "__namecall", function(obj, ...) local args = {...} local method = getnamecallmethod() if method == "Kick" then if args[1] then print("...") end return nil end return kick(obj, unpack(args)) end)')
                            end)
                        end
                        TeleportService:Teleport(placeId, Players.LocalPlayer)
                    elseif chosenversionsubplace == "Copy Script" then
                        setclipboard("game:GetService('TeleportService'):Teleport(" .. tostring(placeId) .. ", LocalPlayer)")
                    elseif chosenversionsubplace == "Copy Game Link" then
                        setclipboard("https://www.roblox.com/games/" .. tostring(placeId))
                    end
                else
                    notify("Error", "Place not found.")
                end
            end
        })
        games:CreateLabel("If you only see the main game, no subplaces found.")
        games:CreateDivider()

        games:CreateInput({
            Name = "Pause Gameplay",
            PlaceholderText = "How many seconds to pause?",
            RemoveTextAfterFocusLost = true,
            Callback = function(t)
                local tt = tonumber(t)
                if type(tt) == "number" then
                    Players.LocalPlayer.GameplayPaused = true; task.wait()
                    Players.LocalPlayer.GameplayPaused = false; task.wait()
                    Players.LocalPlayer.GameplayPaused = true
                    task.wait(tt)
                    Players.LocalPlayer.GameplayPaused = false
                else
                    notify("Error", "Must enter a number (seconds).")
                end
            end
        })
        games:CreateLabel("Pausing gameplay overlays everything, all UI becomes unclickable.")
        games:CreateDivider()

        games:CreateToggle({
            Name = "Force Full Bright Lighting",
            CurrentValue = false,
            Callback = function()
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            end
        })

        games:CreateButton({
            Name = "Teleport to Smallest Server",
            Callback = function()
                local _place = game.PlaceId
                local _servers = "https://games.roblox.com/v1/games/" .. _place .. "/servers/Public?sortOrder=Asc&limit=100"
                local function ListServers(cursor)
                    local Raw = game:HttpGet(_servers .. (cursor and "&cursor=" .. cursor or ""))
                    return game:GetService("HttpService"):JSONDecode(Raw)
                end
                local Server, Next
                repeat
                    local Servers = ListServers(Next)
                    Server = Servers.data[1]
                    Next = Servers.nextPageCursor
                until Server
                notify("Teleporting", "Teleporting to Job ID: " .. Server.id)
                if antikickonteleport then
                    pcall(function()
                        queueonteleport('local kick; kick = hookmetamethod(game, "__namecall", function(obj, ...) local args = {...} local method = getnamecallmethod() if method == "Kick" then if args[1] then print("...") end return nil end return kick(obj, unpack(args)) end)')
                    end)
                end
                TeleportService:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
            end
        })

        games:CreateButton({ Name = "Force Close Roblox App", Callback = function() game:Shutdown() end })
        games:CreateLabel("Place ID: " .. game.PlaceId)
        games:CreateLabel("Universe ID: " .. game.GameId)
        games:CreateLabel("Job ID: " .. game.JobId)
    end

    -- ===================== PLAYERS =====================
    if getgenv().WyvernConfig["Players"] then
        local players = Window:CreateTab("Players", 4483362458)
        players:CreateLabel("Uses SetLocalPlayerInfo() to change your info!")

        players:CreateInput({
            Name = "Spoof as Player (User ID)",
            PlaceholderText = "Enter User ID...",
            RemoveTextAfterFocusLost = false,
            Callback = function(t)
                local tt = tonumber(t)
                if type(tt) == "number" then
                    local name = Players:GetNameFromUserIdAsync(tt)
                    Players:SetLocalPlayerInfo(tt, name, name, Enum.MembershipType.Premium, false)
                    notify("Success", "You are now " .. name .. "! (" .. tt .. ")")
                else
                    notify("Failed", "Please put a correct User ID.")
                end
            end
        })

        players:CreateButton({
            Name = "Spoof as Game Owner",
            Callback = function()
                local name = Players:GetNameFromUserIdAsync(tonumber(game.CreatorId))
                Players:SetLocalPlayerInfo(game.CreatorId, name, name, Enum.MembershipType.Premium, false)
                notify("Success", "You are now " .. name .. "! (" .. game.CreatorId .. ")")
            end
        })

        players:CreateDivider()
        players:CreateToggle({
            Name = "Auto Hide Other Players",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    local usernames = {}
                    while task.wait(0.1) do
                        local plrs = Players:GetPlayers()
                        local localPlayer = Players.LocalPlayer
                        local cusernames = {}
                        for _, player in ipairs(plrs) do
                            if player ~= localPlayer then
                                table.insert(cusernames, player.Name)
                                if not usernames[player.Name] then usernames[player.Name] = true end
                            end
                        end
                        for username, _ in pairs(usernames) do
                            if not table.find(cusernames, username) then usernames[username] = nil end
                        end
                        for _, model in ipairs(game.Workspace:GetChildren()) do
                            if model:IsA("Model") and usernames[model.Name] then model:Destroy() end
                        end
                        if Visit:FindFirstChild("Part") then break end
                    end
                else
                    local kill = Instance.new("Part")
                    kill.Parent = Visit
                    task.wait(0.2)
                    kill:Destroy()
                end
            end
        })

        players:CreateToggle({
            Name = "Show Hidden GUIs of LocalPlayer",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    guis = {}
                    for i, v in pairs(Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui"):GetDescendants()) do
                        if (v:IsA("Frame") or v:IsA("ImageLabel") or v:IsA("ScrollingFrame")) and not v.Visible then
                            v.Visible = true
                            if not table.find(guis, v) then table.insert(guis, v) end
                        end
                    end
                else
                    for i, v in pairs(guis or {}) do v.Visible = false end
                    guis = {}
                end
            end
        })

        players:CreateToggle({
            Name = "Anti AFK",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    Players.LocalPlayer.Idled:connect(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end
        })

        players:CreateDivider()
        local signal
        players:CreateButton({
            Name = "Create Waypoint at Current Position",
            Callback = function()
                if not Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    notify("Failure", "HumanoidRootPart is missing from character")
                    return
                end
                getgenv().pos = Players.LocalPlayer.Character.HumanoidRootPart.Position
                notify("Success", "Created waypoint at " .. tostring(getgenv().pos))
                if getgenv().addeduis then return end
                players:CreateButton({ Name = "Teleport to Saved Waypoint", Callback = function()
                    Players.LocalPlayer.Character:MoveTo(getgenv().pos)
                end})
                players:CreateButton({ Name = "Set Spawnpoint to Saved Waypoint", Callback = function()
                    signal = Players.LocalPlayer.CharacterAdded:Connect(function()
                        Players.LocalPlayer.Character:MoveTo(getgenv().pos)
                    end)
                    players:CreateButton({ Name = "Delete Spawnpoint", Callback = function() signal:Disconnect() end })
                end})
                players:CreateButton({ Name = "Delete Saved Waypoint", Callback = function() getgenv().pos = nil end })
                getgenv().addeduis = true
            end
        })
    end

    -- ===================== NETWORK =====================
    if getgenv().WyvernConfig["Network"] then
        local network = Window:CreateTab("Network", 4483362458)
        network:CreateLabel("This can bypass rate limits when firing remotes!")

        network:CreateInput({
            Name = "KBPS Limit",
            PlaceholderText = "Type a big number to have no limit...",
            RemoveTextAfterFocusLost = true,
            Callback = function(t)
                local tt = tonumber(t)
                if type(tt) == "number" then
                    NetworkClient:SetOutgoingKBPSLimit(tt)
                    notify("Success!", "KBPS Limit set to " .. tostring(tt))
                else
                    notify("Hold up!", "KBPS Limit must be a number.")
                end
            end
        })

        network:CreateDivider()
        network:CreateLabel("Simulates lag/delay from client -> server.")
        network:CreateDropdown({
            Name = "Delay Intensiveness",
            Options = {"Normal", "Mild", "Medium", "Severe", "No Connection"},
            CurrentOption = {"Normal"},
            Callback = function(bool)
                if bool == "Normal" then NetworkSettings.IncomingReplicationLag = 0
                elseif bool == "Mild" then NetworkSettings.IncomingReplicationLag = 1
                elseif bool == "Medium" then NetworkSettings.IncomingReplicationLag = 2
                elseif bool == "Severe" then NetworkSettings.IncomingReplicationLag = 3
                elseif bool == "No Connection" then NetworkSettings.IncomingReplicationLag = 10
                end
            end
        })

        network:CreateDivider()
        network:CreateButton({
            Name = "Show Average Ping",
            Callback = function()
                notify("Average Ping", math.round(Players.LocalPlayer:GetNetworkPing() * 1000) .. "ms")
            end
        })
    end

    -- ===================== INPUT AUTOMATIONS =====================
    if getgenv().WyvernConfig["Input Automations"] then
        local input = Window:CreateTab("Input Automations", 4483362458)

        input:CreateToggle({
            Name = "Auto Use Tools in Inventory",
            CurrentValue = false,
            Callback = function(bool)
                local Player = Players.LocalPlayer
                getgenv().firetools = bool
                if bool then
                    spawn(function()
                        while wait() and firetools do
                            pcall(function()
                                local Tool = Player.Backpack:FindFirstChildWhichIsA("Tool")
                                if not Player.Character:FindFirstChildWhichIsA("Tool") then
                                    Player.Character:FindFirstChildWhichIsA("Humanoid"):EquipTool(Tool)
                                end
                                if Player.Character:FindFirstChildWhichIsA("Tool") then
                                    Player.Character:FindFirstChildWhichIsA("Tool"):Activate()
                                end
                            end)
                        end
                    end)
                end
            end
        })

        input:CreateToggle({
            Name = "Auto Grab All Dropped Tools",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    for i, v in pairs(workspace:GetChildren()) do
                        if Players.LocalPlayer.Character:FindFirstChild("Humanoid") and v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
                            Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):EquipTool(v)
                        end
                    end
                    if getgenv().connected then getgenv().connected:Disconnect() end
                    getgenv().connected = workspace.ChildAdded:Connect(function(child)
                        if Players.LocalPlayer.Character:FindFirstChild("Humanoid") and child:IsA("BackpackItem") and child:FindFirstChild("Handle") then
                            Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):EquipTool(child)
                        end
                    end)
                else
                    if getgenv().connected then getgenv().connected:Disconnect() end
                end
            end
        })

        input:CreateToggle({
            Name = "Infinite ProximityPrompt Range",
            CurrentValue = false,
            Callback = function(bool)
                if bool then
                    ProximityPromptService.MaxPromptsVisible = math.huge
                    for i, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then v.MaxActivationDistance = math.huge end
                    end
                else
                    ProximityPromptService.MaxPromptsVisible = 16
                    for i, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then v.MaxActivationDistance = 10 end
                    end
                end
            end
        })

        input:CreateToggle({
            Name = "Instant ProximityPrompt",
            CurrentValue = false,
            Callback = function(bool)
                local promptsignal = nil
                if bool then
                    promptsignal = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
                        pcall(function() fireproximityprompt(prompt) end)
                    end)
                else
                    if promptsignal then promptsignal:Disconnect(); promptsignal = nil end
                end
            end
        })

        input:CreateButton({ Name = "Equip All Tools", Callback = function()
            for i, v in pairs(Players.LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") then v.Parent = Players.LocalPlayer.Character end
            end
        end})

        input:CreateButton({ Name = "Force Drop Tool", Callback = function()
            for i, v in pairs(Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("Tool") then v.Parent = workspace end
            end
        end})

        input:CreateDivider()
        input:CreateButton({ Name = "Fire All ClickDetectors", Callback = function()
            for i, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") then
                    v.MaxActivationDistance = math.huge
                    pcall(function() fireclickdetector(v) end)
                end
            end
        end})

        input:CreateButton({ Name = "Fire All TouchInterests", Callback = function()
            for i, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") then touch(v) end
            end
        end})

        input:CreateButton({ Name = "Fire All ProximityPrompts", Callback = function()
            for i, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    pcall(function() fireproximityprompt(v) end)
                end
            end
        end})
    end

    -- ===================== PURCHASE EXPLOITS =====================
    if getgenv().WyvernConfig["Purchase Exploits"] then
        local purchase = Window:CreateTab("Purchase Exploits", 4483362458)

        local dnames, dproductIds = {}, {}
        pcall(function()
            local currentPage = 1
            repeat
                local response = game:HttpGet("https://apis.roblox.com/developer-products/v1/developer-products/list?universeId=" .. tostring(game.GameId) .. "&page=" .. tostring(currentPage))
                local decodedResponse = game:GetService("HttpService"):JSONDecode(response)
                local developerProducts = decodedResponse.DeveloperProducts
                for _, developerProduct in pairs(developerProducts) do
                    table.insert(dnames, developerProduct.Name)
                    table.insert(dproductIds, developerProduct.ProductId)
                end
                currentPage = currentPage + 1
                local final = decodedResponse.FinalPage
            until final
        end)
        if #dnames == 0 then table.insert(dnames, " ") end

        purchase:CreateParagraph({
            Title = "Fake Purchaser!",
            Content = "Tricks server that you bought a DevProduct!\nOnly works in some games..."
        })

        local devIndex
        purchase:CreateDropdown({
            Name = "DevProducts List",
            Options = dnames,
            CurrentOption = {dnames[1] or ""},
            Callback = function(x)
                devIndex = nil
                for i, name in ipairs(dnames) do
                    if name == x then devIndex = i; break end
                end
            end
        })
        purchase:CreateLabel("If nothing shows above, no DevProducts found.")

        getgenv().wyvernlooppurchases = false
        purchase:CreateToggle({
            Name = "Loop Selected Dev Product",
            CurrentValue = false,
            Callback = function(bool)
                getgenv().wyvernlooppurchases = bool
                while getgenv().wyvernlooppurchases and task.wait() do
                    if devIndex then
                        local product = dproductIds[devIndex]
                        pcall(function()
                            stealth_call("MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, " .. product .. ", true) ")
                        end)
                    end
                end
            end
        })

        purchase:CreateButton({
            Name = "Fire Selected Dev Product!",
            Callback = function()
                if devIndex then
                    local product = dproductIds[devIndex]
                    pcall(function()
                        stealth_call("MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, " .. product .. ", true) ")
                    end)
                    task.wait(0.2)
                    if not Visit:FindFirstChild("LocalScript") then
                        notify("Error", "Your executor blocked SignalPromptProductPurchaseFinished.")
                    else
                        notify("Success", "Fired PromptProductPurchaseFinished with productId: " .. tostring(product))
                        Visit:FindFirstChild("LocalScript"):Destroy()
                    end
                else
                    notify("Error", "Select a product first.")
                end
            end
        })

        purchase:CreateButton({
            Name = "Fire All Dev Products",
            Callback = function()
                local starttickcc = tick()
                for i, product in pairs(dproductIds) do
                    task.spawn(function()
                        pcall(function()
                            stealth_call("MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, " .. product .. ", true) ")
                        end)
                    end)
                    task.wait()
                end
                notify("Attempt", "Fired All Dev Products! Took " .. tostring(tick() - starttickcc) .. "s!")
            end
        })

        getgenv().wyvernlooppurchases2 = false
        purchase:CreateToggle({
            Name = "Loop All Dev Products",
            CurrentValue = false,
            Callback = function(bool)
                getgenv().wyvernlooppurchases2 = bool
                while getgenv().wyvernlooppurchases2 and task.wait() do
                    for i, product in pairs(dproductIds) do
                        task.spawn(function()
                            pcall(function()
                                stealth_call("MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId, " .. product .. ", true) ")
                            end)
                        end)
                        task.wait()
                    end
                end
            end
        })

        purchase:CreateDivider()
        purchase:CreateLabel("Same as above but for Gamepasses.")

        local gnames, gproductIds = {}, {}
        pcall(function()
            local wyverngamepass = game:GetService("HttpService"):JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/" .. game.GameId .. "/game-passes?limit=100&sortOrder=1")
            )
            for i, v in pairs(wyverngamepass.data) do
                table.insert(gnames, v.name)
                table.insert(gproductIds, v.id)
            end
        end)
        if #gnames == 0 then table.insert(gnames, " ") end

        local gamepass
        purchase:CreateDropdown({
            Name = "GamePass List",
            Options = gnames,
            CurrentOption = {gnames[1] or ""},
            Callback = function(x)
                for i, name in ipairs(gnames) do
                    if name == x then gamepass = gproductIds[i]; break end
                end
            end
        })
        purchase:CreateLabel("If nothing shows above, no GamePass found.")

        purchase:CreateButton({
            Name = "Fire Selected Gamepass",
            Callback = function()
                if gamepass then
                    pcall(function()
                        stealth_call("MarketplaceService:SignalPromptGamePassPurchaseFinished(game.Players.LocalPlayer, " .. tostring(gamepass) .. ", true)")
                    end)
                    task.wait(0.2)
                    if not Visit:FindFirstChild("LocalScript") then
                        notify("Error", "Your executor blocked SignalPromptGamePassPurchaseFinished.")
                    else
                        notify("Success", "Fired GamePassPurchaseFinished with id: " .. tostring(gamepass))
                        Visit:FindFirstChild("LocalScript"):Destroy()
                    end
                else
                    notify("Error", "Select a gamepass first.")
                end
            end
        })

        purchase:CreateDivider()
        purchase:CreateLabel("Signals server that an item purchase failed.\nThis can trick servers to reprompt an item!")

        local returnvalprompt = false
        purchase:CreateToggle({
            Name = "Item Purchase Success Return Value",
            CurrentValue = false,
            Callback = function(bool) returnvalprompt = bool end
        })

        purchase:CreateInput({
            Name = "Signal Purchase Finished (Item ID)",
            PlaceholderText = "Enter the Item ID...",
            RemoveTextAfterFocusLost = false,
            Callback = function(t)
                local tt = tonumber(t)
                if type(tt) == "number" then
                    pcall(function()
                        stealth_call(
                            "MarketplaceService:SignalPromptPurchaseFinished(game.Players.LocalPlayer, " .. tt ..
                            ", false) MarketplaceService:SignalPromptPurchaseFinished(game.Players.LocalPlayer, " .. tt ..
                            ", " .. tostring(returnvalprompt) .. ")"
                        )
                    end)
                    task.wait(0.2)
                    if not Visit:FindFirstChild("LocalScript") then
                        notify("Error", "Your executor blocked SignalPromptPurchaseFinished.")
                    else
                        notify("Success", "Fired PromptPurchaseFinished with id: " .. tostring(tt))
                        Visit:FindFirstChild("LocalScript"):Destroy()
                    end
                else
                    notify("Error", "That's not an Item ID.")
                end
            end
        })

        purchase:CreateDivider()
    end

    -- ===================== FINISH =====================
    getgenv().WyvernLoaded = true
    getgenv().WyvernConfig = nil

    pcall(function()
        if message.Text ~= "loading wyborn (skidded by KW)" then
            game.Players.LocalPlayer:Kick()
            task.spawn(function() task.wait(10); game.Players.LocalPlayer:remove() end)
        end
        message:Destroy()
    end)

    -- Adonis check
    local adonisFound = false
    task.spawn(function()
        for _, v in pairs(game:GetDescendants()) do
            if adonisFound then return end
            if string.find(v.Name:upper(), "ADONIS") or (v:IsA("ImageButton") and v.Image == "rbxassetid://357249130") then
                adonisFound = true
                notify("Adonis Finder", "Adonis detected! Try !buyitem or !buyasset.")
                return
            end
        end
    end)
    task.spawn(function()
        for _, d in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if adonisFound then return end
            if d:IsA("RemoteEvent") and d:FindFirstChild("__FUNCTION") then
                adonisFound = true
                notify("Adonis Finder", "Adonis detected! Try !buyitem or !buyasset.")
                return
            end
        end
    end)

    -- Version check
    if getgenv().SentPromptCorePackage == nil then getgenv().SentPromptCorePackage = false end
    task.spawn(function()
        getgenv().realwyvernversion = loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/refs/heads/main/version"))()
        if getgenv().wyvern_version == nil or getgenv().wyvern_version ~= getgenv().realwyvernversion then
            if not getgenv().SentPromptCorePackage then
                getgenv().SentPromptCorePackage = true
                notify("Heads Up!", "This Wyborn is outdated! Current: " .. tostring(getgenv().wyvern_version) .. " | Latest: " .. tostring(getgenv().realwyvernversion))
            end
        end
    end)
end)
end)

if not wybornsuccess or wyvernerror ~= nil then
    print(wyvernerror)
end
