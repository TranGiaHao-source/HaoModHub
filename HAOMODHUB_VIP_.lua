--[[
    BananaHub UI Library
    (Loaded from ui BananaHub.lua.txt)
]]
-- UI banana make by Hao Mod

if getgenv().Nousigi then 
	if game.CoreGui:FindFirstChild("Night Mystic GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name,  "Night Mystic") then
				v:Destroy()
			end
		end
	end
end
getgenv().Nousigi = true

local DisableAnimation = game.Players.LocalPlayer.PlayerGui:FindFirstChild('TouchGui')

local T1UIColor = {
    ["Border Color"] = Color3.fromRGB(50, 50, 50),
    ["Click Effect Color"] = Color3.fromRGB(200, 40, 40),
    ["Setting Icon Color"] = Color3.fromRGB(200, 200, 200),
    ["Logo Image"] = "rbxassetid:// 89947810111304",
    ["Search Icon Color"] = Color3.fromRGB(200, 40, 40),
    ["Search Icon Highlight Color"] = Color3.fromRGB(255, 60, 60),
    ["GUI Text Color"] = Color3.fromRGB(240, 240, 240),
    ["Text Color"] = Color3.fromRGB(240, 240, 240),
    ["Placeholder Text Color"] = Color3.fromRGB(100, 100, 100),
    ["Title Text Color"] = Color3.fromRGB(255, 255, 255),
    
    ["Background Main Color"] = Color3.fromRGB(15, 15, 15), 
    ["Background 1 Color"] = Color3.fromRGB(22, 22, 22),
    ["Background 1 Transparency"] = 0.05,
    ["Background 2 Color"] = Color3.fromRGB(30, 30, 30),
    ["Background 3 Color"] = Color3.fromRGB(25, 25, 25),
    ["Background Image"] = "",
    
    ["Page Selected Color"] = Color3.fromRGB(200, 40, 40),
    ["Section Text Color"] = Color3.fromRGB(255, 255, 255),
    ["Section Underline Color"] = Color3.fromRGB(200, 40, 40),
    ["Toggle Border Color"] = Color3.fromRGB(70, 70, 70),
    ["Toggle Checked Color"] = Color3.fromRGB(200, 40, 40),
    ["Toggle Desc Color"] = Color3.fromRGB(180, 180, 180),
    
    ["Button Color"] = Color3.fromRGB(35, 35, 35),
    ["Label Color"] = Color3.fromRGB(28, 28, 28),
    ["Dropdown Icon Color"] = Color3.fromRGB(200, 40, 40),
    ["Dropdown Selected Color"] = Color3.fromRGB(200, 40, 40),
    ["Dropdown Selected Check Color"] = Color3.fromRGB(255, 255, 255),
    
    ["Textbox Highlight Color"] = Color3.fromRGB(200, 40, 40),
    ["Box Highlight Color"] = Color3.fromRGB(200, 40, 40),
    ["Slider Line Color"] = Color3.fromRGB(45, 45, 45),
    ["Slider Highlight Color"] = Color3.fromRGB(200, 40, 40),
    
    ["Tween Animation 1 Speed"] = DisableAnimation and 0 or 0.25,
    ["Tween Animation 2 Speed"] = DisableAnimation and 0 or 0.5,
    ["Tween Animation 3 Speed"] = DisableAnimation and 0 or 0.1,
    ["Text Stroke Transparency"] = .8 
}

getgenv().UIColor = T1UIColor
getgenv().AllControls = {}
getgenv().UIToggled = false

local currcolor = {}
local Library = {}
local Library_Function = {}
local TweenService = game:GetService('TweenService')
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function makeDraggable(topBarObject, object)
	local dragging = nil
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if not djtmemay and cac then
				TweenService:Create(object, TweenInfo.new(DisableAnimation and 0 or 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
				}):Play()
			elseif not djtmemay and not cac then
				object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			end
		end
	end)
end

Library_Function.Gui = Instance.new('ScreenGui')
Library_Function.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.Gui.Name = 'Night Mystic GUI'
Library_Function.Gui.Enabled = false

getgenv().ReadyForGuiLoaded = false
spawn(function()
	repeat
		task.wait()
	until getgenv().ReadyForGuiLoaded
	if getgenv().UIToggled then
		Library_Function.Gui.Enabled = true
	end
end)

Library_Function.NotiGui = Instance.new('ScreenGui')
Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.NotiGui.Name = 'Night Mystic Notification'

Library_Function.HideGui = Instance.new('ScreenGui')
Library_Function.HideGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.HideGui.Name = 'Night Mystic'

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ToggleScreenGui = Instance.new("ScreenGui")
ToggleScreenGui.Parent = game:GetService("CoreGui")
ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleScreenGui.Name = "NazuXWindowsToggleUltimate"

-- SERVICES
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- SCREEN GUI (BẮT BUỘC)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BananaToggleGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

-- MAIN TOGGLE BUTTON
local mainButton = Instance.new("ImageButton")
mainButton.Parent = screenGui
mainButton.Size = UDim2.new(0, 50, 0, 50)
mainButton.Position = UDim2.new(0, 20, 0.5, -25)
mainButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainButton.BackgroundTransparency = 0
mainButton.AutoButtonColor = false
mainButton.Image = ""
mainButton.ZIndex = 10

-- BO TRÒN 100%
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = mainButton

-- ICON
local icon = Instance.new("ImageLabel")
icon.Parent = mainButton
icon.AnchorPoint = Vector2.new(0.5, 0.5)
icon.Position = UDim2.new(0.5, 0, 0.5, 0)
icon.Size = UDim2.new(0, 36, 0, 36)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid:// 89947810111304" -- ID ẢNH
icon.ScaleType = Enum.ScaleType.Fit
icon.ZIndex = 11

-- STATE
local isToggled = true
local dragging = false
local dragStart
local startPos
local CLICK_DISTANCE = 6

-- TWEEN
local tweenOn = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenOff = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- INPUT BEGIN
mainButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragStart = input.Position
		startPos = mainButton.Position
		dragging = true
	end
end)

-- DRAG MOVE
UIS.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		local delta = input.Position - dragStart
		if math.abs(delta.X) > CLICK_DISTANCE or math.abs(delta.Y) > CLICK_DISTANCE then
			mainButton.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

-- INPUT END (CLICK / END DRAG)
UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		-- CLICK (KHÔNG KÉO)
		if math.abs(delta.X) < CLICK_DISTANCE and math.abs(delta.Y) < CLICK_DISTANCE then
			isToggled = not isToggled

			if isToggled then
				TweenService:Create(mainButton, tweenOn, {
					BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				}):Play()
			else
				TweenService:Create(mainButton, tweenOff, {
					BackgroundColor3 = Color3.fromRGB(15, 15, 15)
				}):Play()
			end

			print("UI TOGGLED:", isToggled) -- DEBUG
		end

		dragging = false
	end
end)

mainButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

mainButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        TweenService:Create(mainButton, fluentTweenInfo, {
            Size = UDim2.new(0, 60, 0, 60),
            BackgroundTransparency = 0.2
        }):Play()
    end
end)

uis.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

mainButton.MouseEnter:Connect(function()
    isHovering = true
    
    TweenService:Create(mainButton, fluentTweenInfo, {
        Size = UDim2.new(0, 64, 0, 64),
        BackgroundTransparency = 0.1
    }):Play()
    
    TweenService:Create(UIStroke, fluentTweenInfo, {
        Transparency = 0.4
    }):Play()
    
    TweenService:Create(mainButton, hoverTweenInfo, {
        BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    }):Play()
end)

mainButton.MouseLeave:Connect(function()
    isHovering = false
    local targetColor = isToggled and Color3.fromRGB(15, 15, 15) or Color3.fromRGB(45, 45, 45)
    
    TweenService:Create(mainButton, fluentTweenInfo, {
        Size = UDim2.new(0, 60, 0, 60),
        BackgroundTransparency = 0.2
    }):Play()
    
    TweenService:Create(UIStroke, fluentTweenInfo, {
        Transparency = 0.7
    }):Play()
    
    TweenService:Create(mainButton, defaultTweenInfo, {
        BackgroundColor3 = targetColor
    }):Play()
end)

mainButton.MouseButton1Down:Connect(function()
    TweenService:Create(mainButton, hoverTweenInfo, {
        Size = UDim2.new(0, 58, 0, 58),
        BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    }):Play()
end)

mainButton.MouseButton1Click:Connect(function()
    Library.ToggleUI()
    
    isToggled = getgenv().UIToggled
    
    local scaleTween = TweenService:Create(mainButton, clickTweenInfo, {
        Size = UDim2.new(0, 55, 0, 55)
    })
    
    local scaleBackTween = TweenService:Create(mainButton, clickTweenInfo, {
        Size = UDim2.new(0, 60, 0, 60)
    })
    
    local iconScaleTween = TweenService:Create(icon, clickTweenInfo, {
        Size = isToggled and UDim2.new(0, 27, 0, 27) or UDim2.new(0, 40, 0, 40)
    })
    
    local targetColor = isToggled and Color3.fromRGB(15, 15, 15) or Color3.fromRGB(45, 45, 45)
    local colorTween = TweenService:Create(mainButton, defaultTweenInfo, {
        BackgroundColor3 = targetColor
    })
    
    if faded then
        fadeOutTween:Play()
    else
        fadeInTween:Play()
    end
    faded = not faded
    
    scaleTween:Play()
    iconScaleTween:Play()
    colorTween:Play()
    
    spawn(function()
        wait(0.15)
        scaleBackTween:Play()
    end)
    
    if isToggled then
        print("Toggle ON - Ultimate Toggle Activated")
    else
        print("Toggle OFF - Ultimate Toggle Deactivated")
    end
end)

Library.ToggleUI = function()
    getgenv().UIToggled = not getgenv().UIToggled
    
    if game.CoreGui:FindFirstChild("Night Mystic GUI") then
        for a, b in ipairs(game.CoreGui:GetChildren()) do
            if b.Name == "Night Mystic GUI" then
                b.Enabled = getgenv().UIToggled
            end
        end
    end
    
    isToggled = getgenv().UIToggled
    
    local iconScaleTween = TweenService:Create(icon, defaultTweenInfo, {
        Size = isToggled and UDim2.new(0, 27, 0, 27) or UDim2.new(0, 40, 0, 40)
    })
    
    local targetColor = isToggled and Color3.fromRGB(15, 15, 15) or Color3.fromRGB(45, 45, 45)
    local colorTween = TweenService:Create(mainButton, defaultTweenInfo, {
        BackgroundColor3 = targetColor
    })
    
    iconScaleTween:Play()
    colorTween:Play()
end

Library.DestroyUI = function()
    if game.CoreGui:FindFirstChild("Night Mystic GUI") then
        for i, v in ipairs(game.CoreGui:GetChildren()) do
            if string.find(v.Name, "Night Mystic") then
                v:Destroy()
            end
        end
    end
    
    local toggleGui = game.CoreGui:FindFirstChild("NazuXWindowsToggleUltimate")
    if toggleGui then
        toggleGui:Destroy()
    end
    
    getgenv().Nousigi = false
    getgenv().UIToggled = false
    getgenv().AllControls = {}
    getgenv().ReadyForGuiLoaded = false
end

local NotiContainer = Instance.new("Frame")
local NotiList = Instance.new("UIListLayout")

NotiContainer.Name = "NotiContainer"
NotiContainer.Parent = Library_Function.NotiGui
NotiContainer.AnchorPoint = Vector2.new(1, 1)
NotiContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
NotiContainer.BackgroundTransparency = 1.000
NotiContainer.Position = UDim2.new(1, -5, 1, -5)
NotiContainer.Size = UDim2.new(0, 350, 1, -10)

NotiList.Name = "NotiList"
NotiList.Parent = NotiContainer
NotiList.SortOrder = Enum.SortOrder.LayoutOrder
NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotiList.Padding = UDim.new(0, 5)

Library_Function.Gui.Parent = game:GetService('CoreGui')
Library_Function.NotiGui.Parent = game:GetService('CoreGui')
Library_Function.HideGui.Parent = game:GetService('CoreGui')

function Library_Function.Getcolor(color)
	return {
		math.floor(color.r * 255),
		math.floor(color.g * 255),
		math.floor(color.b * 255)
	}
end

local libCreateNoti = function(Setting)
	getgenv().TitleNameNoti = Setting.Title or ""; 
	local Description = Setting.Description or Setting.Desc or Setting.Content or ""; 
	local Duration = Setting.Duration or Setting.Timeshow or Setting.Delay or 10;

	local NotiFrame = Instance.new("Frame")
	local Noticontainer = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Topnoti = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local RuafimgCorner = Instance.new("UICorner")
	local TextLabelNoti = Instance.new("TextLabel")
	local CloseContainer = Instance.new("Frame")
	local CloseImage = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")
	local TextLabelNoti2 = Instance.new("TextLabel")

	NotiFrame.Name = "NotiFrame"
	NotiFrame.Parent = NotiContainer
	NotiFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	NotiFrame.BackgroundTransparency = 1.000
	NotiFrame.ClipsDescendants = true
	NotiFrame.Position = UDim2.new(0, 0, 0, 0)
	NotiFrame.Size = UDim2.new(1, 0, 0, 0)
	NotiFrame.AutomaticSize = Enum.AutomaticSize.Y

	Noticontainer.Name = "Noticontainer"
	Noticontainer.Parent = NotiFrame
	Noticontainer.Position = UDim2.new(1, 0, 0, 0)
	Noticontainer.Size = UDim2.new(1, 0, 1, 6)
	Noticontainer.AutomaticSize = Enum.AutomaticSize.Y
	Noticontainer.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Noticontainer

	Topnoti.Name = "Topnoti"
	Topnoti.Parent = Noticontainer
	Topnoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Topnoti.BackgroundTransparency = 1.000
	Topnoti.Position = UDim2.new(0, 0, 0, 5)
	Topnoti.Size = UDim2.new(1, 0, 0, 25)

	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = Topnoti
	Ruafimg.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Ruafimg.BackgroundTransparency = 1.000
	Ruafimg.Position = UDim2.new(0, 5, 0, getgenv().T1 and 5 or 0)
	Ruafimg.Size = UDim2.new(0, getgenv().T1 and 30 or 25, 0, getgenv().T1 and 15 or 25)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]

	RuafimgCorner.CornerRadius = UDim.new(1, 0)
	RuafimgCorner.Name = "RuafimgCorner"
	RuafimgCorner.Parent = Ruafimg
	
	local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
	local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
	local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
	local color = colorR .. ',' .. colorG .. ',' .. colorB
    TextLabelNoti.Text = "<font color=\"rgb(" .. tostring(color or "255,80,80") .. ")\">" .. tostring(TitleNameMain or "Night Mystic") .. "</font> " .. tostring(getgenv().TitleNameNoti or "")
    
	TextLabelNoti.Name = "TextLabelNoti"
	TextLabelNoti.Parent = Topnoti
	TextLabelNoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabelNoti.BackgroundTransparency = 1.000
	TextLabelNoti.Position = UDim2.new(0, getgenv().T1 and 40 or 35, 0, 0)
	TextLabelNoti.Size = UDim2.new(1, getgenv().T1 and -40 or -35, 1, 0)
	TextLabelNoti.Font = Enum.Font.GothamBold
	TextLabelNoti.TextSize = 14.000
	TextLabelNoti.TextWrapped = true
	TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelNoti.RichText = true
	TextLabelNoti.TextColor3 = getgenv().UIColor["GUI Text Color"]

	CloseContainer.Name = "CloseContainer"
	CloseContainer.Parent = Topnoti
	CloseContainer.AnchorPoint = Vector2.new(1, 0.5)
	CloseContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	CloseContainer.BackgroundTransparency = 1.000
	CloseContainer.Position = UDim2.new(1, -4, 0.5, 0)
	CloseContainer.Size = UDim2.new(0, 22, 0, 22)

	CloseImage.Name = "CloseImage"
	CloseImage.Parent = CloseContainer
	CloseImage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	CloseImage.BackgroundTransparency = 1.000
	CloseImage.Size = UDim2.new(1, 0, 1, 0)
	CloseImage.Image = "rbxassetid://3926305904"
	CloseImage.ImageRectOffset = Vector2.new(284, 4)
	CloseImage.ImageRectSize = Vector2.new(24, 24)
	CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]

	TextButton.Parent = CloseContainer
	TextButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextButton.BackgroundTransparency = 1.000
	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14.000

	if Description then
		TextLabelNoti2.Name = 'TextColor'
		TextLabelNoti2.Parent = Noticontainer
		TextLabelNoti2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TextLabelNoti2.BackgroundTransparency = 1.000
		TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35)
		TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
		TextLabelNoti2.Font = Enum.Font.GothamBold
		TextLabelNoti2.Text = Description
		TextLabelNoti2.TextSize = 14.000
		TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelNoti2.RichText = true
		TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
		TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabelNoti2.TextWrapped = true
	end

	local function remove()
		TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			Position = UDim2.new(1, 0, 0, 0)
		}):Play()
		wait(.25)
		NotiFrame:Destroy()
	end

	TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()

	TextButton.MouseEnter:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
		}):Play()
	end)

	TextButton.MouseLeave:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Color"]
		}):Play()
	end)

	TextButton.MouseButton1Click:Connect(function()
		wait(.25)
		remove()
	end)

	spawn(function()
		wait(Duration)
		remove()
	end)

end

function Library:Notify(Setting, bypass)
	if not getgenv().Config or bypass then
		local s, e = pcall(function()
			libCreateNoti(Setting)
		end)
		if e then
			print(e)
		end
	end
end

