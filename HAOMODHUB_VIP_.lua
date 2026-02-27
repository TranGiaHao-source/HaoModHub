loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDangNhoEm/TuanAnhIOS/refs/heads/main/koby"))()

-- ==========================================
-- SERVICES
-- ==========================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")

-- PLAYER
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui", 5)

-- CHARACTER
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- EXPLOIT CHECK
local executor = (getexecutorname and getexecutorname()) or (identifyexecutor and identifyexecutor())
if executor then
    if
        string.find(executor, "Bunni") or
        string.find(executor, "FluxusZ") or
        string.find(executor, "Delta") or
        string.find(executor, "Arceus") or
        string.find(executor, "Xeno") or
        string.find(executor, "Swift") or
        string.find(executor, "Awp") or
        string.find(executor, "Volcano") or
        string.find(executor, "Argon") or
        string.find(executor, "Macsploit") or
        string.find(executor, "Potassium") or
        string.find(executor, "CodeX") or
        string.find(executor, "Velocity") or
        string.find(executor, "Romix") or
        string.find(executor, "Neutron")
    then
        print("ok")
    else
        game.Players.LocalPlayer:Kick("Please use Delta Exploit or PC use volcano or Exploit paid!")
    end
end

-- ALIASES
local ply = Players
local replicated = ReplicatedStorage
local RunSer = RunService
local vim1 = VirtualInputManager
local vim2 = VirtualUser
local TW = TweenService
local plr = Player
local Root = HumanoidRootPart

-- ==========================================
-- LOAD UI LIBRARY (HDanh Hub)
-- ==========================================
Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/hdanhhub/UI/refs/heads/main/ui_BananaHub_final.lua"))()

Window = Library:CreateWindow({
    Title = "Hao Mod Hub",
    Desc = "• Blox Fruit",
    Image = "rbxassetid://123613996022560"
})

-- ==========================================
-- TẠO CÁC TABS (ĐÚNG API: AddTab nhận string)
-- ==========================================
-- ========================================================
-- HELPER: Thêm OnChanged vào object trả về từ UI elements
-- ========================================================
local function makeProxy(obj, callbackHolder)
    -- obj: object gốc từ library (toggleFunction, dropdownFunction, slider_function)
    -- callbackHolder: { extra = nil } - tham chiếu để inject OnChanged callback
    local proxy = {}
    setmetatable(proxy, {
        __index = function(_, k)
            -- OnChanged: đăng ký callback bổ sung
            if k == "OnChanged" then
                return function(_, fn)
                    callbackHolder.extra = fn
                    return proxy -- cho phép chain
                end
            end
            -- SetStage (toggle) - dot method, không cần self
            if k == "SetStage" and obj.SetStage then
                return function(_, v) pcall(obj.SetStage, v) end
            end
            -- SetValue (slider/dropdown) - thử dot rồi colon
            if k == "SetValue" then
                return function(_, v)
                    if obj.SetValue then
                        local ok = pcall(obj.SetValue, v)
                        if not ok then pcall(function() obj:SetValue(v) end) end
                    end
                end
            end
            -- GetValue
            if k == "GetValue" then
                return function(_)
                    if obj.GetValue then
                        local ok, val = pcall(obj.GetValue)
                        if ok then return val end
                        local ok2, val2 = pcall(function() return obj:GetValue() end)
                        return val2
                    end
                end
            end
            -- SetText / SetDesc (label / paragraph)
            if k == "SetText" or k == "SetDesc" then
                return function(_, t)
                    if obj.SetText then pcall(obj.SetText, obj, t)
                    elseif obj.SetDesc then pcall(obj.SetDesc, obj, t) end
                end
            end
            -- GetNewList (dropdown)
            if k == "GetNewList" then
                return function(_, list)
                    if obj.GetNewList then pcall(obj.GetNewList, obj, list) end
                end
            end
            -- ClearText (dropdown)
            if k == "ClearText" then
                return function(_, v)
                    if obj.ClearText then pcall(obj.ClearText, obj, v) end
                end
            end
            -- fallback: raw value
            local v = rawget(obj, k) or (type(obj) == "table" and obj[k])
            if type(v) == "function" then
                return function(_, ...) return pcall(v, obj, ...) end
            end
            return v
        end
    })
    return proxy
end

local function wrapTab(rawTab)
    local _currentSection = nil
    local _nextIsRight = false

    -- Đảm bảo có section để dùng (lazy init)
    local function ensureSection()
        if not _currentSection then
            _currentSection = rawTab:AddLeftGroupbox(" ")
        end
    end

    local wrapped = {}

    -- AddSection: tạo section mới xen kẽ Left/Right, không tạo mục ảo
    function wrapped:AddSection(name)
        if _nextIsRight then
            _currentSection = rawTab:AddRightGroupbox(name or " ")
            _nextIsRight = false
        else
            _currentSection = rawTab:AddLeftGroupbox(name or " ")
            _nextIsRight = true
        end
        return _currentSection
    end

    function wrapped:AddToggle(id, setting)
        ensureSection()
        local holder = { extra = nil }
        local origCb = setting.Callback or setting["Callback"]
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting["Callback"] = setting.Callback
        -- Xóa Description để tránh button bị đẩy xuống dòng
        setting["Description"] = nil
        setting.Description = nil
        local obj = _currentSection:AddToggle(id, setting)
        return makeProxy(obj, holder)
    end

    function wrapped:AddButton(setting, cb)
        ensureSection()
        -- Xóa Description để tránh button bị đẩy xuống dòng
        if type(setting) == "table" then
            setting["Description"] = nil
            setting.Description = nil
        end
        local proxy = _currentSection:AddButton(setting, cb)
        if proxy then
            local holder = {}
            return makeProxy(proxy, holder)
        end
    end

    function wrapped:AddDropdown(id, setting)
        ensureSection()
        local holder = { extra = nil }
        local origCb = setting.Callback or setting["Callback"]
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting["Callback"] = setting.Callback
        setting["Description"] = nil
        setting.Description = nil
        local obj = _currentSection:AddDropdown(id, setting)
        return makeProxy(obj, holder)
    end

    function wrapped:AddSlider(id, setting)
        ensureSection()
        local holder = { extra = nil }
        local origCb = setting.Callback or setting["Callback"]
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting["Callback"] = setting.Callback
        setting["Description"] = nil
        setting.Description = nil
        local obj = _currentSection:AddSlider(setting)
        return makeProxy(obj, holder)
    end

    function wrapped:AddInput(id, setting)
        ensureSection()
        local holder = { extra = nil }
        local origCb = setting.Callback or setting["Callback"]
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting["Callback"] = setting.Callback
        local obj = _currentSection:AddInput(id, setting)
        return makeProxy(obj, holder)
    end

    function wrapped:AddParagraph(setting)
        ensureSection()
        local title = setting.Title or setting["Title"] or ""
        local desc  = setting.Description or setting["Description"] or setting.Desc or ""
        local txt   = desc ~= "" and (title .. "\n" .. desc) or title
        local obj = _currentSection:AddLabel(txt)
        local holder = {}
        return makeProxy(obj, holder)
    end

    function wrapped:AddLabel(text)
        ensureSection()
        local obj = _currentSection:AddLabel(text)
        local holder = {}
        return makeProxy(obj, holder)
    end

    return wrapped
end

-- ==========================================
-- TẠO CÁC TABS VỚI WRAPPER
-- ==========================================
Tabs = {
    ["Info"]     = wrapTab(Window:AddTab("Thông Tin")),
    ["Main"]     = wrapTab(Window:AddTab("Cày Cấp")),
    ["Sea"]      = wrapTab(Window:AddTab("Sự Kiện")),
    ["Item"]     = wrapTab(Window:AddTab("Lấy & Nâng Cấp Vật Phẩm")),
    ["Setting"]  = wrapTab(Window:AddTab("Cài Đặt")),
    ["Status"]   = wrapTab(Window:AddTab("Webhook")),
    ["Stats"]    = wrapTab(Window:AddTab("Chỉ Số")),
    ["Player"]   = wrapTab(Window:AddTab("Người Chơi")),
    ["Teleport"] = wrapTab(Window:AddTab("Dịch Chuyển")),
    ["Visual"]   = wrapTab(Window:AddTab("Giả Mạo")),
    ["Fruit"]    = wrapTab(Window:AddTab("Trái Ác Quỷ")),
    ["Raid"]     = wrapTab(Window:AddTab("Đột Kích")),
    ["Race"]     = wrapTab(Window:AddTab("Nâng Cấp Chủng Tộc")),
    ["Shop"]     = wrapTab(Window:AddTab("Cửa Hàng")),
    ["Misc"]     = wrapTab(Window:AddTab("Khác")),
}

