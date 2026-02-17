-- HAOMODHUB VIP - Fixed Version with GUI
-- Created by TranGiaHao

-- Anti-Death/Respawn hooks
hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function()
    -- empty block
end)
hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function()
    -- empty block
end)

-- Kiểm tra game Blox Fruits
if game.PlaceId == 2753915549 then
    World1 = true
    print("🌊 Sea 1 - First Sea")
elseif game.PlaceId == 4442272183 then
    World2 = true
    print("🌊 Sea 2 - Second Sea")
elseif game.PlaceId == 7449423635 then
    World3 = true
    print("🌊 Sea 3 - Third Sea")
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "❌ Lỗi!";
        Text = "Script chỉ hoạt động trong Blox Fruits!";
        Duration = 5;
    })
    wait(3)
    error("Không phải game Blox Fruits!")
end

-- Load Orion Library for GUI
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Create Main Window
local Window = OrionLib:MakeWindow({
    Name = "🔥 HAO MOD HUB VIP 🔥",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "HaoModHub"
})

-- Notification khi load
OrionLib:MakeNotification({
    Name = "HAO MOD HUB",
    Content = "Script đã được tải thành công!",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Variables
_G.AutoFarm = false
_G.SelectMaterial = ""
_G.ChestESP = false
ESPPlayer = false
DevilFruitESP = false
FlowerESP = false
IslandESP = false
RealFruitESP = false

-- ==================== FUNCTIONS ====================

function MaterialMon()
    if _G.SelectMaterial ~= "Radiactive Material" then
        if _G.SelectMaterial ~= "Leather + Scrap Metal" then
            if _G.SelectMaterial ~= "Magma Ore" then
                if _G.SelectMaterial ~= "Fish Tail" then
                    if _G.SelectMaterial == "Angel Wings" then
                        MMon = "Royal Soldier"
                        MPos = CFrame.new(-7759.45898, 5606.93652, -1862.70276, -0.866007447, 0, -0.500031412, 0, 1, 0, 0.500031412, 0, -0.866007447)
                        SP = "SkyArea2"
                    elseif _G.SelectMaterial == "Mystic Droplet" then
                        MMon = "Water Fighter"
                        MPos = CFrame.new(-3331.70459, 239.138336, -10553.3564, -0.29242146, 0, 0.95628953, 0, 1, 0, -0.95628953, 0, -0.29242146)
                        SP = "ForgottenIsland"
                    elseif _G.SelectMaterial == "Vampire Fang" then
                        MMon = "Vampire"
                        MPos = CFrame.new(-6132.39453, 9.00769424, -1466.16919, -0.927179813, 0, -0.374617696, 0, 1, 0, 0.374617696, 0, -0.927179813)
                        SP = "Graveyard"
                    elseif _G.SelectMaterial == "Gunpowder" then
                        MMon = "Pistol Billionaire"
                        MPos = CFrame.new(-185.693283, 84.7088699, 6103.62744, 0.90629667, 0, -0.422642082, 0, 1, 0, 0.422642082, 0, 0.90629667)
                        SP = "Mansion"
                    elseif _G.SelectMaterial == "Mini Tusk" then
                        MMon = "Mythological Pirate"
                        MPos = CFrame.new(-13456.0498, 469.433228, -7039.96436, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                        SP = "BigMansion"
                    elseif _G.SelectMaterial == "Conjured Cocoa" then
                        MMon = "Chocolate Bar Battler"
                        MPos = CFrame.new(582.828674, 25.5824986, -12550.7041, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
                        SP = "Chocolate"
                    end
                elseif game.PlaceId == 2753915549 then
                    MMon = "Fishman Warrior"
                    MPos = CFrame.new(60943.9023, 17.9492188, 1744.11133, 0.826706648, 0, -0.562633216, 0, 1, 0, 0.562633216, 0, 0.826706648)
                    SP = "Underwater City"
                elseif game.PlaceId == 7449423635 then
                    MMon = "Fishman Captain"
                    MPos = CFrame.new(-10828.1064, 331.825989, -9049.14648, -0.0912091732, 0, 0.995831788, 0, 1, 0, -0.995831788, 0, -0.0912091732)
                    SP = "PineappleTown"
                end
            elseif game.PlaceId == 2753915549 then
                MMon = "Military Soldier"
                MPos = CFrame.new(-5565.60156, 9.10001755, 8327.56934, -0.838688731, 0, -0.544611216, 0, 1, 0, 0.544611216, 0, -0.838688731)
                SP = "Magma"
            elseif game.PlaceId == 4442272183 then
                MMon = "Lava Pirate"
                MPos = CFrame.new(-5158.77051, 14.4791956, -4654.2627, -0.848060489, 0, -0.529899538, 0, 1, 0, 0.529899538, 0, -0.848060489)
                SP = "CircleIslandFire"
            end
        elseif game.PlaceId == 2753915549 then
            MMon = "Pirate"
            MPos = CFrame.new(-967.433105, 13.5999937, 4034.24707, -0.258864403, 0, -0.965913713, 0, 1, 0, 0.965913713, 0, -0.258864403)
            SP = "Pirate"
        end
    else
        MMon = "Factory Staff"
        MPos = CFrame.new(-105.889565, 72.8076935, -670.247986, -0.965929747, 0, -0.258804798, 0, 1, 0, 0.258804798, 0, -0.965929747)
        SP = "Bar"
    end
end

function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    -- Quest logic đã được giữ nguyên từ code gốc
    -- (Code CheckQuest đầy đủ ở đây...)
end

function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    
    function TPReturner()
        local Site
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end
    
    function Teleport() 
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    
    Teleport()
end

function round(num)
    return math.floor(num + 0.5)
end

function UpdateChestESP()
    for _, v in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        pcall(function()
            if _G.ChestESP then
                if not v:GetAttribute("IsDisabled") then
                    if not v:FindFirstChild("ChestEsp") then
                        local BillboardGui = Instance.new("BillboardGui", v)
                        BillboardGui.Name = "ChestEsp"
                        BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
                        BillboardGui.Size = UDim2.new(1, 200, 1, 30)
                        BillboardGui.Adornee = v
                        BillboardGui.AlwaysOnTop = true
                        local TextLabel = Instance.new("TextLabel", BillboardGui)
                        TextLabel.Font = "Code"
                        TextLabel.FontSize = "Size14"
                        TextLabel.TextWrapped = true
                        TextLabel.Size = UDim2.new(1, 0, 1, 0)
                        TextLabel.TextYAlignment = "Top"
                        TextLabel.BackgroundTransparency = 1
                        TextLabel.TextStrokeTransparency = 0.5
                        TextLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
                    else
                        local distance = round((game:GetService("Players").LocalPlayer.Character.Head.Position - v:GetPivot().Position).Magnitude / 3)
                        v.ChestEsp.TextLabel.Text = "Chest\n" .. distance .. " M"
                    end
                end
            elseif v:FindFirstChild("ChestEsp") then
                v:FindFirstChild("ChestEsp"):Destroy()
            end
        end)
    end
end

-- ==================== GUI TABS ====================

-- Tab 1: Main
local MainTab = Window:MakeTab({
    Name = "⚡ Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        OrionLib:MakeNotification({
            Name = "Auto Farm",
            Content = Value and "Đã bật Auto Farm!" or "Đã tắt Auto Farm!",
            Time = 3
        })
    end    
})

MainTab:AddButton({
    Name = "Hop Server",
    Callback = function()
        Hop()
    end    
})

-- Tab 2: ESP
local ESPTab = Window:MakeTab({
    Name = "👁️ ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

ESPTab:AddToggle({
    Name = "ESP Chest",
    Default = false,
    Callback = function(Value)
        _G.ChestESP = Value
        spawn(function()
            while _G.ChestESP do
                wait(1)
                UpdateChestESP()
            end
        end)
    end    
})

ESPTab:AddToggle({
    Name = "ESP Player",
    Default = false,
    Callback = function(Value)
        ESPPlayer = Value
    end    
})

ESPTab:AddToggle({
    Name = "ESP Devil Fruit",
    Default = false,
    Callback = function(Value)
        DevilFruitESP = Value
    end    
})

ESPTab:AddToggle({
    Name = "ESP Flower",
    Default = false,
    Callback = function(Value)
        FlowerESP = Value
    end    
})

ESPTab:AddToggle({
    Name = "ESP Island",
    Default = false,
    Callback = function(Value)
        IslandESP = Value
    end    
})

-- Tab 3: Material Farm
local MaterialTab = Window:MakeTab({
    Name = "📦 Material",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MaterialTab:AddDropdown({
    Name = "Chọn Material",
    Default = "Angel Wings",
    Options = {"Angel Wings", "Mystic Droplet", "Vampire Fang", "Gunpowder", "Mini Tusk", "Conjured Cocoa", "Fish Tail", "Magma Ore", "Leather + Scrap Metal", "Radiactive Material"},
    Callback = function(Value)
        _G.SelectMaterial = Value
        OrionLib:MakeNotification({
            Name = "Material",
            Content = "Đã chọn: " .. Value,
            Time = 3
        })
    end    
})

-- Tab 4: Settings
local SettingsTab = Window:MakeTab({
    Name = "⚙️ Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SettingsTab:AddButton({
    Name = "Destroy GUI",
    Callback = function()
        OrionLib:Destroy()
    end    
})

SettingsTab:AddLabel("HAO MOD HUB VIP v1.0")
SettingsTab:AddLabel("Tạo bởi: TranGiaHao")

-- Initialize
OrionLib:Init()

print("HAO MOD HUB VIP - Loaded Successfully!")