function Library:CreateWindow(Setting)
    local TitleNameMain = Setting.Title or "Night Mystic"
    getgenv().MainDesc = Setting.Desc or Setting.Subtitle or ""
    
    if Setting.Image then
        getgenv().UIColor["Logo Image"] = Setting.Image
    end
    
	local djtmemay = false
	cac = false

	local Main = Instance.new("Frame")
	local maingui = Instance.new("ImageLabel")
	local MainCorner = Instance.new("UICorner")
	local TopMain = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local TextLabelMain = Instance.new("TextLabel")
	local PageControl = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local ControlList = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ControlTitle = Instance.new("TextLabel")
	local MainPage = Instance.new("Frame")
	local UIPage = Instance.new("UIPageLayout")
	local Concacontainer = Instance.new("Frame")
	local Concacmain = Instance.new("Frame")
	local MainContainer

	Main.Name = "Main"
	Main.Parent = Library_Function.Gui
	Main.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
	Main.BackgroundTransparency = 1.000
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Size = UDim2.new(0, 629, 0, 359)

	makeDraggable(Main, Main)

	maingui.Name = "maingui"
	maingui.Parent = Main
	maingui.AnchorPoint = Vector2.new(0.5, 0.5)
	maingui.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	maingui.BackgroundTransparency = 1.000
	maingui.Position = UDim2.new(0.5, 0, 0.5, 0)
	maingui.Selectable = true
	maingui.Size = UDim2.new(1, 30, 1, 30)
	maingui.Image = "rbxassetid://8068653048"
	maingui.ScaleType = Enum.ScaleType.Slice
	maingui.SliceCenter = Rect.new(15, 15, 175, 175)
	maingui.SliceScale = 1.300
	maingui.ImageColor3 = getgenv().UIColor["Border Color"]
	maingui.ImageTransparency = 1

	maingui.ImageColor3 = getgenv().UIColor['Title Text Color']

	MainContainer = Instance.new("ImageLabel")
	MainContainer.Name = "MainContainer"
	MainContainer.Parent = Main
	MainContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	MainContainer.Size = UDim2.new(1, 0, 1, 0)

	local uistr = Instance.new("UIStroke", MainContainer);
	uistr.Thickness = 1;
	uistr.Color = Color3.fromRGB(90, 90, 70);

	local uigradient = Instance.new("UIGradient", MainContainer);
	uigradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
	}
	uigradient.Rotation = 90
	uigradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.92),
		NumberSequenceKeypoint.new(1, 0.92)
	}

	getgenv().ReadyForGuiLoaded = true
	
	MainCorner.CornerRadius = UDim.new(0, 5)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = MainContainer

	Concacontainer.Name = "Concacontainer"
	Concacontainer.Parent = MainContainer
	Concacontainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Concacontainer.BackgroundTransparency = 1.000
	Concacontainer.ClipsDescendants = true
	Concacontainer.Position = UDim2.new(0, 0, 0, 30)
	Concacontainer.Size = UDim2.new(1, 0, 1, -30)
	
	Concacmain.Name = "Concacmain"
	Concacmain.Parent = Concacontainer
	Concacmain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Concacmain.BackgroundTransparency = 1.000
	Concacmain.Selectable = true
	Concacmain.Size = UDim2.new(1, 0, 1, 0)
	
	TopMain.Name = "TopMain"
	TopMain.Parent = MainContainer
	TopMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopMain.BackgroundTransparency = 1.000
	TopMain.Size = UDim2.new(1, 0, 0, 25)
	
	local TopStroke = Instance.new("Frame", TopMain)
	TopStroke.Name = "TopStroke"
	TopStroke.BackgroundColor3 = Color3.fromRGB(90, 90, 70)
	TopStroke.BackgroundTransparency = 0.6
	TopStroke.BorderSizePixel = 0
	TopStroke.Position = UDim2.new(0, 0, 1, -1)
	TopStroke.Size = UDim2.new(1, 0, 0, 1)
	
	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = TopMain
	Ruafimg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Ruafimg.BackgroundTransparency = 1.000
	Ruafimg.Position = UDim2.new(0, 5, 0, 0)
	Ruafimg.Size = UDim2.new(0, 25, 0, 25)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]

	TextLabelMain.Name = "TextLabelMain"
	TextLabelMain.Parent = TopMain
	TextLabelMain.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabelMain.BackgroundTransparency = 1.000
	TextLabelMain.Position = UDim2.new(0, 220, 0, 0)
	TextLabelMain.Size = UDim2.new(1, -35, 1, 0)
	TextLabelMain.Font = Enum.Font.GothamBold
	TextLabelMain.RichText = true
	TextLabelMain.TextSize = 16.000
	TextLabelMain.TextWrapped = true
	TextLabelMain.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelMain.TextColor3 = getgenv().UIColor["GUI Text Color"]
   TextLabelMain.Text = "<font color=\"rgb(0,0,0)\">" .. tostring(TitleNameMain or "Night Mystic") .. "</font> <font color=\"rgb(255,255,255)\">" .. tostring(getgenv().MainDesc or "") .. "</font>"
	PageControl.Name = "Background1"
	PageControl.Parent = Concacmain
	PageControl.Position = UDim2.new(0, 5, 0, 0)
	PageControl.Size = UDim2.new(0, 180, 0, 325)
	PageControl.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
	PageControl.BackgroundTransparency = 0.1

	local pageControlStroke = Instance.new("UIStroke", PageControl)
	pageControlStroke.Color = Color3.fromRGB(90, 90, 70)
	pageControlStroke.Thickness = 1

	local pageControlGradient = Instance.new("UIGradient", PageControl)
	pageControlGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 34)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 38, 46))
	}
	pageControlGradient.Rotation = 90
	pageControlGradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.06),
		NumberSequenceKeypoint.new(1, 0.12)
	}

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = PageControl

	ControlList.Name = "ControlList"
	ControlList.Parent = PageControl
	ControlList.Active = true
	ControlList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ControlList.BackgroundTransparency = 1.000
	ControlList.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ControlList.BorderSizePixel = 0
	ControlList.Position = UDim2.new(0, 0, 0, 30)
	ControlList.Size = UDim2.new(1, -5, 1, -30)
	ControlList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ControlList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ControlList.ScrollBarThickness = 5
	ControlList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

	UIListLayout.Parent = ControlList
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	ControlTitle.Name = "GUITextColor"
	ControlTitle.Parent = PageControl
	ControlTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ControlTitle.BackgroundTransparency = 1.000
	ControlTitle.Position = UDim2.new(0, 5, 0, 0)
	ControlTitle.Size = UDim2.new(1, 0, 0, 25)
	ControlTitle.Font = Enum.Font.GothamBold
	ControlTitle.Text = TitleNameMain
	ControlTitle.TextSize = 14.000
	ControlTitle.TextXAlignment = Enum.TextXAlignment.Left
	ControlTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

	local PageSearch = Instance.new("Frame")
	local PageSearchCorner = Instance.new("UICorner")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("ImageLabel")
	local SearchBox = Instance.new("TextBox")

	PageSearch.Name = "PageSearch"
	PageSearch.Parent = PageControl
	PageSearch.AnchorPoint = Vector2.new(1, 0)
	PageSearch.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
	PageSearch.Position = UDim2.new(1, -5, 0, 5)
	PageSearch.Size = UDim2.new(0, 170, 0, 25)
	PageSearch.ClipsDescendants = true

	PageSearchCorner.Parent = PageSearch
	PageSearchCorner.CornerRadius = UDim.new(0, 4)

	SearchFrame.Name = "SearchFrame"
	SearchFrame.Parent = PageSearch
	SearchFrame.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	SearchFrame.BackgroundTransparency = 1
	SearchFrame.Size = UDim2.new(0, 25, 1, 0)

	SearchIcon.Name = "SearchIcon"
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	SearchIcon.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	SearchIcon.BackgroundTransparency = 1
	SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 16, 0, 16)
	SearchIcon.Image = "rbxassetid://8154282545"
	SearchIcon.ImageColor3 = Color3.fromRGB(240, 240, 230)

    SearchBox.Name = "SearchBox"
    SearchBox.Parent = PageSearch
    SearchBox.Active = true
    SearchBox.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
    SearchBox.BackgroundTransparency = 1
    SearchBox.CursorPosition = -1
    SearchBox.Position = UDim2.new(0, 30, 0, 0)
    SearchBox.Size = UDim2.new(1, -30, 1, 0)
    SearchBox.Font = Enum.Font.GothamBold
    SearchBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 160)
    SearchBox.PlaceholderText = "Search section or Function..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(235, 235, 230)
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	MainPage.Name = "MainPage"
	MainPage.Parent = Concacmain
	MainPage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	MainPage.BackgroundTransparency = 1.000
	MainPage.ClipsDescendants = true
	MainPage.Position = UDim2.new(0, 190, 0, 0)
	MainPage.Size = UDim2.new(0, 435, 0, 325)

	UIPage.Name = "UIPage"
	UIPage.Parent = MainPage
	UIPage.FillDirection = Enum.FillDirection.Vertical
	UIPage.SortOrder = Enum.SortOrder.LayoutOrder
	UIPage.EasingDirection = Enum.EasingDirection.InOut
	UIPage.EasingStyle = Enum.EasingStyle.Quart
	UIPage.Padding = UDim.new(0, 10)
	UIPage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ControlList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
	end)

	local Shadow = Instance.new("ImageLabel", Main)
	Shadow.Name = "Shadow"
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 40, 1, 40)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://5028857084"
	Shadow.ImageTransparency = 0.35
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(24, 24, 276, 276)

    local sectionInfo = {}
    
    if not GlobalSearch then
        GlobalSearch = function(searchText)
            searchText = string.lower(searchText)
            
            if searchText == "" then
                for _, control in pairs(getgenv().AllControls) do
                    control.TabButton.Visible = true
                    control.Section.Visible = true
                    control.Element.Visible = true
                end
                for _, tab in pairs(ControlList:GetChildren()) do
                    if not tab:IsA('UIListLayout') then
                        tab.Visible = true
                    end
                end
                return
            end
            
            for _, control in pairs(getgenv().AllControls) do
                control.Section.Visible = false
                control.Element.Visible = false
            end
            
            for _, tab in pairs(ControlList:GetChildren()) do
                if not tab:IsA('UIListLayout') then
                    tab.Visible = false
                end
            end
            
            local sectionsWithElements = {}
            local elementsInSection = {}
            
            for _, control in pairs(getgenv().AllControls) do
                local elementName = string.lower(control.Name or "")
                local sectionName = string.lower(control.SectionName or "")
                
                local elementFound = string.find(elementName, searchText, 1, true) ~= nil
                local sectionFound = string.find(sectionName, searchText, 1, true) ~= nil
                
                if not elementsInSection[control.Section] then
                    elementsInSection[control.Section] = {}
                end
                table.insert(elementsInSection[control.Section], {
                    control = control,
                    elementFound = elementFound,
                    sectionFound = sectionFound
                })
                
                if elementFound then
                    sectionsWithElements[control.Section] = true
                end
            end
            
            local foundTabs = {}
            
            for section, elements in pairs(elementsInSection) do
                local shouldShowSection = false
                local hasElementMatch = false
                
                for _, elementInfo in ipairs(elements) do
                    if elementInfo.sectionFound then
                        shouldShowSection = true
                    end
                    if elementInfo.elementFound then
                        hasElementMatch = true
                    end
                end
                
                for _, elementInfo in ipairs(elements) do
                    local control = elementInfo.control
                    
                    if elementInfo.elementFound then
                        control.Element.Visible = true
                        
                        if elementInfo.sectionFound or hasElementMatch then
                            control.Section.Visible = true
                        end
                        
                        foundTabs[control.TabName] = true
                        control.TabButton.Visible = true
                    elseif elementInfo.sectionFound and not hasElementMatch then
                        control.Section.Visible = true
                        control.Element.Visible = false
                        
                        foundTabs[control.TabName] = true
                        control.TabButton.Visible = true
                    end
                end
            end
            
            for tabName, _ in pairs(foundTabs) do
                for _, tab in pairs(ControlList:GetChildren()) do
                    if not tab:IsA('UIListLayout') and string.find(tab.Name, tabName, 1, true) then
                        tab.Visible = true
                    end
                end
            end
            
            if not next(foundTabs) then
            end
        end
    end
    
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        GlobalSearch(SearchBox.Text)
    end)

	local Main_Function = {}

	local LayoutOrderBut = -1
	local LayoutOrder = -1
	local PageCounter = 1

		function Main_Function:AddTab(PageName, IconId)

		local Page_Name = tostring(PageName)
		local Page_Title = Page_Name

		LayoutOrder = LayoutOrder + 1
		LayoutOrderBut = LayoutOrderBut + 1
 
		local PageNameControl = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local TabNameCorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local InLine = Instance.new("Frame")
		local LineCorner = Instance.new("UICorner")
		local TabTitleContainer = Instance.new("Frame")
		local TabTitle = Instance.new("TextLabel")
		local PageButton = Instance.new("TextButton")
        
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "TabIcon"
        TabIcon.Parent = Frame
        TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabIcon.BackgroundTransparency = 1.000
        TabIcon.Position = UDim2.new(0, 10, 0.5, 0)
        TabIcon.AnchorPoint = Vector2.new(0, 0.5)
        TabIcon.Size = UDim2.new(0, 15, 0, 15) 
        TabIcon.Image = IconId or "" 
        
        if not IconId or IconId == "" then
            TabIcon.Visible = false
        end

		PageNameControl.Name = Page_Name .. "_Control"
		PageNameControl.Parent = ControlList
		PageNameControl.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageNameControl.BackgroundTransparency = 1.000
		PageNameControl.Size = UDim2.new(1, -10, 0, 25)
		PageNameControl.LayoutOrder = LayoutOrderBut

		Frame.Parent = PageNameControl
		Frame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Frame.BackgroundTransparency = 1.000
		Frame.Position = UDim2.new(0, 5, 0, 0)
		Frame.Size = UDim2.new(1, -5, 1, 0)

		TabNameCorner.CornerRadius = UDim.new(0, 4)
		TabNameCorner.Name = "TabNameCorner"
		TabNameCorner.Parent = Frame

		Line.Name = "Line"
		Line.Parent = Frame
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Line.BackgroundTransparency = 1.000
		Line.Position = UDim2.new(0, 0, 0.5, 0)
		Line.Size = UDim2.new(0, 14, 1, 0)

		InLine.Name = "PageInLine"
		InLine.Parent = Line
		InLine.AnchorPoint = Vector2.new(0.5, 0.5)
		InLine.BorderSizePixel = 0
		InLine.Position = UDim2.new(0.5, 0, 0.5, 0)
		InLine.Size = UDim2.new(1, -10, 1, -10)
		InLine.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
		InLine.BackgroundTransparency = 1.000

		LineCorner.Name = "LineCorner"
		LineCorner.Parent = InLine

		TabTitleContainer.Name = "TabTitleContainer"
		TabTitleContainer.Parent = Frame
		TabTitleContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TabTitleContainer.BackgroundTransparency = 1.000
        
        if IconId and IconId ~= "" then
		    TabTitleContainer.Position = UDim2.new(0, 35, 0, 0) 
            TabTitleContainer.Size = UDim2.new(1, -35, 1, 0)
        else
            TabTitleContainer.Position = UDim2.new(0, 15, 0, 0)
            TabTitleContainer.Size = UDim2.new(1, -15, 1, 0)
        end

		TabTitle.Name = "GUITextColor"
		TabTitle.Parent = TabTitleContainer
		TabTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TabTitle.BackgroundTransparency = 1.000
		TabTitle.Size = UDim2.new(1, 0, 1, 0)
		TabTitle.Font = Enum.Font.GothamBold
		TabTitle.Text = Page_Name
		TabTitle.TextSize = 14.000
		TabTitle.TextXAlignment = Enum.TextXAlignment.Left
		TabTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

		PageButton.Name = "PageButton"
		PageButton.Parent = PageNameControl
		PageButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageButton.BackgroundTransparency = 1.000
		PageButton.Size = UDim2.new(1, 0, 1, 0)
		PageButton.Font = Enum.Font.SourceSans
		PageButton.Text = ""
		PageButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		PageButton.TextSize = 14.000


		local PageContainer = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local PageTitle = Instance.new("TextLabel")
		local PageList = Instance.new("ScrollingFrame")
		local Pagelistlayout = Instance.new("UIListLayout")

		local CurrentPage = PageCounter
		PageCounter = PageCounter + 1
		PageContainer.Name = "Page" .. CurrentPage
		PageContainer.Parent = MainPage
		PageContainer.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
		PageContainer.Position = UDim2.new(0, 190, 0, 30)
		PageContainer.Size = UDim2.new(0, 435, 0, 325)
		PageContainer.LayoutOrder = LayoutOrder
		PageContainer.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = PageContainer

		PageTitle.Name = "GUITextColor"
		PageTitle.Parent = PageContainer
		PageTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageTitle.BackgroundTransparency = 1.000
		PageTitle.Position = UDim2.new(0, 5, 0, 0)
		PageTitle.Size = UDim2.new(1, 0, 0, 25)
		PageTitle.Font = Enum.Font.GothamBold
		PageTitle.Text = Page_Title
		PageTitle.TextSize = 16.000
		PageTitle.TextXAlignment = Enum.TextXAlignment.Left
		PageTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

		PageList.Name = "PageList"
		PageList.Parent = PageContainer
		PageList.Active = true
		PageList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageList.BackgroundTransparency = 1.000
		PageList.BorderColor3 = Color3.fromRGB(27, 42, 53)
		PageList.BorderSizePixel = 0
		PageList.Position = UDim2.new(0, 5, 0, 30)
		PageList.Size = UDim2.new(1, -10, 1, -30)
		PageList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollBarThickness = 5
		PageList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollingEnabled = true
		PageList.VerticalScrollBarInset = Enum.ScrollBarInset.Always

		Pagelistlayout.Name = "Pagelistlayout"
		Pagelistlayout.Parent = PageList
		Pagelistlayout.SortOrder = Enum.SortOrder.LayoutOrder
		Pagelistlayout.Padding = UDim.new(0, 5)
		Pagelistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageList.CanvasSize = UDim2.new(0, 0, 0, Pagelistlayout.AbsoluteContentSize.Y)
		end)

		local PageSearch = Instance.new("Frame")
		local PageSearchCorner = Instance.new("UICorner")
		local SearchFrame = Instance.new("Frame")
		local SearchIcon = Instance.new("ImageLabel")
		local SearchButton = Instance.new("TextButton")
		local SearchBox = Instance.new("TextBox")

		PageSearch.Name = "Page Search"
		PageSearch.Parent = PageContainer
		PageSearch.AnchorPoint = Vector2.new(1, 0)
		PageSearch.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
		PageSearch.Position = UDim2.new(1, -5, 0, 5)
		PageSearch.Size = UDim2.new(0, 20, 0, 20)
		PageSearch.ClipsDescendants = true

		PageSearchCorner.CornerRadius = UDim.new(0, 2)
		PageSearchCorner.Name = "PageSearchCorner"
		PageSearchCorner.Parent = PageSearch

		SearchFrame.Name = "SearchFrame"
		SearchFrame.Parent = PageSearch
		SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchFrame.BackgroundTransparency = 1.000
		SearchFrame.Size = UDim2.new(0, 20, 0, 20)

		SearchIcon.Name = "SearchIcon"
		SearchIcon.Parent = SearchFrame
		SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchIcon.BackgroundTransparency = 1.000
		SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
		SearchIcon.Size = UDim2.new(0, 16, 0, 16)
		SearchIcon.Image = "rbxassetid://8154282545"
		SearchIcon.ImageColor3 = getgenv().UIColor["Search Icon Color"]

		SearchButton.Name = "Search Button"
		SearchButton.Parent = SearchFrame
		SearchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchButton.BackgroundTransparency = 1.000
		SearchButton.Size = UDim2.new(1, 0, 1, 0)
		SearchButton.Font = Enum.Font.SourceSans
		SearchButton.Text = ""
		SearchButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		SearchButton.TextSize = 14.000

		SearchBox.Name = "Search Box"
		SearchBox.Parent = PageSearch
		SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchBox.BackgroundTransparency = 1.000
		SearchBox.Position = UDim2.new(0, 30, 0, 0)
		SearchBox.Size = UDim2.new(1, -30, 1, 0)
		SearchBox.Font = Enum.Font.GothamBold
		SearchBox.Text = ""
		SearchBox.TextSize = 14.000
		SearchBox.TextXAlignment = Enum.TextXAlignment.Left
		SearchBox.PlaceholderText = "Search Section name"
		SearchBox.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
		SearchBox.TextColor3 = getgenv().UIColor["Text Color"]
		
		local Openned = false 

		SearchButton.MouseEnter:Connect(function()
			TweenService:Create(SearchIcon, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
			}):Play()
		end)

		SearchButton.MouseLeave:Connect(function()
			TweenService:Create(SearchIcon, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Color"]
			}):Play()
		end)

		SearchButton.MouseButton1Click:Connect(function()
			Openned = not Openned
			local size = Openned and UDim2.new(0, 175, 0, 20) or  UDim2.new(0, 20, 0, 20)
			game.TweenService:Create(PageSearch, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
				Size = size
			}):Play()
		end)

		local function hideOtherFrame()
			for i, v in next, PageList:GetChildren() do 
				if not v:IsA('UIListLayout') then 
					v.Visible = false
				end
			end
		end
		
		local function showFrameName()
			for i, v in pairs(PageList:GetChildren()) do
				if not v:IsA('UIListLayout') then 
					if string.find(string.lower(v.Name), string.lower(SearchBox.Text)) then 
						v.Visible = true
					end
				end
			end
		end
		
		SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			hideOtherFrame()
			showFrameName()
		end)

		for i, v in pairs(ControlList:GetChildren()) do
			if not (v:IsA('UIListLayout')) then
				if i == 2 then 
					v.Frame.Line.PageInLine.BackgroundTransparency = 0
				end
			end
		end

		PageButton.MouseButton1Click:Connect(function()
			if tostring(UIPage.CurrentPage) == PageContainer.Name then 
				return
			end

			for i, v in pairs(MainPage:GetChildren()) do
				if not (v:IsA('UIPageLayout')) and not (v:IsA('UICorner')) then
					v.Visible = false
				end
			end

			PageContainer.Visible = true 
			UIPage:JumpTo(PageContainer)

			for i, v in next, ControlList:GetChildren() do
				if not (v:IsA('UIListLayout')) then
					if v.Name == Page_Name .. "_Control" then 
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 0
						}):Play()
					else
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 1
						}):Play()
					end
				end
			end
		end)

		local pageFunction = {}

		function pageFunction:AddSection(Section_Name, Toggleable, SectionGap, SectionColor)
			local Toggleable = Toggleable or false
			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Topsec = Instance.new("Frame")
			local Sectiontitle = Instance.new("TextLabel")
			local Linesec = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local SectionList = Instance.new("UIListLayout")
			
			Section.Name = Section_Name .. "_Dot"
			Section.Parent = PageList
			Section.Size = UDim2.new(1, -5, 0, 30)
			Section.BackgroundColor3 = Color3.fromRGB(48, 48, 56)
			Section.BackgroundTransparency = 0.25
			Section.ClipsDescendants = true

			local sectionStroke = Instance.new("UIStroke", Section)
			sectionStroke.Color = Color3.fromRGB(90, 90, 70)
			sectionStroke.Thickness = 1

			local sectionGradient = Instance.new("UIGradient", Section)
			sectionGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 46)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 48, 56))
			}
			sectionGradient.Rotation = 90
			sectionGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0.05),
				NumberSequenceKeypoint.new(1, 0.15)
			}

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Section

			Topsec.Name = "Topsec"
			Topsec.Parent = Section
			Topsec.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Topsec.BackgroundTransparency = 1.000
			Topsec.Size = UDim2.new(0, 415, 0, 30)

			Sectiontitle.Name = "Sectiontitle"
			Sectiontitle.Parent = Topsec
			Sectiontitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Sectiontitle.BackgroundTransparency = 1.000
			Sectiontitle.Size = UDim2.new(1, 0, 1, 0)
			Sectiontitle.Font = Enum.Font.GothamBold
			Sectiontitle.Text = Section_Name
			Sectiontitle.TextSize = 14.000
			Sectiontitle.TextColor3 = getgenv().UIColor["Section Text Color"]

			Linesec.Name = "Linesec"
			Linesec.Parent = Topsec
			Linesec.AnchorPoint = Vector2.new(0.5, 1)
			Linesec.BorderSizePixel = 0
			Linesec.Position = UDim2.new(0.5, 0, 1, -2)
			Linesec.Size = UDim2.new(1, -10, 0, 2)
			Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]

			local LineShadow = Instance.new("ImageLabel", Linesec)
			LineShadow.Name = "LineShadow"
			LineShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			LineShadow.BackgroundColor3 = Color3.fromRGB(163,162,165)
			LineShadow.BackgroundTransparency = 1
			LineShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			LineShadow.Size = UDim2.new(1, 8, 1, 8)
			LineShadow.ZIndex = 0
			LineShadow.Image = "rbxassetid://5028857084"
			LineShadow.ImageTransparency = 0.6
			LineShadow.ScaleType = Enum.ScaleType.Slice
			LineShadow.SliceCenter = Rect.new(24, 24, 276, 276)

			UIGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.51, 0.02),
				NumberSequenceKeypoint.new(1, 1)
			}
			UIGradient.Parent = Linesec

			SectionList.Name = "SectionList"
			SectionList.Parent = Section
			SectionList.SortOrder = Enum.SortOrder.LayoutOrder
			SectionList.Padding = UDim.new(0, 5)

			local SizeSectionY
			local sectionIsVisible = false
			if Toggleable then
				local VisibilitySectionFrame = Instance.new("Frame")
				local VisibilitySectionFrameCorner = Instance.new("UICorner")
				local visibility = Instance.new("ImageButton")
				local visibility_off = Instance.new("ImageButton")
				local VisibilityButton = Instance.new("TextButton")
				VisibilityButton.Name = "VisibilityButton"
				VisibilityButton.Parent = Topsec
				VisibilityButton.AnchorPoint = Vector2.new(1, 0.5)
				VisibilityButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				VisibilityButton.BackgroundTransparency = 1.000
				VisibilityButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				VisibilityButton.BorderSizePixel = 0
				VisibilityButton.Font = Enum.Font.SourceSans
				VisibilityButton.Text = ""
				VisibilityButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				VisibilityButton.TextSize = 14.000
				VisibilityButton.ZIndex = 2
				VisibilityButton.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilityButton.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrame.Name = "VisibilitySectionFrame"
				VisibilitySectionFrame.Parent = Topsec
				VisibilitySectionFrame.AnchorPoint = Vector2.new(1, 0.5)
				VisibilitySectionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				VisibilitySectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				VisibilitySectionFrame.BorderSizePixel = 0
				VisibilitySectionFrame.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilitySectionFrame.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrameCorner.CornerRadius = UDim.new(0, 4)
				VisibilitySectionFrameCorner.Name = "VisibilitySectionFrameCorner"
				VisibilitySectionFrameCorner.Parent = VisibilitySectionFrame
				visibility.Name = "visibility"
				visibility.Parent = VisibilitySectionFrame
				visibility.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility.BackgroundTransparency = 1.000
				visibility.LayoutOrder = 4
				visibility.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility.Size = UDim2.new(1, -4, 1, -4)
				visibility.ZIndex = 2
				visibility.Image = "rbxassetid://3926307971"
				visibility.ImageRectOffset = Vector2.new(84, 44)
				visibility.ImageRectSize = Vector2.new(36, 36)
				visibility.ImageTransparency = 1
				visibility_off.Name = "visibility_off"
				visibility_off.Parent = VisibilitySectionFrame
				visibility_off.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility_off.BackgroundTransparency = 1.000
				visibility_off.LayoutOrder = 4
				visibility_off.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility_off.Size = UDim2.new(1, -4, 1, -4)
				visibility_off.ZIndex = 2
				visibility_off.Image = "rbxassetid://3926307971"
				visibility_off.ImageRectOffset = Vector2.new(564, 44)
				visibility_off.ImageRectSize = Vector2.new(36, 36)
				visibility_off.ImageTransparency = 0
				VisibilityButton.MouseButton1Down:Connect(function()
					sectionIsVisible = not sectionIsVisible
					TweenService:Create(visibility, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 0 or 1
					}):Play()
					wait(getgenv().UIColor["Tween Animation 1 Speed"] / 4)
					TweenService:Create(visibility_off, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 1 or 0
					}):Play()
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size =  UDim2.new(1, -5, 0, (sectionIsVisible and SizeSectionY or 30))
					}):Play()
				end)
			end
			if SectionGap then
				local SectionGap = Instance.new("Frame")
				SectionGap.Name = "SectionGap"
				SectionGap.Parent = PageList
				SectionGap.Size = UDim2.new(1, -5, 0, 30)
				SectionGap.ClipsDescendants = true
				SectionGap.Transparency = 1
			end

			SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if (not Toggleable) then
					Section.Size = UDim2.new(1, -5, 0, SectionList.AbsoluteContentSize.Y + 5)
				end
				SizeSectionY = SectionList.AbsoluteContentSize.Y + 5
				if sectionIsVisible then
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size =  UDim2.new(1, -5, 0, SizeSectionY)
					}):Play()
				end
			end)
			local sectionFunction = {}
						function sectionFunction:AddToggle(idk,Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local Desc = Setting.Desc or Setting.Description
				local Default = Setting.Default
				if Default == nil then
					Default = false
				end
				local Callback = Setting.Callback
				local ToggleFrame = Instance.new("Frame")
				local TogFrame1 = Instance.new("Frame")
				local checkbox = Instance.new("ImageLabel")
				local check = Instance.new("Frame")
				local ToggleDesc = Instance.new("TextLabel")
				local ToggleTitle = Instance.new("TextLabel")
				local ToggleBg = Instance.new("Frame")
				local ToggleCorner = Instance.new("UICorner")
				local ToggleButton = Instance.new("TextButton")
				local ToggleList = Instance.new("UIListLayout")
				
				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = Section
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleFrame.BackgroundTransparency = 1.000
				
				if Desc and Desc ~= "" then
					ToggleFrame.AutomaticSize = Enum.AutomaticSize.Y
					ToggleFrame.Size = UDim2.new(1, 0, 0, 0)
				else
					ToggleFrame.AutomaticSize = Enum.AutomaticSize.None
					ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
				end

				TogFrame1.Name = "TogFrame1"
				TogFrame1.Parent = ToggleFrame
				TogFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
				TogFrame1.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				TogFrame1.BackgroundTransparency = 1.000
				TogFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
				TogFrame1.Size = UDim2.new(1, -10, 1, 0)
				
				checkbox.Name = "checkbox"
				checkbox.Parent = TogFrame1
				checkbox.AnchorPoint = Vector2.new(1, 0.5)
				checkbox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				checkbox.BackgroundTransparency = 1.000
				checkbox.Position = UDim2.new(1, -5, 0.5, 0)
				checkbox.Size = UDim2.new(0, 20, 0, 20)
				checkbox.Image = "rbxassetid://4552505888"
				checkbox.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
				
				check.Name = "check"
				check.Parent = checkbox
				check.AnchorPoint = Vector2.new(0.5, 0.5)
				check.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
				check.Position = UDim2.new(0.5, 0, 0.5, 0)
				
				if Desc and Desc ~= "" then
					ToggleDesc.Name = "ToggleDesc"
					ToggleDesc.Parent = TogFrame1
					ToggleDesc.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
					ToggleDesc.BackgroundTransparency = 1.000
					ToggleDesc.Position = UDim2.new(0, 10, 0, 25)
					ToggleDesc.Size = UDim2.new(1, -50, 0, 0)
					ToggleDesc.Font = Enum.Font.Gotham
					ToggleDesc.Text = Desc
					ToggleDesc.TextSize = 12.000
					ToggleDesc.TextWrapped = true
					ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
					ToggleDesc.RichText = true
					ToggleDesc.AutomaticSize = Enum.AutomaticSize.Y
					ToggleDesc.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
					
					local pad = Instance.new("UIPadding", TogFrame1)
					pad.PaddingTop = UDim.new(0, 5)
					pad.PaddingBottom = UDim.new(0, 5)
				end
				
				ToggleTitle.Name = "TextColor"
				ToggleTitle.Parent = TogFrame1
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleTitle.BackgroundTransparency = 1.000
				
				if Desc and Desc ~= "" then
					ToggleTitle.Position = UDim2.new(0, 10, 0, 5)
					ToggleTitle.Size = UDim2.new(1, -50, 0, 20)
				else
					ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
					ToggleTitle.Size = UDim2.new(1, -50, 1, 0)
				end
				
				ToggleTitle.Font = Enum.Font.GothamBlack
				ToggleTitle.Text = Title
				ToggleTitle.TextSize = 14.000
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
				ToggleTitle.TextYAlignment = Enum.TextYAlignment.Center
				ToggleTitle.RichText = true
				ToggleTitle.TextColor3 = getgenv().UIColor["Text Color"]
				
				ToggleBg.Name = "Background1"
				ToggleBg.Parent = TogFrame1
				ToggleBg.Size = UDim2.new(1, 0, 1, 0)
				ToggleBg.ZIndex = 0
				ToggleBg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				ToggleBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				
				ToggleCorner.CornerRadius = UDim.new(0, 10)
				ToggleCorner.Name = "ToggleCorner"
				ToggleCorner.Parent = ToggleBg
				
				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = TogFrame1
				ToggleButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleButton.BackgroundTransparency = 1.000
				ToggleButton.Size = UDim2.new(1, 0, 1, 0)
				ToggleButton.Position = UDim2.new(0, 0, 0, 0)
				ToggleButton.Font = Enum.Font.SourceSans
				ToggleButton.Text = ""
				ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleButton.TextSize = 14.000
				
				ToggleList.Name = "ToggleList"
				ToggleList.Parent = ToggleFrame
				ToggleList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ToggleList.SortOrder = Enum.SortOrder.LayoutOrder
				ToggleList.VerticalAlignment = Enum.VerticalAlignment.Center
				ToggleList.Padding = UDim.new(0, 5)
				
				local function ChangeStage(val)
					local csize = val and UDim2.new(0.6, 0, 0.6, 0) or UDim2.new(0, 0, 0, 0)
					local pos = val and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 0)
					local apos = val and Vector2.new(0.5, 0.5) or Vector2.new(0.5, 0.5)
					game.TweenService:Create(check, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size = csize,
						Position = pos,
						AnchorPoint = apos
					}):Play()
				end
				
				ChangeStage(Default)
				if Default and Callback then
					Callback(Default)
				end
				
				local function ButtonClick()
					Default = not Default
					ChangeStage(Default)
					if Callback then
						pcall(Callback, Default)
					end
				end
				
				ToggleButton.MouseButton1Click:Connect(function()
    ButtonClick()
end)

				local toggleFunction = {}
				function toggleFunction.SetStage(value)
					if value ~= Default then
						ButtonClick()
					end
				end
				
				local controlData = {
					Name = Title,
					Section = Section,
					Element = ToggleFrame,
					SectionName = Section_Name,
					TabName = Page_Name,
					TabButton = PageName
				}
				table.insert(getgenv().AllControls, controlData)
				
				return toggleFunction
			end
			function sectionFunction:AddButton(Setting, Callback)
				local Title = Setting.Title or Setting.Text or ""
				local Desc = Setting.Desc or Setting.Description
				local Callback = Setting.Callback or Setting.Func or function() end
				
				local Button = Instance.new("Frame")
				local RowBG_1 = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local RowHover_1 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local TextColor_1 = Instance.new("TextLabel")
				local TextDesc = Instance.new("TextLabel") 
				local ClickArea_1 = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UIGradient_1 = Instance.new("UIGradient")
				local ImageLabel_1 = Instance.new("ImageLabel")
				local Frame_1 = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local UIScale_1 = Instance.new("UIScale")
				local Button_1 = Instance.new("TextButton")
				
				Button.Name = "Button"
				Button.Parent = Section
				Button.BackgroundColor3 = Color3.fromRGB(163,162,165)
				Button.BackgroundTransparency = 1
				
				if Desc and Desc ~= "" then
					Button.AutomaticSize = Enum.AutomaticSize.Y
					Button.Size = UDim2.new(1, 0, 0, 0)
				else
					Button.Size = UDim2.new(1, 0, 0, 30) 
				end
				
				RowBG_1.Name = "RowBG"
				RowBG_1.Parent = Button
				RowBG_1.AnchorPoint = Vector2.new(0.5, 0.5)
				RowBG_1.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				RowBG_1.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				RowBG_1.Position = UDim2.new(0.5, 0, 0.5, 0)
				RowBG_1.Size = UDim2.new(1, -10, 1, 0)
				
				UICorner_1.Parent = RowBG_1
				UICorner_1.CornerRadius = UDim.new(0,10)
				
				RowHover_1.Name = "RowHover"
				RowHover_1.Parent = RowBG_1
				RowHover_1.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				RowHover_1.BackgroundTransparency = 1
				RowHover_1.Size = UDim2.new(1, 0, 1, 0)
				RowHover_1.ZIndex = 2
				
				UICorner_2.Parent = RowHover_1
				UICorner_2.CornerRadius = UDim.new(0,10)
				
				TextColor_1.Name = "TextColor"
				TextColor_1.Parent = RowBG_1
				TextColor_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
				TextColor_1.BackgroundTransparency = 1
				
				if Desc and Desc ~= "" then
					TextColor_1.Position = UDim2.new(0, 12, 0, 5)
					TextColor_1.Size = UDim2.new(1, -110, 0, 20)
				else
					TextColor_1.Position = UDim2.new(0, 12, 0, 0)
					TextColor_1.Size = UDim2.new(1, -110, 1, 0)
				end
				
				TextColor_1.Font = Enum.Font.GothamBold
				TextColor_1.Text = Title
				TextColor_1.TextColor3 = getgenv().UIColor["GUI Text Color"]
				TextColor_1.TextSize = 14
				TextColor_1.TextStrokeTransparency = 0.85
				TextColor_1.TextXAlignment = Enum.TextXAlignment.Left
				
				if Desc and Desc ~= "" then
					TextDesc.Name = "Description"
					TextDesc.Parent = RowBG_1
					TextDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TextDesc.BackgroundTransparency = 1
					TextDesc.Position = UDim2.new(0, 12, 0, 22)
					TextDesc.Size = UDim2.new(1, -110, 0, 0)
					TextDesc.AutomaticSize = Enum.AutomaticSize.Y
					TextDesc.Font = Enum.Font.Gotham
					TextDesc.Text = Desc
					TextDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
					TextDesc.TextSize = 12
					TextDesc.TextWrapped = true
					TextDesc.TextXAlignment = Enum.TextXAlignment.Left
					
					local pad = Instance.new("UIPadding", RowBG_1)
					pad.PaddingTop = UDim.new(0, 5)
					pad.PaddingBottom = UDim.new(0, 5)
				end
				
				ClickArea_1.Name = "ClickArea"
				ClickArea_1.Parent = RowBG_1
				ClickArea_1.AnchorPoint = Vector2.new(1, 0.5)
				ClickArea_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ClickArea_1.Position = UDim2.new(1, -8, 0.5, 0)
				ClickArea_1.Size = UDim2.new(0, 94, 0, 30)
				ClickArea_1.ClipsDescendants = true
				
				UICorner_3.Parent = ClickArea_1
				UICorner_3.CornerRadius = UDim.new(0,12)
				
				UIGradient_1.Parent = ClickArea_1
				UIGradient_1.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.4, Color3.fromRGB(240, 240, 240)),
					ColorSequenceKeypoint.new(0.6, Color3.fromRGB(230, 230, 230)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220))
				}
				UIGradient_1.Rotation = 90
				
				ImageLabel_1.Parent = ClickArea_1
				ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
				ImageLabel_1.BackgroundTransparency = 1
				ImageLabel_1.Position = UDim2.new(0.5, 0, 0.5, 0)
				ImageLabel_1.Size = UDim2.new(1, 14, 1, 14)
				ImageLabel_1.ZIndex = 0
				ImageLabel_1.Image = "rbxassetid://5028857084"
				ImageLabel_1.ImageTransparency = 0.7
				ImageLabel_1.ScaleType = Enum.ScaleType.Slice
				ImageLabel_1.SliceCenter = Rect.new(24, 24, 276, 276)
				
				Frame_1.Parent = ClickArea_1
				Frame_1.AnchorPoint = Vector2.new(0.5, 0)
				Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Frame_1.BackgroundTransparency = 0.8
				Frame_1.Position = UDim2.new(0.5, 0, 0, 2)
				Frame_1.Size = UDim2.new(1, -6, 0, 10)
				Frame_1.ZIndex = 2
				
				UICorner_4.Parent = Frame_1
				UICorner_4.CornerRadius = UDim.new(0,10)
				
				UIScale_1.Parent = ClickArea_1
				
				Button_1.Name = "Button"
				Button_1.Parent = ClickArea_1
				Button_1.Active = true
				Button_1.AutoButtonColor = false
				Button_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
				Button_1.BackgroundTransparency = 1
				Button_1.Size = UDim2.new(1, 0, 1, 0)
				Button_1.Font = Enum.Font.GothamBold
				Button_1.Text = "Click"
				Button_1.TextColor3 = Color3.fromRGB(40, 40, 40)
				Button_1.TextSize = 13
				
				local scaleHover = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1.05 })
				local scaleNormal = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1 })
				
				Button_1.MouseEnter:Connect(function() scaleHover:Play() end)
				Button_1.MouseLeave:Connect(function() scaleNormal:Play() end)
				
				Button_1.MouseButton1Down:Connect(function()
					local ripple = Instance.new("Frame")
					ripple.AnchorPoint = Vector2.new(0.5, 0.5)
					ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
					ripple.Size = UDim2.new(0, 0, 0, 0)
					ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ripple.BackgroundTransparency = 0.6
					ripple.ZIndex = 20
					ripple.Parent = ClickArea_1
					
					local rippleCorner = Instance.new("UICorner")
					rippleCorner.CornerRadius = UICorner_3.CornerRadius
					rippleCorner.Parent = ripple
					
					local rippleTween = TweenService:Create(ripple, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						Position = UDim2.new(0.5, 0, 0.5, 0)
					})
					rippleTween:Play()
					rippleTween.Completed:Connect(function() ripple:Destroy() end)
					
					Callback()
				end)
				
				local f = {}
				function f:SetTitle(vl) TextColor_1.Text = vl end
				
				local controlData = {
					Name = Title,
					Section = Section,
					Element = Button,
					SectionName = Section_Name,
					TabName = Page_Name,
					TabButton = PageName
				}
				table.insert(getgenv().AllControls, controlData)
				return f
			end
        
			function sectionFunction:AddLabel(text)
				local Title = text
                local LabelFrame = Instance.new("Frame")
                local LabelBG = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local TextColor = Instance.new("TextLabel")
                
                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = Section
                LabelFrame.AutomaticSize = Enum.AutomaticSize.Y
                LabelFrame.BackgroundColor3 = Color3.fromRGB(163,162,165)
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Size = UDim2.new(1, 0,0, 0)
                
                LabelBG.Name = "LabelBG"
                LabelBG.Parent = LabelFrame
                LabelBG.AnchorPoint = Vector2.new(0.5, 0)
                LabelBG.AutomaticSize = Enum.AutomaticSize.Y
                LabelBG.BackgroundColor3 = Color3.fromRGB(38,38,46)
                LabelBG.BackgroundTransparency = 0.25
                LabelBG.Position = UDim2.new(0.5, 0,0, 0)
                LabelBG.Size = UDim2.new(1, -10,0, -10)
                
                UICorner.Parent = LabelBG
                UICorner.CornerRadius = UDim.new(0,6)
                
                
                TextColor.Name = "TextColor"
                TextColor.Parent = LabelBG
                TextColor.AutomaticSize = Enum.AutomaticSize.Y
                TextColor.BackgroundColor3 = Color3.fromRGB(163,162,165)
                TextColor.BackgroundTransparency = 1
                TextColor.Position = UDim2.new(0, 12,0, 6)
                TextColor.Size = UDim2.new(1, -24,1, -12)
                TextColor.Font = Enum.Font.GothamMedium
                TextColor.Text = Title
                TextColor.TextColor3 = Color3.fromRGB(240,240,230)
                TextColor.TextSize = 14
                TextColor.TextStrokeTransparency = 0.8500000238418579
                TextColor.TextWrapped = true
                TextColor.TextXAlignment = Enum.TextXAlignment.Left
				local labelFunction = {}
				function labelFunction:SetText(text)
					TextColor.Text = text
				end
				function labelFunction.SetColor(color)
					TextColor.TextColor3 = color
				end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = LabelFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return labelFunction
			end
            function sectionFunction:AddDropdownSection(Setting)
                local Title = tostring(Setting.Text or Setting.Title or "")
                local Search = Setting.Search or false
              
                local DropdownFrame = Instance.new("Frame")
                local Dropdownbg = Instance.new("Frame")
                local Dropdowncorner = Instance.new("UICorner")
                local Topdrop = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local ImgDrop = Instance.new("ImageLabel")
                local DropdownButton = Instance.new("TextButton")
                local Dropdownlisttt = Instance.new("Frame")
                local DropdownScroll = Instance.new("ScrollingFrame")
                local ScrollContainer = Instance.new("Frame")
                local ScrollContainerList = Instance.new("UIListLayout")
                
                DropdownFrame.Name = Title .. "DropdownSectionFrame"
                DropdownFrame.Parent = Section
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownFrame.BackgroundTransparency = 1.000
                DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
                DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
                
                Dropdownbg.Name = "Background1"
                Dropdownbg.Parent = DropdownFrame
                Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
                Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
                Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
                Dropdownbg.ClipsDescendants = true
                Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                Dropdownbg.BackgroundTransparency = 0.25
                
                Dropdowncorner.CornerRadius = UDim.new(0, 4)
                Dropdowncorner.Name = "Dropdowncorner"
                Dropdowncorner.Parent = Dropdownbg
                
                Topdrop.Name = "Background2"
                Topdrop.Parent = Dropdownbg
                Topdrop.Size = UDim2.new(1, 0, 0, 25)
                Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = Topdrop
                
                local Dropdowntitle
                if Search then
                    Dropdowntitle = Instance.new("TextBox")
                    Dropdowntitle.PlaceholderText = Title
                    Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                else
                    Dropdowntitle = Instance.new("TextLabel")
                    Dropdowntitle.Text = Title
                end
                
                Dropdowntitle.Name = "TextColorPlaceholder"
                Dropdowntitle.Parent = Topdrop
                Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                Dropdowntitle.BackgroundTransparency = 1.000
                Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
                Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
                Dropdowntitle.Font = Enum.Font.GothamBlack
                Dropdowntitle.TextSize = 14.000
                Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
                Dropdowntitle.ClipsDescendants = true
                Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
                
                ImgDrop.Name = "ImgDrop"
                ImgDrop.Parent = Topdrop
                ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
                ImgDrop.BackgroundTransparency = 1.000
                ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
                ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
                ImgDrop.Size = UDim2.new(0, 15, 0, 15)
                ImgDrop.Image = "rbxassetid://6954383209"
                ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
                
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = Topdrop
                DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownButton.BackgroundTransparency = 1.000
                DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
                DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
                DropdownButton.Font = Enum.Font.GothamBold
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                DropdownButton.TextSize = 14.000
                
                Dropdownlisttt.Name = "Dropdownlisttt"
                Dropdownlisttt.Parent = Dropdownbg
                Dropdownlisttt.BackgroundTransparency = 1.000
                Dropdownlisttt.BorderSizePixel = 0
                Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
                Dropdownlisttt.Size = UDim2.new(1, 0, 0, 0)
                Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                
                DropdownScroll.Name = "DropdownScroll"
                DropdownScroll.Parent = Dropdownlisttt
                DropdownScroll.Active = true
                DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownScroll.BackgroundTransparency = 1.000
                DropdownScroll.BorderSizePixel = 0
                DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
                DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownScroll.ScrollBarThickness = 5
                DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.ScrollingEnabled = true
                DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
                
                ScrollContainer.Name = "ScrollContainer"
                ScrollContainer.Parent = DropdownScroll
                ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                ScrollContainer.BackgroundTransparency = 1.000
                ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
                ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
                
                ScrollContainerList.Name = "ScrollContainerList"
                ScrollContainerList.Parent = ScrollContainer
                ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
                ScrollContainerList.Padding = UDim.new(0, 5)
                
                local InternalSection = Instance.new("Frame")
                InternalSection.Name = "InternalSection"
                InternalSection.Parent = ScrollContainer
                InternalSection.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                InternalSection.BackgroundTransparency = 1.000
                InternalSection.Size = UDim2.new(1, 0, 0, 0)
                InternalSection.AutomaticSize = Enum.AutomaticSize.Y
                
                local InternalList = Instance.new("UIListLayout")
                InternalList.Name = "InternalList"
                InternalList.Parent = InternalSection
                InternalList.SortOrder = Enum.SortOrder.LayoutOrder
                InternalList.Padding = UDim.new(0, 5)
                
                local isOpen = false
                
                DropdownButton.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    
                    local listsize = isOpen and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, 230) or UDim2.new(1, 0, 0, 25)
                    local DropCRotation = isOpen and 90 or 0
                    
                    TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = listsize
                    }):Play()
                    TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = mainsize
                    }):Play()
                    TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Rotation = DropCRotation
                    }):Play()
                end)
                
                ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
                end)
                
                InternalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    local contentHeight = math.min(InternalList.AbsoluteContentSize.Y + 10, 300)
                    local listsize = isOpen and UDim2.new(1, 0, 0, contentHeight) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, contentHeight + 25) or UDim2.new(1, 0, 0, 25)
                    
                    if isOpen then
                        TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = listsize
                        }):Play()
                        TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = mainsize
                        }):Play()
                    end
                end)
                
               local dropdownSectionFunction = {}
                
                function dropdownSectionFunction:AddSlider(Setting)
                    local TitleText = tostring(Setting.Text or Setting.Title) or ""
                    local minValue = tonumber(Setting.Min) or 0
                    local maxValue = tonumber(Setting.Max) or 100
                    local Precise = Setting.Precise or false
                    local DefaultValue = tonumber(Setting.Default) or 0
                    local Callback = Setting.Callback
                    local Rounding = Setting.Rouding or Setting.Rounding
                    
                    local SliderFrame = Instance.new("Frame")
                    local SliderCorner = Instance.new("UICorner")
                    local SliderBG = Instance.new("Frame")
                    local SliderBGCorner = Instance.new("UICorner")
                    local SliderTitle = Instance.new("TextLabel")
                    local SliderBar = Instance.new("Frame")
                    local SliderButton = Instance.new("TextButton")
                    local SliderBarCorner = Instance.new("UICorner")
                    local Bar = Instance.new("Frame")
                    local BarCorner = Instance.new("UICorner")
                    local Sliderboxframe = Instance.new("Frame")
                    local Sliderbox = Instance.new("UICorner")
                    local Sliderbox_2 = Instance.new("TextBox")
                    
                    SliderFrame.Name = TitleText
                    SliderFrame.Parent = InternalSection
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    SliderFrame.BackgroundTransparency = 1.000
                    SliderFrame.Size = UDim2.new(1, 0, 0, 50) 
                    
                    SliderCorner.CornerRadius = UDim.new(0, 4)
                    SliderCorner.Name = "SliderCorner"
                    SliderCorner.Parent = SliderFrame
                    
                    SliderBG.Name = "Background1"
                    SliderBG.Parent = SliderFrame
                    SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
                    SliderBG.Size = UDim2.new(1, -5, 1, 0) 
                    SliderBG.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
                    SliderBG.BackgroundTransparency = 0.25
                    
                    SliderBGCorner.CornerRadius = UDim.new(0, 4)
                    SliderBGCorner.Name = "SliderBGCorner"
                    SliderBGCorner.Parent = SliderBG
                    
                    SliderTitle.Name = "TextColor"
                    SliderTitle.Parent = SliderBG
                    SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    SliderTitle.BackgroundTransparency = 1.000
                    SliderTitle.Position = UDim2.new(0, 10, 0, 0)
                    SliderTitle.Size = UDim2.new(0.65, -10, 0, 25) 
                    SliderTitle.Font = Enum.Font.GothamBlack
                    SliderTitle.Text = TitleText
                    SliderTitle.TextSize = 14.000
                    SliderTitle.RichText = true
                    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                    SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
                    
                    SliderBar.Name = "SliderBar"
                    SliderBar.Parent = SliderFrame
                    SliderBar.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBar.Position = UDim2.new(0.5, 0, 0.5, 14)
                    SliderBar.Size = UDim2.new(0.9, 0, 0, 6) 
                    SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    
                    SliderButton.Name = "SliderButton"
                    SliderButton.Parent = SliderBar
                    SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    SliderButton.BackgroundTransparency = 1.000
                    SliderButton.Size = UDim2.new(1, 0, 1, 0)
                    SliderButton.Font = Enum.Font.GothamBold
                    SliderButton.Text = ""
                    SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                    SliderButton.TextSize = 14.000
                    
                    SliderBarCorner.CornerRadius = UDim.new(1, 0)
                    SliderBarCorner.Name = "SliderBarCorner"
                    SliderBarCorner.Parent = SliderBar
                    
                    Bar.Name = "Bar"
                    Bar.BorderSizePixel = 0
                    Bar.Parent = SliderBar
                    Bar.Size = UDim2.new(0, 0, 1, 0)
                    Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                    
                    BarCorner.CornerRadius = UDim.new(1, 0)
                    BarCorner.Name = "BarCorner"
                    BarCorner.Parent = Bar
                    
                    Sliderboxframe.Name = "Background2"
                    Sliderboxframe.Parent = SliderFrame
                    Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
                    Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
                    Sliderboxframe.Size = UDim2.new(0.25, 0, 0, 25) 
                    Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    
                    Sliderbox.CornerRadius = UDim.new(0, 4)
                    Sliderbox.Name = "Sliderbox"
                    Sliderbox.Parent = Sliderboxframe
                    
                    Sliderbox_2.Name = "TextColor"
                    Sliderbox_2.Parent = Sliderboxframe
                    Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    Sliderbox_2.BackgroundTransparency = 1.000
                    Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
                    Sliderbox_2.Font = Enum.Font.GothamBold
                    Sliderbox_2.Text = ""
                    Sliderbox_2.TextSize = 14.000
                    Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
                    
                    SliderButton.MouseEnter:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
                        }):Play()
                    end)
                    
                    SliderButton.MouseLeave:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                        }):Play()
                    end)
                    
                    local callBackAndSetText = function(val)
                        Sliderbox_2.Text = tostring(val)
                        Callback(tonumber(val))
                    end
                    if DefaultValue then
                        if DefaultValue <= minValue then
                            DefaultValue = minValue
                        elseif DefaultValue >= maxValue then
                            DefaultValue = maxValue
                        end
                        Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
                        Sliderbox_2.Text = tostring(DefaultValue)
                    end
                    
                    
                    local dragging = false
                    local dragInput
                    local holdTime = 0
                    local holdStarted = 0
                    
                    local function onInputBegan(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            holdStarted = tick()
                            
                            input.Changed:Connect(function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    dragging = false
                                    holdStarted = 0
                                end
                            end)
                        end
                    end
                    
                    local function onInputEnded(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                            holdStarted = 0
                        end
                    end
                    
                    local function onInputChanged(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            dragInput = input
                        end
                    end
                    
                    SliderButton.InputBegan:Connect(onInputBegan)
                    SliderButton.InputEnded:Connect(onInputEnded)
                    SliderButton.InputChanged:Connect(onInputChanged)
                    
                    RunService.RenderStepped:Connect(function()
                        if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
                            dragging = true
                        end
                        
                        if dragging and dragInput then
                            local barWidth = math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
                            local percentage = barWidth / SliderBar.AbsoluteSize.X
                            local value = minValue + (maxValue - minValue) * percentage
                            
                            if Rounding then
                                value = tonumber(string.format("%.".. Rounding .."f", value))
                            elseif not Precise then
                                value = math.floor(value)
                            end
                            
                            value = math.clamp(value, minValue, maxValue)
                            
                            pcall(function()
                                callBackAndSetText(value)
                            end)
                            Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        end
                    end)
                    
                    local function GetSliderValue(Value)
                        Value = tonumber(Value) or minValue
                        Value = math.clamp(Value, minValue, maxValue)
                        
                        if Rounding then
                            Value = tonumber(string.format("%.".. Rounding .."f", Value))
                        elseif not Precise then
                            Value = math.floor(Value)
                        end
                        
                        local percentage = (Value - minValue) / (maxValue - minValue)
                        Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        callBackAndSetText(Value)
                    end
                    
                    Sliderbox_2.FocusLost:Connect(function()
                        GetSliderValue(Sliderbox_2.Text)
                    end)
                    
                    local slider_function = {}
                    function slider_function.SetValue(Value)
                        GetSliderValue(Value)
                    end
                    
                    function slider_function.GetValue()
                        return tonumber(Sliderbox_2.Text) or minValue
                    end
                    
                    return slider_function
                end
                
                function dropdownSectionFunction:SetOpen(state)
                    if state ~= isOpen then
                        DropdownButton.MouseButton1Click:Fire()
                    end
                end
                
                function dropdownSectionFunction:GetOpen()
                    return isOpen
                end
                
                function dropdownSectionFunction:SetTitle(newTitle)
                    if Search then
                        Dropdowntitle.PlaceholderText = newTitle
                    else
                        Dropdowntitle.Text = newTitle
                    end
                end
                
                local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownSectionFunction
            end
            
						function sectionFunction:AddDropdown(idk, Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local List = Setting.Values
				local Search = Setting.Search or false
				local Selected = Setting.Selected or Setting.Multi or false
				local Slider = Setting.Slider or false
				local SliderRelease = Setting.SliderRelease or false
				local Default = (function ()
                    if Setting.Default then
                        if type(Setting.Default) == "number" then
                            return List[Setting.Default]
                        elseif type(Setting.Default) == "string" then
                            return Setting.Default
                        end
                    end
                    return nil
                end)()
				local Callback = Setting.Callback
				local pairs = Setting.SortPairs or pairs
				local DropdownFrame = Instance.new("Frame")
				local Dropdownbg = Instance.new("Frame")
				local Dropdowncorner = Instance.new("UICorner")
				local Topdrop = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ImgDrop = Instance.new("ImageLabel")
				local DropdownButton = Instance.new("TextButton")
				local Dropdownlisttt = Instance.new("Frame")
				local DropdownScroll = Instance.new("ScrollingFrame")
				local ScrollContainer = Instance.new("Frame")
				local ScrollContainerList = Instance.new("UIListLayout")
				local dropdownLeave = false
				local Dropdowntitle;
				if Search then
					Dropdowntitle = Instance.new("TextBox")
				else
					Dropdowntitle = Instance.new("TextLabel")
				end
				DropdownFrame.Name = Title .. "DropdownFrame"
				DropdownFrame.Parent = Section
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownFrame.BackgroundTransparency = 1.000
				DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
				DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
				Dropdownbg.Name = "Background1"
				Dropdownbg.Parent = DropdownFrame
				Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
				Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
				Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
				Dropdownbg.ClipsDescendants = true
				Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				Dropdownbg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				Dropdowncorner.CornerRadius = UDim.new(0, 4)
				Dropdowncorner.Name = "Dropdowncorner"
				Dropdowncorner.Parent = Dropdownbg
				Topdrop.Name = "Background2"
				Topdrop.Parent = Dropdownbg
				Topdrop.Size = UDim2.new(1, 0, 0, 25)
				Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Topdrop
				Dropdowntitle.Name = "TextColorPlaceholder"
				Dropdowntitle.Parent = Topdrop
				Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Dropdowntitle.BackgroundTransparency = 1.000
				Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
				Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
				Dropdowntitle.Font = Enum.Font.GothamBlack
				Dropdowntitle.Text = ''
				Dropdowntitle.TextSize = 14.000
				Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
				Dropdowntitle.ClipsDescendants = true
				local Sel = Instance.new("StringValue", Dropdowntitle)
				Sel.Value = ""
				if Default and table.find(List, Default) then
					Sel.Value = Default
				end
				if not Selected then
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
					if Default and Callback then
						task.spawn(function()
							pcall(Callback, Default)
						end)
					end
				else
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
					if Default and Callback then
						task.spawn(function()
							pcall(Callback, Default)
						end)
					end
				end
				Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
				ImgDrop.Name = "ImgDrop"
				ImgDrop.Parent = Topdrop
				ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
				ImgDrop.BackgroundTransparency = 1.000
				ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
				ImgDrop.Size = UDim2.new(0, 15, 0, 15)
				ImgDrop.Image = "rbxassetid://6954383209"
				ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = Topdrop
				DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownButton.BackgroundTransparency = 1.000
				DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
				DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
				DropdownButton.Font = Enum.Font.GothamBold
				DropdownButton.Text = ""
				DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
				DropdownButton.TextSize = 14.000
				Dropdownlisttt.Name = "Dropdownlisttt"
				Dropdownlisttt.Parent = Dropdownbg
				Dropdownlisttt.BackgroundTransparency = 1.000
				Dropdownlisttt.BorderSizePixel = 0
				Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
				Dropdownlisttt.Size = UDim2.new(1, 0, 0, 25)
				Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownScroll.Name = "DropdownScroll"
				DropdownScroll.Parent = Dropdownlisttt
				DropdownScroll.Active = true
				DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownScroll.BackgroundTransparency = 1.000
				DropdownScroll.BorderSizePixel = 0
				DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
				DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 5
				DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.ScrollingEnabled = true
				DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
				ScrollContainer.Name = "ScrollContainer"
				ScrollContainer.Parent = DropdownScroll
				ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ScrollContainer.BackgroundTransparency = 1.000
				ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
				ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
				ScrollContainerList.Name = "ScrollContainerList"
				ScrollContainerList.Parent = ScrollContainer
				ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
				ScrollContainerList.Padding = UDim.new(0, 5)
				ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
				end)
				local isbusy = false
				local found = {}
				local searchtable = {}
				local function edit()
					for i in pairs(found) do
						found[i] = nil
					end
					for h, l in pairs(ScrollContainer:GetChildren()) do
						if not l:IsA("UIListLayout") and not l:IsA("UIPadding") and not l:IsA('UIGridLayout') then
							l.Visible = false
						end
					end
					Dropdowntitle.Text = string.lower(Dropdowntitle.Text)
				end
				local function SearchDropdown()
					local Results = {}
					for i, v in pairs(searchtable) do
						if string.find(v, Dropdowntitle.Text) then
							table.insert(found, v)
						end
					end
					for a, b in pairs(ScrollContainer:GetChildren()) do
						for c, d in pairs(found) do
							if d == b.Name then
								b.Visible = true
							end
						end
					end
				end
				local function clear_object_in_list()
					for i, v in next, ScrollContainer:GetChildren() do
						if v:IsA('Frame') then
							v:Destroy()
						end
					end
				end
				local ListNew
                local OrderedList = {}
                if Selected then
                    ListNew = {}
                    for _, value in ipairs(List) do
                        ListNew[value] = (value == Default)
                        table.insert(OrderedList, value)
                    end
                    if Default and Callback then
                        task.spawn(function() Callback(Default, true) end)
                    end
                else
                    ListNew = List
                end
				local function refreshlist(SortPairs)
					pairs = SortPairs or pairs
					clear_object_in_list()
					searchtable = {}
					for i, v in pairs(ListNew) do
						if Selected then
							table.insert(searchtable, string.lower(i))
						elseif Slider then
							table.insert(searchtable, string.lower(v['Title']))
						else
							table.insert(searchtable, string.lower(v))
						end
					end
					if Selected then
                        for _, i in ipairs(OrderedList) do
                            local v = ListNew[i]
							local SampleItem = Instance.new("Frame")
							local SampleItemCorner = Instance.new("UICorner")
							local SampleItemBG = Instance.new("Frame")
							local SampleItemBGCorner = Instance.new("UICorner")
							local SampleItemTitle = Instance.new("TextLabel")
							local SampleItemCheck = Instance.new("ImageButton")
							local SampleItemButton = Instance.new("TextButton")
							SampleItem.Name = string.lower(i)
							SampleItem.Parent = ScrollContainer
							SampleItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SampleItem.BackgroundTransparency = 1.000
							SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItem.LayoutOrder = 1
							SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
							SampleItem.Size = UDim2.new(1, 0, 0, 25)
							SampleItemCorner.CornerRadius = UDim.new(0, 4)
							SampleItemCorner.Name = "SampleItemCorner"
							SampleItemCorner.Parent = SampleItem
							SampleItemBG.Name = "SampleItemBG"
							SampleItemBG.Parent = SampleItem
							SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SampleItemBG.BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
							SampleItemBG.BackgroundTransparency = v and .5 or 1
							SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
							SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
							SampleItemBGCorner.Name = "SampleItemBGCorner"
							SampleItemBGCorner.Parent = SampleItemBG
							SampleItemTitle.Name = "SampleItemTitle"
							SampleItemTitle.Parent = SampleItemBG
							SampleItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemTitle.BackgroundTransparency = 1.000
							SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
							SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
							SampleItemTitle.Font = Enum.Font.GothamBlack
							SampleItemTitle.Text = tostring(i)
							SampleItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemTitle.TextSize = 14.000
							SampleItemTitle.TextStrokeTransparency = 0.500
							SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
							SampleItemCheck.Name = "SampleItemCheck"
							SampleItemCheck.Parent = SampleItemBG
							SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
							SampleItemCheck.BackgroundTransparency = 1.000
							SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
							SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
							SampleItemCheck.ZIndex = 2
							SampleItemCheck.Image = "rbxassetid://3926305904"
							SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
							SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
							SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
							SampleItemCheck.ImageTransparency = v and 0 or 1
							SampleItemButton.Name = "SampleItemButton"
							SampleItemButton.Parent = SampleItem
							SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemButton.BackgroundTransparency = 1.000
							SampleItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
							SampleItemButton.BorderSizePixel = 0
							SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
							SampleItemButton.Font = Enum.Font.SourceSans
							SampleItemButton.TextColor3 = getgenv().UIColor["Text Color"]
							SampleItemButton.TextSize = 14.000
							SampleItemButton.TextTransparency = 1.000
							SampleItemButton.MouseEnter:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = .7
								}
										):Play()
							end)
							SampleItemButton.MouseLeave:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = 1
								}
										):Play()
							end)
							SampleItemButton.MouseButton1Click:Connect(function()
								v = not v
								TweenService:Create(
											SampleItemCheck,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									ImageTransparency = v and 0 or 1
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = v and .5 or 1
								}
										):Play()
								if Callback then
									Callback(i, v)
									ListNew[i] = v
								end
								if Search then
									Dropdowntitle.PlaceholderText = Title .. ': '
								else
									Dropdowntitle.Text = Title .. ': '
								end
							end)
						end
					elseif Slider then
						for i, v in pairs(ListNew) do
							local TitleText = tostring(v.Title) or ""
							local minValue = tonumber(v.Min) or 0
							local maxValue = tonumber(v.Max) or 100
							local Precise = v.Precise or false
							local DefaultValue = tonumber(v.Default) or minValue
							local SizeChia = 365;
							local SliderFrame = Instance.new("Frame")
							local SliderCorner = Instance.new("UICorner")
							local SliderBG = Instance.new("Frame")
							local SliderBGCorner = Instance.new("UICorner")
							local SliderTitle = Instance.new("TextLabel")
							local SliderBar = Instance.new("Frame")
							local SliderButton = Instance.new("TextButton")
							local SliderBarCorner = Instance.new("UICorner")
							local Bar = Instance.new("Frame")
							local BarCorner = Instance.new("UICorner")
							local Sliderboxframe = Instance.new("Frame")
							local Sliderbox = Instance.new("UICorner")
							local Sliderbox_2 = Instance.new("TextBox")
							SliderFrame.Name = string.lower(v['Title'])
							SliderFrame.Parent = ScrollContainer
							SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SliderFrame.BackgroundTransparency = 1.000
							SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
							SliderFrame.Size = UDim2.new(1, 0, 0, 50)
							SliderCorner.CornerRadius = UDim.new(0, 4)
							SliderCorner.Name = "SliderCorner"
							SliderCorner.Parent = SliderFrame
							SliderBG.Name = "Background1"
							SliderBG.Parent = SliderFrame
							SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SliderBG.Size = UDim2.new(1, -10, 1, 0)
							SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							SliderBGCorner.CornerRadius = UDim.new(0, 4)
							SliderBGCorner.Name = "SliderBGCorner"
							SliderBGCorner.Parent = SliderBG
							SliderTitle.Name = "TextColor"
							SliderTitle.Parent = SliderBG
							SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderTitle.BackgroundTransparency = 1.000
							SliderTitle.Position = UDim2.new(0, 10, 0, 0)
							SliderTitle.Size = UDim2.new(1, -10, 0, 25)
							SliderTitle.Font = Enum.Font.GothamBlack
							SliderTitle.Text = TitleText
							SliderTitle.TextSize = 14.000
							SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
							SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
							SliderBar.Name = "SliderBar"
							SliderBar.Parent = SliderFrame
							SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
							SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
							SliderBar.Size = UDim2.new(1, -20, 0, 6)
							SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							SliderButton.Name = "SliderButton "
							SliderButton.Parent = SliderBar
							SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.BackgroundTransparency = 1.000
							SliderButton.Size = UDim2.new(1, 0, 1, 0)
							SliderButton.Font = Enum.Font.GothamBold
							SliderButton.Text = ""
							SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.TextSize = 14.000
							SliderBarCorner.CornerRadius = UDim.new(1, 0)
							SliderBarCorner.Name = "SliderBarCorner"
							SliderBarCorner.Parent = SliderBar
							Bar.Name = "Bar"
							Bar.BorderSizePixel = 0
							Bar.Parent = SliderBar
							Bar.Size = UDim2.new(0, 0, 1, 0)
							Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
							BarCorner.CornerRadius = UDim.new(1, 0)
							BarCorner.Name = "BarCorner"
							BarCorner.Parent = Bar
							Sliderboxframe.Name = "Background2"
							Sliderboxframe.Parent = SliderFrame
							Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
							Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
							Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
							Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							Sliderbox.CornerRadius = UDim.new(0, 4)
							Sliderbox.Name = "Sliderbox"
							Sliderbox.Parent = Sliderboxframe
							Sliderbox_2.Name = "TextColor"
							Sliderbox_2.Parent = Sliderboxframe
							Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Sliderbox_2.BackgroundTransparency = 1.000
							Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
							Sliderbox_2.Font = Enum.Font.GothamBold
							Sliderbox_2.Text = ""
							Sliderbox_2.TextSize = 14.000
							Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
							SliderButton.MouseEnter:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
								}):Play()
							end)
							SliderButton.MouseLeave:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
								}):Play()
							end)
							local callBackAndSetText = function(val)
								Sliderbox_2.Text = val
								ListNew[i].Default = val
								Callback(i, v)
							end
							if DefaultValue then
								if DefaultValue <= minValue then
									DefaultValue = minValue
								elseif DefaultValue >= maxValue then
									DefaultValue = maxValue
								end
								Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
								callBackAndSetText(DefaultValue)
							end
							if SliderRelease then
								local dragging = false
								local dragInput
								local holdTime = 0
								local holdStarted = 0

								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick()
										
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0 
											end
										end)
									end
								end
										
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0 
									end
								end

								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									end
								end)
							else
								local dragging = false
								local dragInput
								local holdTime = 0 
								local holdStarted = 0

								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick()
										
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0
											end
										end)
									end
								end
										
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0 
									end
								end

								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									end
								end)
							end
							local function GetSliderValue(Value)
								if tonumber(Value) <= minValue then
									Bar.Size = UDim2.new(0, (0 * SizeChia), 0, 6)
									callBackAndSetText(minValue)
								elseif tonumber(Value) >= maxValue then
									Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SizeChia), 0, 6)
									callBackAndSetText(maxValue)
								else
									Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
									callBackAndSetText(Value)
								end
							end
							Sliderbox_2.FocusLost:Connect(function()
								GetSliderValue(Sliderbox_2.Text)
							end)
						end
					else
						for i, v in pairs (ListNew) do
							if typeof(v) == "string" then
								local SampleItem = Instance.new("Frame")
								local SampleItemCorner = Instance.new("UICorner")
								local SampleItemBG = Instance.new("Frame")
								local SampleItemBGCorner = Instance.new("UICorner")
								local SampleItemTitle = Instance.new("TextLabel")
								local SampleItemCheck = Instance.new("ImageButton")
								local SampleItemButton = Instance.new("TextButton")
								SampleItem.Name = string.lower(v)
								SampleItem.Parent = ScrollContainer
								SampleItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
								SampleItem.BackgroundTransparency = 1.000
								SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItem.LayoutOrder = 1
								SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
								SampleItem.Size = UDim2.new(1, 0, 0, 25)
								SampleItemCorner.CornerRadius = UDim.new(0, 4)
								SampleItemCorner.Name = "SampleItemCorner"
								SampleItemCorner.Parent = SampleItem
								SampleItemBG.Name = "SampleItemBG"
								SampleItemBG.Parent = SampleItem
								SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
								SampleItemBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemBG.BackgroundTransparency = 1
								SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
								SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
								SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
								SampleItemBGCorner.Name = "SampleItemBGCorner"
								SampleItemBGCorner.Parent = SampleItemBG
								SampleItemTitle.Name = "SampleItemTitle"
								SampleItemTitle.Parent = SampleItemBG
								SampleItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemTitle.BackgroundTransparency = 1.000
								SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
								SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
								SampleItemTitle.Font = Enum.Font.GothamBlack
								SampleItemTitle.Text = v
								SampleItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemTitle.TextSize = 14.000
								SampleItemTitle.TextStrokeTransparency = 0.500
								SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
								SampleItemCheck.Name = "SampleItemCheck"
								SampleItemCheck.Parent = SampleItemBG
								SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
								SampleItemCheck.BackgroundTransparency = 1.000
								SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
								SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
								SampleItemCheck.ZIndex = 2
								SampleItemCheck.Image = "rbxassetid://3926305904"
								SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
								SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
								SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
								SampleItemCheck.ImageTransparency = 1
								SampleItemButton.Name = "SampleItemButton"
								SampleItemButton.Parent = SampleItem
								SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemButton.BackgroundTransparency = 1.000
								SampleItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
								SampleItemButton.BorderSizePixel = 0
								SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
								SampleItemButton.Font = Enum.Font.SourceSans
								SampleItemButton.TextColor3 = getgenv().UIColor["Text Color"]
								SampleItemButton.TextSize = 14.000
								SampleItemButton.TextTransparency = 1.000
								SampleItemButton.MouseEnter:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .7
									}
											):Play()
								end)
								SampleItemButton.MouseLeave:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = 1
									}
											):Play()
								end)
								SampleItemButton.MouseButton1Click:Connect(function()
									if Search then
										Dropdowntitle.PlaceholderText = Title .. ': ' .. v or ""
										Sel.Value = v
									else
										Dropdowntitle.Text = Title .. ': ' .. v or ""
										Sel.Value = v
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .5
									}
											):Play()
									if Callback then
										Callback(v)
									end
									if Search then
										Dropdowntitle.Text = ""
									end
									refreshlist()
								end)
								if Sel.Value == v then
									SampleItemBG.BackgroundTransparency = .5;
									SampleItemBG.BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									SampleItem.LayoutOrder = 0
								end
							end
						end
					end
				end
				if Search then
					Dropdowntitle.Changed:Connect(function()
						edit()
						SearchDropdown()
					end)
				end
				if typeof(Default) ~= 'table' then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
				elseif Slider then
					Dropdowntitle.Text = ''
					Dropdowntitle.PlaceholderText = Title .. ': '
				elseif Selected then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
				DropdownButton.MouseButton1Click:Connect(function()
					refreshlist()
					isbusy = not isbusy
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
				end)
				local dropdownFunction = {
					rf = refreshlist
				}
				function dropdownFunction:ClearText(v)
					if not Selected then
						if Search then
							Dropdowntitle.PlaceholderText = Title .. ': ' .. (v or "")
						else
							Dropdowntitle.Text = Title .. ': ' .. (v or "")
						end
					else
						Dropdowntitle.Text = Title .. ': ' .. (v or "")
					end
				end
				function dropdownFunction:GetNewList(List)
					Sel.Value = ""
							--refreshlist()
					isbusy = false
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
					ListNew = {}
					ListNew = List
					refreshlist()
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
                function dropdownFunction:SetValue(value)
                    if not Selected then
                        if table.find(ListNew, value) then
                            Sel.Value = value
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': ' .. value
                            else
                                Dropdowntitle.Text = Title .. ': ' .. value
                            end
                            if Callback then
                                Callback(value)
                            end
                            refreshlist()
                        end
                    else
                        if ListNew[value] ~= nil then
                            ListNew[value] = true
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': '
                            else
                                Dropdowntitle.Text = Title .. ': '
                            end
                            if Callback then
                                Callback(value, true)
                            end
                            refreshlist()
                        end
                    end
                end
                
                function dropdownFunction:GetValue()
                    if not Selected then
                        return Sel.Value
                    else
                        local result = {}
                        for key, val in pairs(ListNew) do
                            if val == true then
                                table.insert(result, key)
                            end
                        end
                        return result
                    end
                end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName,
                    SetValue = dropdownFunction.SetValue, 
                    GetValue = dropdownFunction.GetValue 
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownFunction
			end