-- ==========================================
-- ĐỔI MÀU HỒNG CHO TOÀN BỘ UI
-- ==========================================
pcall(function()
    if Library.SetTheme then
        Library:SetTheme({
            Background         = Color3.fromRGB(255, 182, 193),
            Accent             = Color3.fromRGB(255, 20, 147),
            PrimaryText        = Color3.fromRGB(255, 255, 255),
            SecondaryText      = Color3.fromRGB(255, 220, 230),
            Divider            = Color3.fromRGB(255, 105, 180),
            Header             = Color3.fromRGB(220, 20, 90),
            Box                = Color3.fromRGB(255, 145, 175),
            Button             = Color3.fromRGB(255, 20, 147),
            Hover              = Color3.fromRGB(255, 80, 160),
            Toggle             = Color3.fromRGB(255, 20, 147),
            ToggleBackground   = Color3.fromRGB(255, 182, 193),
            Dropdown           = Color3.fromRGB(255, 145, 175),
            DropdownBackground = Color3.fromRGB(255, 182, 193),
            Scrollbar          = Color3.fromRGB(255, 20, 147),
            Outline            = Color3.fromRGB(255, 105, 180),
            Shadow             = Color3.fromRGB(180, 0, 80),
        })
    end

    if Library.Theme then
        for k, v in pairs(Library.Theme) do
            if typeof(v) == "Color3" then
                if k:lower():find("accent") or k:lower():find("primary") then
                    Library.Theme[k] = Color3.fromRGB(255, 20, 147)
                elseif k:lower():find("back") or k:lower():find("bg") then
                    Library.Theme[k] = Color3.fromRGB(255, 182, 193)
                elseif k:lower():find("text") then
                    Library.Theme[k] = Color3.fromRGB(255, 255, 255)
                else
                    Library.Theme[k] = Color3.fromRGB(255, 105, 180)
                end
            end
        end
    end

    task.spawn(function()
        task.wait(0.5)
        for _, gui in pairs(PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") then
                for _, desc in pairs(gui:GetDescendants()) do
                    if desc:IsA("Frame") or desc:IsA("ScrollingFrame") then
                        if desc.BackgroundTransparency < 1 then
                            desc.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
                        end
                    elseif desc:IsA("TextButton") then
                        desc.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
                        desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                    elseif desc:IsA("TextLabel") then
                        desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                    elseif desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
                        desc.ImageColor3 = Color3.fromRGB(255, 105, 180)
                    elseif desc:IsA("UIStroke") then
                        desc.Color = Color3.fromRGB(255, 20, 147)
                    end
                end
            end
        end
    end)
end)

wait(1)

Library:Notify({
    Title = "Hao Mod Hub",
    Description = "Chào mừng! UI màu xanh dương đã được load thành công.\nNhấn nút góc trái màn hình để mở GUI.",
    Duration = 4
})

-- ==========================================
-- TOGGLE BUTTON (NÚT MỞ/ĐÓNG MENU)
-- ==========================================

-- Anti AFK
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait()
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- ==========================================
-- SEA FLAGS (không kiểm tra, bật hết để mọi tính năng hoạt động)
-- ==========================================
Sea1 = true
Sea2 = true
Sea3 = true
local v5 = game.PlaceId

function CheckLevel()
    local v7 = game:GetService("Players").LocalPlayer.Data.Level.Value
    if Sea1 then
        if v7 == 1 or (v7 <= 9 or SelectMonster == "Bandit") then
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        elseif v7 == 10 or (v7 <= 14 or SelectMonster == "Monkey") then
            Ms = "Monkey"
            NameQuest = "JungleQuest"
            QuestLv = 1
            NameMon = "Monkey"
            CFrameQ = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(- 1448.1446533203, 50.851993560791, 63.60718536377)
        elseif v7 == 15 or (v7 <= 29 or SelectMonster == "Gorilla") then
            Ms = "Gorilla"
            NameQuest = "JungleQuest"
            QuestLv = 2
            NameMon = "Gorilla"
            CFrameQ = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(- 1142.6488037109, 40.462348937988, - 515.39227294922)
        elseif v7 == 30 or (v7 <= 39 or SelectMonster == "Pirate") then
            Ms = "Pirate"
            NameQuest = "BuggyQuest1"
            QuestLv = 1
            NameMon = "Pirate"
            CFrameQ = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(- 1201.0881347656, 40.628940582275, 3857.5966796875)
        elseif v7 == 40 or (v7 <= 59 or SelectMonster == "Brute") then
            Ms = "Brute"
            NameQuest = "BuggyQuest1"
            QuestLv = 2
            NameMon = "Brute"
            CFrameQ = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(- 1387.5324707031, 24.592035293579, 4100.9575195313)
        elseif v7 == 60 or (v7 <= 74 or SelectMonster == "Desert Bandit") then
            Ms = "Desert Bandit"
            NameQuest = "DesertQuest"
            QuestLv = 1
            NameMon = "Desert Bandit"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
        elseif v7 == 75 or (v7 <= 89 or SelectMonster == "Desert Officer") then
            Ms = "Desert Officer"
            NameQuest = "DesertQuest"
            QuestLv = 2
            NameMon = "Desert Officer"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
        elseif v7 == 90 or (v7 <= 99 or SelectMonster == "Snow Bandit") then
            Ms = "Snow Bandit"
            NameQuest = "SnowQuest"
            QuestLv = 1
            NameMon = "Snow Bandit"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156)
            CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, - 1328.2418212891)
        elseif v7 == 100 or (v7 <= 119 or SelectMonster == "Snowman") then
            Ms = "Snowman"
            NameQuest = "SnowQuest"
            QuestLv = 2
            NameMon = "Snowman"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156)
            CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, - 1488.0262451172)
        elseif v7 == 120 or (v7 <= 149 or SelectMonster == "Chief Petty Officer") then
            Ms = "Chief Petty Officer"
            NameQuest = "MarineQuest2"
            QuestLv = 1
            NameMon = "Chief Petty Officer"
            CFrameQ = CFrame.new(- 5035.49609375, 28.677835464478, 4324.1840820313)
            CFrameMon = CFrame.new(- 4931.1552734375, 65.793113708496, 4121.8393554688)
        elseif v7 == 150 or (v7 <= 174 or SelectMonster == "Sky Bandit") then
            Ms = "Sky Bandit"
            NameQuest = "SkyQuest"
            QuestLv = 1
            NameMon = "Sky Bandit"
            CFrameQ = CFrame.new(- 4842.1372070313, 717.69543457031, - 2623.0483398438)
            CFrameMon = CFrame.new(- 4955.6411132813, 365.46365356445, - 2908.1865234375)
        elseif v7 == 175 or (v7 <= 189 or SelectMonster == "Dark Master") then
            Ms = "Dark Master"
            NameQuest = "SkyQuest"
            QuestLv = 2
            NameMon = "Dark Master"
            CFrameQ = CFrame.new(- 4842.1372070313, 717.69543457031, - 2623.0483398438)
            CFrameMon = CFrame.new(- 5148.1650390625, 439.04571533203, - 2332.9611816406)
        elseif v7 == 190 or (v7 <= 209 or SelectMonster == "Prisoner") then
            Ms = "Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 1
            NameMon = "Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, - 0.999846935, 0, 0.0175017118)
            CFrameMon = CFrame.new(4937.31885, 0.332031399, 649.574524, 0.694649816, 0, - 0.719348073, 0, 1, 0, 0.719348073, 0, 0.694649816)
        elseif v7 == 210 or (v7 <= 249 or SelectMonster == "Dangerous Prisoner") then
            Ms = "Dangerous Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 2
            NameMon = "Dangerous Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, - 0.999846935, 0, 0.0175017118)
            CFrameMon = CFrame.new(5099.6626, 0.351562679, 1055.7583, 0.898906827, 0, - 0.438139856, 0, 1, 0, 0.438139856, 0, 0.898906827)
        elseif v7 == 250 or (v7 <= 274 or SelectMonster == "Toga Warrior") then
            Ms = "Toga Warrior"
            NameQuest = "ColosseumQuest"
            QuestLv = 1
            NameMon = "Toga Warrior"
            CFrameQ = CFrame.new(- 1577.7890625, 7.4151420593262, - 2984.4838867188)
            CFrameMon = CFrame.new(- 1872.5166015625, 49.080215454102, - 2913.810546875)
        elseif v7 == 275 or (v7 <= 299 or SelectMonster == "Gladiator") then
            Ms = "Gladiator"
            NameQuest = "ColosseumQuest"
            QuestLv = 2
            NameMon = "Gladiator"
            CFrameQ = CFrame.new(- 1577.7890625, 7.4151420593262, - 2984.4838867188)
            CFrameMon = CFrame.new(- 1521.3740234375, 81.203170776367, - 3066.3139648438)
        elseif v7 == 300 or (v7 <= 324 or SelectMonster == "Military Soldier") then
            Ms = "Military Soldier"
            NameQuest = "MagmaQuest"
            QuestLv = 1
            NameMon = "Military Soldier"
            CFrameQ = CFrame.new(- 5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(- 5369.0004882813, 61.24352645874, 8556.4921875)
        elseif v7 == 325 or (v7 <= 374 or SelectMonster == "Military Spy") then
            Ms = "Military Spy"
            NameQuest = "MagmaQuest"
            QuestLv = 2
            NameMon = "Military Spy"
            CFrameQ = CFrame.new(- 5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(- 5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, - 0.544762194, 0, 1, 0, 0.544762194, 0, 0.838590562)
        elseif v7 == 375 or (v7 <= 399 or SelectMonster == "Fishman Warrior") then
            Ms = "Fishman Warrior"
            NameQuest = "FishmanQuest"
            QuestLv = 1
            NameMon = "Fishman Warrior"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif v7 == 400 or (v7 <= 449 or SelectMonster == "Fishman Commando") then
            Ms = "Fishman Commando"
            NameQuest = "FishmanQuest"
            QuestLv = 2
            NameMon = "Fishman Commando"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif v7 == 10 or (v7 <= 474 or SelectMonster == "God\'s Guard") then
            Ms = "God\'s Guard"
            NameQuest = "SkyExp1Quest"
            QuestLv = 1
            NameMon = "God\'s Guard"
            CFrameQ = CFrame.new(- 4721.8603515625, 845.30297851563, - 1953.8489990234)
            CFrameMon = CFrame.new(- 4628.0498046875, 866.92877197266, - 1931.2352294922)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688))
            end
        elseif v7 == 475 or (v7 <= 524 or SelectMonster == "Shanda") then
            Ms = "Shanda"
            NameQuest = "SkyExp1Quest"
            QuestLv = 2
            NameMon = "Shanda"
            CFrameQ = CFrame.new(- 7863.1596679688, 5545.5190429688, - 378.42266845703)
            CFrameMon = CFrame.new(- 7685.1474609375, 5601.0751953125, - 441.38876342773)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047))
            end
        elseif v7 == 525 or (v7 <= 549 or SelectMonster == "Royal Squad") then
            Ms = "Royal Squad"
            NameQuest = "SkyExp2Quest"
            QuestLv = 1
            NameMon = "Royal Squad"
            CFrameQ = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125)
            CFrameMon = CFrame.new(- 7654.2514648438, 5637.1079101563, - 1407.7550048828)
        elseif v7 == 550 or (v7 <= 624 or SelectMonster == "Royal Soldier") then
            Ms = "Royal Soldier"
            NameQuest = "SkyExp2Quest"
            QuestLv = 2
            NameMon = "Royal Soldier"
            CFrameQ = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125)
            CFrameMon = CFrame.new(- 7760.4106445313, 5679.9077148438, - 1884.8112792969)
        elseif v7 == 625 or (v7 <= 649 or SelectMonster == "Galley Pirate") then
            Ms = "Galley Pirate"
            NameQuest = "FountainQuest"
            QuestLv = 1
            NameMon = "Galley Pirate"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
        elseif v7 >= 650 or SelectMonster == "Galley Captain" then
            Ms = "Galley Captain"
            NameQuest = "FountainQuest"
            QuestLv = 2
            NameMon = "Galley Captain"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
        end
    end
    if Sea2 then
        if v7 == 700 or (v7 <= 724 or SelectMonster == "Raider") then
            Ms = "Raider"
            NameQuest = "Area1Quest"
            QuestLv = 1
            NameMon = "Raider"
            CFrameQ = CFrame.new(- 427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
        elseif v7 == 725 or (v7 <= 774 or SelectMonster == "Mercenary") then
            Ms = "Mercenary"
            NameQuest = "Area1Quest"
            QuestLv = 2
            NameMon = "Mercenary"
            CFrameQ = CFrame.new(- 427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(- 864.85009765625, 122.47104644775, 1453.1505126953)
        elseif v7 == 775 or (v7 <= 799 or SelectMonster == "Swan Pirate") then
            Ms = "Swan Pirate"
            NameQuest = "Area2Quest"
            QuestLv = 1
            NameMon = "Swan Pirate"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
        elseif v7 == 800 or (v7 <= 874 or SelectMonster == "Factory Staff") then
            Ms = "Factory Staff"
            NameQuest = "Area2Quest"
            QuestLv = 2
            NameMon = "Factory Staff"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
        elseif v7 == 875 or (v7 <= 899 or SelectMonster == "Marine Lieutenan") then
            Ms = "Marine Lieutenant"
            NameQuest = "MarineQuest3"
            QuestLv = 1
            NameMon = "Marine Lieutenant"
            CFrameQ = CFrame.new(- 2440.9934082031, 73.04190826416, - 3217.7082519531)
            CFrameMon = CFrame.new(- 2489.2622070313, 84.613594055176, - 3151.8830566406)
        elseif v7 == 900 or (v7 <= 949 or SelectMonster == "Marine Captain") then
            Ms = "Marine Captain"
            NameQuest = "MarineQuest3"
            QuestLv = 2
            NameMon = "Marine Captain"
            CFrameQ = CFrame.new(- 2440.9934082031, 73.04190826416, - 3217.7082519531)
            CFrameMon = CFrame.new(- 2335.2026367188, 79.786659240723, - 3245.8674316406)
        elseif v7 == 950 or (v7 <= 974 or SelectMonster == "Zombie") then
            Ms = "Zombie"
            NameQuest = "ZombieQuest"
            QuestLv = 1
            NameMon = "Zombie"
            CFrameQ = CFrame.new(- 5494.3413085938, 48.505931854248, - 794.59094238281)
            CFrameMon = CFrame.new(- 5536.4970703125, 101.08577728271, - 835.59075927734)
        elseif v7 == 975 or (v7 <= 999 or SelectMonster == "Vampire") then
            Ms = "Vampire"
            NameQuest = "ZombieQuest"
            QuestLv = 2
            NameMon = "Vampire"
            CFrameQ = CFrame.new(- 5494.3413085938, 48.505931854248, - 794.59094238281)
            CFrameMon = CFrame.new(- 5806.1098632813, 16.722528457642, - 1164.4384765625)
        elseif v7 == 1000 or (v7 <= 1049 or SelectMonster == "Snow Trooper") then
            Ms = "Snow Trooper"
            NameQuest = "SnowMountainQuest"
            QuestLv = 1
            NameMon = "Snow Trooper"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, - 5370.5546875)
            CFrameMon = CFrame.new(535.21051025391, 432.74209594727, - 5484.9165039063)
        elseif v7 == 1050 or (v7 <= 1099 or SelectMonster == "Winter Warrior") then
            Ms = "Winter Warrior"
            NameQuest = "SnowMountainQuest"
            QuestLv = 2
            NameMon = "Winter Warrior"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, - 5370.5546875)
            CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, - 5174.130859375)
        elseif v7 == 1100 or (v7 <= 1124 or SelectMonster == "Lab Subordinate") then
            Ms = "Lab Subordinate"
            NameQuest = "IceSideQuest"
            QuestLv = 1
            NameMon = "Lab Subordinate"
            CFrameQ = CFrame.new(- 6061.841796875, 15.926671981812, - 4902.0385742188)
            CFrameMon = CFrame.new(- 5720.5576171875, 63.309471130371, - 4784.6103515625)
        elseif v7 == 1125 or (v7 <= 1174 or SelectMonster == "Horned Warrior") then
            Ms = "Horned Warrior"
            NameQuest = "IceSideQuest"
            QuestLv = 2
            NameMon = "Horned Warrior"
            CFrameQ = CFrame.new(- 6061.841796875, 15.926671981812, - 4902.0385742188)
            CFrameMon = CFrame.new(- 6292.751953125, 91.181983947754, - 5502.6499023438)
        elseif v7 == 1175 or (v7 <= 1199 or SelectMonster == "Magma Ninja") then
            Ms = "Magma Ninja"
            NameQuest = "FireSideQuest"
            QuestLv = 1
            NameMon = "Magma Ninja"
            CFrameQ = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813)
            CFrameMon = CFrame.new(- 5461.8388671875, 130.36347961426, - 5836.4702148438)
        elseif v7 == 1200 or (v7 <= 1249 or SelectMonster == "Lava Pirate") then
            Ms = "Lava Pirate"
            NameQuest = "FireSideQuest"
            QuestLv = 2
            NameMon = "Lava Pirate"
            CFrameQ = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813)
            CFrameMon = CFrame.new(- 5251.1889648438, 55.164535522461, - 4774.4096679688)
        elseif v7 == 1250 or (v7 <= 1274 or SelectMonster == "Ship Deckhand") then
            Ms = "Ship Deckhand"
            NameQuest = "ShipQuest1"
            QuestLv = 1
            NameMon = "Ship Deckhand"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif v7 == 1275 or (v7 <= 1299 or SelectMonster == "Ship Engineer") then
            Ms = "Ship Engineer"
            NameQuest = "ShipQuest1"
            QuestLv = 2
            NameMon = "Ship Engineer"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif v7 == 1300 or (v7 <= 1324 or SelectMonster == "Ship Steward") then
            Ms = "Ship Steward"
            NameQuest = "ShipQuest2"
            QuestLv = 1
            NameMon = "Ship Steward"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif v7 == 1325 or (v7 <= 1349 or SelectMonster == "Ship Officer") then
            Ms = "Ship Officer"
            NameQuest = "ShipQuest2"
            QuestLv = 2
            NameMon = "Ship Officer"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif v7 == 1350 or (v7 <= 1374 or SelectMonster == "Arctic Warrior") then
            Ms = "Arctic Warrior"
            NameQuest = "FrostQuest"
            QuestLv = 1
            NameMon = "Arctic Warrior"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, - 6484.6005859375)
            CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, - 6472.7568359375)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 6508.5581054688, 89.034996032715, - 132.83953857422))
            end
        elseif v7 == 1375 or (v7 <= 1424 or SelectMonster == "Snow Lurker") then
            Ms = "Snow Lurker"
            NameQuest = "FrostQuest"
            QuestLv = 2
            NameMon = "Snow Lurker"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, - 6484.6005859375)
            CFrameMon = CFrame.new(5628.482421875, 57.574996948242, - 6618.3481445313)
        elseif v7 == 1425 or (v7 <= 1449 or SelectMonster == "Sea Soldier") then
            Ms = "Sea Soldier"
            NameQuest = "ForgottenQuest"
            QuestLv = 1
            NameMon = "Sea Soldier"
            CFrameQ = CFrame.new(- 3054.5827636719, 236.87213134766, - 10147.790039063)
            CFrameMon = CFrame.new(- 3185.0153808594, 58.789089202881, - 9663.6064453125)
        elseif v7 >= 1450 or SelectMonster == "Water Fighter" then
            Ms = "Water Fighter"
            NameQuest = "ForgottenQuest"
            QuestLv = 2
            NameMon = "Water Fighter"
            CFrameQ = CFrame.new(- 3054.5827636719, 236.87213134766, - 10147.790039063)
            CFrameMon = CFrame.new(- 3262.9301757813, 298.69036865234, - 10552.529296875)
        end
    end
    if Sea3 then
        if v7 == 1500 or (v7 <= 1524 or SelectMonster == "Pirate Millionaire") then
            Ms = "Pirate Millionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 1
            NameMon = "Pirate Millionaire"
            CFrameQ = CFrame.new(- 450.1046447753906, 107.68145751953125, 5950.72607421875)
            CFrameMon = CFrame.new(- 193.99227905273438, 56.12502670288086, 5755.7880859375)
        elseif v7 == 1525 or (v7 <= 1574 or SelectMonster == "Pistol Billionaire") then
            Ms = "Pistol Billionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 2
            NameMon = "Pistol Billionaire"
            CFrameQ = CFrame.new(- 450.1046447753906, 107.68145751953125, 5950.72607421875)
            CFrameMon = CFrame.new(- 188.14462280273438, 84.49613189697266, 6337.0419921875)
        elseif v7 == 1575 or (v7 <= 1599 or SelectMonster == "Dragon Crew Warrior") then
            Ms = "Dragon Crew Warrior"
            NameQuest = "DragonCrewQuest"
            QuestLv = 1
            NameMon = "Dragon Crew Warrior"
            CFrameQ = CFrame.new(6735.11083984375, 126.99046325683594, - 711.0979614257812)
            CFrameMon = CFrame.new(6615.2333984375, 50.847679138183594, - 978.93408203125)
        elseif v7 == 1600 or (v7 <= 1624 or SelectMonster == "Dragon Crew Archer") then
            Ms = "Dragon Crew Archer"
            NameQuest = "DragonCrewQuest"
            QuestLv = 2
            NameMon = "Dragon Crew Archer"
            CFrameQ = CFrame.new(6735.11083984375, 126.99046325683594, - 711.0979614257812)
            CFrameMon = CFrame.new(6818.58935546875, 483.718994140625, 512.726806640625)
        elseif v7 == 1625 or (v7 <= 1649 or SelectMonster == "Hydra Enforcer") then
            Ms = "Hydra Enforcer"
            NameQuest = "VenomCrewQuest"
            QuestLv = 1
            NameMon = "Hydra Enforcer"
            CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4547.115234375, 1001.60205078125, 334.1954650878906)
        elseif v7 == 1650 or (v7 <= 1699 or SelectMonster == "Venomous Assailant") then
            Ms = "Venomous Assailant"
            NameQuest = "VenomCrewQuest"
            QuestLv = 2
            NameMon = "Venomous Assailant"
            CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4637.88525390625, 1077.85595703125, 882.4183959960938)
        elseif v7 == 1700 or (v7 <= 1724 or SelectMonster == "Marine Commodore") then
            Ms = "Marine Commodore"
            NameQuest = "MarineTreeIsland"
            QuestLv = 1
            NameMon = "Marine Commodore"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, - 6740.0551757813)
            CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, - 7109.5043945313)
        elseif v7 == 1725 or (v7 <= 1774 or SelectMonster == "Marine Rear Admiral") then
            Ms = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            QuestLv = 2
            NameMon = "Marine Rear Admiral"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, - 6740.0551757813)
            CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, - 7048.6342773438)
        elseif v7 == 1775 or (v7 <= 1799 or SelectMonster == "Fishman Raider") then
            Ms = "Fishman Raider"
            NameQuest = "DeepForestIsland3"
            QuestLv = 1
            NameMon = "Fishman Raider"
            CFrameQ = CFrame.new(- 10582.759765625, 331.78845214844, - 8757.666015625)
            CFrameMon = CFrame.new(- 10553.268554688, 521.38439941406, - 8176.9458007813)
        elseif v7 == 1800 or (v7 <= 1824 or SelectMonster == "Fishman Captain") then
            Ms = "Fishman Captain"
            NameQuest = "DeepForestIsland3"
            QuestLv = 2
            NameMon = "Fishman Captain"
            CFrameQ = CFrame.new(- 10583.099609375, 331.78845214844, - 8759.4638671875)
            CFrameMon = CFrame.new(- 10789.401367188, 427.18637084961, - 9131.4423828125)
        elseif v7 == 1825 or (v7 <= 1849 or SelectMonster == "Forest Pirate") then
            Ms = "Forest Pirate"
            NameQuest = "DeepForestIsland"
            QuestLv = 1
            NameMon = "Forest Pirate"
            CFrameQ = CFrame.new(- 13232.662109375, 332.40396118164, - 7626.4819335938)
            CFrameMon = CFrame.new(- 13489.397460938, 400.30349731445, - 7770.251953125)
        elseif v7 == 1850 or (v7 <= 1899 or SelectMonster == "Mythological Pirate") then
            Ms = "Mythological Pirate"
            NameQuest = "DeepForestIsland"
            QuestLv = 2
            NameMon = "Mythological Pirate"
            CFrameQ = CFrame.new(- 13232.662109375, 332.40396118164, - 7626.4819335938)
            CFrameMon = CFrame.new(- 13508.616210938, 582.46228027344, - 6985.3037109375)
        elseif v7 == 1900 or (v7 <= 1924 or SelectMonster == "Jungle Pirate") then
            Ms = "Jungle Pirate"
            NameQuest = "DeepForestIsland2"
            QuestLv = 1
            NameMon = "Jungle Pirate"
            CFrameQ = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375)
            CFrameMon = CFrame.new(- 12267.103515625, 459.75262451172, - 10277.200195313)
        elseif v7 == 1925 or (v7 <= 1974 or SelectMonster == "Musketeer Pirate") then
            Ms = "Musketeer Pirate"
            NameQuest = "DeepForestIsland2"
            QuestLv = 2
            NameMon = "Musketeer Pirate"
            CFrameQ = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375)
            CFrameMon = CFrame.new(- 13291.5078125, 520.47338867188, - 9904.638671875)
        elseif v7 == 1975 or (v7 <= 1999 or SelectMonster == "Reborn Skeleton") then
            Ms = "Reborn Skeleton"
            NameQuest = "HauntedQuest1"
            QuestLv = 1
            NameMon = "Reborn Skeleton"
            CFrameQ = CFrame.new(- 9480.80762, 142.130661, 5566.37305, - 0.00655503059, 4.52954225e-8, - 0.999978542, 2.04920472e-8, 1, 4.51620679e-8, 0.999978542, - 2.01955679e-8, - 0.00655503059)
            CFrameMon = CFrame.new(- 8761.77148, 183.431747, 6168.33301, 0.978073597, - 0.000013950732, - 0.208259016, - 1.08073925e-6, 1, - 0.0000720630269, 0.208259016, 0.0000707080399, 0.978073597)
        elseif v7 == 2000 or (v7 <= 2024 or SelectMonster == "Living Zombie") then
            Ms = "Living Zombie"
            NameQuest = "HauntedQuest1"
            QuestLv = 2
            NameMon = "Living Zombie"
            CFrameQ = CFrame.new(- 9480.80762, 142.130661, 5566.37305, - 0.00655503059, 4.52954225e-8, - 0.999978542, 2.04920472e-8, 1, 4.51620679e-8, 0.999978542, - 2.01955679e-8, - 0.00655503059)
            CFrameMon = CFrame.new(- 10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-8, 0.0324240364, - 2.58006327e-8, 1, - 6.06848474e-8, - 0.0324240364, 5.98163865e-8, 0.999474227)
        elseif v7 == 2025 or (v7 <= 2049 or SelectMonster == "Demonic Soul") then
            Ms = "Demonic Soul"
            NameQuest = "HauntedQuest2"
            QuestLv = 1
            NameMon = "Demonic Soul"
            CFrameQ = CFrame.new(- 9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(- 9712.03125, 204.69589233398, 6193.322265625)
        elseif v7 == 2050 or (v7 <= 2074 or SelectMonster == "Posessed Mummy") then
            Ms = "Posessed Mummy"
            NameQuest = "HauntedQuest2"
            QuestLv = 2
            NameMon = "Posessed Mummy"
            CFrameQ = CFrame.new(- 9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(- 9545.7763671875, 69.619895935059, 6339.5615234375)
        elseif v7 == 2075 or (v7 <= 2099 or SelectMonster == "Peanut Scout") then
            Ms = "Peanut Scout"
            NameQuest = "NutsIslandQuest"
            QuestLv = 1
            NameMon = "Peanut Scout"
            CFrameQ = CFrame.new(- 2105.53198, 37.2495995, - 10195.5088, - 0.766061664, 0, - 0.642767608, 0, 1, 0, 0.642767608, 0, - 0.766061664)
            CFrameMon = CFrame.new(- 2150.587890625, 122.49767303467, - 10358.994140625)
        elseif v7 == 2100 or (v7 <= 2124 or SelectMonster == "Peanut President") then
            Ms = "Peanut President"
            NameQuest = "NutsIslandQuest"
            QuestLv = 2
            NameMon = "Peanut President"
            CFrameQ = CFrame.new(- 2105.53198, 37.2495995, - 10195.5088, - 0.766061664, 0, - 0.642767608, 0, 1, 0, 0.642767608, 0, - 0.766061664)
            CFrameMon = CFrame.new(- 2150.587890625, 122.49767303467, - 10358.994140625)
        elseif v7 == 2125 or (v7 <= 2149 or SelectMonster == "Ice Cream Chef") then
            Ms = "Ice Cream Chef"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 1
            NameMon = "Ice Cream Chef"
            CFrameQ = CFrame.new(- 819.376709, 64.9259796, - 10967.2832, - 0.766061664, 0, 0.642767608, 0, 1, 0, - 0.642767608, 0, - 0.766061664)
            CFrameMon = CFrame.new(- 789.941528, 209.382889, - 11009.9805, - 0.0703101531, 0, - 0.997525156, 0, 1.00000012, 0, 0.997525275, 0, - 0.0703101456)
        elseif v7 == 2150 or (v7 <= 2199 or SelectMonster == "Ice Cream Commander") then
            Ms = "Ice Cream Commander"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 2
            NameMon = "Ice Cream Commander"
            CFrameQ = CFrame.new(- 819.376709, 64.9259796, - 10967.2832, - 0.766061664, 0, 0.642767608, 0, 1, 0, - 0.642767608, 0, - 0.766061664)
            CFrameMon = CFrame.new(- 789.941528, 209.382889, - 11009.9805, - 0.0703101531, 0, - 0.997525156, 0, 1.00000012, 0, 0.997525275, 0, - 0.0703101456)
        elseif v7 == 2200 or (v7 <= 2224 or SelectMonster == "Cookie Crafter") then
            Ms = "Cookie Crafter"
            NameQuest = "CakeQuest1"
            QuestLv = 1
            NameMon = "Cookie Crafter"
            CFrameQ = CFrame.new(- 2022.29858, 36.9275894, - 12030.9766, - 0.961273909, 0, - 0.275594592, 0, 1, 0, 0.275594592, 0, - 0.961273909)
            CFrameMon = CFrame.new(- 2321.71216, 36.699482, - 12216.7871, - 0.780074954, 0, 0.625686109, 0, 1, 0, - 0.625686109, 0, - 0.780074954)
        elseif v7 == 2225 or (v7 <= 2249 or SelectMonster == "Cake Guard") then
            Ms = "Cake Guard"
            NameQuest = "CakeQuest1"
            QuestLv = 2
            NameMon = "Cake Guard"
            CFrameQ = CFrame.new(- 2022.29858, 36.9275894, - 12030.9766, - 0.961273909, 0, - 0.275594592, 0, 1, 0, 0.275594592, 0, - 0.961273909)
            CFrameMon = CFrame.new(- 1418.11011, 36.6718941, - 12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, - 0.997700036, 0, 0.0677844882)
        elseif v7 == 2250 or (v7 <= 2274 or SelectMonster == "Baking Staff") then
            Ms = "Baking Staff"
            NameQuest = "CakeQuest2"
            QuestLv = 1
            NameMon = "Baking Staff"
            CFrameQ = CFrame.new(- 1928.31763, 37.7296638, - 12840.626, 0.951068401, 0, - 0.308980465, 0, 1, 0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(- 1980.43848, 36.6716766, - 12983.8418, - 0.254443765, 0, - 0.967087567, 0, 1, 0, 0.967087567, 0, - 0.254443765)
        elseif v7 == 2275 or (v7 <= 2299 or SelectMonster == "Head Baker") then
            Ms = "Head Baker"
            NameQuest = "CakeQuest2"
            QuestLv = 2
            NameMon = "Head Baker"
            CFrameQ = CFrame.new(- 1928.31763, 37.7296638, - 12840.626, 0.951068401, 0, - 0.308980465, 0, 1, 0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(- 2251.5791, 52.2714615, - 13033.3965, - 0.991971016, 0, - 0.126466095, 0, 1, 0, 0.126466095, 0, - 0.991971016)
        elseif v7 == 2300 or (v7 <= 2324 or SelectMonster == "Cocoa Warrior") then
            Ms = "Cocoa Warrior"
            NameQuest = "ChocQuest1"
            QuestLv = 1
            NameMon = "Cocoa Warrior"
            CFrameQ = CFrame.new(231.75, 23.9003029, - 12200.292, - 1, 0, 0, 0, 1, 0, 0, 0, - 1)
            CFrameMon = CFrame.new(167.978516, 26.2254658, - 12238.874, - 0.939700961, 0, 0.341998369, 0, 1, 0, - 0.341998369, 0, - 0.939700961)
        elseif v7 == 2325 or (v7 <= 2349 or SelectMonster == "Chocolate Bar Battler") then
            Ms = "Chocolate Bar Battler"
            NameQuest = "ChocQuest1"
            QuestLv = 2
            NameMon = "Chocolate Bar Battler"
            CFrameQ = CFrame.new(231.75, 23.9003029, - 12200.292, - 1, 0, 0, 0, 1, 0, 0, 0, - 1)
            CFrameMon = CFrame.new(701.312073, 25.5824986, - 12708.2148, - 0.342042685, 0, - 0.939684391, 0, 1, 0, 0.939684391, 0, - 0.342042685)
        elseif v7 == 2350 or (v7 <= 2374 or SelectMonster == "Sweet Thief") then
            Ms = "Sweet Thief"
            NameQuest = "ChocQuest2"
            QuestLv = 1
            NameMon = "Sweet Thief"
            CFrameQ = CFrame.new(151.198242, 23.8907146, - 12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, - 0.906319618, 0, 0.422592998)
            CFrameMon = CFrame.new(- 140.258301, 25.5824986, - 12652.3115, 0.173624337, 0, - 0.984811902, 0, 1, 0, 0.984811902, 0, 0.173624337)
        elseif v7 == 2375 or (v7 <= 2400 or SelectMonster == "Candy Rebel") then
            Ms = "Candy Rebel"
            NameQuest = "ChocQuest2"
            QuestLv = 2
            NameMon = "Candy Rebel"
            CFrameQ = CFrame.new(151.198242, 23.8907146, - 12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, - 0.906319618, 0, 0.422592998)
            CFrameMon = CFrame.new(47.9231453, 25.5824986, - 13029.2402, - 0.819156051, 0, - 0.573571265, 0, 1, 0, 0.573571265, 0, - 0.819156051)
        elseif v7 == 2400 or (v7 <= 2424 or SelectMonster == "Candy Pirate") then
            Ms = "Candy Pirate"
            NameQuest = "CandyQuest1"
            QuestLv = 1
            NameMon = "Candy Pirate"
            CFrameQ = CFrame.new(- 1149.328, 13.5759039, - 14445.6143, - 0.156446099, 0, - 0.987686574, 0, 1, 0, 0.987686574, 0, - 0.156446099)
            CFrameMon = CFrame.new(- 1437.56348, 17.1481285, - 14385.6934, 0.173624337, 0, - 0.984811902, 0, 1, 0, 0.984811902, 0, 0.173624337)
        elseif v7 == 2425 or (v7 <= 2449 or SelectMonster == "Snow Demon") then
            Ms = "Snow Demon"
            NameQuest = "CandyQuest1"
            QuestLv = 2
            NameMon = "Snow Demon"
            CFrameQ = CFrame.new(- 1149.328, 13.5759039, - 14445.6143, - 0.156446099, 0, - 0.987686574, 0, 1, 0, 0.987686574, 0, - 0.156446099)
            CFrameMon = CFrame.new(- 916.222656, 17.1481285, - 14638.8125, 0.866007268, 0, 0.500031412, 0, 1, 0, - 0.500031412, 0, 0.866007268)
        elseif v7 == 2450 or (v7 <= 2474 or SelectMonster == "Isle Outlaw") then
            Ms = "Isle Outlaw"
            NameQuest = "TikiQuest1"
            QuestLv = 1
            NameMon = "Isle Outlaw"
            CFrameQ = CFrame.new(- 16549.890625, 55.68635559082031, - 179.91360473632812)
            CFrameMon = CFrame.new(- 16162.8193359375, 11.6863374710083, - 96.45481872558594)
        elseif v7 == 2475 or (v7 <= 2499 or SelectMonster == "Island Boy") then
            Ms = "Island Boy"
            NameQuest = "TikiQuest1"
            QuestLv = 2
            NameMon = "Island Boy"
            CFrameQ = CFrame.new(- 16549.890625, 55.68635559082031, - 179.91360473632812)
            CFrameMon = CFrame.new(- 16357.3125, 20.632822036743164, 1005.64892578125)
        elseif v7 == 2500 or (v7 <= 2524 or SelectMonster == "Sun-kissed Warrior") then
            Ms = "Sun-kissed Warrior"
            NameQuest = "TikiQuest2"
            QuestLv = 1
            NameMon = "Sun-kissed Warrior"
            CFrameQ = CFrame.new(- 16541.021484375, 54.77081298828125, 1051.461181640625)
            CFrameMon = CFrame.new(- 16357.3125, 20.632822036743164, 1005.64892578125)
        elseif v7 == 2525 or (v7 <= 2549 or SelectMonster == "Isle Champion") then
            Ms = "Isle Champion"
            NameQuest = "TikiQuest2"
            QuestLv = 2
            NameMon = "Isle Champion"
            CFrameQ = CFrame.new(- 16541.021484375, 54.77081298828125, 1051.461181640625)
            CFrameMon = CFrame.new(- 16848.94140625, 21.68633460998535, 1041.4490966796875)
        elseif v7 == 2550 or (v7 <= 2574 or SelectMonster == "Serpent Hunter") then
            Ms = "Serpent Hunter"
            NameQuest = "TikiQuest3"
            QuestLv = 1
            NameMon = "Serpent Hunter"
            CFrameQ = CFrame.new(- 16665.19140625, 104.59640502929688, 1579.6943359375)
            CFrameMon = CFrame.new(- 16621.4140625, 121.40631103515625, 1290.6881103515625)
        elseif v7 >= 2575 or SelectMonster == "Skull Slayer" then
            Ms = "Skull Slayer"
            NameQuest = "TikiQuest3"
            QuestLv = 2
            NameMon = "Skull Slayer"
            CFrameQ = CFrame.new(- 16665.19140625, 104.59640502929688, 1579.6943359375)
            CFrameMon = CFrame.new(- 16811.5703125, 84.625244140625, 1542.235107421875)
        end
    end
end
if Sea1 then
    tableMon = {
        "Bandit",
        "Monkey",
        "Gorilla",
        "Pirate",
        "Brute",
        "Desert Bandit",
        "Desert Officer",
        "Snow Bandit",
        "Snowman",
        "Chief Petty Officer",
        "Sky Bandit",
        "Dark Master",
        "Prisoner",
        "Dangerous Prisoner",
        "Toga Warrior",
        "Gladiator",
        "Military Soldier",
        "Military Spy",
        "Fishman Warrior",
        "Fishman Commando",
        "God\'s Guard",
        "Shanda",
        "Royal Squad",
        "Royal Soldier",
        "Galley Pirate",
        "Galley Captain"
    }
elseif Sea2 then
    tableMon = {
        "Raider",
        "Mercenary",
        "Swan Pirate",
        "Factory Staff",
        "Marine Lieutenant",
        "Marine Captain",
        "Zombie",
        "Vampire",
        "Snow Trooper",
        "Winter Warrior",
        "Lab Subordinate",
        "Horned Warrior",
        "Magma Ninja",
        "Lava Pirate",
        "Ship Deckhand",
        "Ship Engineer",
        "Ship Steward",
        "Ship Officer",
        "Arctic Warrior",
        "Snow Lurker",
        "Sea Soldier",
        "Water Fighter"
    }
elseif Sea3 then
    tableMon = {
        "Pirate Millionaire",
        "Dragon Crew Warrior",
        "Dragon Crew Archer",
        "Hydra Enforcer",
        "Venomous Assailant",
        "Marine Commodore",
        "Marine Rear Admiral",
        "Fishman Raider",
        "Fishman Captain",
        "Forest Pirate",
        "Mythological Pirate",
        "Jungle Pirate",
        "Musketeer Pirate",
        "Reborn Skeleton",
        "Living Zombie",
        "Demonic Soul",
        "Posessed Mummy",
        "Peanut Scout",
        "Peanut President",
        "Ice Cream Chef",
        "Ice Cream Commander",
        "Cookie Crafter",
        "Cake Guard",
        "Baking Staff",
        "Head Baker",
        "Cocoa Warrior",
        "Chocolate Bar Battler",
        "Sweet Thief",
        "Candy Rebel",
        "Candy Pirate",
        "Snow Demon",
        "Isle Outlaw",
        "Island Boy",
        "Sun-kissed Warrior",
        "Isle Champion",
        "Serpent Hunter",
        "Skull Slayer"
    }
end
if Sea1 then
    AreaList = {
        "Jungle",
        "Buggy",
        "Desert",
        "Snow",
        "Marine",
        "Sky",
        "Prison",
        "Colosseum",
        "Magma",
        "Fishman",
        "Sky Island",
        "Fountain"
    }
elseif Sea2 then
    AreaList = {
        "Area 1",
        "Area 2",
        "Zombie",
        "Marine",
        "Snow Mountain",
        "Ice fire",
        "Ship",
        "Frost",
        "Forgotten"
    }
elseif Sea3 then
    AreaList = {
        "Pirate Port",
        "Amazon",
        "Marine Tree",
        "Deep Forest",
        "Haunted Castle",
        "Nut Island",
        "Ice Cream Island",
        "Cake Island",
        "Choco Island",
        "Candy Island",
        "Tiki Outpost"
    }
end
function CheckBossQuest()
    if Sea1 then
        if SelectBoss ~= "The Gorilla King" then
            if SelectBoss ~= "Bobby" then
                if SelectBoss ~= "The Saw" then
                    if SelectBoss ~= "Yeti" then
                        if SelectBoss ~= "Mob Leader" then
                            if SelectBoss ~= "Vice Admiral" then
                                if SelectBoss ~= "Saber Expert" then
                                    if SelectBoss ~= "Warden" then
                                        if SelectBoss ~= "Chief Warden" then
                                            if SelectBoss ~= "Swan" then
                                                if SelectBoss ~= "Magma Admiral" then
                                                    if SelectBoss ~= "Fishman Lord" then
                                                        if SelectBoss ~= "Wysper" then
                                                            if SelectBoss ~= "Thunder God" then
                                                                if SelectBoss ~= "Cyborg" then
                                                                    if SelectBoss ~= "Ice Admiral" then
                                                                        if SelectBoss == "Greybeard" then
                                                                            BossMon = "Greybeard"
                                                                            NameBoss = "Greybeard"
                                                                            CFrameBoss = CFrame.new(- 5081.3452148438, 85.221641540527, 4257.3588867188)
                                                                        end
                                                                    else
                                                                        BossMon = "Ice Admiral"
                                                                        NameBoss = "Ice Admiral"
                                                                        CFrameBoss = CFrame.new(1266.08948, 26.1757946, - 1399.57678, - 0.573599219, 0, - 0.81913656, 0, 1, 0, 0.81913656, 0, - 0.573599219)
                                                                    end
                                                                else
                                                                    BossMon = "Cyborg"
                                                                    NameBoss = "Cyborg"
                                                                    NameQuestBoss = "FountainQuest"
                                                                    QuestLvBoss = 3
                                                                    RewardBoss = "Reward:\n$20,000\n7,500,000 Exp."
                                                                    CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
                                                                    CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
                                                                end
                                                            else
                                                                BossMon = "Thunder God"
                                                                NameBoss = "Thunder God"
                                                                NameQuestBoss = "SkyExp2Quest"
                                                                QuestLvBoss = 3
                                                                RewardBoss = "Reward:\n$20,000\n5,800,000 Exp."
                                                                CFrameQBoss = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125)
                                                                CFrameBoss = CFrame.new(- 7994.984375, 5761.025390625, - 2088.6479492188)
                                                            end
                                                        else
                                                            BossMon = "Wysper"
                                                            NameBoss = "Wysper"
                                                            NameQuestBoss = "SkyExp1Quest"
                                                            QuestLvBoss = 3
                                                            RewardBoss = "Reward:\n$15,000\n4,800,000 Exp."
                                                            CFrameQBoss = CFrame.new(- 7861.947265625, 5545.517578125, - 379.85974121094)
                                                            CFrameBoss = CFrame.new(- 7866.1333007813, 5576.4311523438, - 546.74816894531)
                                                        end
                                                    else
                                                        BossMon = "Fishman Lord"
                                                        NameBoss = "Fishman Lord"
                                                        NameQuestBoss = "FishmanQuest"
                                                        QuestLvBoss = 3
                                                        RewardBoss = "Reward:\n$15,000\n4,000,000 Exp."
                                                        CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                                                        CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
                                                    end
                                                else
                                                    BossMon = "Magma Admiral"
                                                    NameBoss = "Magma Admiral"
                                                    NameQuestBoss = "MagmaQuest"
                                                    QuestLvBoss = 3
                                                    RewardBoss = "Reward:\n$15,000\n2,800,000 Exp."
                                                    CFrameQBoss = CFrame.new(- 5314.6220703125, 12.262420654297, 8517.279296875)
                                                    CFrameBoss = CFrame.new(- 5765.8969726563, 82.92064666748, 8718.3046875)
                                                end
                                            else
                                                BossMon = "Swan"
                                                NameBoss = "Swan"
                                                NameQuestBoss = "ImpelQuest"
                                                QuestLvBoss = 3
                                                RewardBoss = "Reward:\n$15,000\n1,600,000 Exp."
                                                CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, - 0.309060812, 0, 0.951042235, 0, 1, 0, - 0.951042235, 0, - 0.309060812)
                                                CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635)
                                            end
                                        else
                                            BossMon = "Chief Warden"
                                            NameBoss = "Chief Warden"
                                            NameQuestBoss = "ImpelQuest"
                                            QuestLvBoss = 2
                                            RewardBoss = "Reward:\n$10,000\n1,000,000 Exp."
                                            CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, - 0.00062915677, 0.939684749, 0.00191645394, 0.999998152, - 0.0000280422337, - 0.939682961, 0.00181045406, 0.342041939)
                                            CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635)
                                        end
                                    else
                                        BossMon = "Warden"
                                        NameBoss = "Warden"
                                        NameQuestBoss = "ImpelQuest"
                                        QuestLvBoss = 1
                                        RewardBoss = "Reward:\n$6,000\n850,000 Exp."
                                        CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, - 4.49946401e-6, 0.975376427, - 0.0000195412576, 1, 9.03162072e-6, - 0.975376427, - 0.0000210519756, 0.220546961)
                                        CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635)
                                    end
                                else
                                    NameBoss = "Saber Expert"
                                    BossMon = "Saber Expert"
                                    CFrameBoss = CFrame.new(- 1458.89502, 29.8870335, - 50.633564)
                                end
                            else
                                BossMon = "Vice Admiral"
                                NameBoss = "Vice Admiral"
                                NameQuestBoss = "MarineQuest2"
                                QuestLvBoss = 2
                                RewardBoss = "Reward:\n$10,000\n180,000 Exp."
                                CFrameQBoss = CFrame.new(- 5036.2465820313, 28.677835464478, 4324.56640625)
                                CFrameBoss = CFrame.new(- 5006.5454101563, 88.032081604004, 4353.162109375)
                            end
                        else
                            BossMon = "Mob Leader"
                            NameBoss = "Mob Leader"
                            CFrameBoss = CFrame.new(- 2844.7307128906, 7.4180502891541, 5356.6723632813)
                        end
                    else
                        BossMon = "Yeti"
                        NameBoss = "Yeti"
                        NameQuestBoss = "SnowQuest"
                        QuestLvBoss = 3
                        RewardBoss = "Reward:\n$10,000\n180,000 Exp."
                        CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156)
                        CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, - 1488.0262451172)
                    end
                else
                    BossMon = "The Saw"
                    NameBoss = "The Saw"
                    CFrameBoss = CFrame.new(- 784.89715576172, 72.427383422852, 1603.5822753906)
                end
            else
                BossMon = "Bobby"
                NameBoss = "Bobby"
                NameQuestBoss = "BuggyQuest1"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$8,000\n35,000 Exp."
                CFrameQBoss = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188)
                CFrameBoss = CFrame.new(- 1087.3760986328, 46.949409484863, 4040.1462402344)
            end
        else
            BossMon = "The Gorilla King"
            NameBoss = "The Gorrila King"
            NameQuestBoss = "JungleQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$2,000\n7,000 Exp."
            CFrameQBoss = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameBoss = CFrame.new(- 1088.75977, 8.13463783, - 488.559906, - 0.707134247, 0, 0.707079291, 0, 1, 0, - 0.707079291, 0, - 0.707134247)
        end
    end
    if Sea2 then
        if SelectBoss ~= "Diamond" then
            if SelectBoss ~= "Jeremy" then
                if SelectBoss ~= "Fajita" then
                    if SelectBoss ~= "Don Swan" then
                        if SelectBoss ~= "Smoke Admiral" then
                            if SelectBoss ~= "Awakened Ice Admiral" then
                                if SelectBoss ~= "Tide Keeper" then
                                    if SelectBoss ~= "Darkbeard" then
                                        if SelectBoss ~= "Cursed Captain" then
                                            if SelectBoss == "Order" then
                                                BossMon = "Order"
                                                NameBoss = "Order"
                                                CFrameBoss = CFrame.new(- 6217.2021484375, 28.047645568848, - 5053.1357421875)
                                            end
                                        else
                                            BossMon = "Cursed Captain"
                                            NameBoss = "Cursed Captain"
                                            CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
                                        end
                                    else
                                        BossMon = "Darkbeard"
                                        NameBoss = "Darkbeard"
                                        CFrameMon = CFrame.new(3677.08203125, 62.751937866211, - 3144.8332519531)
                                    end
                                else
                                    BossMon = "Tide Keeper"
                                    NameBoss = "Tide Keeper"
                                    NameQuestBoss = "ForgottenQuest"
                                    QuestLvBoss = 3
                                    RewardBoss = "Reward:\n$12,500\n38,000,000 Exp."
                                    CFrameQBoss = CFrame.new(- 3053.9814453125, 237.18954467773, - 10145.0390625)
                                    CFrameBoss = CFrame.new(- 3795.6423339844, 105.88877105713, - 11421.307617188)
                                end
                            else
                                BossMon = "Awakened Ice Admiral"
                                NameBoss = "Awakened Ice Admiral"
                                NameQuestBoss = "FrostQuest"
                                QuestLvBoss = 3
                                RewardBoss = "Reward:\n$20,000\n36,000,000 Exp."
                                CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, - 6483.3520507813)
                                CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, - 6894.5595703125)
                            end
                        else
                            BossMon = "Smoke Admiral"
                            NameBoss = "Smoke Admiral"
                            NameQuestBoss = "IceSideQuest"
                            QuestLvBoss = 3
                            RewardBoss = "Reward:\n$20,000\n25,000,000 Exp."
                            CFrameQBoss = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813)
                            CFrameBoss = CFrame.new(- 5275.1987304688, 20.757257461548, - 5260.6669921875)
                        end
                    else
                        BossMon = "Don Swan"
                        NameBoss = "Don Swan"
                        CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
                    end
                else
                    BossMon = "Fajita"
                    NameBoss = "Fajita"
                    NameQuestBoss = "MarineQuest3"
                    QuestLvBoss = 3
                    RewardBoss = "Reward:\n$25,000\n15,000,000 Exp."
                    CFrameQBoss = CFrame.new(- 2441.986328125, 73.359344482422, - 3217.5324707031)
                    CFrameBoss = CFrame.new(- 2172.7399902344, 103.32216644287, - 4015.025390625)
                end
            else
                BossMon = "Jeremy"
                NameBoss = "Jeremy"
                NameQuestBoss = "Area2Quest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$25,000\n11,500,000 Exp."
                CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
                CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
            end
        else
            BossMon = "Diamond"
            NameBoss = "Diamond"
            NameQuestBoss = "Area1Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n9,000,000 Exp."
            CFrameQBoss = CFrame.new(- 427.5666809082, 73.313781738281, 1835.4208984375)
            CFrameBoss = CFrame.new(- 1576.7166748047, 198.59265136719, 13.724286079407)
        end
    end
    if Sea3 then
        if SelectBoss ~= "Stone" then
            if SelectBoss ~= "Hydra Leader" then
                if SelectBoss ~= "Kilo Admiral" then
                    if SelectBoss ~= "Captain Elephant" then
                        if SelectBoss ~= "Beautiful Pirate" then
                            if SelectBoss ~= "Cake Queen" then
                                if SelectBoss ~= "Longma" then
                                    if SelectBoss ~= "Soul Reaper" then
                                        if SelectBoss == "rip_indra True Form" then
                                            BossMon = "rip_indra True Form"
                                            NameBoss = "rip_indra True Form"
                                            CFrameBoss = CFrame.new(- 5415.3920898438, 505.74133300781, - 2814.0166015625)
                                        end
                                    else
                                        BossMon = "Soul Reaper"
                                        NameBoss = "Soul Reaper"
                                        CFrameBoss = CFrame.new(- 9524.7890625, 315.80429077148, 6655.7192382813)
                                    end
                                else
                                    BossMon = "Longma"
                                    NameBoss = "Longma"
                                    CFrameBoss = CFrame.new(- 10238.875976563, 389.7912902832, - 9549.7939453125)
                                end
                            else
                                BossMon = "Cake Queen"
                                NameBoss = "Cake Queen"
                                NameQuestBoss = "IceCreamIslandQuest"
                                QuestLvBoss = 3
                                RewardBoss = "Reward:\n$30,000\n112,500,000 Exp."
                                CFrameQBoss = CFrame.new(- 819.376709, 64.9259796, - 10967.2832, - 0.766061664, 0, 0.642767608, 0, 1, 0, - 0.642767608, 0, - 0.766061664)
                                CFrameBoss = CFrame.new(- 678.648804, 381.353943, - 11114.2012, - 0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, - 0.417492568, 0.0167988986, - 0.90852499)
                            end
                        else
                            BossMon = "Beautiful Pirate"
                            NameBoss = "Beautiful Pirate"
                            NameQuestBoss = "DeepForestIsland2"
                            QuestLvBoss = 3
                            RewardBoss = "Reward:\n$50,000\n70,000,000 Exp."
                            CFrameQBoss = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375)
                            CFrameBoss = CFrame.new(5283.609375, 22.56223487854, - 110.78285217285)
                        end
                    else
                        BossMon = "Captain Elephant"
                        NameBoss = "Captain Elephant"
                        NameQuestBoss = "DeepForestIsland"
                        QuestLvBoss = 3
                        RewardBoss = "Reward:\n$40,000\n67,000,000 Exp."
                        CFrameQBoss = CFrame.new(- 13232.682617188, 332.40396118164, - 7626.01171875)
                        CFrameBoss = CFrame.new(- 13376.7578125, 433.28689575195, - 8071.392578125)
                    end
                else
                    BossMon = "Kilo Admiral"
                    NameBoss = "Kilo Admiral"
                    NameQuestBoss = "MarineTreeIsland"
                    QuestLvBoss = 3
                    RewardBoss = "Reward:\n$35,000\n56,000,000 Exp."
                    CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, - 6739.9741210938)
                    CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, - 7144.4580078125)
                end
            else
                BossMon = "Hydra Leader"
                NameBoss = "Hydra Leader"
                NameQuestBoss = "VenomCrewQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$30,000\n52,000,000 Exp."
                CFrameQBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609)
                CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)
            end
        else
            BossMon = "Stone"
            NameBoss = "Stone"
            NameQuestBoss = "PiratePortQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n40,000,000 Exp."
            CFrameQBoss = CFrame.new(- 289.76705932617, 43.819011688232, 5579.9384765625)
            CFrameBoss = CFrame.new(- 1027.6512451172, 92.404174804688, 6578.8530273438)
        end
    end