function sectionFunction:AddKeyBind(Setting, Callback)
    local TitleText = tostring(Setting.Title or Setting.Text) or ""
    local Default = Setting.Default or Setting.Key or "F"
    local Mode = Setting.Mode or "Toggle"
    local Callback = Setting.Callback or Callback or function() end
    
    local function GetKeyString(key)
        local keyStr = tostring(key)
        keyStr = keyStr:gsub("Enum.UserInputType.", "")
        keyStr = keyStr:gsub("Enum.KeyCode.", "")
        return keyStr
    end
    
    local CurrentKey = GetKeyString(Default)
    local CurrentMode = Mode
    local Picking = false
    local ToggleState = false
    local HoldActive = false
    
    local BindFrame = Instance.new("Frame")
    local BindCorner = Instance.new("UICorner")
    local BindBG = Instance.new("Frame")
    local ButtonCorner = Instance.new("UICorner")
    local BindButtonTitle = Instance.new("TextLabel")
    local BindCor = Instance.new("Frame")
    local ButtonCorner_2 = Instance.new("UICorner")
    local Bindkey = Instance.new("TextButton")
    
    BindFrame.Name = TitleText .. "bguvl"
    BindFrame.Parent = Section
    BindFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    BindFrame.BackgroundTransparency = 1.000
    BindFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
    BindFrame.Size = UDim2.new(1, 0, 0, 35)
    
    BindCorner.CornerRadius = UDim.new(0, 4)
    BindCorner.Name = "BindCorner"
    BindCorner.Parent = BindFrame
    
    BindBG.Name = "Background1"
    BindBG.Parent = BindFrame
    BindBG.AnchorPoint = Vector2.new(0.5, 0.5)
    BindBG.Position = UDim2.new(0.5, 0, 0.5, 0)
    BindBG.Size = UDim2.new(1, -10, 1, 0)
    BindBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
    BindBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
    
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Name = "ButtonCorner"
    ButtonCorner.Parent = BindBG
    
    BindButtonTitle.Name = "TextColor"
    BindButtonTitle.Parent = BindBG
    BindButtonTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    BindButtonTitle.BackgroundTransparency = 1.000
    BindButtonTitle.Position = UDim2.new(0, 10, 0, 0)
    BindButtonTitle.Size = UDim2.new(1, -10, 1, 0)
    BindButtonTitle.Font = Enum.Font.GothamBlack
    BindButtonTitle.Text = TitleText
    BindButtonTitle.TextSize = 14.000
    BindButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
    BindButtonTitle.TextColor3 = getgenv().UIColor["Text Color"]
    
    BindCor.Name = "Background2"
    BindCor.Parent = BindBG
    BindCor.AnchorPoint = Vector2.new(1, 0.5)
    BindCor.Position = UDim2.new(1, -5, 0.5, 0)
    BindCor.Size = UDim2.new(0, 150, 0, 25)
    BindCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
    
    ButtonCorner_2.CornerRadius = UDim.new(0, 4)
    ButtonCorner_2.Name = "ButtonCorner"
    ButtonCorner_2.Parent = BindCor
    
    Bindkey.Name = "Bindkey"
    Bindkey.Parent = BindCor
    Bindkey.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    Bindkey.BackgroundTransparency = 1.000
    Bindkey.Size = UDim2.new(1, 0, 1, 0)
    Bindkey.Font = Enum.Font.GothamBold
    Bindkey.Text = CurrentKey
    Bindkey.TextSize = 14.000
    Bindkey.TextColor3 = getgenv().UIColor["Text Color"]
    
    Bindkey.MouseButton1Click:Connect(function()
        if Picking then return end
        
        Picking = true
        Bindkey.Text = "..."
        
        task.wait(0.2)
        
        local Connection
        Connection = uis.InputBegan:Connect(function(input)
            if Picking then
                local Key
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    Key = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Key = "MouseLeft"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Key = "MouseRight"
                end
                
                if Key then
                    Picking = false
                    CurrentKey = Key
                    Bindkey.Text = Key
                    Connection:Disconnect()
                end
            end
        end)
    end)
    
    uis.InputBegan:Connect(function(input, gpe)
        if gpe or Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local pressedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            pressedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            pressedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            pressedKey = "MouseRight"
        end
        
        if pressedKey == CurrentKey then
            if CurrentMode == "Toggle" then
                ToggleState = not ToggleState
                pcall(Callback, ToggleState)
            elseif CurrentMode == "Hold" then
                HoldActive = true
                pcall(Callback, true)
            end
        end
    end)
    
    uis.InputEnded:Connect(function(input)
        if Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local releasedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            releasedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            releasedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            releasedKey = "MouseRight"
        end
        
        if releasedKey == CurrentKey and CurrentMode == "Hold" and HoldActive then
            HoldActive = false
            pcall(Callback, false)
        end
    end)
    
    local controlData = {
        Name = TitleText,
        Section = Section,
        Element = BindFrame,
        SectionName = Section_Name,
        TabName = Page_Name,
        TabButton = PageName
    }
    table.insert(getgenv().AllControls, controlData)
    
    local keybindFunction = {}
    
    function keybindFunction:Set(newKey)
        CurrentKey = GetKeyString(newKey)
        Bindkey.Text = CurrentKey
    end
    
    function keybindFunction:Get()
        return CurrentKey
    end
    
    function keybindFunction:SetMode(mode)
        if mode == "Hold" or mode == "Toggle" then
            CurrentMode = mode
            ToggleState = false
            HoldActive = false
        end
    end
    
    function keybindFunction:GetMode()
        return CurrentMode
    end
    
    function keybindFunction:GetState()
        if CurrentMode == "Toggle" then
            return ToggleState
        elseif CurrentMode == "Hold" then
            return HoldActive
        end
        return false
    end
    
    return keybindFunction
end
			function sectionFunction:AddInput(idk, Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local Desc = Setting.Desc or Setting.Description 
				local Placeholder = tostring(Setting.Placeholder) or ""
				local Default = Setting.Default or false
				local Number_Only = Setting.Numeric or false
				local Callback = Setting.Callback
				
				local BoxFrame = Instance.new("Frame")
				local BoxCorner = Instance.new("UICorner")
				local BoxBG = Instance.new("Frame")
				local ButtonCorner = Instance.new("UICorner")
				local Boxtitle = Instance.new("TextLabel")
				local BoxCor = Instance.new("Frame")
				local ButtonCorner_2 = Instance.new("UICorner")
				local Boxxx = Instance.new("TextBox")
				local Lineeeee = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				
				BoxFrame.Name = "BoxFrame"
				BoxFrame.Parent = Section
				BoxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				BoxFrame.BackgroundTransparency = 1.000
				
				if Desc and Desc ~= "" then
					BoxFrame.AutomaticSize = Enum.AutomaticSize.Y
					BoxFrame.Size = UDim2.new(1, 0, 0, 0)
				else
					BoxFrame.Size = UDim2.new(1, 0, 0, 40)
				end
				
				BoxCorner.CornerRadius = UDim.new(0, 4)
				BoxCorner.Name = "BoxCorner"
				BoxCorner.Parent = BoxFrame
				
				BoxBG.Name = "Background1"
				BoxBG.Parent = BoxFrame
				BoxBG.AnchorPoint = Vector2.new(0.5, 0.5)
				BoxBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				BoxBG.Size = UDim2.new(1, -10, 1, 0)
				BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				
				ButtonCorner.CornerRadius = UDim.new(0, 4)
				ButtonCorner.Name = "ButtonCorner"
				ButtonCorner.Parent = BoxBG
				
				Boxtitle.Name = "TextColor"
				Boxtitle.Parent = BoxBG
				Boxtitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Boxtitle.BackgroundTransparency = 1.000
				
				if Desc and Desc ~= "" then
					Boxtitle.Position = UDim2.new(0, 10, 0, 5)
					Boxtitle.Size = UDim2.new(1, -10, 0, 20)
				else
					Boxtitle.Position = UDim2.new(0, 10, 0, 0)
					Boxtitle.Size = UDim2.new(0.5, 0, 1, 0) 
				end
				
				Boxtitle.Font = Enum.Font.GothamBlack
				Boxtitle.Text = TitleText
				Boxtitle.TextSize = 14.000
				Boxtitle.TextXAlignment = Enum.TextXAlignment.Left
				Boxtitle.TextColor3 = getgenv().UIColor["Text Color"]
				
				if Desc and Desc ~= "" then
					local TextDesc = Instance.new("TextLabel")
					TextDesc.Parent = BoxBG
					TextDesc.BackgroundTransparency = 1
					TextDesc.Position = UDim2.new(0, 10, 0, 25)
					TextDesc.Size = UDim2.new(1, -20, 0, 0)
					TextDesc.AutomaticSize = Enum.AutomaticSize.Y
					TextDesc.Font = Enum.Font.Gotham
					TextDesc.Text = Desc
					TextDesc.TextColor3 = Color3.fromRGB(180, 180, 180)
					TextDesc.TextSize = 12
					TextDesc.TextWrapped = true
					TextDesc.TextXAlignment = Enum.TextXAlignment.Left
					
					local pad = Instance.new("UIPadding", BoxBG)
					pad.PaddingTop = UDim.new(0, 5)
					pad.PaddingBottom = UDim.new(0, 5)
				end
				
				BoxCor.Name = "Background2"
				BoxCor.Parent = BoxBG
				BoxCor.AnchorPoint = Vector2.new(1, 0.5)
				BoxCor.ClipsDescendants = true
				
				BoxCor.Position = UDim2.new(1, -5, 0.5, 0)
				BoxCor.Size = UDim2.new(0, 120, 0, 25)
				
				BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				
				ButtonCorner_2.CornerRadius = UDim.new(0, 4)
				ButtonCorner_2.Name = "ButtonCorner"
				ButtonCorner_2.Parent = BoxCor
				
				Boxxx.Name = "TextColorPlaceholder"
				Boxxx.Parent = BoxCor
				Boxxx.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Boxxx.BackgroundTransparency = 1.000
				Boxxx.Position = UDim2.new(0, 5, 0, 0)
				Boxxx.Size = UDim2.new(1, -5, 1, 0)
				Boxxx.Font = Enum.Font.GothamBold
				Boxxx.PlaceholderText = Placeholder
				Boxxx.Text = ""
				Boxxx.TextSize = 14.000
				Boxxx.TextXAlignment = Enum.TextXAlignment.Left
				Boxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
				Boxxx.TextColor3 = getgenv().UIColor["Text Color"]
				
				Lineeeee.Name = "TextNSBoxLineeeee"
				Lineeeee.Parent = BoxCor
				Lineeeee.BackgroundTransparency = 1.000
				Lineeeee.Position = UDim2.new(0, 0, 1, -2)
				Lineeeee.Size = UDim2.new(1, 0, 0, 6)
				Lineeeee.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
				
				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = Lineeeee
				
				Boxxx.Focused:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 0
					}):Play()
				end)
				
				if Number_Only then
					Boxxx:GetPropertyChangedSignal("Text"):Connect(function()
						if tonumber(Boxxx.Text) then
						else
							Boxxx.PlaceholderText = Placeholder
							Boxxx.Text = ''
						end
					end)
				end
				
				Boxxx.FocusLost:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 1
					}):Play()
					if Boxxx.Text ~= '' then
						Callback(Boxxx.Text)
					end
				end)
				
				local textbox_function = {}
				if Default then Boxxx.Text = Default end
				function textbox_function.SetValue(Value)
					Boxxx.Text = Value
					Callback(Value)
				end
				
				local controlData = {
					Name = TitleText,
					Section = Section,
					Element = BoxFrame,
					SectionName = Section_Name,
					TabName = Page_Name,
					TabButton = PageName
				}
				table.insert(getgenv().AllControls, controlData)
				return textbox_function
			end
			function sectionFunction:AddSlider(Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local minValue = tonumber(Setting.Min) or 0
				local maxValue = tonumber(Setting.Max) or 100
				local Precise = Setting.Precise or false
				local DefaultValue = tonumber(Setting.Default) or 0
				local Callback = Setting.Callback
				local SizeChia = 400;
                local SliderFrame = Instance.new("Frame")
				local SliderCorner = Instance.new("UICorner")
				local SliderBG = Instance.new("Frame")
				local SliderBGCorner = Instance.new("UICorner")
				local SliderTitle = Instance.new("TextLabel")
				local SliderBar = Instance.new("Frame")
				local SliderButton = Instance.new("TextButton")
				local SliderBarCorner = Instance.new("UICorner")
				local Bar = Instance.new("Frame")
				local BarCorner = Instance.new("UICorner")
				local Sliderboxframe = Instance.new("Frame")
				local Sliderbox = Instance.new("UICorner")
				local Sliderbox_2 = Instance.new("TextBox")
				SliderFrame.Name = TitleText .. 'buda'
				SliderFrame.Parent = Section
				SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				SliderFrame.BackgroundTransparency = 1.000
				SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
				SliderFrame.Size = UDim2.new(1, 0, 0, 50)
				SliderCorner.CornerRadius = UDim.new(0, 4)
				SliderCorner.Name = "SliderCorner"
				SliderCorner.Parent = SliderFrame
				SliderBG.Name = "Background1"
				SliderBG.Parent = SliderFrame
				SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				SliderBG.Size = UDim2.new(1, -10, 1, 0)
				SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				SliderBGCorner.CornerRadius = UDim.new(0, 4)
				SliderBGCorner.Name = "SliderBGCorner"
				SliderBGCorner.Parent = SliderBG
				SliderTitle.Name = "TextColor"
				SliderTitle.Parent = SliderBG
				SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				SliderTitle.BackgroundTransparency = 1.000
				SliderTitle.Position = UDim2.new(0, 10, 0, 0)
				SliderTitle.Size = UDim2.new(1, -10, 0, 25)
				SliderTitle.Font = Enum.Font.GothamBlack
				SliderTitle.Text = TitleText
				SliderTitle.TextSize = 14.000
				SliderTitle.RichText = true
				SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
				SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
				SliderBar.Name = "SliderBar"
				SliderBar.Parent = SliderFrame
				SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
				SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
				SliderBar.Size = UDim2.new(0, 400, 0, 6)
				SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				SliderButton.Name = "SliderButton "
				SliderButton.Parent = SliderBar
				SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				SliderButton.BackgroundTransparency = 1.000
				SliderButton.Size = UDim2.new(1, 0, 1, 0)
				SliderButton.Font = Enum.Font.GothamBold
				SliderButton.Text = ""
				SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
				SliderButton.TextSize = 14.000
				SliderBarCorner.CornerRadius = UDim.new(1, 0)
				SliderBarCorner.Name = "SliderBarCorner"
				SliderBarCorner.Parent = SliderBar
				Bar.Name = "Bar"
				Bar.BorderSizePixel = 0
				Bar.Parent = SliderBar
				Bar.Size = UDim2.new(0, 0, 1, 0)
				Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
				BarCorner.CornerRadius = UDim.new(1, 0)
				BarCorner.Name = "BarCorner"
				BarCorner.Parent = Bar
				Sliderboxframe.Name = "Background2"
				Sliderboxframe.Parent = SliderFrame
				Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
				Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
				Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
				Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				Sliderbox.CornerRadius = UDim.new(0, 4)
				Sliderbox.Name = "Sliderbox"
				Sliderbox.Parent = Sliderboxframe
				Sliderbox_2.Name = "TextColor"
				Sliderbox_2.Parent = Sliderboxframe
				Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Sliderbox_2.BackgroundTransparency = 1.000
				Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
				Sliderbox_2.Font = Enum.Font.GothamBold
				Sliderbox_2.Text = ""
				Sliderbox_2.TextSize = 14.000
				Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
				SliderButton.MouseEnter:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
					}):Play()
				end)
				SliderButton.MouseLeave:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
					}):Play()
				end)
				local callBackAndSetText = function(val)
					Sliderbox_2.Text = val
					Callback(tonumber(val))
				end
				if DefaultValue then
					if DefaultValue <= minValue then
						DefaultValue = minValue
					elseif DefaultValue >= maxValue then
						DefaultValue = maxValue
					end
					Sliderbox_2.Text = tostring(DefaultValue)
					Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
                    if Callback then
                        Callback(tonumber(DefaultValue))
                    end
				end
				local dragging = false
				local dragInput
				local holdTime = 0 
				local holdStarted = 0

				local function onInputBegan(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						holdStarted = tick() 
						
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
								holdStarted = 0 
							end
						end)
					end
				end
						
				local function onInputEnded(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
						holdStarted = 0 
					end
				end

				local function onInputChanged(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end
						
				SliderButton.InputBegan:Connect(onInputBegan)
				SliderButton.InputEnded:Connect(onInputEnded)
				SliderButton.InputChanged:Connect(onInputChanged)
						
				RunService.RenderStepped:Connect(function()
					if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
						dragging = true
					end
					if dragging and dragInput then
						local value = Setting.Rouding and  tonumber(string.format("%.".. Setting.Rouding or 1 .."f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
						pcall(function()
							callBackAndSetText(value)
						end)
						Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
					end
				end)
				local function GetSliderValue(Value)
					if tonumber(Value) <= minValue then
						Bar.Size = UDim2.new(0, (0 * SizeChia), 0, 6)
						callBackAndSetText(minValue)
					elseif tonumber(Value) >= maxValue then
						Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SizeChia), 0, 6)
						callBackAndSetText(maxValue)
					else
						Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
						callBackAndSetText(Value)
					end
				end
				Sliderbox_2.FocusLost:Connect(function()
					GetSliderValue(Sliderbox_2.Text)
				end)
				local slider_function = {}
				function slider_function.SetValue(Value)
					GetSliderValue(Value)
				end
				local controlData = {
                    Name = TitleText,
                    Section = Section,
                    Element = SliderFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return slider_function
			end
			function sectionFunction:AddSeperator(text)
				local SeparatorFrame = Instance.new("Frame")
				SeparatorFrame.Name = "Separator"
				SeparatorFrame.Parent = Section
				SeparatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SeparatorFrame.BackgroundTransparency = 1.000
				SeparatorFrame.Size = UDim2.new(1, 0, 0, 25)

				if text and text ~= "" then
					local SeparatorLabel = Instance.new("TextLabel")
					SeparatorLabel.Name = "Title"
					SeparatorLabel.Parent = SeparatorFrame
					SeparatorLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SeparatorLabel.BackgroundTransparency = 1.000
					SeparatorLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					SeparatorLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					SeparatorLabel.AutomaticSize = Enum.AutomaticSize.X
					SeparatorLabel.Size = UDim2.new(0, 0, 1, 0)
					SeparatorLabel.Font = Enum.Font.GothamBold
					SeparatorLabel.Text = text
					SeparatorLabel.TextColor3 = getgenv().UIColor["Section Text Color"]
					SeparatorLabel.TextSize = 14.000
					
					local LeftLine = Instance.new("Frame")
					LeftLine.Name = "LeftLine"
					LeftLine.Parent = SeparatorFrame
					LeftLine.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
					LeftLine.BorderSizePixel = 0
					LeftLine.AnchorPoint = Vector2.new(1, 0.5) 
					LeftLine.Position = UDim2.new(0.5, -5, 0.5, 0) 
					LeftLine.Size = UDim2.new(0.5, -10, 0, 1) 
					
					local LeftGradient = Instance.new("UIGradient")
					LeftGradient.Parent = LeftLine
					LeftGradient.Rotation = 180
					LeftGradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),  
						NumberSequenceKeypoint.new(1, 0.8) 
					}

					local RightLine = Instance.new("Frame")
					RightLine.Name = "RightLine"
					RightLine.Parent = SeparatorFrame
					RightLine.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
					RightLine.BorderSizePixel = 0
					RightLine.AnchorPoint = Vector2.new(0, 0.5)
					RightLine.Position = UDim2.new(0.5, 5, 0.5, 0)
					RightLine.Size = UDim2.new(0.5, -10, 0, 1)

					local RightGradient = Instance.new("UIGradient")
					RightGradient.Parent = RightLine
					RightGradient.Rotation = 0
					RightGradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(1, 0.8) 
					}

					local function UpdateSeparator()
						local textWidth = SeparatorLabel.TextBounds.X
						local padding = 8
						
						LeftLine.Size = UDim2.new(0.5, -(textWidth / 2) - padding, 0, 1)
						LeftLine.Position = UDim2.new(0.5, -(textWidth / 2) - padding, 0.5, 0)
						LeftLine.AnchorPoint = Vector2.new(1, 0.5)
						LeftLine.Position = UDim2.new(0.5, -(textWidth / 2) - padding, 0.5, 0)
						
						LeftLine.Size = UDim2.new(0.5, -(textWidth / 2) - padding, 0, 1)
						LeftLine.Position = UDim2.new(0, 0, 0.5, 0)
						LeftLine.AnchorPoint = Vector2.new(0, 0.5)

						RightLine.Size = UDim2.new(0.5, -(textWidth / 2) - padding, 0, 1)
						RightLine.Position = UDim2.new(1, 0, 0.5, 0) 
						RightLine.AnchorPoint = Vector2.new(1, 0.5)
					end

					SeparatorLabel:GetPropertyChangedSignal("TextBounds"):Connect(UpdateSeparator)
					UpdateSeparator()

				else
					local SeparatorLine = Instance.new("Frame")
					SeparatorLine.Name = "Line"
					SeparatorLine.Parent = SeparatorFrame
					SeparatorLine.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
					SeparatorLine.BorderSizePixel = 0
					SeparatorLine.Position = UDim2.new(0, 10, 0.5, 0)
					SeparatorLine.Size = UDim2.new(1, -20, 0, 1)
					
					local LineGradient = Instance.new("UIGradient")
					LineGradient.Parent = SeparatorLine
					LineGradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(0.2, 0),
						NumberSequenceKeypoint.new(0.8, 0),
						NumberSequenceKeypoint.new(1, 1)
					}
				end

				local controlData = {
					Name = text or "Separator",
					Section = Section,
					Element = SeparatorFrame,
					SectionName = Section_Name,
					TabName = Page_Name,
					TabButton = PageName
				}
				table.insert(getgenv().AllControls, controlData)
			end

			return sectionFunction
		end
        local pagefunc = {}
        function pagefunc:AddLeftGroupbox(name)
            return pageFunction:AddSection(name)
        end
        function pagefunc:AddRightGroupbox(name)
            return pageFunction:AddSection(name)
        end
		return pagefunc
        end

	return Main_Function