end
function MaterialMon()
    if SelectMaterial ~= "Radioactive Material" then
        if SelectMaterial ~= "Mystic Droplet" then
            if SelectMaterial ~= "Magma Ore" then
                if SelectMaterial ~= "Angel Wings" then
                    if SelectMaterial ~= "Leather" then
                        if SelectMaterial ~= "Scrap Metal" then
                            if SelectMaterial ~= "Fish Tail" then
                                if SelectMaterial ~= "Demonic Wisp" then
                                    if SelectMaterial ~= "Vampire Fang" then
                                        if SelectMaterial ~= "Conjured Cocoa" then
                                            if SelectMaterial ~= "Dragon Scale" then
                                                if SelectMaterial ~= "Gunpowder" then
                                                    if SelectMaterial == "Mini Tusk" then
                                                        MMon = "Mythological Pirate"
                                                        MPos = CFrame.new()
                                                        SP = "Default"
                                                    end
                                                else
                                                    MMon = "Pistol Billionaire"
                                                    MPos = CFrame.new(- 469, 74, 5904)
                                                    SP = "Default"
                                                end
                                            else
                                                MMon = "Dragon Crew Archer"
                                                MPos = CFrame.new(6827.91455078125, 609.4127197265625, 252.3538055419922)
                                                SP = "Default"
                                            end
                                        else
                                            MMon = "Chocolate Bar Battler"
                                            MPos = CFrame.new(620.6344604492188, 78.93644714355469, - 12581.369140625)
                                            SP = "Default"
                                        end
                                    else
                                        MMon = "Vampire"
                                        MPos = CFrame.new(- 6033, 7, - 1317)
                                        SP = "Default"
                                    end
                                else
                                    MMon = "Demonic Soul"
                                    MPos = CFrame.new(- 9507, 172, 6158)
                                    SP = "Default"
                                end
                            elseif Sea3 then
                                MMon = "Fishman Raider"
                                MPos = CFrame.new(- 10993, 332, - 8940)
                                SP = "Default"
                            elseif Sea1 then
                                MMon = "Fishman Warrior"
                                MPos = CFrame.new(61123, 19, 1569)
                                SP = "Default"
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)).Magnitude >= 17000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875))
                                end
                            end
                        elseif Sea1 then
                            MMon = "Brute"
                            MPos = CFrame.new(- 1145, 15, 4350)
                            SP = "Default"
                        elseif Sea2 then
                            MMon = "Swan Pirate"
                            MPos = CFrame.new(878, 122, 1235)
                            SP = "Default"
                        elseif Sea3 then
                            MMon = "Jungle Pirate"
                            MPos = CFrame.new(- 12107, 332, - 10549)
                            SP = "Default"
                        end
                    elseif Sea1 then
                        MMon = "Brute"
                        MPos = CFrame.new(- 1145, 15, 4350)
                        SP = "Default"
                    elseif Sea2 then
                        MMon = "Marine Captain"
                        MPos = CFrame.new(- 2010.5059814453125, 73.00115966796875, - 3326.620849609375)
                        SP = "Default"
                    elseif Sea3 then
                        MMon = "Jungle Pirate"
                        MPos = CFrame.new(- 11975.78515625, 331.7734069824219, - 10620.0302734375)
                        SP = "Default"
                    end
                else
                    MMon = "God\'s Guard"
                    MPos = CFrame.new(- 4698, 845, - 1912)
                    SP = "Default"
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 7859.09814, 5544.19043, - 381.476196)).Magnitude >= 5000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7859.09814, 5544.19043, - 381.476196))
                    end
                end
            elseif Sea1 then
                MMon = "Military Spy"
                MPos = CFrame.new(- 5815, 84, 8820)
                SP = "Default"
            elseif Sea2 then
                MMon = "Magma Ninja"
                MPos = CFrame.new(- 5428, 78, - 5959)
                SP = "Default"
            end
        else
            MMon = "Water Fighter"
            MPos = CFrame.new(- 3385, 239, - 10542)
            SP = "Default"
        end
    else
        MMon = "Factory Staff"
        MPos = CFrame.new(295, 73, - 56)
        SP = "Default"
    end