end

-- ==================== END OF BANANAHUB UI ====================

-- Now paste all the features from HAOMODHUB_VIP_.lua (excluding the old UI loading part)

-- Owner : HaoMod

hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function()
    -- empty block
end)
hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function()
    -- empty block
end)

-- Kiểm tra game Blox Fruits
if game.PlaceId == 85211729168715 or 2753915549 then
    World1 = true
    print("🌊 Sea 1 - First Sea")
elseif game.PlaceId == 79091703265657 or 4442272183 then
    World2 = true
    print("🌊 Sea 2 - Second Sea")
elseif game.PlaceId == 100117331123089 or 7449423635 then
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
                    elseif _G.SelectMaterial ~= "Mini Tusk" then
                        if _G.SelectMaterial == "Conjured Cocoa" then
                            MMon = "Chocolate Bar Battler"
                            MPos = CFrame.new(582.828674, 25.5824986, -12550.7041, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
                            SP = "Chocolate"
                        end
                    else
                        MMon = "Mythological Pirate"
                        MPos = CFrame.new(-13456.0498, 469.433228, -7039.96436, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                        SP = "BigMansion"
                    end
                elseif game.PlaceId == 2753915549 then
                    MMon = "Fishman Warrior"
                    MPos = CFrame.new(60943.9023, 17.9492188, 1744.11133, 0.826706648, 0, -0.562633216, 0, 1, 0, 0.562633216, 0, 0.826706648)
                    SP = "Underwater City"
                    MMon = "Fishman Commando"
                    MPos = CFrame.new(61760.8984, 18.0800781, 1460.11133, -0.632549644, 0, -0.774520278, 0, 1, 0, 0.774520278, 0, -0.632549644)
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
                MMon = "Military Spy"
                MPos = CFrame.new(-5806.70068, 78.5000458, 8904.46973, 0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, 0.707134247)
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
            MMon = "Brute"
            MPos = CFrame.new(-1191.41235, 15.5999985, 4235.50928, 0.629286051, 0, -0.777173758, 0, 1, 0, 0.777173758, 0, 0.629286051)
            SP = "Pirate"
        elseif game.PlaceId ~= 4442272183 then
            if game.PlaceId == 7449423635 then
                MMon = "Pirate Millionaire"
                MPos = CFrame.new(-118.809372, 55.4874573, 5649.17041, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                SP = "Default"
            end
        else
            MMon = "Mercenary"
            MPos = CFrame.new(-986.774475, 72.8755951, 1088.44653, -0.656062722, 0, 0.754706323, 0, 1, 0, -0.754706323, 0, -0.656062722)
            SP = "DressTown"
        end
    else
        MMon = "Factory Staff"
        MPos = CFrame.new(-105.889565, 72.8076935, -670.247986, -0.965929747, 0, -0.258804798, 0, 1, 0, 0.258804798, 0, -0.965929747)
        SP = "Bar"
    end
end

function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 or SelectMonster == "Bandit" then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, -0, 1, -0, 0.341998369, -0, 0.939700544)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif (MyLevel < 10 or MyLevel > 14) and SelectMonster ~= "Monkey" then
            if (MyLevel < 15 or MyLevel > 29) and SelectMonster ~= "Gorilla" then
                if (MyLevel < 30 or MyLevel > 39) and SelectMonster ~= "Pirate" then
                    if (MyLevel < 40 or MyLevel > 59) and SelectMonster ~= "Brute" then
                        if MyLevel >= 60 and MyLevel <= 74 or SelectMonster == "Desert Bandit" then
                            Mon = "Desert Bandit"
                            LevelQuest = 1
                            NameQuest = "DesertQuest"
                            NameMon = "Desert Bandit"
                            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
                        elseif (MyLevel < 75 or MyLevel > 89) and SelectMonster ~= "Desert Officer" then
                            if (MyLevel < 90 or MyLevel > 99) and SelectMonster ~= "Snow Bandit" then
                                if MyLevel >= 100 and MyLevel <= 119 or SelectMonster == "Snowman" then
                                    Mon = "Snowman"
                                    LevelQuest = 2
                                    NameQuest = "SnowQuest"
                                    NameMon = "Snowman"
                                    CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                                    CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
                                elseif (MyLevel < 120 or MyLevel > 149) and SelectMonster ~= "Chief Petty Officer" then
                                    if (MyLevel < 150 or MyLevel > 174) and SelectMonster ~= "Sky Bandit" then
                                        if (MyLevel < 175 or MyLevel > 189) and SelectMonster ~= "Dark Master" then
                                            if MyLevel >= 190 and MyLevel <= 209 or SelectMonster == "Prisoner" then
                                                Mon = "Prisoner"
                                                LevelQuest = 1
                                                NameQuest = "PrisonerQuest"
                                                NameMon = "Prisoner"
                                                CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918E-9, -0.995993316, 1.60817859E-9, 1, -5.16744869E-9, 0.995993316, -2.06384709E-9, -0.0894274712)
                                                CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
                                            elseif (MyLevel < 210 or MyLevel > 249) and SelectMonster ~= "Dangerous Prisone" then
                                                if MyLevel >= 250 and MyLevel <= 274 or SelectMonster == "Toga Warrior" then
                                                    Mon = "Toga Warrior"
                                                    LevelQuest = 1
                                                    NameQuest = "ColosseumQuest"
                                                    NameMon = "Toga Warrior"
                                                    CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                                                    CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
                                                elseif (MyLevel < 275 or MyLevel > 299) and SelectMonster ~= "Gladiator" then
                                                    if (MyLevel < 300 or MyLevel > 324) and SelectMonster ~= "Military Soldier" then
                                                        if (MyLevel < 325 or MyLevel > 374) and SelectMonster ~= "Military Spy" then
                                                            if (MyLevel < 375 or MyLevel > 399) and SelectMonster ~= "Fishman Warrior" then
                                                                if (MyLevel < 400 or MyLevel > 449) and SelectMonster ~= "Fishman Commando" then
                                                                    if MyLevel >= 450 and MyLevel <= 474 or SelectMonster == "God's Guard" then
                                                                        Mon = "God's Guard"
                                                                        LevelQuest = 1
                                                                        NameQuest = "SkyExp1Quest"
                                                                        NameMon = "God's Guard"
                                                                        CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, -0, 1, -0, 0.0871884301, -0, 0.996191859)
                                                                        CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
                                                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
                                                                        end
                                                                    elseif MyLevel >= 475 and MyLevel <= 524 or SelectMonster == "Shanda" then
                                                                        Mon = "Shanda"
                                                                        LevelQuest = 2
                                                                        NameQuest = "SkyExp1Quest"
                                                                        NameMon = "Shanda"
                                                                        CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, -0, 0.906319618, -0, 1, -0, -0.906319618, -0, -0.422592998)
                                                                        CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
                                                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                                                                        end
                                                                    elseif MyLevel >= 525 and MyLevel <= 549 or SelectMonster == "Royal Squad" then
                                                                        Mon = "Royal Squad"
                                                                        LevelQuest = 1
                                                                        NameQuest = "SkyExp2Quest"
                                                                        NameMon = "Royal Squad"
                                                                        CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                                        CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
                                                                    elseif (MyLevel < 550 or MyLevel > 624) and SelectMonster ~= "Royal Soldier" then
                                                                        if MyLevel >= 625 and MyLevel <= 649 or SelectMonster == "Galley Pirate" then
                                                                            Mon = "Galley Pirate"
                                                                            LevelQuest = 1
                                                                            NameQuest = "FountainQuest"
                                                                            NameMon = "Galley Pirate"
                                                                            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                                                                            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
                                                                        elseif MyLevel >= 650 or SelectMonster == "Galley Captain" then
                                                                            Mon = "Galley Captain"
                                                                            LevelQuest = 2
                                                                            NameQuest = "FountainQuest"
                                                                            NameMon = "Galley Captain"
                                                                            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                                                                            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
                                                                        end
                                                                    else
                                                                        Mon = "Royal Soldier"
                                                                        LevelQuest = 2
                                                                        NameQuest = "SkyExp2Quest"
                                                                        NameMon = "Royal Soldier"
                                                                        CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                                        CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
                                                                    end
                                                                else
                                                                    Mon = "Fishman Commando"
                                                                    LevelQuest = 2
                                                                    NameQuest = "FishmanQuest"
                                                                    NameMon = "Fishman Commando"
                                                                    CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                                                                    CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
                                                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                    end
                                                                end
                                                            else
                                                                Mon = "Fishman Warrior"
                                                                LevelQuest = 1
                                                                NameQuest = "FishmanQuest"
                                                                NameMon = "Fishman Warrior"
                                                                CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                                                                CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
                                                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                end
                                                            end
                                                        else
                                                            Mon = "Military Spy"
                                                            LevelQuest = 2
                                                            NameQuest = "MagmaQuest"
                                                            NameMon = "Military Spy"
                                                            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                                                            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
                                                        end
                                                    else
                                                        Mon = "Military Soldier"
                                                        LevelQuest = 1
                                                        NameQuest = "MagmaQuest"
                                                        NameMon = "Military Soldier"
                                                        CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                                                        CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
                                                    end
                                                else
                                                    Mon = "Gladiator"
                                                    LevelQuest = 2
                                                    NameQuest = "ColosseumQuest"
                                                    NameMon = "Gladiator"
                                                    CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                                                    CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
                                                end
                                            else
                                                Mon = "Dangerous Prisoner"
                                                LevelQuest = 2
                                                NameQuest = "PrisonerQuest"
                                                NameMon = "Dangerous Prisoner"
                                                CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918E-9, -0.995993316, 1.60817859E-9, 1, -5.16744869E-9, 0.995993316, -2.06384709E-9, -0.0894274712)
                                                CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
                                            end
                                        else
                                            Mon = "Dark Master"
                                            LevelQuest = 2
                                            NameQuest = "SkyQuest"
                                            NameMon = "Dark Master"
                                            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                                            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
                                        end
                                    else
                                        Mon = "Sky Bandit"
                                        LevelQuest = 1
                                        NameQuest = "SkyQuest"
                                        NameMon = "Sky Bandit"
                                        CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                                        CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
                                    end
                                else
                                    Mon = "Chief Petty Officer"
                                    LevelQuest = 1
                                    NameQuest = "MarineQuest2"
                                    NameMon = "Chief Petty Officer"
                                    CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                    CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
                                end
                            else
                                Mon = "Snow Bandit"
                                LevelQuest = 1
                                NameQuest = "SnowQuest"
                                NameMon = "Snow Bandit"
                                CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                                CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
                            end
                        else
                            Mon = "Desert Officer"
                            LevelQuest = 2
                            NameQuest = "DesertQuest"
                            NameMon = "Desert Officer"
                            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
                        end
                    else
                        Mon = "Brute"
                        LevelQuest = 2
                        NameQuest = "BuggyQuest1"
                        NameMon = "Brute"
                        CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                        CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
                    end
                else
                    Mon = "Pirate"
                    LevelQuest = 1
                    NameQuest = "BuggyQuest1"
                    NameMon = "Pirate"
                    CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                    CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
                end
            else
                Mon = "Gorilla"
                LevelQuest = 2
                NameQuest = "JungleQuest"
                NameMon = "Gorilla"
                CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
            end
        else
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, -0, -0, 1, -0, 1, -0, -1, -0, -0)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
        end
    elseif not World2 then
        if World3 then
            if MyLevel >= 1500 and MyLevel <= 1524 or SelectMonster == "Pirate Millionaire" then
                Mon = "Pirate Millionaire"
                LevelQuest = 1
                NameQuest = "PiratePortQuest"
                NameMon = "Pirate Millionaire"
                CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.957107544, -0, -0.289732844, -0, 1, -0, 0.289732844, -0, 0.957107544)
                CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
            elseif (MyLevel < 1525 or MyLevel > 1574) and SelectMonster ~= "Pistol Billionaire" then
                if MyLevel >= 1575 and MyLevel <= 1599 or SelectMonster == "Dragon Crew Warrior" then
                    Mon = "Dragon Crew Warrior"
                    LevelQuest = 1
                    NameQuest = "DragonCrewQuest"
                    NameMon = "Dragon Crew Warrior"
                    CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
                    CFrameMon = CFrame.new(6709.76367, 52.3442993, -1139.02966, -0.763515472, -0, 0.645789504, -0, 1, -0, -0.645789504, -0, -0.763515472)
                elseif MyLevel >= 1600 and MyLevel <= 1624 or SelectMonster == "Dragon Crew Archer" then
                    Mon = "Dragon Crew Archer"
                    NameQuest = "DragonCrewQuest"
                    LevelQuest = 2
                    NameMon = "Dragon Crew Archer"
                    CFrameQuest = CFrame.new(6750.4931640625, 127.44916534423828, -711.0308837890625)
                    CFrameMon = CFrame.new(6668.76172, 481.376923, 329.12207, -0.121787429, -0, -0.992556155, -0, 1, -0, 0.992556155, -0, -0.121787429)
                elseif (MyLevel < 1625 or MyLevel > 1649) and SelectMonster ~= "Hydra Enforcer" then
                    if (MyLevel < 1650 or MyLevel > 1699) and SelectMonster ~= "Venomous Assailant" then
                        if (MyLevel < 1700 or MyLevel > 1724) and SelectMonster ~= "Marine Commodore" then
                            if (MyLevel < 1725 or MyLevel > 1774) and SelectMonster ~= "Marine Rear Admiral" then
                                if (MyLevel < 1775 or MyLevel > 1799) and SelectMonster ~= "Fishman Raider" then
                                    if MyLevel >= 1800 and MyLevel <= 1824 or SelectMonster == "Fishman Captain" then
                                        Mon = "Fishman Captain"
                                        LevelQuest = 2
                                        NameQuest = "DeepForestIsland3"
                                        NameMon = "Fishman Captain"
                                        CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                                        CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
                                    elseif (MyLevel < 1825 or MyLevel > 1849) and SelectMonster ~= "Forest Pirate" then
                                        if (MyLevel < 1850 or MyLevel > 1899) and SelectMonster ~= "Mythological Pirate" then
                                            if MyLevel >= 1900 and MyLevel <= 1924 or SelectMonster == "Jungle Pirate" then
                                                Mon = "Jungle Pirate"
                                                LevelQuest = 1
                                                NameQuest = "DeepForestIsland2"
                                                NameMon = "Jungle Pirate"
                                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                                                CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
                                            elseif MyLevel >= 1925 and MyLevel <= 1974 or SelectMonster == "Musketeer Pirate" then
                                                Mon = "Musketeer Pirate"
                                                LevelQuest = 2
                                                NameQuest = "DeepForestIsland2"
                                                NameMon = "Musketeer Pirate"
                                                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                                                CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
                                            elseif MyLevel >= 1975 and MyLevel <= 1999 or SelectMonster == "Reborn Skeleton" then
                                                Mon = "Reborn Skeleton"
                                                LevelQuest = 1
                                                NameQuest = "HauntedQuest1"
                                                NameMon = "Reborn Skeleton"
                                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                                                CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
                                            elseif (MyLevel < 2000 or MyLevel > 2024) and SelectMonster ~= "Living Zombie" then
                                                if MyLevel >= 2025 and MyLevel <= 2049 or SelectMonster == "Demonic Soul" then
                                                    Mon = "Demonic Soul"
                                                    LevelQuest = 1
                                                    NameQuest = "HauntedQuest2"
                                                    NameMon = "Demonic Soul"
                                                    CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
                                                elseif MyLevel >= 2050 and MyLevel <= 2074 or SelectMonster == "Posessed Mummy" then
                                                    Mon = "Posessed Mummy"
                                                    LevelQuest = 2
                                                    NameQuest = "HauntedQuest2"
                                                    NameMon = "Posessed Mummy"
                                                    CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
                                                elseif (MyLevel < 2075 or MyLevel > 2099) and SelectMonster ~= "Peanut Scout" then
                                                    if MyLevel >= 2100 and MyLevel <= 2124 or SelectMonster == "Peanut President" then
                                                        Mon = "Peanut President"
                                                        LevelQuest = 2
                                                        NameQuest = "NutsIslandQuest"
                                                        NameMon = "Peanut President"
                                                        CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
                                                    elseif MyLevel >= 2125 and MyLevel <= 2149 or SelectMonster == "Ice Cream Chef" then
                                                        Mon = "Ice Cream Chef"
                                                        LevelQuest = 1
                                                        NameQuest = "IceCreamIslandQuest"
                                                        NameMon = "Ice Cream Chef"
                                                        CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
                                                    elseif MyLevel >= 2150 and MyLevel <= 2199 or SelectMonster == "Ice Cream Commander" then
                                                        Mon = "Ice Cream Commander"
                                                        LevelQuest = 2
                                                        NameQuest = "IceCreamIslandQuest"
                                                        NameMon = "Ice Cream Commander"
                                                        CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                        CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
                                                    elseif MyLevel >= 2200 and MyLevel <= 2224 or SelectMonster == "Cookie Crafter" then
                                                        Mon = "Cookie Crafter"
                                                        LevelQuest = 1
                                                        NameQuest = "CakeQuest1"
                                                        NameMon = "Cookie Crafter"
                                                        CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053E-8, 0.288177818, 6.9301187E-8, 1, 7.51931211E-8, -0.288177818, -5.2032135E-8, 0.957576931)
                                                        CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
                                                    elseif (MyLevel < 2225 or MyLevel > 2249) and SelectMonster ~= "Cake Guard" then
                                                        if MyLevel >= 2250 and MyLevel <= 2274 or SelectMonster == "Baking Staff" then
                                                            Mon = "Baking Staff"
                                                            LevelQuest = 1
                                                            NameQuest = "CakeQuest2"
                                                            NameMon = "Baking Staff"
                                                            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143E-8, 0.250778586, 4.74911062E-8, 1, 1.49904711E-8, -0.250778586, 2.64211941E-8, -0.96804446)
                                                            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
                                                        elseif MyLevel >= 2275 and MyLevel <= 2299 or SelectMonster == "Head Baker" then
                                                            Mon = "Head Baker"
                                                            LevelQuest = 2
                                                            NameQuest = "CakeQuest2"
                                                            NameMon = "Head Baker"
                                                            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143E-8, 0.250778586, 4.74911062E-8, 1, 1.49904711E-8, -0.250778586, 2.64211941E-8, -0.96804446)
                                                            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
                                                        elseif (MyLevel < 2300 or MyLevel > 2324) and SelectMonster ~= "Cocoa Warrior" then
                                                            if MyLevel >= 2325 and MyLevel <= 2349 or SelectMonster == "Chocolate Bar Battler" then
                                                                Mon = "Chocolate Bar Battler"
                                                                LevelQuest = 2
                                                                NameQuest = "ChocQuest1"
                                                                NameMon = "Chocolate Bar Battler"
                                                                CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
                                                                CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
                                                            elseif MyLevel >= 2350 and MyLevel <= 2374 or SelectMonster == "Sweet Thief" then
                                                                Mon = "Sweet Thief"
                                                                LevelQuest = 1
                                                                NameQuest = "ChocQuest2"
                                                                NameMon = "Sweet Thief"
                                                                CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
                                                                CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
                                                            elseif MyLevel >= 2375 and MyLevel <= 2399 or SelectMonster == "Candy Rebel" then
                                                                Mon = "Candy Rebel"
                                                                LevelQuest = 2
                                                                NameQuest = "ChocQuest2"
                                                                NameMon = "Candy Rebel"
                                                                CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
                                                                CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
                                                            elseif (MyLevel < 2400 or MyLevel > 2424) and SelectMonster ~= "Candy Pirate" then
                                                                if MyLevel >= 2425 and MyLevel <= 2449 or SelectMonster == "Snow Demon" then
                                                                    Mon = "Snow Demon"
                                                                    LevelQuest = 2
                                                                    NameQuest = "CandyQuest1"
                                                                    NameMon = "Snow Demon"
                                                                    CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
                                                                    CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
                                                                elseif MyLevel >= 2450 and MyLevel <= 2474 or SelectMonster == "Isle Outlaw" then
                                                                    Mon = "Isle Outlaw"
                                                                    LevelQuest = 1
                                                                    NameQuest = "TikiQuest1"
                                                                    NameMon = "Isle Outlaw"
                                                                    CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
                                                                    CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
                                                                elseif (MyLevel < 2475 or MyLevel > 2524) and SelectMonster ~= "Island Boy" then
                                                                    if MyLevel >= 2525 and MyLevel <= 2550 or SelectMonster == "Isle Champion" then
                                                                        Mon = "Isle Champion"
                                                                        LevelQuest = 2
                                                                        NameQuest = "TikiQuest2"
                                                                        NameMon = "Isle Champion"
                                                                        CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
                                                                        CFrameMon = CFrame.new(-16641.6796875, 235.7825469970703, 1031.282958984375)
                                                                    elseif (MyLevel < 2550 or MyLevel > 2574) and SelectMonster ~= "Serpent Hunter" then
                                                                        if MyLevel >= 2575 or SelectMonster == "Skull Slayer" then
                                                                            Mon = "Skull Slayer"
                                                                            LevelQuest = 2
                                                                            NameQuest = "TikiQuest3"
                                                                            NameMon = "Skull Slayer"
                                                                            CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, -0, 1, -0, 0.308980465, -0, 0.951068401)
                                                                            CFrameMon = CFrame.new(-16855.043, 122.457253, 1478.15308, -0.999392271, -0, -0.0348687991, -0, 1, -0, 0.0348687991, -0, -0.999392271)
                                                                        end
                                                                    else
                                                                        Mon = "Serpent Hunter"
                                                                        LevelQuest = 1
                                                                        NameQuest = "TikiQuest3"
                                                                        NameMon = "Serpent Hunter"
                                                                        CFrameQuest = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, -0, 1, -0, 0.308980465, -0, 0.951068401)
                                                                        CFrameMon = CFrame.new(-16521.0625, 106.09285, 1488.78467, 0.469467044, -0, 0.882950008, -0, 1, -0, -0.882950008, -0, 0.469467044)
                                                                    end
                                                                else
                                                                    Mon = "Island Boy"
                                                                    LevelQuest = 2
                                                                    NameQuest = "TikiQuest1"
                                                                    NameMon = "Island Boy"
                                                                    CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
                                                                    CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562)
                                                                end
                                                            else
                                                                Mon = "Candy Pirate"
                                                                LevelQuest = 1
                                                                NameQuest = "CandyQuest1"
                                                                NameMon = "Candy Pirate"
                                                                CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
                                                                CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
                                                            end
                                                        else
                                                            Mon = "Cocoa Warrior"
                                                            LevelQuest = 1
                                                            NameQuest = "ChocQuest1"
                                                            NameMon = "Cocoa Warrior"
                                                            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
                                                            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
                                                        end
                                                    else
                                                        Mon = "Cake Guard"
                                                        LevelQuest = 2
                                                        NameQuest = "CakeQuest1"
                                                        NameMon = "Cake Guard"
                                                        CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053E-8, 0.288177818, 6.9301187E-8, 1, 7.51931211E-8, -0.288177818, -5.2032135E-8, 0.957576931)
                                                        CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
                                                    end
                                                else
                                                    Mon = "Peanut Scout"
                                                    LevelQuest = 1
                                                    NameQuest = "NutsIslandQuest"
                                                    NameMon = "Peanut Scout"
                                                    CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                                                    CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
                                                end
                                            else
                                                Mon = "Living Zombie"
                                                LevelQuest = 2
                                                NameQuest = "HauntedQuest1"
                                                NameMon = "Living Zombie"
                                                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                                                CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
                                            end
                                        else
                                            Mon = "Mythological Pirate"
                                            LevelQuest = 2
                                            NameQuest = "DeepForestIsland"
                                            NameMon = "Mythological Pirate"
                                            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, -0, 1, -0, 0.707079291, -0, 0.707134247)
                                            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
                                        end
                                    else
                                        Mon = "Forest Pirate"
                                        LevelQuest = 1
                                        NameQuest = "DeepForestIsland"
                                        NameMon = "Forest Pirate"
                                        CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, -0, 1, -0, 0.707079291, -0, 0.707134247)
                                        CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
                                    end
                                else
                                    Mon = "Fishman Raider"
                                    LevelQuest = 1
                                    NameQuest = "DeepForestIsland3"
                                    NameMon = "Fishman Raider"
                                    CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                                    CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
                                end
                            else
                                Mon = "Marine Rear Admiral"
                                LevelQuest = 2
                                NameQuest = "MarineTreeIsland"
                                NameMon = "Marine Rear Admiral"
                                CFrameQuest = CFrame.new(2481.09228515625, 74.27049255371094, -6779.640625)
                                CFrameMon = CFrame.new(3761.81006, 123.912003, -6823.52197, 0.961273968, -0, 0.275594592, -0, 1, -0, -0.275594592, -0, 0.961273968)
                            end
                        else
                            Mon = "Marine Commodore"
                            LevelQuest = 1
                            NameQuest = "MarineTreeIsland"
                            NameMon = "Marine Commodore"
                            CFrameQuest = CFrame.new(2481.09228515625, 74.27049255371094, -6779.640625)
                            CFrameMon = CFrame.new(2577.25391, 75.6100006, -7739.87207, 0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, 0.499959469)
                        end
                    else
                        Mon = "Venomous Assailant"
                        NameQuest = "VenomCrewQuest"
                        LevelQuest = 2
                        NameMon = "Venomous Assailant"
                        CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
                        CFrameMon = CFrame.new(4674.92676, 1134.82654, 996.308838, 0.731321394, -0, -0.682033002, -0, 1, -0, 0.682033002, -0, 0.731321394)
                    end
                else
                    Mon = "Hydra Enforcer"
                    NameQuest = "VenomCrewQuest"
                    LevelQuest = 1
                    NameMon = "Hydra Enforcer"
                    CFrameQuest = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
                    CFrameMon = CFrame.new(4547.11523, 1003.10217, 334.194824, 0.388810456, -0, -0.921317935, -0, 1, -0, 0.921317935, -0, 0.388810456)
                end
            else
                Mon = "Pistol Billionaire"
                LevelQuest = 2
                NameQuest = "PiratePortQuest"
                NameMon = "Pistol Billionaire"
                CFrameQuest = CFrame.new(-450.104645, 107.681458, 5950.72607, 0.957107544, -0, -0.289732844, -0, 1, -0, 0.289732844, -0, 0.957107544)
                CFrameMon = CFrame.new(-54.8110352, 83.7698746, 5947.84082, -0.965929747, -0, 0.258804798, -0, 1, -0, -0.258804798, -0, -0.965929747)
            end
        end
    elseif (MyLevel < 700 or MyLevel > 724) and SelectMonster ~= "Raider" then
        if MyLevel >= 725 and MyLevel <= 774 or SelectMonster == "Mercenary" then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, -0, -0.974368095, -0, 1, -0, 0.974368095, -0, -0.22495985)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel >= 775 and MyLevel <= 799 or SelectMonster == "Swan Pirate" then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, -0, 0.99026376, -0, 1, -0, -0.99026376, -0, 0.139203906)
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif (MyLevel < 800 or MyLevel > 874) and SelectMonster ~= "Factory Staff" then
            if MyLevel >= 875 and MyLevel <= 899 or SelectMonster == "Marine Lieutenant" then
                Mon = "Marine Lieutenant"
                LevelQuest = 1
                NameQuest = "MarineQuest3"
                NameMon = "Marine Lieutenant"
                CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
            elseif MyLevel >= 900 and MyLevel <= 949 or SelectMonster == "Marine Captain" then
                Mon = "Marine Captain"
                LevelQuest = 2
                NameQuest = "MarineQuest3"
                NameMon = "Marine Captain"
                CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
            elseif (MyLevel < 950 or MyLevel > 974) and SelectMonster ~= "Zombie" then
                if MyLevel >= 975 and MyLevel <= 999 or SelectMonster == "Vampire" then
                    Mon = "Vampire"
                    LevelQuest = 2
                    NameQuest = "ZombieQuest"
                    NameMon = "Vampire"
                    CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, -0, -0.95628953, -0, 1, -0, 0.95628953, -0, -0.29242146)
                    CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
                elseif (MyLevel < 1000 or MyLevel > 1049) and SelectMonster ~= "Snow Trooper" then
                    if MyLevel >= 1050 and MyLevel <= 1099 or SelectMonster == "Winter Warrior" then
                        Mon = "Winter Warrior"
                        LevelQuest = 2
                        NameQuest = "SnowMountainQuest"
                        NameMon = "Winter Warrior"
                        CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, -0, 0.92718488, -0, 1, -0, -0.92718488, -0, -0.374604106)
                        CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
                    elseif MyLevel >= 1100 and MyLevel <= 1124 or SelectMonster == "Lab Subordinate" then
                        Mon = "Lab Subordinate"
                        LevelQuest = 1
                        NameQuest = "IceSideQuest"
                        NameMon = "Lab Subordinate"
                        CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, -0, 1, -0, 0.891015649, -0, 0.453972578)
                        CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
                    elseif MyLevel >= 1125 and MyLevel <= 1174 or SelectMonster == "Horned Warrior" then
                        Mon = "Horned Warrior"
                        LevelQuest = 2
                        NameQuest = "IceSideQuest"
                        NameMon = "Horned Warrior"
                        CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, -0, 1, -0, 0.891015649, -0, 0.453972578)
                        CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
                    elseif (MyLevel < 1175 or MyLevel > 1199) and SelectMonster ~= "Magma Ninja" then
                        if (MyLevel < 1200 or MyLevel > 1249) and SelectMonster ~= "Lava Pirate" then
                            if MyLevel >= 1250 and MyLevel <= 1274 or SelectMonster == "Ship Deckhand" then
                                Mon = "Ship Deckhand"
                                LevelQuest = 1
                                NameQuest = "ShipQuest1"
                                NameMon = "Ship Deckhand"
                                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
                                CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            elseif (MyLevel < 1275 or MyLevel > 1299) and SelectMonster ~= "Ship Engineer" then
                                if MyLevel >= 1300 and MyLevel <= 1324 or SelectMonster == "Ship Steward" then
                                    Mon = "Ship Steward"
                                    LevelQuest = 1
                                    NameQuest = "ShipQuest2"
                                    NameMon = "Ship Steward"
                                    CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
                                    CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)
                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                    end
                                elseif (MyLevel < 1325 or MyLevel > 1349) and SelectMonster ~= "Ship Officer" then
                                    if (MyLevel < 1350 or MyLevel > 1374) and SelectMonster ~= "Arctic Warrior" then
                                        if MyLevel >= 1375 and MyLevel <= 1424 or SelectMonster == "Snow Lurker" then
                                            Mon = "Snow Lurker"
                                            LevelQuest = 2
                                            NameQuest = "FrostQuest"
                                            NameMon = "Snow Lurker"
                                            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, -0, -0.358349502, -0, 1, -0, 0.358349502, -0, -0.933587909)
                                            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
                                        elseif (MyLevel < 1425 or MyLevel > 1449) and SelectMonster ~= "Sea Soldier" then
                                            if MyLevel >= 1450 or SelectMonster == "Water Fighter" then
                                                Mon = "Water Fighter"
                                                LevelQuest = 2
                                                NameQuest = "ForgottenQuest"
                                                NameMon = "Water Fighter"
                                                CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, -0, 1, -0, 0.13915664, -0, 0.990270376)
                                                CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
                                            end
                                        else
                                            Mon = "Sea Soldier"
                                            LevelQuest = 1
                                            NameQuest = "ForgottenQuest"
                                            NameMon = "Sea Soldier"
                                            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, -0, 1, -0, 0.13915664, -0, 0.990270376)
                                            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
                                        end
                                    else
                                        Mon = "Arctic Warrior"
                                        LevelQuest = 1
                                        NameQuest = "FrostQuest"
                                        NameMon = "Arctic Warrior"
                                        CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, -0, -0.358349502, -0, 1, -0, 0.358349502, -0, -0.933587909)
                                        CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
                                        if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422))
                                        end
                                    end
                                else
                                    Mon = "Ship Officer"
                                    LevelQuest = 2
                                    NameQuest = "ShipQuest2"
                                    NameMon = "Ship Officer"
                                    CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
                                    CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
                                    if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                    end
                                end
                            else
                                Mon = "Ship Engineer"
                                LevelQuest = 2
                                NameQuest = "ShipQuest1"
                                NameMon = "Ship Engineer"
                                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
                                CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
                                if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                                end
                            end
                        else
                            Mon = "Lava Pirate"
                            LevelQuest = 2
                            NameQuest = "FireSideQuest"
                            NameMon = "Lava Pirate"
                            CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                            CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
                        end
                    else
                        Mon = "Magma Ninja"
                        LevelQuest = 1
                        NameQuest = "FireSideQuest"
                        NameMon = "Magma Ninja"
                        CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                        CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
                    end
                else
                    Mon = "Snow Trooper"
                    LevelQuest = 1
                    NameQuest = "SnowMountainQuest"
                    NameMon = "Snow Trooper"
                    CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, -0, 0.92718488, -0, 1, -0, -0.92718488, -0, -0.374604106)
                    CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
                end
            else
                Mon = "Zombie"
                LevelQuest = 1
                NameQuest = "ZombieQuest"
                NameMon = "Zombie"
                CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, -0, -0.95628953, -0, 1, -0, 0.95628953, -0, -0.29242146)
                CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
            end
        else
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881E-10, -0.999488771, 1.36326533E-10, 1, 8.92172336E-10, 0.999488771, -1.07732087E-10, -0.0319722369)
            CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
        end
    else
        Mon = "Raider"
        LevelQuest = 1
        NameQuest = "Area1Quest"
        NameMon = "Raider"
        CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, -0, -0.974368095, -0, 1, -0, 0.974368095, -0, -0.22495985)
        CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
    end