end
function UpdateIslandESP()
    local v8, v9, v10 = pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren())
    while true do
        local vu11
        v10, vu11 = v8(v9, v10)
        if v10 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu11
            if IslandESP then
                if vu11.Name ~= "Sea" then
                    if vu11:FindFirstChild("NameEsp") then
                        vu11.NameEsp.TextLabel.Text = vu11.Name .. "   \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - vu11.Position).Magnitude / 3) .. " Distance"
                    else
                        local v12 = Instance.new("BillboardGui", vu11)
                        v12.Name = "NameEsp"
                        v12.ExtentsOffset = Vector3.new(0, 1, 0)
                        v12.Size = UDim2.new(1, 200, 1, 30)
                        v12.Adornee = vu11
                        v12.AlwaysOnTop = true
                        local v13 = Instance.new("TextLabel", v12)
                        v13.Font = "GothamBold"
                        v13.FontSize = "Size14"
                        v13.TextWrapped = true
                        v13.Size = UDim2.new(1, 0, 1, 0)
                        v13.TextYAlignment = "Top"
                        v13.BackgroundTransparency = 1
                        v13.TextStrokeTransparency = 0.5
                        v13.TextColor3 = Color3.fromRGB(8, 0, 0)
                    end
                end
            elseif vu11:FindFirstChild("NameEsp") then
                vu11:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function isnil(p14)
    return p14 == nil
end
local function vu16(p15)
    return math.floor(tonumber(p15) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
	-- upvalues: (ref) vu16
    local v17, v18, v19 = pairs(game:GetService("Players"):GetChildren())
    while true do
        local vu20
        v19, vu20 = v17(v18, v19)
        if v19 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu20, (ref) vu16
            if not isnil(vu20.Character) then
                if ESPPlayer then
                    if isnil(vu20.Character.Head) or vu20.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        vu20.Character.Head["NameEsp" .. Number].TextLabel.Text = vu20.Name .. " | " .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu20.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. vu16(vu20.Character.Humanoid.Health * 100 / vu20.Character.Humanoid.MaxHealth) .. "%"
                    else
                        local v21 = Instance.new("BillboardGui", vu20.Character.Head)
                        v21.Name = "NameEsp" .. Number
                        v21.ExtentsOffset = Vector3.new(0, 1, 0)
                        v21.Size = UDim2.new(1, 200, 1, 30)
                        v21.Adornee = vu20.Character.Head
                        v21.AlwaysOnTop = true
                        local v22 = Instance.new("TextLabel", v21)
                        v22.Font = Enum.Font.GothamSemibold
                        v22.FontSize = "Size10"
                        v22.TextWrapped = true
                        v22.Text = vu20.Name .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu20.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v22.Size = UDim2.new(1, 0, 1, 0)
                        v22.TextYAlignment = "Top"
                        v22.BackgroundTransparency = 1
                        v22.TextStrokeTransparency = 0.5
                        if vu20.Team ~= game.Players.LocalPlayer.Team then
                            v22.TextColor3 = Color3.new(255, 0, 0)
                        else
                            v22.TextColor3 = Color3.new(0, 0, 254)
                        end
                    end
                elseif vu20.Character.Head:FindFirstChild("NameEsp" .. Number) then
                    vu20.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateChestChams()
	-- upvalues: (ref) vu16
    local v23, v24, v25 = pairs(game.Workspace:GetChildren())
    while true do
        local vu26
        v25, vu26 = v23(v24, v25)
        if v25 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu26, (ref) vu16
            if string.find(vu26.Name, "Chest") then
                if ChestESP then
                    if string.find(vu26.Name, "Chest") then
                        if vu26:FindFirstChild("NameEsp" .. Number) then
                            vu26["NameEsp" .. Number].TextLabel.Text = vu26.Name .. "   \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu26.Position).Magnitude / 3) .. " Distance"
                        else
                            local v27 = Instance.new("BillboardGui", vu26)
                            v27.Name = "NameEsp" .. Number
                            v27.ExtentsOffset = Vector3.new(0, 1, 0)
                            v27.Size = UDim2.new(1, 200, 1, 30)
                            v27.Adornee = vu26
                            v27.AlwaysOnTop = true
                            local v28 = Instance.new("TextLabel", v27)
                            v28.Font = Enum.Font.GothamSemibold
                            v28.FontSize = "Size14"
                            v28.TextWrapped = true
                            v28.Size = UDim2.new(1, 0, 1, 0)
                            v28.TextYAlignment = "Top"
                            v28.BackgroundTransparency = 1
                            v28.TextStrokeTransparency = 0.5
                            if vu26.Name == "Chest1" then
                                v28.TextColor3 = Color3.fromRGB(109, 109, 109)
                                v28.Text = "Chest 1" .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu26.Position).Magnitude / 3) .. " Distance"
                            end
                            if vu26.Name == "Chest2" then
                                v28.TextColor3 = Color3.fromRGB(173, 158, 21)
                                v28.Text = "Chest 2" .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu26.Position).Magnitude / 3) .. " Distance"
                            end
                            if vu26.Name == "Chest3" then
                                v28.TextColor3 = Color3.fromRGB(85, 255, 255)
                                v28.Text = "Chest 3" .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu26.Position).Magnitude / 3) .. " Distance"
                            end
                        end
                    end
                elseif vu26:FindFirstChild("NameEsp" .. Number) then
                    vu26:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateDevilChams()
	-- upvalues: (ref) vu16
    local v29, v30, v31 = pairs(game.Workspace:GetChildren())
    while true do
        local vu32
        v31, vu32 = v29(v30, v31)
        if v31 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu32, (ref) vu16
            if DevilFruitESP then
                if string.find(vu32.Name, "Fruit") then
                    if vu32.Handle:FindFirstChild("NameEsp" .. Number) then
                        vu32.Handle["NameEsp" .. Number].TextLabel.Text = vu32.Name .. "   \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu32.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v33 = Instance.new("BillboardGui", vu32.Handle)
                        v33.Name = "NameEsp" .. Number
                        v33.ExtentsOffset = Vector3.new(0, 1, 0)
                        v33.Size = UDim2.new(1, 200, 1, 30)
                        v33.Adornee = vu32.Handle
                        v33.AlwaysOnTop = true
                        local v34 = Instance.new("TextLabel", v33)
                        v34.Font = Enum.Font.GothamSemibold
                        v34.FontSize = "Size14"
                        v34.TextWrapped = true
                        v34.Size = UDim2.new(1, 0, 1, 0)
                        v34.TextYAlignment = "Top"
                        v34.BackgroundTransparency = 1
                        v34.TextStrokeTransparency = 0.5
                        v34.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v34.Text = vu32.Name .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu32.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            elseif vu32.Handle:FindFirstChild("NameEsp" .. Number) then
                vu32.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end)
    end
end
function UpdateFlowerChams()
	-- upvalues: (ref) vu16
    local v35, v36, v37 = pairs(game.Workspace:GetChildren())
    while true do
        local vu38
        v37, vu38 = v35(v36, v37)
        if v37 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu38, (ref) vu16
            if vu38.Name == "Flower2" or vu38.Name == "Flower1" then
                if FlowerESP then
                    if vu38:FindFirstChild("NameEsp" .. Number) then
                        vu38["NameEsp" .. Number].TextLabel.Text = vu38.Name .. "   \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu38.Position).Magnitude / 3) .. " Distance"
                    else
                        local v39 = Instance.new("BillboardGui", vu38)
                        v39.Name = "NameEsp" .. Number
                        v39.ExtentsOffset = Vector3.new(0, 1, 0)
                        v39.Size = UDim2.new(1, 200, 1, 30)
                        v39.Adornee = vu38
                        v39.AlwaysOnTop = true
                        local v40 = Instance.new("TextLabel", v39)
                        v40.Font = Enum.Font.GothamSemibold
                        v40.FontSize = "Size14"
                        v40.TextWrapped = true
                        v40.Size = UDim2.new(1, 0, 1, 0)
                        v40.TextYAlignment = "Top"
                        v40.BackgroundTransparency = 1
                        v40.TextStrokeTransparency = 0.5
                        v40.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if vu38.Name == "Flower1" then
                            v40.Text = "Blue Flower" .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu38.Position).Magnitude / 3) .. " Distance"
                            v40.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if vu38.Name == "Flower2" then
                            v40.Text = "Red Flower" .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu38.Position).Magnitude / 3) .. " Distance"
                            v40.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                elseif vu38:FindFirstChild("NameEsp" .. Number) then
                    vu38:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateRealFruitChams()
	-- upvalues: (ref) vu16
    local v41, v42, v43 = pairs(game.Workspace.AppleSpawner:GetChildren())
    while true do
        local v44
        v43, v44 = v41(v42, v43)
        if v43 == nil then
            break
        end
        if v44:IsA("Tool") then
            if RealFruitESP then
                if v44.Handle:FindFirstChild("NameEsp" .. Number) then
                    v44.Handle["NameEsp" .. Number].TextLabel.Text = v44.Name .. " " .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - v44.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v45 = Instance.new("BillboardGui", v44.Handle)
                    v45.Name = "NameEsp" .. Number
                    v45.ExtentsOffset = Vector3.new(0, 1, 0)
                    v45.Size = UDim2.new(1, 200, 1, 30)
                    v45.Adornee = v44.Handle
                    v45.AlwaysOnTop = true
                    local v46 = Instance.new("TextLabel", v45)
                    v46.Font = Enum.Font.GothamSemibold
                    v46.FontSize = "Size14"
                    v46.TextWrapped = true
                    v46.Size = UDim2.new(1, 0, 1, 0)
                    v46.TextYAlignment = "Top"
                    v46.BackgroundTransparency = 1
                    v46.TextStrokeTransparency = 0.5
                    v46.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v46.Text = v44.Name .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - v44.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v44.Handle:FindFirstChild("NameEsp" .. Number) then
                v44.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    local v47, v48, v49 = pairs(game.Workspace.PineappleSpawner:GetChildren())
    while true do
        local v50
        v49, v50 = v47(v48, v49)
        if v49 == nil then
            break
        end
        if v50:IsA("Tool") then
            if RealFruitESP then
                if v50.Handle:FindFirstChild("NameEsp" .. Number) then
                    v50.Handle["NameEsp" .. Number].TextLabel.Text = v50.Name .. " " .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v51 = Instance.new("BillboardGui", v50.Handle)
                    v51.Name = "NameEsp" .. Number
                    v51.ExtentsOffset = Vector3.new(0, 1, 0)
                    v51.Size = UDim2.new(1, 200, 1, 30)
                    v51.Adornee = v50.Handle
                    v51.AlwaysOnTop = true
                    local v52 = Instance.new("TextLabel", v51)
                    v52.Font = Enum.Font.GothamSemibold
                    v52.FontSize = "Size14"
                    v52.TextWrapped = true
                    v52.Size = UDim2.new(1, 0, 1, 0)
                    v52.TextYAlignment = "Top"
                    v52.BackgroundTransparency = 1
                    v52.TextStrokeTransparency = 0.5
                    v52.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v52.Text = v50.Name .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v50.Handle:FindFirstChild("NameEsp" .. Number) then
                v50.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    local v53, v54, v55 = pairs(game.Workspace.BananaSpawner:GetChildren())
    while true do
        local v56
        v55, v56 = v53(v54, v55)
        if v55 == nil then
            break
        end
        if v56:IsA("Tool") then
            if RealFruitESP then
                if v56.Handle:FindFirstChild("NameEsp" .. Number) then
                    v56.Handle["NameEsp" .. Number].TextLabel.Text = v56.Name .. " " .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - v56.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v57 = Instance.new("BillboardGui", v56.Handle)
                    v57.Name = "NameEsp" .. Number
                    v57.ExtentsOffset = Vector3.new(0, 1, 0)
                    v57.Size = UDim2.new(1, 200, 1, 30)
                    v57.Adornee = v56.Handle
                    v57.AlwaysOnTop = true
                    local v58 = Instance.new("TextLabel", v57)
                    v58.Font = Enum.Font.GothamSemibold
                    v58.FontSize = "Size14"
                    v58.TextWrapped = true
                    v58.Size = UDim2.new(1, 0, 1, 0)
                    v58.TextYAlignment = "Top"
                    v58.BackgroundTransparency = 1
                    v58.TextStrokeTransparency = 0.5
                    v58.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v58.Text = v56.Name .. " \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - v56.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v56.Handle:FindFirstChild("NameEsp" .. Number) then
                v56.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
function UpdateIslandESP()
	-- upvalues: (ref) vu16
    local v59, v60, v61 = pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren())
    while true do
        local vu62
        v61, vu62 = v59(v60, v61)
        if v61 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu62, (ref) vu16
            if IslandESP then
                if vu62.Name ~= "Sea" then
                    if vu62:FindFirstChild("NameEsp") then
                        vu62.NameEsp.TextLabel.Text = vu62.Name .. "   \n" .. vu16((game:GetService("Players").LocalPlayer.Character.Head.Position - vu62.Position).Magnitude / 3) .. " Distance"
                    else
                        local v63 = Instance.new("BillboardGui", vu62)
                        v63.Name = "NameEsp"
                        v63.ExtentsOffset = Vector3.new(0, 1, 0)
                        v63.Size = UDim2.new(1, 200, 1, 30)
                        v63.Adornee = vu62
                        v63.AlwaysOnTop = true
                        local v64 = Instance.new("TextLabel", v63)
                        v64.Font = "GothamBold"
                        v64.FontSize = "Size14"
                        v64.TextWrapped = true
                        v64.Size = UDim2.new(1, 0, 1, 0)
                        v64.TextYAlignment = "Top"
                        v64.BackgroundTransparency = 1
                        v64.TextStrokeTransparency = 0.5
                        v64.TextColor3 = Color3.fromRGB(7, 236, 240)
                    end
                end
            elseif vu62:FindFirstChild("NameEsp") then
                vu62:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function isnil(p65)
    return p65 == nil
end
local function vu67(p66)
    return math.floor(tonumber(p66) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
	-- upvalues: (ref) vu67
    local v68, v69, v70 = pairs(game:GetService("Players"):GetChildren())
    while true do
        local vu71
        v70, vu71 = v68(v69, v70)
        if v70 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu71, (ref) vu67
            if not isnil(vu71.Character) then
                if ESPPlayer then
                    if isnil(vu71.Character.Head) or vu71.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        vu71.Character.Head["NameEsp" .. Number].TextLabel.Text = vu71.Name .. " | " .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu71.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. vu67(vu71.Character.Humanoid.Health * 100 / vu71.Character.Humanoid.MaxHealth) .. "%"
                    else
                        local v72 = Instance.new("BillboardGui", vu71.Character.Head)
                        v72.Name = "NameEsp" .. Number
                        v72.ExtentsOffset = Vector3.new(0, 1, 0)
                        v72.Size = UDim2.new(1, 200, 1, 30)
                        v72.Adornee = vu71.Character.Head
                        v72.AlwaysOnTop = true
                        local v73 = Instance.new("TextLabel", v72)
                        v73.Font = Enum.Font.GothamSemibold
                        v73.FontSize = "Size14"
                        v73.TextWrapped = true
                        v73.Text = vu71.Name .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu71.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v73.Size = UDim2.new(1, 0, 1, 0)
                        v73.TextYAlignment = "Top"
                        v73.BackgroundTransparency = 1
                        v73.TextStrokeTransparency = 0.5
                        if vu71.Team ~= game.Players.LocalPlayer.Team then
                            v73.TextColor3 = Color3.new(255, 0, 0)
                        else
                            v73.TextColor3 = Color3.new(0, 255, 0)
                        end
                    end
                elseif vu71.Character.Head:FindFirstChild("NameEsp" .. Number) then
                    vu71.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateChestChams()
	-- upvalues: (ref) vu67
    local v74, v75, v76 = pairs(game.Workspace:GetChildren())
    while true do
        local vu77
        v76, vu77 = v74(v75, v76)
        if v76 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu77, (ref) vu67
            if string.find(vu77.Name, "Chest") then
                if ChestESP then
                    if string.find(vu77.Name, "Chest") then
                        if vu77:FindFirstChild("NameEsp" .. Number) then
                            vu77["NameEsp" .. Number].TextLabel.Text = vu77.Name .. "   \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu77.Position).Magnitude / 3) .. " Distance"
                        else
                            local v78 = Instance.new("BillboardGui", vu77)
                            v78.Name = "NameEsp" .. Number
                            v78.ExtentsOffset = Vector3.new(0, 1, 0)
                            v78.Size = UDim2.new(1, 200, 1, 30)
                            v78.Adornee = vu77
                            v78.AlwaysOnTop = true
                            local v79 = Instance.new("TextLabel", v78)
                            v79.Font = Enum.Font.GothamSemibold
                            v79.FontSize = "Size14"
                            v79.TextWrapped = true
                            v79.Size = UDim2.new(1, 0, 1, 0)
                            v79.TextYAlignment = "Top"
                            v79.BackgroundTransparency = 1
                            v79.TextStrokeTransparency = 0.5
                            if vu77.Name == "Chest1" then
                                v79.TextColor3 = Color3.fromRGB(109, 109, 109)
                                v79.Text = "Chest 1" .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu77.Position).Magnitude / 3) .. " Distance"
                            end
                            if vu77.Name == "Chest2" then
                                v79.TextColor3 = Color3.fromRGB(173, 158, 21)
                                v79.Text = "Chest 2" .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu77.Position).Magnitude / 3) .. " Distance"
                            end
                            if vu77.Name == "Chest3" then
                                v79.TextColor3 = Color3.fromRGB(85, 255, 255)
                                v79.Text = "Chest 3" .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu77.Position).Magnitude / 3) .. " Distance"
                            end
                        end
                    end
                elseif vu77:FindFirstChild("NameEsp" .. Number) then
                    vu77:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateDevilChams()
	-- upvalues: (ref) vu67
    local v80, v81, v82 = pairs(game.Workspace:GetChildren())
    while true do
        local vu83
        v82, vu83 = v80(v81, v82)
        if v82 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu83, (ref) vu67
            if DevilFruitESP then
                if string.find(vu83.Name, "Fruit") then
                    if vu83.Handle:FindFirstChild("NameEsp" .. Number) then
                        vu83.Handle["NameEsp" .. Number].TextLabel.Text = vu83.Name .. "   \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu83.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v84 = Instance.new("BillboardGui", vu83.Handle)
                        v84.Name = "NameEsp" .. Number
                        v84.ExtentsOffset = Vector3.new(0, 1, 0)
                        v84.Size = UDim2.new(1, 200, 1, 30)
                        v84.Adornee = vu83.Handle
                        v84.AlwaysOnTop = true
                        local v85 = Instance.new("TextLabel", v84)
                        v85.Font = Enum.Font.GothamSemibold
                        v85.FontSize = "Size14"
                        v85.TextWrapped = true
                        v85.Size = UDim2.new(1, 0, 1, 0)
                        v85.TextYAlignment = "Top"
                        v85.BackgroundTransparency = 1
                        v85.TextStrokeTransparency = 0.5
                        v85.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v85.Text = vu83.Name .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu83.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            elseif vu83.Handle:FindFirstChild("NameEsp" .. Number) then
                vu83.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end)
    end
end
function UpdateFlowerChams()
	-- upvalues: (ref) vu67
    local v86, v87, v88 = pairs(game.Workspace:GetChildren())
    while true do
        local vu89
        v88, vu89 = v86(v87, v88)
        if v88 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu89, (ref) vu67
            if vu89.Name == "Flower2" or vu89.Name == "Flower1" then
                if FlowerESP then
                    if vu89:FindFirstChild("NameEsp" .. Number) then
                        vu89["NameEsp" .. Number].TextLabel.Text = vu89.Name .. "   \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu89.Position).Magnitude / 3) .. " Distance"
                    else
                        local v90 = Instance.new("BillboardGui", vu89)
                        v90.Name = "NameEsp" .. Number
                        v90.ExtentsOffset = Vector3.new(0, 1, 0)
                        v90.Size = UDim2.new(1, 200, 1, 30)
                        v90.Adornee = vu89
                        v90.AlwaysOnTop = true
                        local v91 = Instance.new("TextLabel", v90)
                        v91.Font = Enum.Font.GothamSemibold
                        v91.FontSize = "Size14"
                        v91.TextWrapped = true
                        v91.Size = UDim2.new(1, 0, 1, 0)
                        v91.TextYAlignment = "Top"
                        v91.BackgroundTransparency = 1
                        v91.TextStrokeTransparency = 0.5
                        v91.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if vu89.Name == "Flower1" then
                            v91.Text = "Blue Flower" .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu89.Position).Magnitude / 3) .. " Distance"
                            v91.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if vu89.Name == "Flower2" then
                            v91.Text = "Red Flower" .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - vu89.Position).Magnitude / 3) .. " Distance"
                            v91.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                elseif vu89:FindFirstChild("NameEsp" .. Number) then
                    vu89:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateRealFruitChams()
	-- upvalues: (ref) vu67
    local v92, v93, v94 = pairs(game.Workspace.AppleSpawner:GetChildren())
    while true do
        local v95
        v94, v95 = v92(v93, v94)
        if v94 == nil then
            break
        end
        if v95:IsA("Tool") then
            if RealFruitESP then
                if v95.Handle:FindFirstChild("NameEsp" .. Number) then
                    v95.Handle["NameEsp" .. Number].TextLabel.Text = v95.Name .. " " .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - v95.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v96 = Instance.new("BillboardGui", v95.Handle)
                    v96.Name = "NameEsp" .. Number
                    v96.ExtentsOffset = Vector3.new(0, 1, 0)
                    v96.Size = UDim2.new(1, 200, 1, 30)
                    v96.Adornee = v95.Handle
                    v96.AlwaysOnTop = true
                    local v97 = Instance.new("TextLabel", v96)
                    v97.Font = Enum.Font.GothamSemibold
                    v97.FontSize = "Size14"
                    v97.TextWrapped = true
                    v97.Size = UDim2.new(1, 0, 1, 0)
                    v97.TextYAlignment = "Top"
                    v97.BackgroundTransparency = 1
                    v97.TextStrokeTransparency = 0.5
                    v97.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v97.Text = v95.Name .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - v95.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v95.Handle:FindFirstChild("NameEsp" .. Number) then
                v95.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    local v98, v99, v100 = pairs(game.Workspace.PineappleSpawner:GetChildren())
    while true do
        local v101
        v100, v101 = v98(v99, v100)
        if v100 == nil then
            break
        end
        if v101:IsA("Tool") then
            if RealFruitESP then
                if v101.Handle:FindFirstChild("NameEsp" .. Number) then
                    v101.Handle["NameEsp" .. Number].TextLabel.Text = v101.Name .. " " .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - v101.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v102 = Instance.new("BillboardGui", v101.Handle)
                    v102.Name = "NameEsp" .. Number
                    v102.ExtentsOffset = Vector3.new(0, 1, 0)
                    v102.Size = UDim2.new(1, 200, 1, 30)
                    v102.Adornee = v101.Handle
                    v102.AlwaysOnTop = true
                    local v103 = Instance.new("TextLabel", v102)
                    v103.Font = Enum.Font.GothamSemibold
                    v103.FontSize = "Size14"
                    v103.TextWrapped = true
                    v103.Size = UDim2.new(1, 0, 1, 0)
                    v103.TextYAlignment = "Top"
                    v103.BackgroundTransparency = 1
                    v103.TextStrokeTransparency = 0.5
                    v103.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v103.Text = v101.Name .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - v101.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v101.Handle:FindFirstChild("NameEsp" .. Number) then
                v101.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    local v104, v105, v106 = pairs(game.Workspace.BananaSpawner:GetChildren())
    while true do
        local v107
        v106, v107 = v104(v105, v106)
        if v106 == nil then
            break
        end
        if v107:IsA("Tool") then
            if RealFruitESP then
                if v107.Handle:FindFirstChild("NameEsp" .. Number) then
                    v107.Handle["NameEsp" .. Number].TextLabel.Text = v107.Name .. " " .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - v107.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v108 = Instance.new("BillboardGui", v107.Handle)
                    v108.Name = "NameEsp" .. Number
                    v108.ExtentsOffset = Vector3.new(0, 1, 0)
                    v108.Size = UDim2.new(1, 200, 1, 30)
                    v108.Adornee = v107.Handle
                    v108.AlwaysOnTop = true
                    local v109 = Instance.new("TextLabel", v108)
                    v109.Font = Enum.Font.GothamSemibold
                    v109.FontSize = "Size14"
                    v109.TextWrapped = true
                    v109.Size = UDim2.new(1, 0, 1, 0)
                    v109.TextYAlignment = "Top"
                    v109.BackgroundTransparency = 1
                    v109.TextStrokeTransparency = 0.5
                    v109.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v109.Text = v107.Name .. " \n" .. vu67((game:GetService("Players").LocalPlayer.Character.Head.Position - v107.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v107.Handle:FindFirstChild("NameEsp" .. Number) then
                v107.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
spawn(function()
    while wait() do
        pcall(function()
            if MobESP then
                local v110, v111, v112 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                while true do
                    local v113
                    v112, v113 = v110(v111, v112)
                    if v112 == nil then
                        break
                    end
                    if v113:FindFirstChild("HumanoidRootPart") then
                        if not v113:FindFirstChild("MobEap") then
                            local v114 = Instance.new("BillboardGui")
                            local v115 = Instance.new("TextLabel")
                            v114.Parent = v113
                            v114.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            v114.Active = true
                            v114.Name = "MobEap"
                            v114.AlwaysOnTop = true
                            v114.LightInfluence = 1
                            v114.Size = UDim2.new(0, 200, 0, 50)
                            v114.StudsOffset = Vector3.new(0, 2.5, 0)
                            v115.Parent = v114
                            v115.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v115.BackgroundTransparency = 1
                            v115.Size = UDim2.new(0, 200, 0, 50)
                            v115.Font = Enum.Font.GothamBold
                            v115.TextColor3 = Color3.fromRGB(7, 236, 240)
                            v115.Text.Size = 35
                        end
                        local v116 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v113.HumanoidRootPart.Position).Magnitude)
                        v113.MobEap.TextLabel.Text = v113.Name .. "-" .. v116 .. " Distance"
                    end
                end
            else
                local v117, v118, v119 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                while true do
                    local v120
                    v119, v120 = v117(v118, v119)
                    if v119 == nil then
                        break
                    end
                    if v120:FindFirstChild("MobEap") then
                        v120.MobEap:Destroy()
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if SeaESP then
                local v121, v122, v123 = pairs(game:GetService("Workspace").SeaBeasts:GetChildren())
                while true do
                    local v124
                    v123, v124 = v121(v122, v123)
                    if v123 == nil then
                        break
                    end
                    if v124:FindFirstChild("HumanoidRootPart") then
                        if not v124:FindFirstChild("Seaesps") then
                            local v125 = Instance.new("BillboardGui")
                            local v126 = Instance.new("TextLabel")
                            v125.Parent = v124
                            v125.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            v125.Active = true
                            v125.Name = "Seaesps"
                            v125.AlwaysOnTop = true
                            v125.LightInfluence = 1
                            v125.Size = UDim2.new(0, 200, 0, 50)
                            v125.StudsOffset = Vector3.new(0, 2.5, 0)
                            v126.Parent = v125
                            v126.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v126.BackgroundTransparency = 1
                            v126.Size = UDim2.new(0, 200, 0, 50)
                            v126.Font = Enum.Font.GothamBold
                            v126.TextColor3 = Color3.fromRGB(7, 236, 240)
                            v126.Text.Size = 35
                        end
                        local v127 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v124.HumanoidRootPart.Position).Magnitude)
                        v124.Seaesps.TextLabel.Text = v124.Name .. "-" .. v127 .. " Distance"
                    end
                end
            else
                local v128, v129, v130 = pairs(game:GetService("Workspace").SeaBeasts:GetChildren())
                while true do
                    local v131
                    v130, v131 = v128(v129, v130)
                    if v130 == nil then
                        break
                    end
                    if v131:FindFirstChild("Seaesps") then
                        v131.Seaesps:Destroy()
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if NpcESP then
                local v132, v133, v134 = pairs(game:GetService("Workspace").NPCs:GetChildren())
                while true do
                    local v135
                    v134, v135 = v132(v133, v134)
                    if v134 == nil then
                        break
                    end
                    if v135:FindFirstChild("HumanoidRootPart") then
                        if not v135:FindFirstChild("NpcEspes") then
                            local v136 = Instance.new("BillboardGui")
                            local v137 = Instance.new("TextLabel")
                            v136.Parent = v135
                            v136.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            v136.Active = true
                            v136.Name = "NpcEspes"
                            v136.AlwaysOnTop = true
                            v136.LightInfluence = 1
                            v136.Size = UDim2.new(0, 200, 0, 50)
                            v136.StudsOffset = Vector3.new(0, 2.5, 0)
                            v137.Parent = v136
                            v137.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v137.BackgroundTransparency = 1
                            v137.Size = UDim2.new(0, 200, 0, 50)
                            v137.Font = Enum.Font.GothamBold
                            v137.TextColor3 = Color3.fromRGB(7, 236, 240)
                            v137.Text.Size = 35
                        end
                        local v138 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v135.HumanoidRootPart.Position).Magnitude)
                        v135.NpcEspes.TextLabel.Text = v135.Name .. "-" .. v138 .. " Distance"
                    end
                end
            else
                local v139, v140, v141 = pairs(game:GetService("Workspace").NPCs:GetChildren())
                while true do
                    local v142
                    v141, v142 = v139(v140, v141)
                    if v141 == nil then
                        break
                    end
                    if v142:FindFirstChild("NpcEspes") then
                        v142.NpcEspes:Destroy()
                    end
                end
            end
        end)
    end