end

function Hop()
    local l_PlaceId_0 = game.PlaceId
    local v1 = {}
    local v2 = ""
    local l_hour_0 = os.date("!*t").hour
    local _ = false
    function TPReturner()
        local v5
        if v2 ~= "" then
            v5 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. l_PlaceId_0 .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. v2))
        else
            v5 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. l_PlaceId_0 .. "/servers/Public?sortOrder=Asc&limit=100"))
        end
        local v6 = ""
        if v5.nextPageCursor and v5.nextPageCursor ~= "null" and v5.nextPageCursor ~= "null" then
            v2 = v5.nextPageCursor
        end
        local v7 = 0
        for _, v9 in pairs(v5.data) do
            local v10 = true
            v6 = tostring(v9.id)
            if tonumber(v9.maxPlayers) > tonumber(v9.playing) then
                for _, v12 in pairs(v1) do
                    if v7 ~= 0 then
                        if v6 == tostring(v12) then
                            v10 = false
                        end
                    elseif tonumber(l_hour_0) ~= tonumber(v12) then
                        local _ = pcall(function()
                            v1 = {}
                            table.insert(v1, l_hour_0)
                        end)
                    end
                    v7 = v7 + 1
                end
                if v10 == true then
                    table.insert(v1, v6)
                    wait(0.1)
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(l_PlaceId_0, v6, game.Players.LocalPlayer)
                    end)
                    wait(0.1)
                end
            end
        end
    end
    function Teleport()
        while wait(0.1) do
            pcall(function()
                TPReturner()
                if v2 ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end

function CheckItem(v14)
    for _, v16 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if v16.Name == v14 then
            return v16
        end
    end
end

function UpdateIslandESP()
    for _, v18 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v18_0 = v18
            pcall(function()
                if IslandESP then
                    if l_v18_0.Name ~= "Sea" then
                        if not l_v18_0:FindFirstChild("NameEsp") then
                            local v20 = Instance.new("BillboardGui", l_v18_0)
                            v20.Name = "NameEsp"
                            v20.ExtentsOffset = Vector3.new(0, 1, 0)
                            v20.Size = UDim2.new(1, 200, 1, 30)
                            v20.Adornee = l_v18_0
                            v20.AlwaysOnTop = true
                            local v21 = Instance.new("TextLabel", v20)
                            v21.Font = "GothamSemibold"
                            v21.FontSize = "Size14"
                            v21.TextWrapped = true
                            v21.Size = UDim2.new(1, 0, 1, 0)
                            v21.TextYAlignment = "Top"
                            v21.BackgroundTransparency = 1
                            v21.TextStrokeTransparency = 0.5
                            v21.TextColor3 = Color3.fromRGB(255, 255, 255)
                        else
                            l_v18_0.NameEsp.TextLabel.Text = l_v18_0.Name .. "   \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v18_0.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v18_0:FindFirstChild("NameEsp") then
                    l_v18_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end

function isnil(v22)
    local v23 = nil
    if v22 ~= v23 then
        local _ = false
    end
    return true
end

local function v26(v25)
    return math.floor(tonumber(v25) + 0.5)
end

Number = math.random(1, 1000000)

function UpdatePlayerChams()
    for _, v28 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v28_0 = v28
            pcall(function()
                if not isnil(l_v28_0.Character) then
                    if not ESPPlayer then
                        if l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif not isnil(l_v28_0.Character.Head) and not l_v28_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        local v30 = Instance.new("BillboardGui", l_v28_0.Character.Head)
                        v30.Name = "NameEsp" .. Number
                        v30.ExtentsOffset = Vector3.new(0, 1, 0)
                        v30.Size = UDim2.new(1, 200, 1, 30)
                        v30.Adornee = l_v28_0.Character.Head
                        v30.AlwaysOnTop = true
                        local v31 = Instance.new("TextLabel", v30)
                        v31.Font = Enum.Font.GothamSemibold
                        v31.FontSize = "Size14"
                        v31.TextWrapped = true
                        v31.Text = l_v28_0.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v28_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v31.Size = UDim2.new(1, 0, 1, 0)
                        v31.TextYAlignment = "Top"
                        v31.BackgroundTransparency = 1
                        v31.TextStrokeTransparency = 0.5
                        if l_v28_0.Team == game.Players.LocalPlayer.Team then
                            v31.TextColor3 = Color3.new(0, 255, 0)
                        else
                            v31.TextColor3 = Color3.new(255, 0, 0)
                        end
                    else
                        l_v28_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v28_0.Name .. " | " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v28_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v26(l_v28_0.Character.Humanoid.Health * 100 / l_v28_0.Character.Humanoid.MaxHealth) .. "%"
                    end
                end
            end)
        end
    end
end

function UpdateChestESP()
    for _, v33 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v33_0 = v33
            pcall(function()
                if _G.ChestESP then
                    if not l_v33_0:GetAttribute("IsDisabled") then
                        if not l_v33_0:FindFirstChild("ChestEsp") then
                            local v35 = Instance.new("BillboardGui", l_v33_0)
                            v35.Name = "ChestEsp"
                            v35.ExtentsOffset = Vector3.new(0, 1, 0)
                            v35.Size = UDim2.new(1, 200, 1, 30)
                            v35.Adornee = l_v33_0
                            v35.AlwaysOnTop = true
                            local v36 = Instance.new("TextLabel", v35)
                            v36.Font = "Code"
                            v36.FontSize = "Size14"
                            v36.TextWrapped = true
                            v36.Size = UDim2.new(1, 0, 1, 0)
                            v36.TextYAlignment = "Top"
                            v36.BackgroundTransparency = 1
                            v36.TextStrokeTransparency = 0.5
                            v36.TextColor3 = Color3.fromRGB(255, 215, 0)
                        else
                            local v37 = v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v33_0:GetPivot().Position).Magnitude / 3)
                            l_v33_0.ChestEsp.TextLabel.Text = "Chest\n" .. v37 .. " M"
                        end
                    end
                elseif l_v33_0:FindFirstChild("ChestEsp") then
                    l_v33_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end

function v26(v38)
    return math.floor(v38 + 0.5)
end

function UpdateDevilChams()
    for _, v40 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v40_0 = v40
            pcall(function()
                if DevilFruitESP then
                    if string.find(l_v40_0.Name, "Fruit") then
                        if not l_v40_0.Handle:FindFirstChild("NameEsp" .. Number) then
                            local v42 = Instance.new("BillboardGui", l_v40_0.Handle)
                            v42.Name = "NameEsp" .. Number
                            v42.ExtentsOffset = Vector3.new(0, 1, 0)
                            v42.Size = UDim2.new(1, 200, 1, 30)
                            v42.Adornee = l_v40_0.Handle
                            v42.AlwaysOnTop = true
                            local v43 = Instance.new("TextLabel", v42)
                            v43.Font = Enum.Font.GothamSemibold
                            v43.FontSize = "Size14"
                            v43.TextWrapped = true
                            v43.Size = UDim2.new(1, 0, 1, 0)
                            v43.TextYAlignment = "Top"
                            v43.BackgroundTransparency = 1
                            v43.TextStrokeTransparency = 0.5
                            v43.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v43.Text = l_v40_0.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v40_0.Handle.Position).Magnitude / 3) .. " Distance"
                        else
                            l_v40_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v40_0.Name .. "   \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v40_0.Handle.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v40_0.Handle:FindFirstChild("NameEsp" .. Number) then
                    l_v40_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end)
        end
    end
end

function UpdateFlowerChams()
    for _, v45 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v45_0 = v45
            pcall(function()
                if l_v45_0.Name == "Flower2" or l_v45_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v45_0:FindFirstChild("NameEsp" .. Number) then
                            l_v45_0["NameEsp" .. Number].TextLabel.Text = l_v45_0.Name .. "   \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v47 = Instance.new("BillboardGui", l_v45_0)
                            v47.Name = "NameEsp" .. Number
                            v47.ExtentsOffset = Vector3.new(0, 1, 0)
                            v47.Size = UDim2.new(1, 200, 1, 30)
                            v47.Adornee = l_v45_0
                            v47.AlwaysOnTop = true
                            local v48 = Instance.new("TextLabel", v47)
                            v48.Font = Enum.Font.GothamSemibold
                            v48.FontSize = "Size14"
                            v48.TextWrapped = true
                            v48.Size = UDim2.new(1, 0, 1, 0)
                            v48.TextYAlignment = "Top"
                            v48.BackgroundTransparency = 1
                            v48.TextStrokeTransparency = 0.5
                            v48.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v45_0.Name == "Flower1" then
                                v48.Text = "Blue Flower" .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                                v48.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v45_0.Name == "Flower2" then
                                v48.Text = "Red Flower" .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v45_0.Position).Magnitude / 3) .. " Distance"
                                v48.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v45_0:FindFirstChild("NameEsp" .. Number) then
                        l_v45_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end

function UpdateRealFruitChams()
    for _, v50 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v50:IsA("Tool") then
            if not RealFruitESP then
                if v50.Handle:FindFirstChild("NameEsp" .. Number) then
                    v50.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v50.Handle:FindFirstChild("NameEsp" .. Number) then
                v50.Handle["NameEsp" .. Number].TextLabel.Text = v50.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
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