end)
function isnil(p143)
    return p143 == nil
end
local function vu145(p144)
    return math.floor(tonumber(p144) + 0.5)
end
Number = math.random(1, 1000000)
function UpdateIslandMirageESP()
	-- upvalues: (ref) vu145
    local v146, v147, v148 = pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren())
    while true do
        local vu149
        v148, vu149 = v146(v147, v148)
        if v148 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu149, (ref) vu145
            if MirageIslandESP then
                if vu149.Name == "Mirage Island" then
                    if vu149:FindFirstChild("NameEsp") then
                        vu149.NameEsp.TextLabel.Text = vu149.Name .. "   \n" .. vu145((game:GetService("Players").LocalPlayer.Character.Head.Position - vu149.Position).Magnitude / 3) .. " M"
                    else
                        local v150 = Instance.new("BillboardGui", vu149)
                        v150.Name = "NameEsp"
                        v150.ExtentsOffset = Vector3.new(0, 1, 0)
                        v150.Size = UDim2.new(1, 200, 1, 30)
                        v150.Adornee = vu149
                        v150.AlwaysOnTop = true
                        local v151 = Instance.new("TextLabel", v150)
                        v151.Font = "Code"
                        v151.FontSize = "Size14"
                        v151.TextWrapped = true
                        v151.Size = UDim2.new(1, 0, 1, 0)
                        v151.TextYAlignment = "Top"
                        v151.BackgroundTransparency = 1
                        v151.TextStrokeTransparency = 0.5
                        v151.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif vu149:FindFirstChild("NameEsp") then
                vu149:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function UpdateAuraESP()
	-- upvalues: (ref) vu145
    local v152, v153, v154 = pairs(game:GetService("Workspace").NPCs:GetChildren())
    while true do
        local vu155
        v154, vu155 = v152(v153, v154)
        if v154 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu155, (ref) vu145
            if AuraESP then
                if vu155.Name == "Master of Enhancement" then
                    if vu155:FindFirstChild("NameEsp") then
                        vu155.NameEsp.TextLabel.Text = vu155.Name .. "   \n" .. vu145((game:GetService("Players").LocalPlayer.Character.Head.Position - vu155.Position).Magnitude / 3) .. " M"
                    else
                        local v156 = Instance.new("BillboardGui", vu155)
                        v156.Name = "NameEsp"
                        v156.ExtentsOffset = Vector3.new(0, 1, 0)
                        v156.Size = UDim2.new(1, 200, 1, 30)
                        v156.Adornee = vu155
                        v156.AlwaysOnTop = true
                        local v157 = Instance.new("TextLabel", v156)
                        v157.Font = "Code"
                        v157.FontSize = "Size14"
                        v157.TextWrapped = true
                        v157.Size = UDim2.new(1, 0, 1, 0)
                        v157.TextYAlignment = "Top"
                        v157.BackgroundTransparency = 1
                        v157.TextStrokeTransparency = 0.5
                        v157.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif vu155:FindFirstChild("NameEsp") then
                vu155:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function UpdateLSDESP()
	-- upvalues: (ref) vu145
    local v158, v159, v160 = pairs(game:GetService("Workspace").NPCs:GetChildren())
    while true do
        local vu161
        v160, vu161 = v158(v159, v160)
        if v160 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu161, (ref) vu145
            if LADESP then
                if vu161.Name == "Legendary Sword Dealer" then
                    if vu161:FindFirstChild("NameEsp") then
                        vu161.NameEsp.TextLabel.Text = vu161.Name .. "   \n" .. vu145((game:GetService("Players").LocalPlayer.Character.Head.Position - vu161.Position).Magnitude / 3) .. " M"
                    else
                        local v162 = Instance.new("BillboardGui", vu161)
                        v162.Name = "NameEsp"
                        v162.ExtentsOffset = Vector3.new(0, 1, 0)
                        v162.Size = UDim2.new(1, 200, 1, 30)
                        v162.Adornee = vu161
                        v162.AlwaysOnTop = true
                        local v163 = Instance.new("TextLabel", v162)
                        v163.Font = "Code"
                        v163.FontSize = "Size14"
                        v163.TextWrapped = true
                        v163.Size = UDim2.new(1, 0, 1, 0)
                        v163.TextYAlignment = "Top"
                        v163.BackgroundTransparency = 1
                        v163.TextStrokeTransparency = 0.5
                        v163.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif vu161:FindFirstChild("NameEsp") then
                vu161:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function UpdateGeaESP()
	-- upvalues: (ref) vu145
    local v164, v165, v166 = pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren())
    while true do
        local vu167
        v166, vu167 = v164(v165, v166)
        if v166 == nil then
            break
        end
        pcall(function()
			-- upvalues: (ref) vu167, (ref) vu145
            if GearESP then
                if vu167.Name == "MeshPart" then
                    if vu167:FindFirstChild("NameEsp") then
                        vu167.NameEsp.TextLabel.Text = vu167.Name .. "   \n" .. vu145((game:GetService("Players").LocalPlayer.Character.Head.Position - vu167.Position).Magnitude / 3) .. " M"
                    else
                        local v168 = Instance.new("BillboardGui", vu167)
                        v168.Name = "NameEsp"
                        v168.ExtentsOffset = Vector3.new(0, 1, 0)
                        v168.Size = UDim2.new(1, 200, 1, 30)
                        v168.Adornee = vu167
                        v168.AlwaysOnTop = true
                        local v169 = Instance.new("TextLabel", v168)
                        v169.Font = "Code"
                        v169.FontSize = "Size14"
                        v169.TextWrapped = true
                        v169.Size = UDim2.new(1, 0, 1, 0)
                        v169.TextYAlignment = "Top"
                        v169.BackgroundTransparency = 1
                        v169.TextStrokeTransparency = 0.5
                        v169.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif vu167:FindFirstChild("NameEsp") then
                vu167:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function Tween2(p170)
    local v171 = (p170.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local v172 = 350
    local v173 = TweenInfo.new(v171 / v172, Enum.EasingStyle.Linear)
    local v174 = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, v173, {
        ["CFrame"] = p170
    })
    v174:Play()
    if _G.StopTween2 then
        v174:Cancel()
    end
    _G.Clip2 = true
    wait(v171 / v172)
    _G.Clip2 = false
end
function BKP(p175)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p175
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p175
end
TweenSpeed = 600
-- Tốc độ tối đa server Blox Fruits chấp nhận (studs/giây)
-- Nếu vượt quá, server giật player về vị trí cũ
local SERVER_MAX_SPEED = 120  -- studs/giây, an toàn cho server
local STEP_SIZE = 60          -- studs mỗi bước (120 studs/s × 0.5s wait)
local STEP_WAIT = 0.5         -- giây chờ giữa mỗi bước

-- SafeMove: di chuyển từng bước nhỏ để server không reject
-- Mỗi bước ~60 studs, chờ 0.5s để server sync trước khi bước tiếp
local function SafeMove(targetCF, checkStop)
    local player = game.Players.LocalPlayer
    if not player.Character then return end
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local targetPos = targetCF.Position
    while true do
        if checkStop and checkStop() then break end
        local curPos = hrp.Position
        local remaining = (targetPos - curPos).Magnitude
        if remaining < 8 then break end

        -- Tính điểm đến của bước này
        local dir = (targetPos - curPos).Unit
        local stepDist = math.min(remaining, STEP_SIZE)
        local nextPos = curPos + dir * stepDist

        -- Giữ nguyên rotation của CFrame đích, chỉ thay position
        local nextCF
        if remaining <= STEP_SIZE then
            nextCF = targetCF  -- bước cuối giữ đúng CFrame
        else
            nextCF = CFrame.new(nextPos)
        end

        -- Set CFrame (server sync qua physics)
        pcall(function()
            hrp.CFrame = nextCF
        end)
        -- Chờ để server nhận và xác nhận vị trí mới
        task.wait(STEP_WAIT)
    end
end

-- Tween không blocking: dùng SafeMove trong coroutine riêng
-- Khi đích thay đổi, hủy coroutine cũ
local _tweenThread = nil

function Tween(p176)
    if not p176 then return end
    -- Hủy coroutine tween cũ nếu có
    if _tweenThread then
        pcall(function() task.cancel(_tweenThread) end)
        _tweenThread = nil
    end
    _tweenThread = task.spawn(function()
        SafeMove(p176, function()
            return _tweenThread == nil
        end)
        _tweenThread = nil
    end)
end

-- TweenBlock: blocking SafeMove, chờ đến nơi rồi mới return
function TweenBlock(targetCF)
    if not targetCF then return end
    -- Hủy tween đang chạy
    if _tweenThread then
        pcall(function() task.cancel(_tweenThread) end)
        _tweenThread = nil
    end
    _G.Clip2 = true
    pcall(function()
        SafeMove(targetCF, function()
            return _G.StopTween
        end)
    end)
    _G.Clip2 = false
end
function EquipTool(p181)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(p181) then
        local v182 = game.Players.LocalPlayer.Backpack:FindFirstChild(p181)
        wait()
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v182)
    end
end
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.AutoEvoRace or (_G.CastleRaid or (_G.CollectAzure or (_G.TweenToKitsune or (_G.GhostShip or (_G.Ship or (_G.Auto_Holy_Torch or (_G.TeleportPly or (_G.Auto_Sea3 or (_G.Auto_Sea2 or (_G.Tweenfruit or (_G.AutoFishCrew or (_G.Auto_Saber or (_G.AutoShark or (_G.Auto_Warden or (_G.Auto_RainbowHaki or (AutoFarmRace or (_G.AutoQuestRace or (Auto_Law or (AutoTushita or (_G.AutoHolyTorch or (_G.AutoTerrorshark or (_G.farmpiranya or (_G.Auto_MusketeerHat or (_G.Auto_ObservationV2 or (_G.AutoNear or (_G.Auto_PoleV1 or (_G.Auto_Buddy or (_G.Ectoplasm or (AutoEvoRace or (AutoBartilo or (_G.Auto_Canvander or (_G.AutoLevel or (_G.Auto_DualKatana or (Auto_Quest_Yama_3 or (Auto_Quest_Yama_2 or (Auto_Quest_Yama_1 or (Auto_Quest_Tushita_1 or (Auto_Quest_Tushita_2 or (Auto_Quest_Tushita_3 or (_G.Clip2 or (_G.Auto_Regoku or (_G.AutoBone or (_G.AutoBoneNoQuest or (_G.AutoBoss or (AutoFarmMasDevilFruit or (AutoFarmMasGun or (AutoHallowSycthe or (AutoTushita or (_G.Cake or (_G.Auto_SkullGuitar or (_G.AutoFarmSwan or (_G.AutoEliteor or (AutoNextIsland or (Musketeer or (_G.AutoMaterial or (AutoFarmRaceQuest or (_G.Factory or (_G.Auto_Saw or (_G.AutoFrozenDimension or (_G.AutoKillTrial or (_G.AutoUpgrade or _G.TweenToFrozenDimension))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) then
                if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local v183 = Instance.new("BodyVelocity")
                    v183.Name = "BodyClip"
                    v183.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                    v183.MaxForce = Vector3.new(100000, 100000, 100000)
                    v183.Velocity = Vector3.new(0, 0, 0)
                end
            else
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
            end
        end)
    end
end)
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.AutoEvoRace or (_G.Auto_RainbowHaki or (_G.Auto_SkullGuitar or (_G.CastleRaid or (_G.CollectAzure or (_G.TweenToKitsune or (_G.Auto_Sea3 or (_G.Auto_Sea2 or (_G.GhostShip or (_G.Ship or (_G.Auto_Holy_Torch or (_G.TeleportPly or (_G.Tweenfruit or (_G.Auto_Saber or (_G.Auto_PoleV1 or (_G.Auto_MusketeerHat or (_G.AutoFishCrew or (_G.AutoShark or (AutoFarmRace or (_G.AutoQuestRace or (_G.Auto_Warden or (Auto_Law or (_G.Auto_DualKatana or (Auto_Quest_Tushita_1 or (Auto_Quest_Tushita_2 or (Auto_Quest_Tushita_3 or (AutoTushita or (_G.AutoHolyTorch or (_G.Auto_Buddy or (_G.AutoTerrorshark or (_G.farmpiranya or (Auto_Quest_Yama_3 or (_G.Auto_ObservationV2 or (Auto_Quest_Yama_2 or (Auto_Quest_Yama_1 or (_G.AutoNear or (_G.Ectoplasm or (AutoEvoRace or (_G.AutoKillTrial or (AutoBartilo or (AutoFarmMasGun or (_G.Auto_Regoku or (_G.AutoLevel or (_G.Clip2 or (_G.AutoBone or (_G.Auto_Canvander or (_G.AutoBoneNoQuest or (_G.AutoBoss or (_G.Auto_Saw or (AutoFarmMasDevilFruit or (AutoHallowSycthe or (AutoTushita or (_G.Cake or (_G.AutoFarmSwan or (_G.AutoEliteor or (AutoNextIsland or (Musketeer or (_G.AutoMaterial or (_G.Factory or (_G.AutoFrozenDimension or (AutoFarmRaceQuest or (_G.AutoUpgrade or _G.TweenToFrozenDimension))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) then
                local v184, v185, v186 = pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants())
                while true do
                    local v187
                    v186, v187 = v184(v185, v186)
                    if v186 == nil then
                        break
                    end
                    if v187:IsA("BasePart") then
                        v187.CanCollide = false
                    end
                end
            end
        end)
    end)
end)
task.spawn(function()
    if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
        game.Players.LocalPlayer.Character.Stun.Changed:connect(function()
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
                    game.Players.LocalPlayer.Character.Stun.Value = 0
                end
            end)
        end)
    end
end)
function CheckMaterial(p188)
    local v189, v190, v191 = pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory"))
    while true do
        local v192
        v191, v192 = v189(v190, v191)
        if v191 == nil then
            break
        end
        if type(v192) == "table" and (v192.Type == "Material" and v192.Name == p188) then
            return v192.Count
        end
    end
    return 0
end
function GetWeaponInventory(p193)
    local v194, v195, v196 = pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory"))
    while true do
        local v197
        v196, v197 = v194(v195, v196)
        if v196 == nil then
            break
        end
        if type(v197) == "table" and (v197.Type == "Sword" and v197.Name == p193) then
            return true
        end
    end
    return false
end
local vu198 = game.Players.LocalPlayer
function AttackNoCoolDown()
	-- upvalues: (ref) vu198
    local vu199 = vu198.Character
    if not vu199 then
        return
    end
    local v200, v201, v202 = ipairs(vu199:GetChildren())
    local v203 = nil
    while true do
        local vu204
        v202, vu204 = v200(v201, v202)
        if v202 == nil then
            vu204 = v203
            break
        end
        if vu204:IsA("Tool") then
            break
        end
    end
    if vu204 then
        local function vu207(p205)
            local v206 = p205 and p205:FindFirstChild("Humanoid")
            if v206 then
                v206 = p205.Humanoid.Health > 0
            end
            return v206
        end
        local function v217(p208)
			-- upvalues: (ref) vu199, (ref) vu207
            local v209 = game:GetService("Workspace").Enemies:GetChildren()
            local v210 = vu199:GetPivot().Position
            local v211, v212, v213 = ipairs(v209)
            local v214 = {}
            while true do
                local v215
                v213, v215 = v211(v212, v213)
                if v213 == nil then
                    break
                end
                local v216 = v215:FindFirstChild("HumanoidRootPart")
                if v216 and (vu207(v215) and (v216.Position - v210).Magnitude <= p208) then
                    table.insert(v214, v215)
                end
            end
            return v214
        end
        if vu204:FindFirstChild("LeftClickRemote") then
            local v218 = v217(60)
            local v219, v220, v221 = ipairs(v218)
            local vu222 = 1
            while true do
                local v223
                v221, v223 = v219(v220, v221)
                if v221 == nil then
                    break
                end
                local vu224 = (v223.HumanoidRootPart.Position - vu199:GetPivot().Position).Unit
                pcall(function()
					-- upvalues: (ref) vu204, (ref) vu224, (ref) vu222
                    vu204.LeftClickRemote:FireServer(vu224, vu222)
                end)
                local v225 = vu222 + 1
                vu222 = v225 > 1000000000 and 1 or v225
            end
        else
            local v226 = game:GetService("Workspace").Enemies:GetChildren()
            local v227 = vu199:GetPivot().Position
            local v228, v229, v230 = ipairs(v226)
            local v231 = vu207
            local vu232 = {}
            local vu233 = nil
            while true do
                local v234, v235 = v228(v229, v230)
                if v234 == nil then
                    break
                end
                v230 = v234
                if not v235:GetAttribute("IsBoat") and v231(v235) then
                    local v236 = v235:FindFirstChild("Head")
                    if v236 and (v227 - v236.Position).Magnitude <= 60 then
                        table.insert(vu232, {
                            v235,
                            v236
                        })
                        vu233 = v236
                    end
                end
            end
            if not vu233 then
                return
            end
            pcall(function()
				-- upvalues: (ref) vu232, (ref) vu233
                local v237 = game:GetService("ReplicatedStorage")
                local v238 = v237:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
                local v239 = v237:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
                if # vu232 <= 0 then
                    task.wait(1e-9)
                else
                    v238:FireServer(1e-9)
                    v239:FireServer(vu233, vu232)
                end
            end)
        end
    end
end
Type = 1
spawn(function()
    while wait() do
        if Type == 1 then
            Pos = CFrame.new(0, 30, 0)
        end
    end
end)
spawn(function()
    while wait() do
        Type = 1
    end
end)
function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end
function to(p240)
    repeat
        wait(_G.Fast_Delay)
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p240
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p240
    until (p240.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000
end
function to(pu241)
    pcall(function()
		-- upvalues: (ref) pu241
        if (pu241.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 and (not Auto_Raid and game.Players.LocalPlayer.Character.Humanoid.Health > 0) then
            if NameMon ~= "FishmanQuest" then
                if Mon ~= "God\'s Guard" then
                    if NameMon ~= "SkyExp1Quest" then
                        if NameMon ~= "ShipQuest1" then
                            if NameMon ~= "ShipQuest2" then
                                if NameMon ~= "FrostQuest" then
                                    repeat
                                        wait(_G.Fast_Delay)
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pu241
                                        wait(0.05)
                                        game.Players.LocalPlayer.Character.Head:Destroy()
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pu241
                                    until (pu241.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0
                                    wait()
                                else
                                    Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                                    wait()
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 6508.5581054688, 89.034996032715, - 132.83953857422))
                                end
                            else
                                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                                wait()
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                            end
                        else
                            Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                            wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                        end
                    else
                        Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                        wait()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047))
                    end
                else
                    Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                    wait()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688))
                end
            else
                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                wait()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        end
    end)
end
task.defer(function()
    if game:GetService("ReplicatedStorage"):FindFirstChild("Effect") and (game:GetService("ReplicatedStorage").Effect:FindFirstChild("Container") and game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Death")) then
        local v250 = require(game:GetService("ReplicatedStorage").Effect.Container.Death)
        local v251 = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
        if v251 then
            v251:Stop()
        end
        if hookfunction then
            hookfunction(v250, function(...)
                return ...
            end)
        end
    end
end)
Tabs.Info:AddSection("Thông Tin")
Tabs.Info:AddButton({
    ["Title"] = "HDanh Community",
    ["Description"] = "Discord",
    ["Callback"] = function()
        setclipboard(tostring("https://dsc.gg/nopermc"))
    end
})
Tabs.Info:AddButton({
    ["Title"] = "HDanh Hub",
    ["Description"] = "Youtube",
    ["Callback"] = function()
        setclipboard(tostring("https://youtube.com/@nopermc"))
    end
})
Tabs.Info:AddButton({
    ["Title"] = "HDanh Hub",
    ["Description"] = "Tiktok",
    ["Callback"] = function()
        setclipboard(tostring("www.tiktok.com/@uytins1vn._"))
    end
})
Tabs.Info:AddParagraph({
    ["Title"] = "Phát triển Monster",
    ["Description"] = "Kỹ Năng: Del có"
})
local v252 = nil
if identifyexecutor then
    v252 = identifyexecutor()
elseif getexecutorname then
    v252 = getexecutorname()
end
if v252 then
    Tabs.Info:AddParagraph({
        ["Title"] = "Client Đang Dùng",
        ["Description"] = v252
    })
end
Tabs.Info:AddParagraph({
    ["Title"] = "Cấp Nhắt",
    ["Description"] = "Tôi sẽ Cấp nhắt nhiều tính năng hơn trong tương lai"
})
Tabs.Info:AddParagraph({
    ["Title"] = "Các Client Android và Ios Hợ Trỡ",
    ["Description"] = "Tất Cả Client Android và Ios "
})
Tabs.Info:AddParagraph({
    ["Title"] = "Các Client Pc Hợ Trỡ",
    ["Description"] = "Tất Cả Client Pc"
})
_G.FastAttackStrix_Mode = "Super Fast Attack"
spawn(function()
    while wait() do
        if _G.FastAttackStrix_Mode then
            pcall(function()
                if _G.FastAttackStrix_Mode == "Super Fast Attack" then
                    _G.Fast_Delay = 1e-9
                end
            end)
        end
    end
end)
Tabs.Main:AddSection("Cày Cấp")
local v253 = Tabs.Main:AddDropdown("DropdownSelectWeapon", {
    ["Title"] = "Vũ Khí",
    ["Values"] = {
        "Melee",
        "Sword",
        "Blox Fruit"
    },
    ["Multi"] = false,
    ["Default"] = 1
})
v253:SetValue("Melee")
ChooseWeapon = "Melee" -- khởi tạo ngay, không chờ callback
v253:OnChanged(function(p254)
    ChooseWeapon = p254
end)
task.spawn(function()
    while wait() do
        pcall(function()
            -- Tìm trong Backpack VÀ Character (tool đang cầm nằm trong Character)
            local sources = {game.Players.LocalPlayer.Backpack}
            if game.Players.LocalPlayer.Character then
                table.insert(sources, game.Players.LocalPlayer.Character)
            end
            for _, src in pairs(sources) do
                for _, t in pairs(src:GetChildren()) do
                    if t:IsA("Tool") then
                        if ChooseWeapon == "Blox Fruit" and t.ToolTip == "Blox Fruit" then
                            SelectWeapon = t.Name
                        elseif ChooseWeapon == "Sword" and t.ToolTip == "Sword" then
                            SelectWeapon = t.Name
                        elseif ChooseWeapon == "Melee" and t.ToolTip == "Melee" then
                            SelectWeapon = t.Name
                        end
                    end
                end
            end
        end)
    end
end)
Tabs.Main:AddToggle("ToggleLevel", {
    ["Title"] = "Cày Cấp",
    ["Default"] = false
}):OnChanged(function(p267)
    _G.AutoLevel = p267
    if p267 == true then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "✅ Auto Farm Level";
            Text = "Đã bật! Bot sẽ tự động farm level";
            Duration = 3;
        })
    else
        wait()
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ Auto Farm Level";
            Text = "Đã tắt!";
            Duration = 2;
        })
    end
end)
-- [SetValue skipped - Library không cần]
spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                CheckLevel()

                if not Ms or not NameMon or not NameQuest or not QuestLv or not CFrameQ or not CFrameMon then
                    return
                end

                local questVisible = false
                local QuestTitle = ""
                pcall(function()
                    questVisible = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                    if questVisible then
                        QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    end
                end)

                -- Nếu đang có quest KHÁC thì bỏ quest
                if questVisible and QuestTitle ~= "" and not string.find(QuestTitle, NameMon) then
                    bringmob = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    return
                end

                -- Chưa có quest → bay tới NPC nhận quest bằng Tween2 (giống di chuyển đảo)
                if not questVisible then
                    bringmob = false
                    Tween2(CFrameQ)
                    repeat task.wait(0.1) until (CFrameQ.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.AutoLevel
                    wait(0.2)
                    if (CFrameQ.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                        wait(0.3)
                    end
                    return
                end

                -- Đã có quest đúng → farm (dùng BKP để đứng cạnh quái, giống island travel)
                if questVisible and string.find(QuestTitle, NameMon) then
                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                        for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == Ms then
                                -- Bật hiệu ứng tia lửa + tiếng spam liên tục
                                if not _fxEnabled then _fxEnabled = true; StartFXLoop() end
                                repeat
                                    task.wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    bringmob = true
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    -- Dùng BKP teleport trực tiếp cạnh quái (giống các tính năng khác)
                                    local _mobCF = v.HumanoidRootPart.CFrame * Pos
                                    if (_mobCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then
                                        BKP(_mobCF)
                                    end
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    pcall(function() v.Head.CanCollide = false end)
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                    local qv = false
                                    pcall(function() qv = game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible end)
                                until not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0 or not qv
                                bringmob = false
                                if not _G.OneHitKill and not _G.AutoBone and not _G.AutoBoneNoQuest and not _G.AutoNear then StopFXLoop() end
                            end
                        end
                    else
                        bringmob = false
                        -- Bay đến vị trí quái spawn bằng Tween2 (giống di chuyển đảo)
                        Tween2(CFrameMon)
                    end
                end
            end)
        end
    end
end)
Tabs.Main:AddSection("Chiến Đấu")
Tabs.Main:AddToggle("ToggleOneHit", {
    ["Title"] = "Đánh Nhanh",
    ["Default"] = false
}):OnChanged(function(v)
    _G.OneHitKill = v
    getgenv().AutoClick = v
end)
-- AutoClick: dùng Button1Down/Up vào giữa viewport game - KHÔNG click vào UI
getgenv().AutoClick = false
getgenv().ClicksPerSecond = 20
local _vu = game:GetService("VirtualUser")
task.spawn(function()
    while task.wait(1 / getgenv().ClicksPerSecond) do
        if getgenv().AutoClick then
            pcall(function()
                local cam = workspace.CurrentCamera
                local vp = cam.ViewportSize
                local center = Vector2.new(vp.X / 2, vp.Y / 2)
                _vu:Button1Down(center, cam.CFrame)
                task.wait(0.02)
                _vu:Button1Up(center, cam.CFrame)
            end)
        end
    end
end)
-- ============================================================
-- HỆ THỐNG HIỆU ỨNG ĐÁNH: Tia lửa đóm đóm CỰC NHIỀU phủ toàn thân quái
-- ============================================================
local _fxThread = nil      -- coroutine vòng lặp hiệu ứng
local _fxEnabled = false   -- bật/tắt hiệu ứng

-- Danh sách sound IDs tiếng đánh (ngắn, mạnh, đa dạng)
local _hitSounds = {
    "rbxassetid://5221806718",
    "rbxassetid://5221806728",
    "rbxassetid://5221806736",
    "rbxassetid://341336274",
    "rbxassetid://5221806751",
}

-- Tạo 1 emitter node tại vị trí offset, emit đóm và tự xóa
local function _spawnNode(basePos, offsetX, offsetY, offsetZ, count)
    pcall(function()
        local fx = Instance.new("Part")
        fx.Anchored = true
        fx.CanCollide = false
        fx.CastShadow = false
        fx.Size = Vector3.new(0.1, 0.1, 0.1)
        fx.Transparency = 1
        fx.Position = basePos + Vector3.new(offsetX, offsetY, offsetZ)
        fx.Parent = workspace

        -- Sparkles lấp lánh trắng
        local sp = Instance.new("Sparkles")
        sp.SparkleColor = Color3.fromRGB(255, 255, 255)
        sp.Enabled = true
        sp.Parent = fx

        -- Particle đóm lửa chính
        local pe = Instance.new("ParticleEmitter")
        pe.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 240, 120)),
            ColorSequenceKeypoint.new(0.55,Color3.fromRGB(255, 140, 0)),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(220, 30, 0)),
        })
        pe.LightEmission  = 1
        pe.LightInfluence = 0
        pe.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0,   0.55),
            NumberSequenceKeypoint.new(0.4, 0.35),
            NumberSequenceKeypoint.new(1,   0),
        })
        pe.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,   0),
            NumberSequenceKeypoint.new(0.6, 0.3),
            NumberSequenceKeypoint.new(1,   1),
        })
        pe.Speed        = NumberRange.new(6, 18)
        pe.SpreadAngle  = Vector2.new(180, 180)
        pe.Rate         = 0
        pe.Lifetime     = NumberRange.new(0.25, 0.65)
        pe.RotSpeed     = NumberRange.new(-400, 400)
        pe.Rotation     = NumberRange.new(0, 360)
        pe.Parent = fx
        pe:Emit(count)

        game:GetService("Debris"):AddItem(fx, 0.7)
    end)
end

-- Spawn đóm CỰC NHIỀU: lưới điểm bao phủ toàn bộ bounding box quái + lan ra ngoài
local function SpawnSparkFX(mob)
    pcall(function()
        if not mob or not mob.Parent then return end
        -- Tính bounding box tất cả BasePart của quái
        local parts = {}
        for _, p in pairs(mob:GetDescendants()) do
            if p:IsA("BasePart") then table.insert(parts, p) end
        end
        if #parts == 0 then
            -- fallback: dùng HumanoidRootPart
            local hrp = mob:FindFirstChild("HumanoidRootPart")
            if hrp then table.insert(parts, hrp) end
        end

        local minX, minY, minZ =  math.huge,  math.huge,  math.huge
        local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge
        for _, p in pairs(parts) do
            local pos = p.Position
            local hs  = p.Size * 0.5
            minX = math.min(minX, pos.X - hs.X)
            minY = math.min(minY, pos.Y - hs.Y)
            minZ = math.min(minZ, pos.Z - hs.Z)
            maxX = math.max(maxX, pos.X + hs.X)
            maxY = math.max(maxY, pos.Y + hs.Y)
            maxZ = math.max(maxZ, pos.Z + hs.Z)
        end

        -- Lan ra 2 studs bên ngoài bounding box
        local pad = 2
        minX = minX - pad; minY = minY - pad; minZ = minZ - pad
        maxX = maxX + pad; maxY = maxY + pad; maxZ = maxZ + pad

        local cx = (minX + maxX) * 0.5
        local cy = (minY + maxY) * 0.5
        local cz = (minZ + maxZ) * 0.5
        local base = Vector3.new(cx, cy, cz)

        local rx = (maxX - minX) * 0.5
        local ry = (maxY - minY) * 0.5
        local rz = (maxZ - minZ) * 0.5

        -- Grid 4x5x4 = 80 node, mỗi node emit 8-14 đóm → ~640-1120 đóm/lần gọi
        local stepsX, stepsY, stepsZ = 4, 5, 4
        for ix = 0, stepsX - 1 do
            for iy = 0, stepsY - 1 do
                for iz = 0, stepsZ - 1 do
                    local ox = -rx + (2 * rx / (stepsX - 1)) * ix
                    local oy = -ry + (2 * ry / (stepsY - 1)) * iy
                    local oz = -rz + (2 * rz / (stepsZ - 1)) * iz
                    -- jitter nhỏ để trông tự nhiên
                    ox = ox + (math.random() - 0.5) * 0.8
                    oy = oy + (math.random() - 0.5) * 0.8
                    oz = oz + (math.random() - 0.5) * 0.8
                    _spawnNode(base, ox, oy, oz, math.random(8, 14))
                end
            end
        end
    end)
end

-- Phát tiếng đánh ngẫu nhiên tại vị trí
local function PlayHitSound(pos)
    pcall(function()
        local sid = _hitSounds[math.random(1, #_hitSounds)]
        local snd = Instance.new("Sound")
        snd.SoundId = sid
        snd.Volume = 0.9
        snd.RollOffMaxDistance = 60
        local p = Instance.new("Part")
        p.Anchored = true; p.CanCollide = false
        p.Transparency = 1; p.Size = Vector3.new(0.1,0.1,0.1)
        p.Position = pos; p.Parent = workspace
        snd.Parent = p
        snd:Play()
        game:GetService("Debris"):AddItem(p, 1.5)
    end)
end

-- Giữ tên cũ để code bên dưới dùng được
local function ApplyHitEffect(mob)
    SpawnSparkFX(mob)
end

-- Vòng lặp hiệu ứng chính: spam đóm + tiếng mỗi 0.06s (~17 lần/giây)
local function StartFXLoop()
    if _fxThread then pcall(function() task.cancel(_fxThread) end) end
    _fxThread = task.spawn(function()
        while _fxEnabled do
            pcall(function()
                if MonFarm and MonFarm ~= "" then
                    for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if mob.Name == MonFarm
                            and mob:FindFirstChild("HumanoidRootPart")
                            and mob:FindFirstChild("Humanoid")
                            and mob.Humanoid.Health > 0 then
                            local pos = mob.HumanoidRootPart.Position
                            SpawnSparkFX(mob)
                            PlayHitSound(pos)
                            break
                        end
                    end
                end
            end)
            task.wait(0.06)
        end
        _fxThread = nil
    end)
end

local function StopFXLoop()
    _fxEnabled = false
    if _fxThread then
        pcall(function() task.cancel(_fxThread) end)
        _fxThread = nil
    end
end

-- ============================================================
-- ĐÁNH NHANH: HP quái còn 25%, tự động kích hoạt hiệu ứng
-- ============================================================
local _oneHitConns = {}

spawn(function()
    while wait(0.1) do
        if _G.OneHitKill then
            -- Bật FX loop khi đánh nhanh đang on
            if not _fxEnabled then
                _fxEnabled = true
                StartFXLoop()
            end
            pcall(function()
                local localPlayer = game:GetService("Players").LocalPlayer
                for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    local hum = mob:FindFirstChild("Humanoid")
                    if hum and not _oneHitConns[mob] then
                        -- Clamp HP về 25%
                        pcall(function()
                            sethiddenproperty(localPlayer, "SimulationRadius", math.huge)
                            if hum.Health > hum.MaxHealth * 0.25 then
                                hum.Health = hum.MaxHealth * 0.25
                            end
                        end)
                        -- Hook: khi server restore HP → clamp lại 25%
                        local prevHp = hum.Health
                        _oneHitConns[mob] = hum.HealthChanged:Connect(function(newHp)
                            if not _G.OneHitKill then return end
                            pcall(function()
                                sethiddenproperty(localPlayer, "SimulationRadius", math.huge)
                                if newHp > hum.MaxHealth * 0.25 then
                                    hum.Health = hum.MaxHealth * 0.25
                                end
                                prevHp = newHp
                            end)
                        end)
                    end
                end
                -- Dọn connection mob đã despawn
                for mob, conn in pairs(_oneHitConns) do
                    if not mob.Parent then
                        pcall(function() conn:Disconnect() end)
                        _oneHitConns[mob] = nil
                    end
                end
            end)
        else
            -- Tắt FX loop khi OneHitKill off
            if _fxEnabled and not (_G.AutoBone or _G.AutoBoneNoQuest or _G.AutoLevel or _G.AutoNear) then
                StopFXLoop()
            end
            for mob, conn in pairs(_oneHitConns) do
                pcall(function() conn:Disconnect() end)
            end
            _oneHitConns = {}
        end
    end
end)
Tabs.Main:AddToggle("ToggleMobAura", {
    ["Title"] = "Đánh Quái Gần",
    ["Default"] = false
}):OnChanged(function(p276)
    _G.AutoNear = p276
    if p276 == false then
        wait()
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
    end
end)
-- [SetValue skipped - Library không cần]
spawn(function()
    while wait() do
        if _G.AutoNear then
            pcall(function()
                local v277, v278, v279 = pairs(game.Workspace.Enemies:GetChildren())
                while true do
                    local v280
                    v279, v280 = v277(v278, v279)
                    if v279 == nil then
                        break
                    end
                    if v280:FindFirstChild("Humanoid") and (v280:FindFirstChild("HumanoidRootPart") and (v280.Humanoid.Health > 0 and (v280.Name and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v280:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 5000))) then
                        repeat
                            wait(_G.Fast_Delay)
                            v280.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v280.HumanoidRootPart.Transparency = 1
                            v280.Humanoid.JumpPower = 0
                            v280.Humanoid.WalkSpeed = 0
                            v280.HumanoidRootPart.CanCollide = false
                            local mobCF7 = v280.HumanoidRootPart.CFrame * Pos
                            local dist7 = (mobCF7.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if dist7 > 5 then BKP(mobCF7) end
                            bringmob = true
                            AutoHaki()
                            EquipTool(SelectWeapon)
                            AttackNoCoolDown()
                            FarmPos = v280.HumanoidRootPart.CFrame
                            MonFarm = v280.Name
                        until not _G.AutoNear or (not v280.Parent or v280.Humanoid.Health <= 0) or not game.Workspace.Enemies:FindFirstChild(v280.Name)
                        bringmob = false
                    end
                end
            end)
        end
    end
end)
Tabs.Main:AddToggle("ToggleCastleRaid", {
    ["Title"] = "Đánh Hải Tặc",
    ["Default"] = false
}):OnChanged(function(p281)
    _G.CastleRaid = p281
end)
-- [SetValue skipped - Library không cần]
spawn(function()
    while wait() do
        if _G.CastleRaid then
            pcall(function()
                local v282 = CFrame.new(- 5496.17432, 313.768921, - 2841.53027, 0.924894512, 7.37058015e-9, 0.380223751, 3.5881019e-8, 1, - 1.06665446e-7, - 0.380223751, 1.12297109e-7, 0.924894512)
                if (CFrame.new(- 5539.3115234375, 313.800537109375, - 2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                    Tween2(v282)
                else
                    local v283, v284, v285 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                    while true do
                        local v286
                        v285, v286 = v283(v284, v285)
                        if v285 == nil then
                            break
                        end
                        if _G.CastleRaid and (v286:FindFirstChild("HumanoidRootPart") and (v286:FindFirstChild("Humanoid") and (v286.Humanoid.Health > 0 and (v286.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000))) then
                            repeat
                                wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v286.HumanoidRootPart.CanCollide = false
                                v286.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                local _mc1 = v286.HumanoidRootPart.CFrame * Pos
                                if (v286.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc1) end
                            until v286.Humanoid.Health <= 0 or not (v286.Parent and _G.CastleRaid)
                        end
                    end
                end
            end)
        end
    end
end)
Tabs.Main:AddToggle("ToggleHakiFortress", {
    ["Title"] = "Bắt Haki Màu Pháo Đài",
    ["Default"] = false
}):OnChanged(function(p287)
    _G.EnableHakiFortress = p287
end)
-- [SetValue skipped - Library không cần]
local function vu291(p288, p289)
    local v290 = {
        {
            ["StorageName"] = p288,
            ["Type"] = "AuraSkin",
            ["Context"] = "Equip"
        }
    }
    game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/FruitCustomizerRF"):InvokeServer(unpack(v290))
    Tween2(p289)
end
local function vu295(p292, p293)
    local v294 = game.Players.LocalPlayer.Character
    if v294 and v294:FindFirstChild("HumanoidRootPart") then
        return (v294.HumanoidRootPart.Position - p292).Magnitude < p293
    else
        return false
    end
end
spawn(function()
	-- upvalues: (ref) vu291, (ref) vu295
    while true do
        if _G.EnableHakiFortress then
            vu291("Snow White", Vector3.new(- 4971.71826171875, 335.9582214355469, - 3720.0595703125))
            while not vu295(Vector3.new(- 4971.71826171875, 335.9582214355469, - 3720.0595703125), 1) do
                wait(0.1)
            end
            wait(0.5)
            vu291("Pure Red", Vector3.new(- 5414.92041015625, 314.2582092285156, - 2212.20166015625))
            while not vu295(Vector3.new(- 5414.92041015625, 314.2582092285156, - 2212.20166015625), 1) do
                wait(0.1)
            end
            wait(0.5)
            vu291("Winter Sky", Vector3.new(- 5420.26318359375, 1089.3582763671875, - 2666.8193359375))
            while not vu295(Vector3.new(- 5420.26318359375, 1089.3582763671875, - 2666.8193359375), 1) do
                wait(0.1)
            end
            wait(0.5)
            _G.EnableHakiFortress = false
        end
        wait(0.5)
    end
end)
Tabs.Main:AddToggle("ToggleCollectChest", {
    ["Title"] = "Làm Rương",
    ["Default"] = false
}):OnChanged(function(p296)
    _G.AutoCollectChest = p296
end)
spawn(function()
    while wait() do
        if _G.AutoCollectChest then
            local v297 = game:GetService("Players").LocalPlayer
            local v298 = (v297.Character or v297.CharacterAdded:Wait()):GetPivot().Position
            local v299 = game:GetService("CollectionService"):GetTagged("_ChestTagged")
            local v300 = math.huge
            local v301 = nil
            for v302 = 1, # v299 do
                local v303 = v299[v302]
                local v304 = (v303:GetPivot().Position - v298).Magnitude
                if not v303:GetAttribute("IsDisabled") then
                    if v304 < v300 then
                        v301 = v303
                        v300 = v304
                    end
                end
            end
            if v301 then
                local v305 = v301:GetPivot().Position
                local v306 = CFrame.new(v305)
                Tween2(v306)
            end
        end
    end
end)
Tabs.Main:AddToggle("ToggleCollectBerry", {
    ["Title"] = "Bay Đến Khu Vực Có Berry+Hop",
    ["Default"] = false
}):OnChanged(function(p307)
    _G.AutoCollectBerry = p307
end)
spawn(function()
	-- upvalues: (ref) vu1
    while wait() do
        if _G.AutoCollectBerry then
            local v308 = game:GetService("Players").LocalPlayer
            local v309 = (v308.Character or v308.CharacterAdded:Wait()):GetPivot().Position
            local v310 = game:GetService("CollectionService"):GetTagged("BerryBush")
            local v311 = math.huge
            local v312 = nil
            local v313 = nil
            for v314 = 1, # v310 do
                local v315 = v310[v314]
                local v316, v317, v318 = pairs(v315:GetAttributes())
                while true do
                    local v319
                    v318, v319 = v316(v317, v318)
                    if v318 == nil then
                        break
                    end
                    local v320 = (v315.Parent:GetPivot().Position - v309).Magnitude
                    if v320 < v311 then
                        v313 = v319
                        v312 = v315
                        v311 = v320
                    end
                end
            end
            if v312 then
                local v321 = v312.Parent:GetPivot().Position
                local v322 = CFrame.new(v321)
                Tween2(v322)
                Library:Notify({
                    ["Title"] = "Strix",
                    ["Description"] = "Tìm Thấy Berry: " .. tostring(v313),
                    ["Duration"] = 10
                })
            else
                Hop()
            end
        end
    end
end)
Tabs.Main:AddSection("Thông Thạo")
local v323 = Tabs.Main:AddDropdown("DropdownMastery", {
    ["Title"] = "Chọn Loại",
    ["Values"] = {
        "Level",
        "Level No Quest",
        "Near Mob",
        "Bone",
        "Cake",
        "Ecto"
    },
    ["Multi"] = false,
    ["Default"] = 1
})
v323:SetValue(TypeMastery)
v323:OnChanged(function(p324)
    TypeMastery = p324
end)
Tabs.Main:AddToggle("ToggleMasteryFruit", {
    ["Title"] = "Cày Trái",
    ["Default"] = false
}):OnChanged(function(p325)
    AutoFarmMasDevilFruit = p325
end)
-- [SetValue skipped - Library không cần]
Tabs.Main:AddToggle("ToggleMasteryGun", {
    ["Title"] = "Cày Súng",
    ["Default"] = false
}):OnChanged(function(p326)
    AutoFarmMasGun = p326
end)
local v328 = Tabs.Main:AddSlider("SliderHealt", {
    ["Title"] = "Máu Quái",
    ["Default"] = 20,
    ["Min"] = 0,
    ["Max"] = 100,
    ["Rounding"] = 1,
    ["Callback"] = function(p327)
        KillPercent = p327
    end
})
v328:OnChanged(function(p329)
    KillPercent = p329
end)
v328:SetValue(20)
spawn(function()
    while task.wait() do
        if _G.UseSkill then
            pcall(function()
				-- block 48
                if not _G.UseSkill then
					-- ::l3::
                    return
                end
                local v330, v331, v332 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				-- ::l4::
                local v333
                v332, v333 = v330(v331, v332)
                if v332 == nil then
					-- goto l3
                end
                if v333.Name ~= MonFarm or (not v333:FindFirstChild("Humanoid") or (not v333:FindFirstChild("HumanoidRootPart") or v333.Humanoid.Health > v333.Humanoid.MaxHealth * KillPercent / 100)) then
					-- goto l4
                end
				-- ::l13::
                game:GetService("RunService").Heartbeat:wait()
                EquipTool(game.Players.LocalPlayer.Data.DevilFruit.Value)
                local _mc2 = v333.HumanoidRootPart.CFrame * Pos
                if (v333.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc2) end
                PositionSkillMasteryDevilFruit = v333.HumanoidRootPart.Position
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).MousePos.Value = PositionSkillMasteryDevilFruit
                    local v334 = game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).Level.Value
                    if SkillZ and 1 <= v334 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                        wait()
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                    end
                    if SkillX and 1 <= v334 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                        wait()
                        game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                    end
                    if SkillC and 1 <= v334 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
                        wait()
                        game:service("VirtualInputManager"):SendKeyEvent(false, "C", false, game)
                    end
                    if SkillV and 1 <= v334 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "V", false, game)
                        wait()
                        game:service("VirtualInputManager"):SendKeyEvent(false, "V", false, game)
                    end
                    if SkillF and 1 <= v334 then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                        wait()
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                    end
                end
                if AutoFarmMasDevilFruit and (_G.UseSkill and v333.Humanoid.Health ~= 0) then
					-- goto l13
                else
					-- goto l3
                end
				-- ::l3::
				-- ::l2::
				-- goto l4
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if AutoFarmMasDevilFruit and TypeMastery == "Near Mob" then
            pcall(function()
                local v335, v336, v337 = pairs(game.Workspace.Enemies:GetChildren())
                while true do
                    local v338
                    v337, v338 = v335(v336, v337)
                    if v337 == nil then
                        return
                    end
                    if v338.Name and (v338:FindFirstChild("Humanoid") and (v338:FindFirstChild("HumanoidRootPart") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v338:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 5000)) then
                        repeat
                            if true then
                                wait(_G.Fast_Delay)
                                if v338.Humanoid.Health > v338.Humanoid.MaxHealth * KillPercent / 100 then
                                    _G.UseSkill = false
                                    AutoHaki()
                                    bringmob = true
                                    EquipTool(SelectWeapon)
                                    local _mc3 = v338.HumanoidRootPart.CFrame * Pos
                                    if (v338.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc3) end
                                    v338.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v338.HumanoidRootPart.Transparency = 1
                                    v338.Humanoid.JumpPower = 0
                                    v338.Humanoid.WalkSpeed = 0
                                    v338.HumanoidRootPart.CanCollide = false
                                    FarmPos = v338.HumanoidRootPart.CFrame
                                    MonFarm = v338.Name
                                    AttackNoCoolDown()
                                else
                                    _G.UseSkill = true
                                end
                            end
                        until not AutoFarmMasDevilFruit or (not MasteryType == "Near Mob" or (not v338.Parent or (v338.Humanoid.Health == 0 or not TypeMastery == "Near Mob")))
                        bringmob = false
                        _G.UseSkill = false
                    end
                end
            end)
        end
    end
end)
spawn(function()
	-- ::l0::
    repeat
        if not wait() then
            return
        end
    until AutoFarmMasDevilFruit and TypeMastery == "Ecto"
    pcall(function()
        local v339 = CFrame.new(904.4072265625, 181.05767822266, 33341.38671875)
        Tween2(v339)
    end)
    if (Vector3.new(904.4072265625, 181.05767822266, 33341.38671875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
    end
    local v340, v341, v342 = pairs(game:GetService("Workspace").Enemies:GetChildren())
	-- ::l11::
	-- ::l7::
	-- ::l19::
    if true then
        wait(_G.Fast_Delay)
        if v343.Humanoid.Health > v343.Humanoid.MaxHealth * KillPercent / 100 then
            _G.UseSkill = false
            AutoHaki()
            bringmob = true
            EquipTool(SelectWeapon)
            local _mc4 = v343.HumanoidRootPart.CFrame * Pos
            if (v343.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc4) end
            v343.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
            v343.HumanoidRootPart.Transparency = 1
            v343.Humanoid.JumpPower = 0
            v343.Humanoid.WalkSpeed = 0
            v343.HumanoidRootPart.CanCollide = false
            FarmPos = v343.HumanoidRootPart.CFrame
            MonFarm = v343.Name
            AttackNoCoolDown()
        else
            _G.UseSkill = true
        end
    end
    if AutoFarmMasDevilFruit and (not MasteryType ~= "Ecto" and (v343.Parent and (v343.Humanoid.Health ~= 0 and not TypeMastery ~= "Ecto"))) then
		-- goto l19
    else
		-- goto l31
    end
	-- ::l31::
    bringmob = false
    _G.UseSkill = false
	-- ::l11::
    local v343
    v342, v343 = v340(v341, v342)
    if v342 ~= nil then
		-- goto l12
    end
    local v344, v345, v346 = pairs(game:GetService("ReplicatedStorage"):GetChildren())
    while true do
        local v347
        v346, v347 = v344(v345, v346)
        if v346 == nil then
            break
        end
        if v347.Name ~= "Ship Steward" then
            if v347.Name ~= "Ship Engineer" then
                if v347.Name ~= "Ship Deckhand" then
                    if v347.Name == "Ship Officer" then
                        local _mc5 = v347.HumanoidRootPart.CFrame * Pos
                        if (v347.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc5) end
                    end
                else
                    local _mc6 = v347.HumanoidRootPart.CFrame * Pos
                    if (v347.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc6) end
                end
            else
                local _mc7 = v347.HumanoidRootPart.CFrame * Pos
                if (v347.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc7) end
            end
        else
            local _mc8 = v347.HumanoidRootPart.CFrame * Pos
            if (v347.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc8) end
        end
    end
	-- goto l0
	-- ::l12::
    if v343:FindFirstChild("Humanoid") and (v343:FindFirstChild("HumanoidRootPart") and (v343.Name == "Ship Steward" or (v343.Name == "Ship Engineer" or (v343.Name == "Ship Deckhand" or v343.Name == "Ship Officer")))) then
		-- goto l11
    else
		-- goto l16
    end
	-- ::l16::
	-- ::l2::
	-- goto l11
end)
spawn(function()
	-- ::l0::
    repeat
        if not wait() then
            return
        end
    until AutoFarmMasDevilFruit and TypeMastery == "Cake"
    pcall(function()
        local v348 = CFrame.new(- 9508.5673828125, 142.1398468017578, 5737.3603515625)
        Tween2(v348)
    end)
    local v349, v350, v351 = pairs(game.Workspace.Enemies:GetChildren())
	-- ::l8::
	-- ::l7::
	-- ::l16::
    if true then
        wait(_G.Fast_Delay)
        if v352.Humanoid.Health > v352.Humanoid.MaxHealth * KillPercent / 100 then
            _G.UseSkill = false
            AutoHaki()
            bringmob = true
            EquipTool(SelectWeapon)
            local _mc9 = v352.HumanoidRootPart.CFrame * Pos
            if (v352.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc9) end
            v352.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
            v352.HumanoidRootPart.Transparency = 1
            v352.Humanoid.JumpPower = 0
            v352.Humanoid.WalkSpeed = 0
            v352.HumanoidRootPart.CanCollide = false
            FarmPos = v352.HumanoidRootPart.CFrame
            MonFarm = v352.Name
            AttackNoCoolDown()
        else
            _G.UseSkill = true
        end
    end
    if AutoFarmMasDevilFruit and (not MasteryType ~= "Cake" and (v352.Parent and (v352.Humanoid.Health ~= 0 and not TypeMastery ~= "Cake"))) then
		-- goto l16
    else
		-- goto l28
    end
	-- ::l28::
    bringmob = false
    _G.UseSkill = false
	-- ::l8::
    local v352
    v351, v352 = v349(v350, v351)
    if v351 ~= nil then
		-- goto l9
    end
    local v353, v354, v355 = pairs(game:GetService("ReplicatedStorage"):GetChildren())
    while true do
        local v356
        v355, v356 = v353(v354, v355)
        if v355 == nil then
            break
        end
        if v356.Name ~= "Cookie Crafter" then
            if v356.Name ~= "Cake Guard" then
                if v356.Name ~= "Baking Staff" then
                    if v356.Name == "Head Baker" then
                        local _mc10 = v356.HumanoidRootPart.CFrame * Pos
                        if (v356.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc10) end
                    end
                else
                    local _mc11 = v356.HumanoidRootPart.CFrame * Pos
                    if (v356.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc11) end
                end
            else
                local _mc12 = v356.HumanoidRootPart.CFrame * Pos
                if (v356.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc12) end
            end
        else
            local _mc13 = v356.HumanoidRootPart.CFrame * Pos
            if (v356.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc13) end
        end
    end
	-- goto l0
	-- ::l9::
    if v352:FindFirstChild("Humanoid") and (v352:FindFirstChild("HumanoidRootPart") and (v352.Name == "Cookie Crafter" or (v352.Name == "Cake Guard" or (v352.Name == "Baking Staff" or v352.Name == "Head Baker")))) then
		-- goto l8
    else
		-- goto l13
    end
	-- ::l13::
	-- ::l2::
	-- goto l8
end)
spawn(function()
	-- ::l0::
    repeat
        if not wait() then
            return
        end
    until AutoFarmMasDevilFruit and TypeMastery == "Level No Quest"
    pcall(function()
        CheckLevel()
        Tween2(CFrameQ)
    end)
    local v357, v358, v359 = pairs(game.Workspace.Enemies:GetChildren())
	-- ::l8::
	-- ::l7::
	-- ::l15::
    if true then
        wait(_G.Fast_Delay)
        if v360.Humanoid.Health > v360.Humanoid.MaxHealth * KillPercent / 100 then
            _G.UseSkill = false
            AutoHaki()
            bringmob = true
            EquipTool(SelectWeapon)
            local _mc14 = v360.HumanoidRootPart.CFrame * Pos
            if (v360.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then BKP(_mc14) end
            v360.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
            v360.HumanoidRootPart.Transparency = 1
            v360.Humanoid.JumpPower = 0
            v360.Humanoid.WalkSpeed = 0
