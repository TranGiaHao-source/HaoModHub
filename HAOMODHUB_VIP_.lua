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
                v52.TextColor3 = Color3.fromRGB(255, 0, 0)
                v52.Text = v50.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v54 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v54:IsA("Tool") then
            if RealFruitESP then
                if v54.Handle:FindFirstChild("NameEsp" .. Number) then
                    v54.Handle["NameEsp" .. Number].TextLabel.Text = v54.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v54.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v55 = Instance.new("BillboardGui", v54.Handle)
                    v55.Name = "NameEsp" .. Number
                    v55.ExtentsOffset = Vector3.new(0, 1, 0)
                    v55.Size = UDim2.new(1, 200, 1, 30)
                    v55.Adornee = v54.Handle
                    v55.AlwaysOnTop = true
                    local v56 = Instance.new("TextLabel", v55)
                    v56.Font = Enum.Font.GothamSemibold
                    v56.FontSize = "Size14"
                    v56.TextWrapped = true
                    v56.Size = UDim2.new(1, 0, 1, 0)
                    v56.TextYAlignment = "Top"
                    v56.BackgroundTransparency = 1
                    v56.TextStrokeTransparency = 0.5
                    v56.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v56.Text = v54.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v54.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v54.Handle:FindFirstChild("NameEsp" .. Number) then
                v54.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v58 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v58:IsA("Tool") then
            if RealFruitESP then
                if not v58.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v59 = Instance.new("BillboardGui", v58.Handle)
                    v59.Name = "NameEsp" .. Number
                    v59.ExtentsOffset = Vector3.new(0, 1, 0)
                    v59.Size = UDim2.new(1, 200, 1, 30)
                    v59.Adornee = v58.Handle
                    v59.AlwaysOnTop = true
                    local v60 = Instance.new("TextLabel", v59)
                    v60.Font = Enum.Font.GothamSemibold
                    v60.FontSize = "Size14"
                    v60.TextWrapped = true
                    v60.Size = UDim2.new(1, 0, 1, 0)
                    v60.TextYAlignment = "Top"
                    v60.BackgroundTransparency = 1
                    v60.TextStrokeTransparency = 0.5
                    v60.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v60.Text = v58.Name .. " \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v58.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v58.Handle["NameEsp" .. Number].TextLabel.Text = v58.Name .. " " .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - v58.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v58.Handle:FindFirstChild("NameEsp" .. Number) then
                v58.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end

function UpdateIslandESP()
    for _, v62 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v62_0 = v62
            pcall(function()
                if IslandESP then
                    if l_v62_0.Name ~= "Sea" then
                        if not l_v62_0:FindFirstChild("NameEsp") then
                            local v64 = Instance.new("BillboardGui", l_v62_0)
                            v64.Name = "NameEsp"
                            v64.ExtentsOffset = Vector3.new(0, 1, 0)
                            v64.Size = UDim2.new(1, 200, 1, 30)
                            v64.Adornee = l_v62_0
                            v64.AlwaysOnTop = true
                            local v65 = Instance.new("TextLabel", v64)
                            v65.Font = "GothamSemibold"
                            v65.FontSize = "Size14"
                            v65.TextWrapped = true
                            v65.Size = UDim2.new(1, 0, 1, 0)
                            v65.TextYAlignment = "Top"
                            v65.BackgroundTransparency = 1
                            v65.TextStrokeTransparency = 0.5
                            v65.TextColor3 = Color3.fromRGB(8, 247, 255)
                        else
                            l_v62_0.NameEsp.TextLabel.Text = l_v62_0.Name .. "   \n" .. v26((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v62_0.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v62_0:FindFirstChild("NameEsp") then
                    l_v62_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end

function isnil(v66)
    local v67 = nil
    if v66 ~= v67 then
        local _ = false
    end
    return true
end

local function v70(v69)
    return math.floor(tonumber(v69) + 0.5)
end

Number = math.random(1, 1000000)

function UpdatePlayerChams()
    for _, v72 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v72_0 = v72
            pcall(function()
                if not isnil(l_v72_0.Character) then
                    if ESPPlayer then
                        if not isnil(l_v72_0.Character.Head) and not l_v72_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            local v74 = Instance.new("BillboardGui", l_v72_0.Character.Head)
                            v74.Name = "NameEsp" .. Number
                            v74.ExtentsOffset = Vector3.new(0, 1, 0)
                            v74.Size = UDim2.new(1, 200, 1, 30)
                            v74.Adornee = l_v72_0.Character.Head
                            v74.AlwaysOnTop = true
                            local v75 = Instance.new("TextLabel", v74)
                            v75.Font = Enum.Font.GothamSemibold
                            v75.FontSize = "Size14"
                            v75.TextWrapped = true
                            v75.Text = l_v72_0.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v72_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v75.Size = UDim2.new(1, 0, 1, 0)
                            v75.TextYAlignment = "Top"
                            v75.BackgroundTransparency = 1
                            v75.TextStrokeTransparency = 0.5
                            if l_v72_0.Team == game.Players.LocalPlayer.Team then
                                v75.TextColor3 = Color3.new(0, 255, 0)
                            else
                                v75.TextColor3 = Color3.new(255, 0, 0)
                            end
                        else
                            l_v72_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v72_0.Name .. " | " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v72_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v70(l_v72_0.Character.Humanoid.Health * 100 / l_v72_0.Character.Humanoid.MaxHealth) .. "%"
                        end
                    elseif l_v72_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v72_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end

function UpdateChestESP()
    for _, v77 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v77_0 = v77
            pcall(function()
                if _G.ChestESP then
                    if not l_v77_0:GetAttribute("IsDisabled") then
                        if l_v77_0:FindFirstChild("ChestEsp") then
                            local v79 = v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v77_0:GetPivot().Position).Magnitude / 3)
                            l_v77_0.ChestEsp.TextLabel.Text = "Chest\n" .. v79 .. " M"
                        else
                            local v80 = Instance.new("BillboardGui", l_v77_0)
                            v80.Name = "ChestEsp"
                            v80.ExtentsOffset = Vector3.new(0, 1, 0)
                            v80.Size = UDim2.new(1, 200, 1, 30)
                            v80.Adornee = l_v77_0
                            v80.AlwaysOnTop = true
                            local v81 = Instance.new("TextLabel", v80)
                            v81.Font = "Code"
                            v81.FontSize = "Size14"
                            v81.TextWrapped = true
                            v81.Size = UDim2.new(1, 0, 1, 0)
                            v81.TextYAlignment = "Top"
                            v81.BackgroundTransparency = 1
                            v81.TextStrokeTransparency = 0.5
                            v81.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v77_0:FindFirstChild("ChestEsp") then
                    l_v77_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end

function v70(v82)
    return math.floor(v82 + 0.5)
end

function UpdateDevilChams()
    for _, v84 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v84_0 = v84
            pcall(function()
                if not DevilFruitESP then
                    if l_v84_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v84_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v84_0.Name, "Fruit") then
                    if l_v84_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v84_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v84_0.Name .. "   \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v84_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v86 = Instance.new("BillboardGui", l_v84_0.Handle)
                        v86.Name = "NameEsp" .. Number
                        v86.ExtentsOffset = Vector3.new(0, 1, 0)
                        v86.Size = UDim2.new(1, 200, 1, 30)
                        v86.Adornee = l_v84_0.Handle
                        v86.AlwaysOnTop = true
                        local v87 = Instance.new("TextLabel", v86)
                        v87.Font = Enum.Font.GothamSemibold
                        v87.FontSize = "Size14"
                        v87.TextWrapped = true
                        v87.Size = UDim2.new(1, 0, 1, 0)
                        v87.TextYAlignment = "Top"
                        v87.BackgroundTransparency = 1
                        v87.TextStrokeTransparency = 0.5
                        v87.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v87.Text = l_v84_0.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v84_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end

function UpdateFlowerChams()
    for _, v89 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v89_0 = v89
            pcall(function()
                if l_v89_0.Name == "Flower2" or l_v89_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v89_0:FindFirstChild("NameEsp" .. Number) then
                            l_v89_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v89_0:FindFirstChild("NameEsp" .. Number) then
                        l_v89_0["NameEsp" .. Number].TextLabel.Text = l_v89_0.Name .. "   \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v91 = Instance.new("BillboardGui", l_v89_0)
                        v91.Name = "NameEsp" .. Number
                        v91.ExtentsOffset = Vector3.new(0, 1, 0)
                        v91.Size = UDim2.new(1, 200, 1, 30)
                        v91.Adornee = l_v89_0
                        v91.AlwaysOnTop = true
                        local v92 = Instance.new("TextLabel", v91)
                        v92.Font = Enum.Font.GothamSemibold
                        v92.FontSize = "Size14"
                        v92.TextWrapped = true
                        v92.Size = UDim2.new(1, 0, 1, 0)
                        v92.TextYAlignment = "Top"
                        v92.BackgroundTransparency = 1
                        v92.TextStrokeTransparency = 0.5
                        v92.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v89_0.Name == "Flower1" then
                            v92.Text = "Blue Flower" .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                            v92.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v89_0.Name == "Flower2" then
                            v92.Text = "Red Flower" .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v89_0.Position).Magnitude / 3) .. " Distance"
                            v92.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end

function UpdateRealFruitChams()
    for _, v94 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v94:IsA("Tool") then
            if not RealFruitESP then
                if v94.Handle:FindFirstChild("NameEsp" .. Number) then
                    v94.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v94.Handle:FindFirstChild("NameEsp" .. Number) then
                v94.Handle["NameEsp" .. Number].TextLabel.Text = v94.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v94.Handle.Position).Magnitude / 3) .. " Distance"
            else
                local v95 = Instance.new("BillboardGui", v94.Handle)
                v95.Name = "NameEsp" .. Number
                v95.ExtentsOffset = Vector3.new(0, 1, 0)
                v95.Size = UDim2.new(1, 200, 1, 30)
                v95.Adornee = v94.Handle
                v95.AlwaysOnTop = true
                local v96 = Instance.new("TextLabel", v95)
                v96.Font = Enum.Font.GothamSemibold
                v96.FontSize = "Size14"
                v96.TextWrapped = true
                v96.Size = UDim2.new(1, 0, 1, 0)
                v96.TextYAlignment = "Top"
                v96.BackgroundTransparency = 1
                v96.TextStrokeTransparency = 0.5
                v96.TextColor3 = Color3.fromRGB(255, 0, 0)
                v96.Text = v94.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v94.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v98 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v98:IsA("Tool") then
            if RealFruitESP then
                if not v98.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v99 = Instance.new("BillboardGui", v98.Handle)
                    v99.Name = "NameEsp" .. Number
                    v99.ExtentsOffset = Vector3.new(0, 1, 0)
                    v99.Size = UDim2.new(1, 200, 1, 30)
                    v99.Adornee = v98.Handle
                    v99.AlwaysOnTop = true
                    local v100 = Instance.new("TextLabel", v99)
                    v100.Font = Enum.Font.GothamSemibold
                    v100.FontSize = "Size14"
                    v100.TextWrapped = true
                    v100.Size = UDim2.new(1, 0, 1, 0)
                    v100.TextYAlignment = "Top"
                    v100.BackgroundTransparency = 1
                    v100.TextStrokeTransparency = 0.5
                    v100.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v100.Text = v98.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v98.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v98.Handle["NameEsp" .. Number].TextLabel.Text = v98.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v98.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v98.Handle:FindFirstChild("NameEsp" .. Number) then
                v98.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v102 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v102:IsA("Tool") then
            if not RealFruitESP then
                if v102.Handle:FindFirstChild("NameEsp" .. Number) then
                    v102.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v102.Handle:FindFirstChild("NameEsp" .. Number) then
                local v103 = Instance.new("BillboardGui", v102.Handle)
                v103.Name = "NameEsp" .. Number
                v103.ExtentsOffset = Vector3.new(0, 1, 0)
                v103.Size = UDim2.new(1, 200, 1, 30)
                v103.Adornee = v102.Handle
                v103.AlwaysOnTop = true
                local v104 = Instance.new("TextLabel", v103)
                v104.Font = Enum.Font.GothamSemibold
                v104.FontSize = "Size14"
                v104.TextWrapped = true
                v104.Size = UDim2.new(1, 0, 1, 0)
                v104.TextYAlignment = "Top"
                v104.BackgroundTransparency = 1
                v104.TextStrokeTransparency = 0.5
                v104.TextColor3 = Color3.fromRGB(251, 255, 0)
                v104.Text = v102.Name .. " \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v102.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v102.Handle["NameEsp" .. Number].TextLabel.Text = v102.Name .. " " .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - v102.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
end

function UpdateIslandESP()
    for _, v106 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v106_0 = v106
            pcall(function()
                if not IslandESP then
                    if l_v106_0:FindFirstChild("NameEsp") then
                        l_v106_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v106_0.Name ~= "Sea" then
                    if l_v106_0:FindFirstChild("NameEsp") then
                        l_v106_0.NameEsp.TextLabel.Text = l_v106_0.Name .. "   \n" .. v70((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v106_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v108 = Instance.new("BillboardGui", l_v106_0)
                        v108.Name = "NameEsp"
                        v108.ExtentsOffset = Vector3.new(0, 1, 0)
                        v108.Size = UDim2.new(1, 200, 1, 30)
                        v108.Adornee = l_v106_0
                        v108.AlwaysOnTop = true
                        local v109 = Instance.new("TextLabel", v108)
                        v109.Font = "GothamSemibold"
                        v109.FontSize = "Size14"
                        v109.TextWrapped = true
                        v109.Size = UDim2.new(1, 0, 1, 0)
                        v109.TextYAlignment = "Top"
                        v109.BackgroundTransparency = 1
                        v109.TextStrokeTransparency = 0.5
                        v109.TextColor3 = Color3.fromRGB(8, 247, 255)
                    end
                end
            end)
        end
    end
end

function isnil(v110)
    local v111 = nil
    if v110 ~= v111 then
        local _ = false
    end
    return true
end

local function v114(v113)
    return math.floor(tonumber(v113) + 0.5)
end

Number = math.random(1, 1000000)

function UpdatePlayerChams()
    for _, v116 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v116_0 = v116
            pcall(function()
                if not isnil(l_v116_0.Character) then
                    if ESPPlayer then
                        if isnil(l_v116_0.Character.Head) or l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v116_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v116_0.Name .. " | " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v116_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v114(l_v116_0.Character.Humanoid.Health * 100 / l_v116_0.Character.Humanoid.MaxHealth) .. "%"
                        else
                            local v118 = Instance.new("BillboardGui", l_v116_0.Character.Head)
                            v118.Name = "NameEsp" .. Number
                            v118.ExtentsOffset = Vector3.new(0, 1, 0)
                            v118.Size = UDim2.new(1, 200, 1, 30)
                            v118.Adornee = l_v116_0.Character.Head
                            v118.AlwaysOnTop = true
                            local v119 = Instance.new("TextLabel", v118)
                            v119.Font = Enum.Font.GothamSemibold
                            v119.FontSize = "Size14"
                            v119.TextWrapped = true
                            v119.Text = l_v116_0.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v116_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v119.Size = UDim2.new(1, 0, 1, 0)
                            v119.TextYAlignment = "Top"
                            v119.BackgroundTransparency = 1
                            v119.TextStrokeTransparency = 0.5
                            if l_v116_0.Team ~= game.Players.LocalPlayer.Team then
                                v119.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v119.TextColor3 = Color3.new(0, 255, 0)
                            end
                        end
                    elseif l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v116_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end

function UpdateChestESP()
    for _, v121 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v121_0 = v121
            pcall(function()
                if _G.ChestESP then
                    if not l_v121_0:GetAttribute("IsDisabled") then
                        if l_v121_0:FindFirstChild("ChestEsp") then
                            local v123 = v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v121_0:GetPivot().Position).Magnitude / 3)
                            l_v121_0.ChestEsp.TextLabel.Text = "Chest\n" .. v123 .. " M"
                        else
                            local v124 = Instance.new("BillboardGui", l_v121_0)
                            v124.Name = "ChestEsp"
                            v124.ExtentsOffset = Vector3.new(0, 1, 0)
                            v124.Size = UDim2.new(1, 200, 1, 30)
                            v124.Adornee = l_v121_0
                            v124.AlwaysOnTop = true
                            local v125 = Instance.new("TextLabel", v124)
                            v125.Font = "Code"
                            v125.FontSize = "Size14"
                            v125.TextWrapped = true
                            v125.Size = UDim2.new(1, 0, 1, 0)
                            v125.TextYAlignment = "Top"
                            v125.BackgroundTransparency = 1
                            v125.TextStrokeTransparency = 0.5
                            v125.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v121_0:FindFirstChild("ChestEsp") then
                    l_v121_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end

function v114(v126)
    return math.floor(v126 + 0.5)
end

function UpdateDevilChams()
    for _, v128 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v128_0 = v128
            pcall(function()
                if not DevilFruitESP then
                    if l_v128_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v128_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v128_0.Name, "Fruit") then
                    if l_v128_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v128_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v128_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v128_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v130 = Instance.new("BillboardGui", l_v128_0.Handle)
                        v130.Name = "NameEsp" .. Number
                        v130.ExtentsOffset = Vector3.new(0, 1, 0)
                        v130.Size = UDim2.new(1, 200, 1, 30)
                        v130.Adornee = l_v128_0.Handle
                        v130.AlwaysOnTop = true
                        local v131 = Instance.new("TextLabel", v130)
                        v131.Font = Enum.Font.GothamSemibold
                        v131.FontSize = "Size14"
                        v131.TextWrapped = true
                        v131.Size = UDim2.new(1, 0, 1, 0)
                        v131.TextYAlignment = "Top"
                        v131.BackgroundTransparency = 1
                        v131.TextStrokeTransparency = 0.5
                        v131.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v131.Text = l_v128_0.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v128_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end

function UpdateFlowerChams()
    for _, v133 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v133_0 = v133
            pcall(function()
                if l_v133_0.Name == "Flower2" or l_v133_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v133_0:FindFirstChild("NameEsp" .. Number) then
                            l_v133_0["NameEsp" .. Number].TextLabel.Text = l_v133_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v135 = Instance.new("BillboardGui", l_v133_0)
                            v135.Name = "NameEsp" .. Number
                            v135.ExtentsOffset = Vector3.new(0, 1, 0)
                            v135.Size = UDim2.new(1, 200, 1, 30)
                            v135.Adornee = l_v133_0
                            v135.AlwaysOnTop = true
                            local v136 = Instance.new("TextLabel", v135)
                            v136.Font = Enum.Font.GothamSemibold
                            v136.FontSize = "Size14"
                            v136.TextWrapped = true
                            v136.Size = UDim2.new(1, 0, 1, 0)
                            v136.TextYAlignment = "Top"
                            v136.BackgroundTransparency = 1
                            v136.TextStrokeTransparency = 0.5
                            v136.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v133_0.Name == "Flower1" then
                                v136.Text = "Blue Flower" .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                                v136.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v133_0.Name == "Flower2" then
                                v136.Text = "Red Flower" .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v133_0.Position).Magnitude / 3) .. " Distance"
                                v136.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v133_0:FindFirstChild("NameEsp" .. Number) then
                        l_v133_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end

function UpdateRealFruitChams()
    for _, v138 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v138:IsA("Tool") then
            if RealFruitESP then
                if v138.Handle:FindFirstChild("NameEsp" .. Number) then
                    v138.Handle["NameEsp" .. Number].TextLabel.Text = v138.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v138.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v139 = Instance.new("BillboardGui", v138.Handle)
                    v139.Name = "NameEsp" .. Number
                    v139.ExtentsOffset = Vector3.new(0, 1, 0)
                    v139.Size = UDim2.new(1, 200, 1, 30)
                    v139.Adornee = v138.Handle
                    v139.AlwaysOnTop = true
                    local v140 = Instance.new("TextLabel", v139)
                    v140.Font = Enum.Font.GothamSemibold
                    v140.FontSize = "Size14"
                    v140.TextWrapped = true
                    v140.Size = UDim2.new(1, 0, 1, 0)
                    v140.TextYAlignment = "Top"
                    v140.BackgroundTransparency = 1
                    v140.TextStrokeTransparency = 0.5
                    v140.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v140.Text = v138.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v138.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v138.Handle:FindFirstChild("NameEsp" .. Number) then
                v138.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v142 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v142:IsA("Tool") then
            if RealFruitESP then
                if v142.Handle:FindFirstChild("NameEsp" .. Number) then
                    v142.Handle["NameEsp" .. Number].TextLabel.Text = v142.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v142.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v143 = Instance.new("BillboardGui", v142.Handle)
                    v143.Name = "NameEsp" .. Number
                    v143.ExtentsOffset = Vector3.new(0, 1, 0)
                    v143.Size = UDim2.new(1, 200, 1, 30)
                    v143.Adornee = v142.Handle
                    v143.AlwaysOnTop = true
                    local v144 = Instance.new("TextLabel", v143)
                    v144.Font = Enum.Font.GothamSemibold
                    v144.FontSize = "Size14"
                    v144.TextWrapped = true
                    v144.Size = UDim2.new(1, 0, 1, 0)
                    v144.TextYAlignment = "Top"
                    v144.BackgroundTransparency = 1
                    v144.TextStrokeTransparency = 0.5
                    v144.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v144.Text = v142.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v142.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v142.Handle:FindFirstChild("NameEsp" .. Number) then
                v142.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v146 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v146:IsA("Tool") then
            if not RealFruitESP then
                if v146.Handle:FindFirstChild("NameEsp" .. Number) then
                    v146.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v146.Handle:FindFirstChild("NameEsp" .. Number) then
                local v147 = Instance.new("BillboardGui", v146.Handle)
                v147.Name = "NameEsp" .. Number
                v147.ExtentsOffset = Vector3.new(0, 1, 0)
                v147.Size = UDim2.new(1, 200, 1, 30)
                v147.Adornee = v146.Handle
                v147.AlwaysOnTop = true
                local v148 = Instance.new("TextLabel", v147)
                v148.Font = Enum.Font.GothamSemibold
                v148.FontSize = "Size14"
                v148.TextWrapped = true
                v148.Size = UDim2.new(1, 0, 1, 0)
                v148.TextYAlignment = "Top"
                v148.BackgroundTransparency = 1
                v148.TextStrokeTransparency = 0.5
                v148.TextColor3 = Color3.fromRGB(251, 255, 0)
                v148.Text = v146.Name .. " \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v146.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v146.Handle["NameEsp" .. Number].TextLabel.Text = v146.Name .. " " .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - v146.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
end

function UpdateIslandESP()
    for _, v150 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v150_0 = v150
            pcall(function()
                if IslandESP then
                    if l_v150_0.Name ~= "Sea" then
                        if l_v150_0:FindFirstChild("NameEsp") then
                            l_v150_0.NameEsp.TextLabel.Text = l_v150_0.Name .. "   \n" .. v114((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v150_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v152 = Instance.new("BillboardGui", l_v150_0)
                            v152.Name = "NameEsp"
                            v152.ExtentsOffset = Vector3.new(0, 1, 0)
                            v152.Size = UDim2.new(1, 200, 1, 30)
                            v152.Adornee = l_v150_0
                            v152.AlwaysOnTop = true
                            local v153 = Instance.new("TextLabel", v152)
                            v153.Font = "GothamSemibold"
                            v153.FontSize = "Size14"
                            v153.TextWrapped = true
                            v153.Size = UDim2.new(1, 0, 1, 0)
                            v153.TextYAlignment = "Top"
                            v153.BackgroundTransparency = 1
                            v153.TextStrokeTransparency = 0.5
                            v153.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                elseif l_v150_0:FindFirstChild("NameEsp") then
                    l_v150_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end

function isnil(v154)
    local v155 = nil
    if v154 ~= v155 then
        local _ = false
    end
    return true
end

local function v158(v157)
    return math.floor(tonumber(v157) + 0.5)
end

Number = math.random(1, 1000000)

function UpdatePlayerChams()
    for _, v160 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v160_0 = v160
            pcall(function()
                if not isnil(l_v160_0.Character) then
                    if not ESPPlayer then
                        if l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif isnil(l_v160_0.Character.Head) or l_v160_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v160_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v160_0.Name .. " | " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v160_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v158(l_v160_0.Character.Humanoid.Health * 100 / l_v160_0.Character.Humanoid.MaxHealth) .. "%"
                    else
                        local v162 = Instance.new("BillboardGui", l_v160_0.Character.Head)
                        v162.Name = "NameEsp" .. Number
                        v162.ExtentsOffset = Vector3.new(0, 1, 0)
                        v162.Size = UDim2.new(1, 200, 1, 30)
                        v162.Adornee = l_v160_0.Character.Head
                        v162.AlwaysOnTop = true
                        local v163 = Instance.new("TextLabel", v162)
                        v163.Font = Enum.Font.GothamSemibold
                        v163.FontSize = "Size14"
                        v163.TextWrapped = true
                        v163.Text = l_v160_0.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v160_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v163.Size = UDim2.new(1, 0, 1, 0)
                        v163.TextYAlignment = "Top"
                        v163.BackgroundTransparency = 1
                        v163.TextStrokeTransparency = 0.5
                        if l_v160_0.Team == game.Players.LocalPlayer.Team then
                            v163.TextColor3 = Color3.new(0, 255, 0)
                        else
                            v163.TextColor3 = Color3.new(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end

function UpdateChestESP()
    for _, v165 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v165_0 = v165
            pcall(function()
                if _G.ChestESP then
                    if not l_v165_0:GetAttribute("IsDisabled") then
                        if l_v165_0:FindFirstChild("ChestEsp") then
                            local v167 = v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v165_0:GetPivot().Position).Magnitude / 3)
                            l_v165_0.ChestEsp.TextLabel.Text = "Chest\n" .. v167 .. " M"
                        else
                            local v168 = Instance.new("BillboardGui", l_v165_0)
                            v168.Name = "ChestEsp"
                            v168.ExtentsOffset = Vector3.new(0, 1, 0)
                            v168.Size = UDim2.new(1, 200, 1, 30)
                            v168.Adornee = l_v165_0
                            v168.AlwaysOnTop = true
                            local v169 = Instance.new("TextLabel", v168)
                            v169.Font = "Code"
                            v169.FontSize = "Size14"
                            v169.TextWrapped = true
                            v169.Size = UDim2.new(1, 0, 1, 0)
                            v169.TextYAlignment = "Top"
                            v169.BackgroundTransparency = 1
                            v169.TextStrokeTransparency = 0.5
                            v169.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v165_0:FindFirstChild("ChestEsp") then
                    l_v165_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end

function v158(v170)
    return math.floor(v170 + 0.5)
end

function UpdateDevilChams()
    for _, v172 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v172_0 = v172
            pcall(function()
                if DevilFruitESP then
                    if string.find(l_v172_0.Name, "Fruit") then
                        if l_v172_0.Handle:FindFirstChild("NameEsp" .. Number) then
                            l_v172_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v172_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v172_0.Handle.Position).Magnitude / 3) .. " Distance"
                        else
                            local v174 = Instance.new("BillboardGui", l_v172_0.Handle)
                            v174.Name = "NameEsp" .. Number
                            v174.ExtentsOffset = Vector3.new(0, 1, 0)
                            v174.Size = UDim2.new(1, 200, 1, 30)
                            v174.Adornee = l_v172_0.Handle
                            v174.AlwaysOnTop = true
                            local v175 = Instance.new("TextLabel", v174)
                            v175.Font = Enum.Font.GothamSemibold
                            v175.FontSize = "Size14"
                            v175.TextWrapped = true
                            v175.Size = UDim2.new(1, 0, 1, 0)
                            v175.TextYAlignment = "Top"
                            v175.BackgroundTransparency = 1
                            v175.TextStrokeTransparency = 0.5
                            v175.TextColor3 = Color3.fromRGB(255, 255, 255)
                            v175.Text = l_v172_0.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v172_0.Handle.Position).Magnitude / 3) .. " Distance"
                        end
                    end
                elseif l_v172_0.Handle:FindFirstChild("NameEsp" .. Number) then
                    l_v172_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end)
        end
    end
end

function UpdateFlowerChams()
    for _, v177 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v177_0 = v177
            pcall(function()
                if l_v177_0.Name == "Flower2" or l_v177_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v177_0:FindFirstChild("NameEsp" .. Number) then
                            l_v177_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v177_0:FindFirstChild("NameEsp" .. Number) then
                        l_v177_0["NameEsp" .. Number].TextLabel.Text = l_v177_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v179 = Instance.new("BillboardGui", l_v177_0)
                        v179.Name = "NameEsp" .. Number
                        v179.ExtentsOffset = Vector3.new(0, 1, 0)
                        v179.Size = UDim2.new(1, 200, 1, 30)
                        v179.Adornee = l_v177_0
                        v179.AlwaysOnTop = true
                        local v180 = Instance.new("TextLabel", v179)
                        v180.Font = Enum.Font.GothamSemibold
                        v180.FontSize = "Size14"
                        v180.TextWrapped = true
                        v180.Size = UDim2.new(1, 0, 1, 0)
                        v180.TextYAlignment = "Top"
                        v180.BackgroundTransparency = 1
                        v180.TextStrokeTransparency = 0.5
                        v180.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v177_0.Name == "Flower1" then
                            v180.Text = "Blue Flower" .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                            v180.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v177_0.Name == "Flower2" then
                            v180.Text = "Red Flower" .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v177_0.Position).Magnitude / 3) .. " Distance"
                            v180.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end

function UpdateRealFruitChams()
    for _, v182 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v182:IsA("Tool") then
            if RealFruitESP then
                if v182.Handle:FindFirstChild("NameEsp" .. Number) then
                    v182.Handle["NameEsp" .. Number].TextLabel.Text = v182.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v182.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v183 = Instance.new("BillboardGui", v182.Handle)
                    v183.Name = "NameEsp" .. Number
                    v183.ExtentsOffset = Vector3.new(0, 1, 0)
                    v183.Size = UDim2.new(1, 200, 1, 30)
                    v183.Adornee = v182.Handle
                    v183.AlwaysOnTop = true
                    local v184 = Instance.new("TextLabel", v183)
                    v184.Font = Enum.Font.GothamSemibold
                    v184.FontSize = "Size14"
                    v184.TextWrapped = true
                    v184.Size = UDim2.new(1, 0, 1, 0)
                    v184.TextYAlignment = "Top"
                    v184.BackgroundTransparency = 1
                    v184.TextStrokeTransparency = 0.5
                    v184.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v184.Text = v182.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v182.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v182.Handle:FindFirstChild("NameEsp" .. Number) then
                v182.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v186 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v186:IsA("Tool") then
            if RealFruitESP then
                if not v186.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v187 = Instance.new("BillboardGui", v186.Handle)
                    v187.Name = "NameEsp" .. Number
                    v187.ExtentsOffset = Vector3.new(0, 1, 0)
                    v187.Size = UDim2.new(1, 200, 1, 30)
                    v187.Adornee = v186.Handle
                    v187.AlwaysOnTop = true
                    local v188 = Instance.new("TextLabel", v187)
                    v188.Font = Enum.Font.GothamSemibold
                    v188.FontSize = "Size14"
                    v188.TextWrapped = true
                    v188.Size = UDim2.new(1, 0, 1, 0)
                    v188.TextYAlignment = "Top"
                    v188.BackgroundTransparency = 1
                    v188.TextStrokeTransparency = 0.5
                    v188.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v188.Text = v186.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v186.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v186.Handle["NameEsp" .. Number].TextLabel.Text = v186.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v186.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v186.Handle:FindFirstChild("NameEsp" .. Number) then
                v186.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v190 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v190:IsA("Tool") then
            if RealFruitESP then
                if v190.Handle:FindFirstChild("NameEsp" .. Number) then
                    v190.Handle["NameEsp" .. Number].TextLabel.Text = v190.Name .. " " .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v190.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v191 = Instance.new("BillboardGui", v190.Handle)
                    v191.Name = "NameEsp" .. Number
                    v191.ExtentsOffset = Vector3.new(0, 1, 0)
                    v191.Size = UDim2.new(1, 200, 1, 30)
                    v191.Adornee = v190.Handle
                    v191.AlwaysOnTop = true
                    local v192 = Instance.new("TextLabel", v191)
                    v192.Font = Enum.Font.GothamSemibold
                    v192.FontSize = "Size14"
                    v192.TextWrapped = true
                    v192.Size = UDim2.new(1, 0, 1, 0)
                    v192.TextYAlignment = "Top"
                    v192.BackgroundTransparency = 1
                    v192.TextStrokeTransparency = 0.5
                    v192.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v192.Text = v190.Name .. " \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - v190.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v190.Handle:FindFirstChild("NameEsp" .. Number) then
                v190.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end

function UpdateIslandESP()
    for _, v194 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v194_0 = v194
            pcall(function()
                if not IslandESP then
                    if l_v194_0:FindFirstChild("NameEsp") then
                        l_v194_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v194_0.Name ~= "Sea" then
                    if l_v194_0:FindFirstChild("NameEsp") then
                        l_v194_0.NameEsp.TextLabel.Text = l_v194_0.Name .. "   \n" .. v158((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v194_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v196 = Instance.new("BillboardGui", l_v194_0)
                        v196.Name = "NameEsp"
                        v196.ExtentsOffset = Vector3.new(0, 1, 0)
                        v196.Size = UDim2.new(1, 200, 1, 30)
                        v196.Adornee = l_v194_0
                        v196.AlwaysOnTop = true
                        local v197 = Instance.new("TextLabel", v196)
                        v197.Font = "GothamSemibold"
                        v197.FontSize = "Size14"
                        v197.TextWrapped = true
                        v197.Size = UDim2.new(1, 0, 1, 0)
                        v197.TextYAlignment = "Top"
                        v197.BackgroundTransparency = 1
                        v197.TextStrokeTransparency = 0.5
                        v197.TextColor3 = Color3.fromRGB(8, 247, 255)
                    end
                end
            end)
        end
    end
end

function isnil(v198)
    local v199 = nil
    if v198 ~= v199 then
        local _ = false
    end
    return true
end

local function v202(v201)
    return math.floor(tonumber(v201) + 0.5)
end

Number = math.random(1, 1000000)

function UpdatePlayerChams()
    for _, v204 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v204_0 = v204
            pcall(function()
                if not isnil(l_v204_0.Character) then
                    if ESPPlayer then
                        if isnil(l_v204_0.Character.Head) or l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            l_v204_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v204_0.Name .. " | " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v204_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v202(l_v204_0.Character.Humanoid.Health * 100 / l_v204_0.Character.Humanoid.MaxHealth) .. "%"
                        else
                            local v206 = Instance.new("BillboardGui", l_v204_0.Character.Head)
                            v206.Name = "NameEsp" .. Number
                            v206.ExtentsOffset = Vector3.new(0, 1, 0)
                            v206.Size = UDim2.new(1, 200, 1, 30)
                            v206.Adornee = l_v204_0.Character.Head
                            v206.AlwaysOnTop = true
                            local v207 = Instance.new("TextLabel", v206)
                            v207.Font = Enum.Font.GothamSemibold
                            v207.FontSize = "Size14"
                            v207.TextWrapped = true
                            v207.Text = l_v204_0.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v204_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v207.Size = UDim2.new(1, 0, 1, 0)
                            v207.TextYAlignment = "Top"
                            v207.BackgroundTransparency = 1
                            v207.TextStrokeTransparency = 0.5
                            if l_v204_0.Team ~= game.Players.LocalPlayer.Team then
                                v207.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v207.TextColor3 = Color3.new(0, 255, 0)
                            end
                        end
                    elseif l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v204_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end

function UpdateChestESP()
    for _, v209 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v209_0 = v209
            pcall(function()
                if _G.ChestESP then
                    if not l_v209_0:GetAttribute("IsDisabled") then
                        if not l_v209_0:FindFirstChild("ChestEsp") then
                            local v211 = Instance.new("BillboardGui", l_v209_0)
                            v211.Name = "ChestEsp"
                            v211.ExtentsOffset = Vector3.new(0, 1, 0)
                            v211.Size = UDim2.new(1, 200, 1, 30)
                            v211.Adornee = l_v209_0
                            v211.AlwaysOnTop = true
                            local v212 = Instance.new("TextLabel", v211)
                            v212.Font = "Code"
                            v212.FontSize = "Size14"
                            v212.TextWrapped = true
                            v212.Size = UDim2.new(1, 0, 1, 0)
                            v212.TextYAlignment = "Top"
                            v212.BackgroundTransparency = 1
                            v212.TextStrokeTransparency = 0.5
                            v212.TextColor3 = Color3.fromRGB(255, 215, 0)
                        else
                            local v213 = v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v209_0:GetPivot().Position).Magnitude / 3)
                            l_v209_0.ChestEsp.TextLabel.Text = "Chest\n" .. v213 .. " M"
                        end
                    end
                elseif l_v209_0:FindFirstChild("ChestEsp") then
                    l_v209_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end

function v202(v214)
    return math.floor(v214 + 0.5)
end

function UpdateDevilChams()
    for _, v216 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v216_0 = v216
            pcall(function()
                if not DevilFruitESP then
                    if l_v216_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v216_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v216_0.Name, "Fruit") then
                    if l_v216_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v216_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v216_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v216_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v218 = Instance.new("BillboardGui", l_v216_0.Handle)
                        v218.Name = "NameEsp" .. Number
                        v218.ExtentsOffset = Vector3.new(0, 1, 0)
                        v218.Size = UDim2.new(1, 200, 1, 30)
                        v218.Adornee = l_v216_0.Handle
                        v218.AlwaysOnTop = true
                        local v219 = Instance.new("TextLabel", v218)
                        v219.Font = Enum.Font.GothamSemibold
                        v219.FontSize = "Size14"
                        v219.TextWrapped = true
                        v219.Size = UDim2.new(1, 0, 1, 0)
                        v219.TextYAlignment = "Top"
                        v219.BackgroundTransparency = 1
                        v219.TextStrokeTransparency = 0.5
                        v219.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v219.Text = l_v216_0.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v216_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end

function UpdateFlowerChams()
    for _, v221 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v221_0 = v221
            pcall(function()
                if l_v221_0.Name == "Flower2" or l_v221_0.Name == "Flower1" then
                    if not FlowerESP then
                        if l_v221_0:FindFirstChild("NameEsp" .. Number) then
                            l_v221_0:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    elseif l_v221_0:FindFirstChild("NameEsp" .. Number) then
                        l_v221_0["NameEsp" .. Number].TextLabel.Text = l_v221_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                    else
                        local v223 = Instance.new("BillboardGui", l_v221_0)
                        v223.Name = "NameEsp" .. Number
                        v223.ExtentsOffset = Vector3.new(0, 1, 0)
                        v223.Size = UDim2.new(1, 200, 1, 30)
                        v223.Adornee = l_v221_0
                        v223.AlwaysOnTop = true
                        local v224 = Instance.new("TextLabel", v223)
                        v224.Font = Enum.Font.GothamSemibold
                        v224.FontSize = "Size14"
                        v224.TextWrapped = true
                        v224.Size = UDim2.new(1, 0, 1, 0)
                        v224.TextYAlignment = "Top"
                        v224.BackgroundTransparency = 1
                        v224.TextStrokeTransparency = 0.5
                        v224.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if l_v221_0.Name == "Flower1" then
                            v224.Text = "Blue Flower" .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                            v224.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if l_v221_0.Name == "Flower2" then
                            v224.Text = "Red Flower" .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v221_0.Position).Magnitude / 3) .. " Distance"
                            v224.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                end
            end)
        end
    end
end

function UpdateRealFruitChams()
    for _, v226 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v226:IsA("Tool") then
            if not RealFruitESP then
                if v226.Handle:FindFirstChild("NameEsp" .. Number) then
                    v226.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif v226.Handle:FindFirstChild("NameEsp" .. Number) then
                v226.Handle["NameEsp" .. Number].TextLabel.Text = v226.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v226.Handle.Position).Magnitude / 3) .. " Distance"
            else
                local v227 = Instance.new("BillboardGui", v226.Handle)
                v227.Name = "NameEsp" .. Number
                v227.ExtentsOffset = Vector3.new(0, 1, 0)
                v227.Size = UDim2.new(1, 200, 1, 30)
                v227.Adornee = v226.Handle
                v227.AlwaysOnTop = true
                local v228 = Instance.new("TextLabel", v227)
                v228.Font = Enum.Font.GothamSemibold
                v228.FontSize = "Size14"
                v228.TextWrapped = true
                v228.Size = UDim2.new(1, 0, 1, 0)
                v228.TextYAlignment = "Top"
                v228.BackgroundTransparency = 1
                v228.TextStrokeTransparency = 0.5
                v228.TextColor3 = Color3.fromRGB(255, 0, 0)
                v228.Text = v226.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v226.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v230 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v230:IsA("Tool") then
            if RealFruitESP then
                if v230.Handle:FindFirstChild("NameEsp" .. Number) then
                    v230.Handle["NameEsp" .. Number].TextLabel.Text = v230.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v230.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v231 = Instance.new("BillboardGui", v230.Handle)
                    v231.Name = "NameEsp" .. Number
                    v231.ExtentsOffset = Vector3.new(0, 1, 0)
                    v231.Size = UDim2.new(1, 200, 1, 30)
                    v231.Adornee = v230.Handle
                    v231.AlwaysOnTop = true
                    local v232 = Instance.new("TextLabel", v231)
                    v232.Font = Enum.Font.GothamSemibold
                    v232.FontSize = "Size14"
                    v232.TextWrapped = true
                    v232.Size = UDim2.new(1, 0, 1, 0)
                    v232.TextYAlignment = "Top"
                    v232.BackgroundTransparency = 1
                    v232.TextStrokeTransparency = 0.5
                    v232.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v232.Text = v230.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v230.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v230.Handle:FindFirstChild("NameEsp" .. Number) then
                v230.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v234 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v234:IsA("Tool") then
            if RealFruitESP then
                if not v234.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v235 = Instance.new("BillboardGui", v234.Handle)
                    v235.Name = "NameEsp" .. Number
                    v235.ExtentsOffset = Vector3.new(0, 1, 0)
                    v235.Size = UDim2.new(1, 200, 1, 30)
                    v235.Adornee = v234.Handle
                    v235.AlwaysOnTop = true
                    local v236 = Instance.new("TextLabel", v235)
                    v236.Font = Enum.Font.GothamSemibold
                    v236.FontSize = "Size14"
                    v236.TextWrapped = true
                    v236.Size = UDim2.new(1, 0, 1, 0)
                    v236.TextYAlignment = "Top"
                    v236.BackgroundTransparency = 1
                    v236.TextStrokeTransparency = 0.5
                    v236.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v236.Text = v234.Name .. " \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v234.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v234.Handle["NameEsp" .. Number].TextLabel.Text = v234.Name .. " " .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - v234.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v234.Handle:FindFirstChild("NameEsp" .. Number) then
                v234.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end

function UpdateIslandESP()
    for _, v238 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v238_0 = v238
            pcall(function()
                if IslandESP then
                    if l_v238_0.Name ~= "Sea" then
                        if l_v238_0:FindFirstChild("NameEsp") then
                            l_v238_0.NameEsp.TextLabel.Text = l_v238_0.Name .. "   \n" .. v202((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v238_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v240 = Instance.new("BillboardGui", l_v238_0)
                            v240.Name = "NameEsp"
                            v240.ExtentsOffset = Vector3.new(0, 1, 0)
                            v240.Size = UDim2.new(1, 200, 1, 30)
                            v240.Adornee = l_v238_0
                            v240.AlwaysOnTop = true
                            local v241 = Instance.new("TextLabel", v240)
                            v241.Font = "GothamSemibold"
                            v241.FontSize = "Size14"
                            v241.TextWrapped = true
                            v241.Size = UDim2.new(1, 0, 1, 0)
                            v241.TextYAlignment = "Top"
                            v241.BackgroundTransparency = 1
                            v241.TextStrokeTransparency = 0.5
                            v241.TextColor3 = Color3.fromRGB(8, 247, 255)
                        end
                    end
                elseif l_v238_0:FindFirstChild("NameEsp") then
                    l_v238_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end

function isnil(v242)
    local v243 = nil
    if v242 ~= v243 then
        local _ = false
    end
    return true
end

local function v246(v245)
    return math.floor(tonumber(v245) + 0.5)
end

Number = math.random(1, 1000000)

function UpdatePlayerChams()
    for _, v248 in pairs(game:GetService("Players"):GetChildren()) do
        do
            local l_v248_0 = v248
            pcall(function()
                if not isnil(l_v248_0.Character) then
                    if ESPPlayer then
                        if not isnil(l_v248_0.Character.Head) and not l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            local v250 = Instance.new("BillboardGui", l_v248_0.Character.Head)
                            v250.Name = "NameEsp" .. Number
                            v250.ExtentsOffset = Vector3.new(0, 1, 0)
                            v250.Size = UDim2.new(1, 200, 1, 30)
                            v250.Adornee = l_v248_0.Character.Head
                            v250.AlwaysOnTop = true
                            local v251 = Instance.new("TextLabel", v250)
                            v251.Font = Enum.Font.GothamSemibold
                            v251.FontSize = "Size14"
                            v251.TextWrapped = true
                            v251.Text = l_v248_0.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v248_0.Character.Head.Position).Magnitude / 3) .. " Distance"
                            v251.Size = UDim2.new(1, 0, 1, 0)
                            v251.TextYAlignment = "Top"
                            v251.BackgroundTransparency = 1
                            v251.TextStrokeTransparency = 0.5
                            if l_v248_0.Team ~= game.Players.LocalPlayer.Team then
                                v251.TextColor3 = Color3.new(255, 0, 0)
                            else
                                v251.TextColor3 = Color3.new(0, 255, 0)
                            end
                        else
                            l_v248_0.Character.Head["NameEsp" .. Number].TextLabel.Text = l_v248_0.Name .. " | " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v248_0.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. v246(l_v248_0.Character.Humanoid.Health * 100 / l_v248_0.Character.Humanoid.MaxHealth) .. "%"
                        end
                    elseif l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        l_v248_0.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end

function UpdateChestESP()
    for _, v253 in pairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
        do
            local l_v253_0 = v253
            pcall(function()
                if _G.ChestESP then
                    if not l_v253_0:GetAttribute("IsDisabled") then
                        if l_v253_0:FindFirstChild("ChestEsp") then
                            local v255 = v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v253_0:GetPivot().Position).Magnitude / 3)
                            l_v253_0.ChestEsp.TextLabel.Text = "Chest\n" .. v255 .. " M"
                        else
                            local v256 = Instance.new("BillboardGui", l_v253_0)
                            v256.Name = "ChestEsp"
                            v256.ExtentsOffset = Vector3.new(0, 1, 0)
                            v256.Size = UDim2.new(1, 200, 1, 30)
                            v256.Adornee = l_v253_0
                            v256.AlwaysOnTop = true
                            local v257 = Instance.new("TextLabel", v256)
                            v257.Font = "Code"
                            v257.FontSize = "Size14"
                            v257.TextWrapped = true
                            v257.Size = UDim2.new(1, 0, 1, 0)
                            v257.TextYAlignment = "Top"
                            v257.BackgroundTransparency = 1
                            v257.TextStrokeTransparency = 0.5
                            v257.TextColor3 = Color3.fromRGB(255, 215, 0)
                        end
                    end
                elseif l_v253_0:FindFirstChild("ChestEsp") then
                    l_v253_0:FindFirstChild("ChestEsp"):Destroy()
                end
            end)
        end
    end
end

function v246(v258)
    return math.floor(v258 + 0.5)
end

function UpdateDevilChams()
    for _, v260 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v260_0 = v260
            pcall(function()
                if not DevilFruitESP then
                    if l_v260_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v260_0.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                elseif string.find(l_v260_0.Name, "Fruit") then
                    if l_v260_0.Handle:FindFirstChild("NameEsp" .. Number) then
                        l_v260_0.Handle["NameEsp" .. Number].TextLabel.Text = l_v260_0.Name .. "   \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v260_0.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v262 = Instance.new("BillboardGui", l_v260_0.Handle)
                        v262.Name = "NameEsp" .. Number
                        v262.ExtentsOffset = Vector3.new(0, 1, 0)
                        v262.Size = UDim2.new(1, 200, 1, 30)
                        v262.Adornee = l_v260_0.Handle
                        v262.AlwaysOnTop = true
                        local v263 = Instance.new("TextLabel", v262)
                        v263.Font = Enum.Font.GothamSemibold
                        v263.FontSize = "Size14"
                        v263.TextWrapped = true
                        v263.Size = UDim2.new(1, 0, 1, 0)
                        v263.TextYAlignment = "Top"
                        v263.BackgroundTransparency = 1
                        v263.TextStrokeTransparency = 0.5
                        v263.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v263.Text = l_v260_0.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v260_0.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            end)
        end
    end
end

function UpdateFlowerChams()
    for _, v265 in pairs(game.Workspace:GetChildren()) do
        do
            local l_v265_0 = v265
            pcall(function()
                if l_v265_0.Name == "Flower2" or l_v265_0.Name == "Flower1" then
                    if FlowerESP then
                        if l_v265_0:FindFirstChild("NameEsp" .. Number) then
                            l_v265_0["NameEsp" .. Number].TextLabel.Text = l_v265_0.Name .. "   \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                        else
                            local v267 = Instance.new("BillboardGui", l_v265_0)
                            v267.Name = "NameEsp" .. Number
                            v267.ExtentsOffset = Vector3.new(0, 1, 0)
                            v267.Size = UDim2.new(1, 200, 1, 30)
                            v267.Adornee = l_v265_0
                            v267.AlwaysOnTop = true
                            local v268 = Instance.new("TextLabel", v267)
                            v268.Font = Enum.Font.GothamSemibold
                            v268.FontSize = "Size14"
                            v268.TextWrapped = true
                            v268.Size = UDim2.new(1, 0, 1, 0)
                            v268.TextYAlignment = "Top"
                            v268.BackgroundTransparency = 1
                            v268.TextStrokeTransparency = 0.5
                            v268.TextColor3 = Color3.fromRGB(255, 0, 0)
                            if l_v265_0.Name == "Flower1" then
                                v268.Text = "Blue Flower" .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                                v268.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if l_v265_0.Name == "Flower2" then
                                v268.Text = "Red Flower" .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v265_0.Position).Magnitude / 3) .. " Distance"
                                v268.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif l_v265_0:FindFirstChild("NameEsp" .. Number) then
                        l_v265_0:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end
            end)
        end
    end
end

function UpdateRealFruitChams()
    for _, v270 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v270:IsA("Tool") then
            if RealFruitESP then
                if not v270.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v271 = Instance.new("BillboardGui", v270.Handle)
                    v271.Name = "NameEsp" .. Number
                    v271.ExtentsOffset = Vector3.new(0, 1, 0)
                    v271.Size = UDim2.new(1, 200, 1, 30)
                    v271.Adornee = v270.Handle
                    v271.AlwaysOnTop = true
                    local v272 = Instance.new("TextLabel", v271)
                    v272.Font = Enum.Font.GothamSemibold
                    v272.FontSize = "Size14"
                    v272.TextWrapped = true
                    v272.Size = UDim2.new(1, 0, 1, 0)
                    v272.TextYAlignment = "Top"
                    v272.BackgroundTransparency = 1
                    v272.TextStrokeTransparency = 0.5
                    v272.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v272.Text = v270.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v270.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v270.Handle["NameEsp" .. Number].TextLabel.Text = v270.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v270.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v270.Handle:FindFirstChild("NameEsp" .. Number) then
                v270.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for _, v274 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v274:IsA("Tool") then
            if not RealFruitESP then
                if v274.Handle:FindFirstChild("NameEsp" .. Number) then
                    v274.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            elseif not v274.Handle:FindFirstChild("NameEsp" .. Number) then
                local v275 = Instance.new("BillboardGui", v274.Handle)
                v275.Name = "NameEsp" .. Number
                v275.ExtentsOffset = Vector3.new(0, 1, 0)
                v275.Size = UDim2.new(1, 200, 1, 30)
                v275.Adornee = v274.Handle
                v275.AlwaysOnTop = true
                local v276 = Instance.new("TextLabel", v275)
                v276.Font = Enum.Font.GothamSemibold
                v276.FontSize = "Size14"
                v276.TextWrapped = true
                v276.Size = UDim2.new(1, 0, 1, 0)
                v276.TextYAlignment = "Top"
                v276.BackgroundTransparency = 1
                v276.TextStrokeTransparency = 0.5
                v276.TextColor3 = Color3.fromRGB(255, 174, 0)
                v276.Text = v274.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v274.Handle.Position).Magnitude / 3) .. " Distance"
            else
                v274.Handle["NameEsp" .. Number].TextLabel.Text = v274.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v274.Handle.Position).Magnitude / 3) .. " Distance"
            end
        end
    end
    for _, v278 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v278:IsA("Tool") then
            if RealFruitESP then
                if not v278.Handle:FindFirstChild("NameEsp" .. Number) then
                    local v279 = Instance.new("BillboardGui", v278.Handle)
                    v279.Name = "NameEsp" .. Number
                    v279.ExtentsOffset = Vector3.new(0, 1, 0)
                    v279.Size = UDim2.new(1, 200, 1, 30)
                    v279.Adornee = v278.Handle
                    v279.AlwaysOnTop = true
                    local v280 = Instance.new("TextLabel", v279)
                    v280.Font = Enum.Font.GothamSemibold
                    v280.FontSize = "Size14"
                    v280.TextWrapped = true
                    v280.Size = UDim2.new(1, 0, 1, 0)
                    v280.TextYAlignment = "Top"
                    v280.BackgroundTransparency = 1
                    v280.TextStrokeTransparency = 0.5
                    v280.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v280.Text = v278.Name .. " \n" .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v278.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    v278.Handle["NameEsp" .. Number].TextLabel.Text = v278.Name .. " " .. v246((game:GetService("Players").LocalPlayer.Character.Head.Position - v278.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v278.Handle:FindFirstChild("NameEsp" .. Number) then
                v278.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end

spawn(function()
    while wait() do
        pcall(function()
            if MobESP then
                for _, v282 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v282:FindFirstChild("HumanoidRootPart") then
                        if not v282:FindFirstChild("MobEap") then
                            local l_BillboardGui_0 = Instance.new("BillboardGui")
                            local l_TextLabel_0 = Instance.new("TextLabel")
                            l_BillboardGui_0.Parent = v282
                            l_BillboardGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_0.Active = true
                            l_BillboardGui_0.Name = "MobEap"
                            l_BillboardGui_0.AlwaysOnTop = true
                            l_BillboardGui_0.LightInfluence = 1
                            l_BillboardGui_0.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_0.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_0.Parent = l_BillboardGui_0
                            l_TextLabel_0.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_0.BackgroundTransparency = 1
                            l_TextLabel_0.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_0.Font = Enum.Font.GothamBold
                            l_TextLabel_0.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_0.Text.Size = 35
                        end
                        local v285 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v282.HumanoidRootPart.Position).Magnitude)
                        v282.MobEap.TextLabel.Text = v282.Name .. " - " .. v285 .. " Distance"
                    end
                end
            else
                for _, v287 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v287:FindFirstChild("MobEap") then
                        v287.MobEap:Destroy()
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if not SeaESP then
                for _, v289 in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v289:FindFirstChild("Seaesps") then
                        v289.Seaesps:Destroy()
                    end
                end
            else
                for _, v291 in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v291:FindFirstChild("HumanoidRootPart") then
                        if not v291:FindFirstChild("Seaesps") then
                            local l_BillboardGui_1 = Instance.new("BillboardGui")
                            local l_TextLabel_1 = Instance.new("TextLabel")
                            l_BillboardGui_1.Parent = v291
                            l_BillboardGui_1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_1.Active = true
                            l_BillboardGui_1.Name = "Seaesps"
                            l_BillboardGui_1.AlwaysOnTop = true
                            l_BillboardGui_1.LightInfluence = 1
                            l_BillboardGui_1.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_1.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_1.Parent = l_BillboardGui_1
                            l_TextLabel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_1.BackgroundTransparency = 1
                            l_TextLabel_1.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_1.Font = Enum.Font.GothamBold
                            l_TextLabel_1.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_1.Text.Size = 35
                        end
                        local v294 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v291.HumanoidRootPart.Position).Magnitude)
                        v291.Seaesps.TextLabel.Text = v291.Name .. " - " .. v294 .. " Distance"
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if not NpcESP then
                for _, v296 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v296:FindFirstChild("NpcEspes") then
                        v296.NpcEspes:Destroy()
                    end
                end
            else
                for _, v298 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v298:FindFirstChild("HumanoidRootPart") then
                        if not v298:FindFirstChild("NpcEspes") then
                            local l_BillboardGui_2 = Instance.new("BillboardGui")
                            local l_TextLabel_2 = Instance.new("TextLabel")
                            l_BillboardGui_2.Parent = v298
                            l_BillboardGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            l_BillboardGui_2.Active = true
                            l_BillboardGui_2.Name = "NpcEspes"
                            l_BillboardGui_2.AlwaysOnTop = true
                            l_BillboardGui_2.LightInfluence = 1
                            l_BillboardGui_2.Size = UDim2.new(0, 200, 0, 50)
                            l_BillboardGui_2.StudsOffset = Vector3.new(0, 2.5, 0)
                            l_TextLabel_2.Parent = l_BillboardGui_2
                            l_TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            l_TextLabel_2.BackgroundTransparency = 1
                            l_TextLabel_2.Size = UDim2.new(0, 200, 0, 50)
                            l_TextLabel_2.Font = Enum.Font.GothamBold
                            l_TextLabel_2.TextColor3 = Color3.fromRGB(7, 236, 240)
                            l_TextLabel_2.Text.Size = 35
                        end
                        local v301 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v298.HumanoidRootPart.Position).Magnitude)
                        v298.NpcEspes.TextLabel.Text = v298.Name .. " - " .. v301 .. " Distance"
                    end
                end
            end
        end)
    end
end)

function isnil(v302)
    local v303 = nil
    if v302 ~= v303 then
        local _ = false
    end
    return true
end

local function v306(v305)
    return math.floor(tonumber(v305) + 0.5)
end

Number = math.random(1, 1000000)

function UpdateIslandMirageESP()
    for _, v308 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v308_0 = v308
            pcall(function()
                if not MirageIslandESP then
                    if l_v308_0:FindFirstChild("NameEsp") then
                        l_v308_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v308_0.Name == "Mirage Island" then
                    if l_v308_0:FindFirstChild("NameEsp") then
                        l_v308_0.NameEsp.TextLabel.Text = l_v308_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v308_0.Position).Magnitude / 3) .. " M"
                    else
                        local v310 = Instance.new("BillboardGui", l_v308_0)
                        v310.Name = "NameEsp"
                        v310.ExtentsOffset = Vector3.new(0, 1, 0)
                        v310.Size = UDim2.new(1, 200, 1, 30)
                        v310.Adornee = l_v308_0
                        v310.AlwaysOnTop = true
                        local v311 = Instance.new("TextLabel", v310)
                        v311.Font = "Code"
                        v311.FontSize = "Size14"
                        v311.TextWrapped = true
                        v311.Size = UDim2.new(1, 0, 1, 0)
                        v311.TextYAlignment = "Top"
                        v311.BackgroundTransparency = 1
                        v311.TextStrokeTransparency = 0.5
                        v311.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end

function UpdatePrehistoricIslandESP()
    for _, v313 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v313_0 = v313
            pcall(function()
                if not PrehistoricIslandESP then
                    if l_v313_0:FindFirstChild("NameEsp") then
                        l_v313_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v313_0.Name == "PrehistoricIsland" then
                    if not l_v313_0:FindFirstChild("NameEsp") then
                        local v315 = Instance.new("BillboardGui", l_v313_0)
                        v315.Name = "NameEsp"
                        v315.ExtentsOffset = Vector3.new(0, 1, 0)
                        v315.Size = UDim2.new(1, 200, 1, 30)
                        v315.Adornee = l_v313_0
                        v315.AlwaysOnTop = true
                        local v316 = Instance.new("TextLabel", v315)
                        v316.Font = "Code"
                        v316.FontSize = "Size14"
                        v316.TextWrapped = true
                        v316.Size = UDim2.new(1, 0, 1, 0)
                        v316.TextYAlignment = "Top"
                        v316.BackgroundTransparency = 1
                        v316.TextStrokeTransparency = 0.5
                        v316.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        l_v313_0.NameEsp.TextLabel.Text = l_v313_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v313_0.Position).Magnitude / 3) .. " M"
                    end
                end
            end)
        end
    end
end

function UpdateAfdESP()
    for _, v318 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v318_0 = v318
            pcall(function()
                if not AfdESP then
                    if l_v318_0:FindFirstChild("NameEsp") then
                        l_v318_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v318_0.Name == "Advanced Fruit Dealer" then
                    if l_v318_0:FindFirstChild("NameEsp") then
                        l_v318_0.NameEsp.TextLabel.Text = l_v318_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v318_0.Position).Magnitude / 3) .. " M"
                    else
                        local v320 = Instance.new("BillboardGui", l_v318_0)
                        v320.Name = "NameEsp"
                        v320.ExtentsOffset = Vector3.new(0, 1, 0)
                        v320.Size = UDim2.new(1, 200, 1, 30)
                        v320.Adornee = l_v318_0
                        v320.AlwaysOnTop = true
                        local v321 = Instance.new("TextLabel", v320)
                        v321.Font = "Code"
                        v321.FontSize = "Size14"
                        v321.TextWrapped = true
                        v321.Size = UDim2.new(1, 0, 1, 0)
                        v321.TextYAlignment = "Top"
                        v321.BackgroundTransparency = 1
                        v321.TextStrokeTransparency = 0.5
                        v321.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end

function UpdateAuraESP()
    for _, v323 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v323_0 = v323
            pcall(function()
                if AuraESP then
                    if l_v323_0.Name == "Master of Enhancement" then
                        if l_v323_0:FindFirstChild("NameEsp") then
                            l_v323_0.NameEsp.TextLabel.Text = l_v323_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v323_0.Position).Magnitude / 3) .. " M"
                        else
                            local v325 = Instance.new("BillboardGui", l_v323_0)
                            v325.Name = "NameEsp"
                            v325.ExtentsOffset = Vector3.new(0, 1, 0)
                            v325.Size = UDim2.new(1, 200, 1, 30)
                            v325.Adornee = l_v323_0
                            v325.AlwaysOnTop = true
                            local v326 = Instance.new("TextLabel", v325)
                            v326.Font = "Code"
                            v326.FontSize = "Size14"
                            v326.TextWrapped = true
                            v326.Size = UDim2.new(1, 0, 1, 0)
                            v326.TextYAlignment = "Top"
                            v326.BackgroundTransparency = 1
                            v326.TextStrokeTransparency = 0.5
                            v326.TextColor3 = Color3.fromRGB(80, 245, 245)
                        end
                    end
                elseif l_v323_0:FindFirstChild("NameEsp") then
                    l_v323_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end

function UpdateLSDESP()
    for _, v328 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        do
            local l_v328_0 = v328
            pcall(function()
                if LADESP then
                    if l_v328_0.Name == "Legendary Sword Dealer" then
                        if l_v328_0:FindFirstChild("NameEsp") then
                            l_v328_0.NameEsp.TextLabel.Text = l_v328_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v328_0.Position).Magnitude / 3) .. " M"
                        else
                            local v330 = Instance.new("BillboardGui", l_v328_0)
                            v330.Name = "NameEsp"
                            v330.ExtentsOffset = Vector3.new(0, 1, 0)
                            v330.Size = UDim2.new(1, 200, 1, 30)
                            v330.Adornee = l_v328_0
                            v330.AlwaysOnTop = true
                            local v331 = Instance.new("TextLabel", v330)
                            v331.Font = "Code"
                            v331.FontSize = "Size14"
                            v331.TextWrapped = true
                            v331.Size = UDim2.new(1, 0, 1, 0)
                            v331.TextYAlignment = "Top"
                            v331.BackgroundTransparency = 1
                            v331.TextStrokeTransparency = 0.5
                            v331.TextColor3 = Color3.fromRGB(80, 245, 245)
                        end
                    end
                elseif l_v328_0:FindFirstChild("NameEsp") then
                    l_v328_0:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
end

spawn(function()
    while wait() do
        if InfAbility then
            InfAb()
        end
    end
end)

function InfAb()
    if InfAbility then
        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            local l_ParticleEmitter_0 = Instance.new("ParticleEmitter")
            l_ParticleEmitter_0.Acceleration = Vector3.new(0, 0, 0)
            l_ParticleEmitter_0.Archivable = true
            l_ParticleEmitter_0.Drag = 20
            l_ParticleEmitter_0.EmissionDirection = Enum.NormalId.Top
            l_ParticleEmitter_0.Enabled = true
            l_ParticleEmitter_0.Lifetime = NumberRange.new(0, 0)
            l_ParticleEmitter_0.LightInfluence = 0
            l_ParticleEmitter_0.LockedToPart = true
            l_ParticleEmitter_0.Name = "Agility"
            l_ParticleEmitter_0.Rate = 500
            local v333 = {NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 4)}
            l_ParticleEmitter_0.Size = NumberSequence.new(v333)
            l_ParticleEmitter_0.RotSpeed = NumberRange.new(9999, 99999)
            l_ParticleEmitter_0.Rotation = NumberRange.new(0, 0)
            l_ParticleEmitter_0.Speed = NumberRange.new(30, 30)
            l_ParticleEmitter_0.SpreadAngle = Vector2.new(0, 0, 0, 0)
            l_ParticleEmitter_0.Texture = ""
            l_ParticleEmitter_0.VelocityInheritance = 0
            l_ParticleEmitter_0.ZOffset = 2
            l_ParticleEmitter_0.Transparency = NumberSequence.new(0)
            l_ParticleEmitter_0.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0))
            l_ParticleEmitter_0.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        end
    elseif game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy()
    end
end

function UpdateGeaESP()
    for _, v335 in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
        do
            local l_v335_0 = v335
            pcall(function()
                if not GearESP then
                    if l_v335_0:FindFirstChild("NameEsp") then
                        l_v335_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v335_0.Name == "MeshPart" then
                    if not l_v335_0:FindFirstChild("NameEsp") then
                        local v337 = Instance.new("BillboardGui", l_v335_0)
                        v337.Name = "NameEsp"
                        v337.ExtentsOffset = Vector3.new(0, 1, 0)
                        v337.Size = UDim2.new(1, 200, 1, 30)
                        v337.Adornee = l_v335_0
                        v337.AlwaysOnTop = true
                        local v338 = Instance.new("TextLabel", v337)
                        v338.Font = "Code"
                        v338.FontSize = "Size14"
                        v338.TextWrapped = true
                        v338.Size = UDim2.new(1, 0, 1, 0)
                        v338.TextYAlignment = "Top"
                        v338.BackgroundTransparency = 1
                        v338.TextStrokeTransparency = 0.5
                        v338.TextColor3 = Color3.fromRGB(80, 245, 245)
                    else
                        l_v335_0.NameEsp.TextLabel.Text = l_v335_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v335_0.Position).Magnitude / 3) .. " M"
                    end
                end
            end)
        end
    end
end

function UpdateBerriesESP()
    local l_Tagged_0 = game:GetService("CollectionService"):GetTagged("BerryBush")
    for _, v341 in pairs(l_Tagged_0) do
        do
            local l_v341_0 = v341
            pcall(function()
                for _, v344 in pairs(l_v341_0:GetAttributes()) do
                    if not v344 then
                        if l_v341_0.Parent:FindFirstChild("NameEsp") then
                            l_v341_0.Parent:FindFirstChild("NameEsp"):Destroy()
                        end
                    else
                        if not l_v341_0.Parent:FindFirstChild("BerryESP") then
                            local v345 = Instance.new("BillboardGui", l_v341_0.Parent)
                            v345.Name = "BerryESP"
                            v345.ExtentsOffset = Vector3.new(0, 2, 0)
                            v345.Size = UDim2.new(1, 200, 1, 30)
                            v345.Adornee = l_v341_0.Parent
                            v345.AlwaysOnTop = true
                            local v346 = Instance.new("TextLabel", v345)
                            v346.Font = Enum.Font.GothamSemibold
                            v346.TextSize = 14
                            v346.TextWrapped = true
                            v346.Size = UDim2.new(1, 0, 1, 0)
                            v346.TextYAlignment = Enum.TextYAlignment.Top
                            v346.BackgroundTransparency = 1
                            v346.TextStrokeTransparency = 0.5
                            v346.TextColor3 = Color3.fromRGB(128, 0, 128)
                            v346.Text = v344
                        end
                        if l_v341_0.Parent:FindFirstChild("BerryESP") then
                            local l_LocalPlayer_0 = game.Players.LocalPlayer
                            if l_LocalPlayer_0 and l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("Head") then
                                local l_Position_0 = l_LocalPlayer_0.Character.Head.Position
                                local l_Magnitude_0 = (l_v341_0.Parent:GetPivot().Position - l_Position_0).Magnitude
                                l_v341_0.Parent.BerryESP.TextLabel.Text = v344 .. "\n" .. math.floor(l_Magnitude_0) .. "m"
                            end
                        end
                    end
                end
            end)
        end
    end
end

function UpdateIslandKisuneESP()
    for _, v351 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        do
            local l_v351_0 = v351
            pcall(function()
                if not KitsuneIslandEsp then
                    if l_v351_0:FindFirstChild("NameEsp") then
                        l_v351_0:FindFirstChild("NameEsp"):Destroy()
                    end
                elseif l_v351_0.Name == "Kitsune Island" then
                    if l_v351_0:FindFirstChild("NameEsp") then
                        l_v351_0.NameEsp.TextLabel.Text = l_v351_0.Name .. "   \n" .. v306((game:GetService("Players").LocalPlayer.Character.Head.Position - l_v351_0.Position).Magnitude / 3) .. " M"
                    else
                        local v353 = Instance.new("BillboardGui", l_v351_0)
                        v353.Name = "NameEsp"
                        v353.ExtentsOffset = Vector3.new(0, 1, 0)
                        v353.Size = UDim2.new(1, 200, 1, 30)
                        v353.Adornee = l_v351_0
                        v353.AlwaysOnTop = true
                        local v354 = Instance.new("TextLabel", v353)
                        v354.Font = "Code"
                        v354.FontSize = "Size14"
                        v354.TextWrapped = true
                        v354.Size = UDim2.new(1, 0, 1, 0)
                        v354.TextYAlignment = "Top"
                        v354.BackgroundTransparency = 1
                        v354.TextStrokeTransparency = 0.5
                        v354.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            end)
        end
    end
end

function AutoHaki()
    local l_Character_0 = game:GetService("Players").LocalPlayer.Character
    if l_Character_0 and not l_Character_0:FindFirstChild("HasBuso") then
        local l_CommF__0 = game:GetService("ReplicatedStorage").Remotes.CommF_
        if l_CommF__0 then
            l_CommF__0:InvokeServer("Buso")
        end
    end
end

function UnEquipWeapon(v357)
    if game.Players.LocalPlayer.Character:FindFirstChild(v357) then
        _G.NotAutoEquip = true
        wait(0.5)
        game.Players.LocalPlayer.Character:FindFirstChild(v357).Parent = game.Players.LocalPlayer.Backpack
        wait(0.1)
        _G.NotAutoEquip = false
    end
end

function EquipWeapon(v358)
    if not _G.NotAutoEquip and game.Players.LocalPlayer.Backpack:FindFirstChild(v358) then
        Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(v358)
        wait(0.1)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
    end
end

spawn(function()
    local v359 = getrawmetatable(game)
    local l___namecall_0 = v359.__namecall
    setreadonly(v359, false)
    v359.__namecall = newcclosure(function(...)
        local v361 = getnamecallmethod()
        local v362 = {...}
        if tostring(v361) == "FireServer" and tostring(v362[1]) == "RemoteEvent" and tostring(v362[2]) ~= "true" and tostring(v362[2]) ~= "false" and _G.UseSkill then
            if type(v362[2]) ~= "vector" then
                v362[2] = CFrame.new(PositionSkillMasteryDevilFruit)
            else
                v362[2] = PositionSkillMasteryDevilFruit
            end
            return l___namecall_0(unpack(v362))
        else
            return l___namecall_0(...)
        end
    end)
end)

spawn(function()
    pcall(function()
        while task.wait() do
            for _, v364 in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v364:IsA("Tool") and v364:FindFirstChild("RemoteFunctionShoot") then
                    CurrentEquipGun = v364.Name
                end
            end
        end
    end)
end)

function StopTween(v365)
    local l_Character_1 = game:GetService("Players").LocalPlayer.Character
    if not v365 then
        _G.StopTween = true
        wait(0.2)
        topos(l_Character_1.HumanoidRootPart.CFrame)
        wait(0.2)
        if l_Character_1.HumanoidRootPart:FindFirstChild("BodyClip") then
            l_Character_1.HumanoidRootPart.BodyClip:Destroy()
        end
        if l_Character_1:FindFirstChild("Block") then
            l_Character_1.Block:Destroy()
        end
        _G.StopTween = false
        _G.Clip = false
    end
    if l_Character_1:FindFirstChild("Highlight") then
        l_Character_1.Highlight:Destroy()
    end
end

function LockTween()
    if _G.LockTween then
        return 
    else
        _G.LockTween = true
        wait()
        local l_Character_2 = game.Players.LocalPlayer.Character
        if l_Character_2 and l_Character_2:IsDescendantOf(game.Workspace) then
            local l_HumanoidRootPart_0 = l_Character_2:WaitForChild("HumanoidRootPart")
            if l_HumanoidRootPart_0 then
                l_HumanoidRootPart_0.CFrame = l_HumanoidRootPart_0.CFrame
            end
        end
        wait()
        if l_Character_2:FindFirstChild("BodyClip") then
            l_Character_2.BodyClip:Destroy()
        end
        if l_Character_2:FindFirstChild("PartTele") then
            l_Character_2.Block:Destroy()
        end
        _G.LockTween = false
        return 
    end
end

function BringMob(v369)
    for _, v371 in pairs(WS.Enemies:GetChildren()) do
        if v371.Name == v369 and v371.Parent and v371:FindFirstChild("HumanoidRootPart") and v371:FindFirstChild("Humanoid") and v371.Humanoid.Health > 0 and (v371.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 350 then
            v371.HumanoidRootPart.CFrame = BringPos
            v371.Humanoid.JumpPower = 0
            v371.Humanoid.WalkSpeed = 0
            v371.HumanoidRootPart.Transparency = 1
            v371.HumanoidRootPart.CanCollide = false
            v371.Head.CanCollide = false
            if v371.Humanoid:FindFirstChild("Animator") then
                v371.Humanoid.Animator:Destroy()
            end
            if not v371.HumanoidRootPart:FindFirstChild("Lock") then
                local l_BodyVelocity_0 = Instance.new("BodyVelocity")
                l_BodyVelocity_0.Parent = v371.HumanoidRootPart
                l_BodyVelocity_0.Name = "Lock"
                l_BodyVelocity_0.MaxForce = Vector3.new(100000, 100000, 100000)
                l_BodyVelocity_0.Velocity = Vector3.new(0, 0, 0)
            end
            sethiddenproperty(plr, "SimulationRadius", math.huge)
            v371.Humanoid:ChangeState(11)
        end
    end
end

function CancelTween23()
    if plr.Character.Head:FindFirstChild("BodyVelocity") then
        plr.Character.Head:FindFirstChild("BodyVelocity"):Destroy()
    end
    if plr.Character:FindFirstChild("PartTele") then
        plr.Character:FindFirstChild("PartTele"):Destroy()
    end
    NoClip = false
    return Tween23(plr.Character.HumanoidRootPart.CFrame)
end

function KillMob(v373, v374)
    pcall(function()
        thismob = DetectMob2(v373)
        if thismob:FindFirstChild("HumanoidRootPart") and thismob.Parent and thismob:FindFirstChild("Humanoid") and thismob.Humanoid.Health > 0 then
            repeat
                task.wait()
                Buso()
                EquipWeapon()
                Tween23(thismob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                BringPos = thismob.HumanoidRootPart.CFrame
                BringMob(v373)
                NoClip = true
            until not thismob.Parent or not thismob:FindFirstChild("Humanoid") or thismob:FindFirstChild("Humanoid").Health <= 0 or not thismob:FindFirstChild("HumanoidRootPart") or v374()
            NoClip = false
            CancelTween23()
        end
    end)
end

spawn(function()
    while wait() do
        pcall(function()
            if NoClip ~= true then
                if plr.Character.Head:FindFirstChild("Nigga") then
                    plr.Character.Head:FindFirstChild("Nigga"):Destroy()
                end
            else
                if not plr.Character.Head:FindFirstChild("Nigga") then
                    local v375 = Instance.new("BodyVelocity", plr.Character.Head)
                    v375.P = 1500
                    v375.Name = "Nigga"
                    v375.MaxForce = Vector3.new(0, 100000, 0)
                    v375.Velocity = Vector3.new(0, 0, 0)
                end
                for _, v377 in pairs(plr.Character:GetDescendants()) do
                    if v377:IsA("BasePart") then
                        v377.CanCollide = false
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while task.wait() do
        pcall(function()
            local l_Character_3 = game:GetService("Players").LocalPlayer.Character
            local l_HumanoidRootPart_1 = l_Character_3:FindFirstChild("HumanoidRootPart")
            if (l_Character_3.Humanoid.Health <= 0 or not l_HumanoidRootPart_1) and l_Character_3:FindFirstChild("Block") then
                l_Character_3.Block:Destroy()
            end
        end)
    end
end)

spawn(function()
    while task.wait() do
        pcall(function()
            local l_Character_4 = game:GetService("Players").LocalPlayer.Character
            local l_HumanoidRootPart_2 = l_Character_4:FindFirstChild("HumanoidRootPart")
            if l_Character_4:FindFirstChild("Block") and (l_HumanoidRootPart_2.Position - l_Character_4.Block.Position).Magnitude >= 100 then
                l_Character_4.Block:Destroy()
            end
        end)
    end
end)

function enableNoclip()
    if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
        local l_BodyVelocity_1 = Instance.new("BodyVelocity")
        l_BodyVelocity_1.Name = "BodyClip"
        l_BodyVelocity_1.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
        l_BodyVelocity_1.MaxForce = Vector3.new(100000, 100000, 100000)
        l_BodyVelocity_1.Velocity = Vector3.new(0, 0, 0)
    end
end

function disableNoclip()
    local l_BodyClip_0 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip")
    if l_BodyClip_0 then
        l_BodyClip_0:Destroy()
    end
end

function disableCollisions()
    for _, v385 in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v385:IsA("BasePart") then
            v385.CanCollide = false
        end
    end
end

local _, _ = pcall(function()
    return getgenv().Module
end)

spawn(function()
    pcall(function()
        while task.wait(0.2) do
            if getgenv().Module or _G.DefendVolcano or getgenv().AutoFarm then
                enableNoclip()
                disableCollisions()
            else
                disableNoclip()
            end
        end
    end)
end)

function EquipAllWeapon()
    pcall(function()
        for _, v389 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v389:IsA("Tool") and v389.Name ~= "Summon Sea Beast" and v389.Name ~= "Water Body" and v389.Name ~= "Awakening" then
                local l_FirstChild_0 = game.Players.LocalPlayer.Backpack:FindFirstChild(v389.Name)
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(l_FirstChild_0)
                wait(1)
            end
        end
    end)
end

local v391 = false

function WaitHRP(v392)
    if v392 then
        return v392.Character:WaitForChild("HumanoidRootPart", 9)
    else
        return 
    end
end

function CheckNearestTeleporter(v393)
    local l_Position_1 = v393.Position
    local l_huge_0 = math.huge
    local v396 = nil
    local l_PlaceId_1 = game.PlaceId
    local v398 = {}
    if l_PlaceId_1 ~= 85211729168715 then
        if l_PlaceId_1 ~= 79091703265657 then
            if l_PlaceId_1 == 100117331123089 then
                v398 = {
                    ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
                    ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
                    Mansion = Vector3.new(-12462, 375, -7552),
                    Castle = Vector3.new(-5036, 315, -3179),
                    ["Dimensional Shift"] = Vector3.new(-2097.3447265625, 4776.24462890625, -15013.4990234375),
                    ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
                    ["Beautiful Room"] = Vector3.new(5314.58203, 22.5364361, -125.942276, 1, 2.14762768E-8, -1.99111154E-13, -2.14762768E-8, 1, -3.0510602E-8, 1.98455903E-13, 3.0510602E-8, 1),
                    ["Temple of Time"] = Vector3.new(28286, 14897, 103)
                }
            end
        else
            v398 = {
                ["Swan Mansion"] = Vector3.new(-390, 332, 673),
                ["Swan Room"] = Vector3.new(2285, 15, 905),
                ["Cursed Ship"] = Vector3.new(923, 126, 32852),
                ["Zombie Island"] = Vector3.new(-6509, 83, -133)
            }
        end
    else
        v398 = {
            Sky3 = Vector3.new(-7894, 5547, -380),
            Sky3Exit = Vector3.new(-4607, 874, -1667),
            UnderWater = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            UnderwaterExit = Vector3.new(4050, -1, -1814)
        }
    end
    for _, v400 in pairs(v398) do
        local l_Magnitude_1 = (v400 - l_Position_1).Magnitude
        if l_Magnitude_1 < l_huge_0 then
            l_huge_0 = l_Magnitude_1
            v396 = v400
        end
    end
    if l_huge_0 <= (l_Position_1 - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude then
        return v396
    else
        return 
    end
end

function requestEntrance(v402)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", v402)
    local l_HumanoidRootPart_3 = game.Players.LocalPlayer.Character.HumanoidRootPart
    l_HumanoidRootPart_3.CFrame = l_HumanoidRootPart_3.CFrame + Vector3.new(0, 50, 0)
    task.wait(0.5)
end

function TelePPlayer(v404)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v404
end

function topos(v405)
    local l_LocalPlayer_1 = game.Players.LocalPlayer
    if l_LocalPlayer_1.Character and l_LocalPlayer_1.Character.Humanoid.Health > 0 and l_LocalPlayer_1.Character:FindFirstChild("HumanoidRootPart") then
        local l_Magnitude_2 = (v405.Position - l_LocalPlayer_1.Character.HumanoidRootPart.Position).Magnitude
        if not v405 then
            return 
        else
            local v408 = CheckNearestTeleporter(v405)
            if v408 then
                requestEntrance(v408)
            end
            if not l_LocalPlayer_1.Character:FindFirstChild("PartTele") then
                local v409 = Instance.new("Part", l_LocalPlayer_1.Character)
                v409.Size = Vector3.new(10, 1, 10)
                v409.Name = "PartTele"
                v409.Anchored = true
                v409.Transparency = 1
                v409.CanCollide = true
                v409.CFrame = WaitHRP(l_LocalPlayer_1).CFrame
                do
                    local l_v409_0 = v409
                    l_v409_0:GetPropertyChangedSignal("CFrame"):Connect(function()
                        if not v391 then
                            return 
                        else
                            task.wait()
                            if l_LocalPlayer_1.Character and l_LocalPlayer_1.Character:FindFirstChild("HumanoidRootPart") then
                                WaitHRP(l_LocalPlayer_1).CFrame = l_v409_0.CFrame
                            end
                            return 
                        end
                    end)
                end
            end
            v391 = true
            local v411 = game:GetService("TweenService"):Create(l_LocalPlayer_1.Character.PartTele, TweenInfo.new(l_Magnitude_2 / 360, Enum.EasingStyle.Linear), {CFrame = v405})
            v411:Play()
            v411.Completed:Connect(function(v412)
                if v412 == Enum.PlaybackState.Completed then
                    if l_LocalPlayer_1.Character:FindFirstChild("PartTele") then
                        l_LocalPlayer_1.Character.PartTele:Destroy()
                    end
                    v391 = false
                end
            end)
        end
    end
end

function stopTeleport()
    v391 = false
    local l_LocalPlayer_2 = game.Players.LocalPlayer
    if l_LocalPlayer_2.Character:FindFirstChild("PartTele") then
        l_LocalPlayer_2.Character.PartTele:Destroy()
    end
end

spawn(function()
    while task.wait() do
        if not v391 then
            stopTeleport()
        end
    end
end)

spawn(function()
    local l_LocalPlayer_3 = game.Players.LocalPlayer
    while task.wait() do
        pcall(function()
            if l_LocalPlayer_3.Character:FindFirstChild("PartTele") and (l_LocalPlayer_3.Character.HumanoidRootPart.Position - l_LocalPlayer_3.Character.PartTele.Position).Magnitude >= 100 then
                stopTeleport()
            end
        end)
    end
end)

local l_LocalPlayer_4 = game.Players.LocalPlayer
local function v417(v416)
    v416:WaitForChild("Humanoid").Died:Connect(function()
        stopTeleport()
    end)
end
l_LocalPlayer_4.CharacterAdded:Connect(v417)
if l_LocalPlayer_4.Character then
    v417(l_LocalPlayer_4.Character)
end

function TP1(v418)
    topos(v418)
end

spawn(function()
    while wait() do
        if _G.SpinPos then
            Pos = CFrame.new(0, PosY, -20)
            wait(0.1)
            Pos = CFrame.new(-20, PosY, 0)
            wait(0.1)
            Pos = CFrame.new(0, PosY, 20)
            wait(0.1)
            Pos = CFrame.new(20, PosY, 0)
        else
            Pos = CFrame.new(0, PosY, 0)
        end
    end
end)

spawn(function()
    while task.wait() do
        pcall(function()
            if _G.FarmBone or _G.AutoFarm or _G.Pray or _G.Trylux or _G.Hallow or _G.FarmCake or _G.FarmDaiBan or _G.Greybeard or _G.CursedCaptain or _G.AutoDarkBoss or _G.ChiefWarden or _G.Trident or _G.Longsword or _G.GravityBlade or _G.SwodsFlail or _G.AutoRengoku or _G.SwodsDRTrident or _G.SwodCanvande or _G.SwodsBuddy or _G.FarmBlazeEM or _G.AutoFindPrehistoric or _G.TweenVolcano or _G.DefendVolcano or _G.KillGolem or _G.SwodTwinHooks or _G.Fullykatakuri or _G.AutoBoss or _G.SwodCanvander or _G.AutoFarmMaterial or _G.AutoSecondSea or _G.Autosaw or _G.ChiefWarden or _G.Trident or _G.AutoSaber or _G.ThirdSea or _G.AutoBartilo or _G.AutoFactory or _G.Longsword or _G.GravityBlade or _G.SwodsFlail or _G.AutoRengoku or _G.SwodsDRTrident or _G.SwodTwinHooks or _G.SwodCanvander or _G.AutoRaidPirate or _G.AutoQuestYama or _G.AutoYamaQuest or _G.AutoSaber or _G.DefendVolcano or _G.TPB or _G.SailBoat or _G.Autoterrorshark or _G.KillShark or _G.KillPiranha or _G.KillFishCrew or _G.AutoQuestRace or _G.Dungeon or _G.AutoLawRaid or _G.Tweenfruit or ProjectTrialPro or _G.TweenMGear or _G.AutoMysticIsland or AutoUpgradeRace or AutoRaceEvo1 or _G.AutoFarmFruits or _G.Autopole or _G.Autosaw or _G.AutoElitehunter or FarmMtrFruit or _G.AutoNear or _G.CollectBerry or _G.RipIndraKill or _G.FarmChocola or SoulGuitar or _G.AutoHolyTorch or _G.AutoGetTushita or _G.AutoYama or _G.AutoMobDragon or _G.AutoHydraTree or _G.TweenToKitsune or _G.AutoDooHee or _G.AutoAzuerEmber or _G.TweenVolcano or _G.Dungeon or _G.AutoLawRaid or _G.TweenFruit or _G.Grabfruit or _G.TeleportIsland or _G.TeleportNPC or _G.SafeMode or _G.AutoPlayerHunter or _G.AutoKillPlayer or _G.TeleportPly or _G.AutoQuestBoss or _G.AutoAllBoss or _G.AutoFarmLevelNew or _G.FarmSummer or _G.BossPain then
                if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local l_BodyVelocity_2 = Instance.new("BodyVelocity")
                    l_BodyVelocity_2.Name = "BodyClip"
                    l_BodyVelocity_2.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                    l_BodyVelocity_2.MaxForce = Vector3.new(100000, 100000, 100000)
                    l_BodyVelocity_2.Velocity = Vector3.new(0, 0, 0)
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
            if _G.FarmBone or _G.AutoFarm or _G.Pray or _G.Trylux or _G.Hallow or _G.FarmCake or _G.FarmDaiBan or _G.Fullykatakuri or _G.AutoBoss or _G.AutoMateria or _G.AutoSecondSea or _G.Autosaw or _G.ChiefWarden or _G.Trident or _G.AutoSaber or _G.Greybeard or _G.CursedCaptain or _G.AutoDarkBoss or _G.ChiefWarden or _G.Trident or _G.Longsword or _G.GravityBlade or _G.SwodsFlail or _G.AutoRengoku or _G.SwodsDRTrident or _G.SwodCanvande or _G.SwodTwinHooks or _G.ThirdSea or _G.AutoBartilo or _G.AutoFactory or _G.Longsword or _G.GravityBlade or _G.SwodsFlail or _G.AutoRengoku or _G.SwodsDRTrident or _G.SwodTwinHooks or _G.SwodCanvander or _G.SwodsBuddy or _G.FarmBlazeEM or _G.AutoFindPrehistoric or _G.TweenVolcano or _G.DefendVolcano or _G.KillGolem or _G.AutoRaidPirate or _G.AutoQuestYama or _G.AutoYamaQuest or _G.AutoElitehunter or FarmMtrFruit or AutoUpgradeRace or _G.AutoFarmMaterial or AutoRaceEvo1 or AutoSaber or _G.Autopole or _G.SwodCanvander or _G.DefendVolcano or _G.SailBoat or _G.Autoterrorshark or _G.KillShark or _G.KillPiranha or _G.KillFishCrew or _G.AutoQuestRace or _G.Dungeon or _G.AutoLawRaid or _G.Tweenfruit or ProjectTrialPro or _G.AutoMysticIsland or _G.TweenMGear or _G.Autosaw or _G.AutoNear or _G.AutoFarmFruits or _G.CollectBerry or _G.RipIndraKill or _G.FarmChocola or SoulGuitar or _G.AutoHolyTorch or _G.AutoGetTushita or _G.AutoYama or _G.AutoMobDragon or _G.AutoHydraTree or _G.TweenToKitsune or _G.AutoDooHee or _G.AutoAzuerEmber or _G.TweenVolcano or _G.Dungeon or _G.AutoLawRaid or _G.TweenFruit or _G.Grabfruit or _G.TeleportIsland or _G.TeleportNPC or _G.SafeMode or _G.AutoPlayerHunter or _G.AutoKillPlayer or _G.TeleportPly or _G.AutoQuestBoss or _G.AutoAllBoss or _G.AutoFarmLevelNew or _G.FarmSummer or _G.BossPain then
                for _, v421 in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v421:IsA("BasePart") then
                        v421.CanCollide = false
                    end
                end
            end
        end)
    end
end)

local v422 = {}

function TP13(v423)
    local l_Magnitude_3 = (v423.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local v425 = game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(l_Magnitude_3 / TweenSpeed, Enum.EasingStyle.Linear), {CFrame = v423}):Play()
    v422.Stop = function(_)
        v425:Cancel()
    end
    return v422
end

function fastpos(v427)
    Distance = (v427.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    Speed = 1000
    game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), {CFrame = v427}):Play()
end

function slowpos(v428)
    Distance = (v428.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    Speed = 150
    game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear), {CFrame = v428}):Play()
end

local _ = {}

function BTP(v430)
    pcall(function()
        if (v430.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 and not Auto_Raid and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
            repeat
                wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v430
                wait(0.05)
                game.Players.LocalPlayer.Character.Head:Destroy()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v430
            until (v430.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0
        end
    end)
end

function TelePPlayer(v431)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v431
end

function TPB(v432)
    local v433 = game:service("TweenService")
    local v434 = TweenInfo.new((game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.CFrame.Position - v432.Position).Magnitude / 300, Enum.EasingStyle.Linear)
    tween = v433:Create(game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat, v434, {CFrame = v432})
    tween:Play()
    return {Stop = function(_)
        tween:Cancel()
    end}
end

function TPP(v436)
    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then
        local v437 = game:service("TweenService")
        local v438 = TweenInfo.new((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v436.Position).Magnitude / 325, Enum.EasingStyle.Linear)
        tween = v437:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, v438, {CFrame = v436})
        tween:Play()
        return {Stop = function(_)
            tween:Cancel()
        end}
    else
        tween:Cancel()
        repeat
            wait()
        until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
        wait(7)
        return 
    end
end

function StopTween(v440)
    if not v440 then
        _G.StopTween = true
        wait()
        topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
        end
        _G.StopTween = false
        _G.Clip = false
    end
end

spawn(function()
    pcall(function()
        while wait() do
            for _, v442 in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v442:IsA("Tool") and v442:FindFirstChild("RemoteFunctionShoot") then
                    _G.SelectWeaponGun = v442.Name
                end
            end
        end
    end)
end)

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

function CheckColorRipIndra()
    mmb = {}
    for _, v444 in next, game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:GetChildren() do
        if v444:IsA("Part") and v444:FindFirstChild("Part") and v444.Part.BrickColor.Name == "Dark stone grey" then
            mmb[v444.BrickColor.Name] = v444
        end
    end
    return mmb
end

function ActivateColor(v445)
    haki = {["Hot pink"] = "Winter Sky", ["Really red"] = "Pure Red", Oyster = "Snow White"}
    runnay = haki[v445]
    if runnay then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", runnay)
    end
end

function AutoActiveColorRip_Indra()
    for v446, v447 in pairs(CheckColorRipIndra()) do
        ActivateColor(v446)
        topos(v447.CFrame)
        firetouchinterest(v447.TouchInterest)
    end
end

function CheckRace()
    local v448 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
    local v449 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1")
    if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
        if v448 == -2 then
            return game:GetService("Players").LocalPlayer.Data.Race.Value .. " V3"
        elseif v449 == -2 then
            return game:GetService("Players").LocalPlayer.Data.Race.Value .. " V2"
        else
            return game:GetService("Players").LocalPlayer.Data.Race.Value .. " V1"
        end
    else
        return game:GetService("Players").LocalPlayer.Data.Race.Value .. " V4"
    end
end

_G.TargTrial = "TargTrial"

function targettrial()
    if _G.TargTrial == "TargTrial" then
        local v450 = nil
        local v451 = 450
        for _, v453 in pairs(game.Players:GetChildren()) do
            c = (v453.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if c <= v451 and v453 ~= game.Players.LocalPlayer then
                v451 = c
                v450 = v453
            end
        end
        if v450 == "c" then
            return 
        elseif _G.TargTrial == "c" then
            _G.TargTrial = v450
            return 
        else
            return 
        end
    else
        return 
    end
end

function CheckPirateBoat()
    local v454 = {"PirateBrigade", "PirateBrigade"}
    for _, v456 in next, game:GetService("Workspace").Enemies:GetChildren() do
        if table.find(v454, v456.Name) and v456:FindFirstChild("Health") and v456.Health.Value > 0 then
            return v456
        end
    end
end

function CheckPirateBoat()
    local v457 = {"FishBoat"}
    for _, v459 in next, game:GetService("Workspace").Enemies:GetChildren() do
        if table.find(v457, v459.Name) and v459:FindFirstChild("Health") and v459.Health.Value > 0 then
            return v459
        end
    end
end

function StoreFruit()
    for _, v461 in pairs(thelocal.Backpack:GetChildren()) do
        if v461:IsA("Tool") and string.find(v461.Name, "Fruit") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v461:GetAttribute("OriginalName"), v461)
        end
    end
end

function TpEntrance(v462)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", v462)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
    wait(0.5)
end

function CheckItemBPCRBPCR(v463)
    chbp = {game.Players.LocalPlayer.Character, game.Players.LocalPlayer.Backpack}
    for _, v465 in pairs(chbp) do
        if v465:FindFirstChild(v463) then
            return v465:FindFirstChild(v463)
        end
    end
end

-- ==================== CREATE UI WITH BANANAHUB ====================

local window = Library:CreateWindow({
    Title = "HAO MOD HUB",
    SubTitle = "By HaoMod",
    Image = "rbxassetid:// 89947810111304"
})

-- Farming Tab
local tabFarming = window:AddTab("Farming")
local sectionWeapon = tabFarming:AddSection("Select Melee,Sword,Gun,Fruit")
_G.SelectWeapon = "Melee"

task.spawn(function()
    while task.wait() do
        pcall(function()
            if _G.SelectWeapon ~= "Melee" then
                if _G.SelectWeapon ~= "Sword" then
                    if _G.SelectWeapon == "Gun" then
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Gun" then
                                _G.SelectWeapon = v.Name
                            end
                        end
                    elseif _G.SelectWeapon == "Fruit" or _G.SelectWeapon == "Blox Fruit" then
                        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ToolTip == "Blox Fruit" then
                                _G.SelectWeapon = v.Name
                            end
                        end
                    end
                else
                    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v.ToolTip == "Sword" then
                            _G.SelectWeapon = v.Name
                        end
                    end
                end
            else
                for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ToolTip == "Melee" then
                        _G.SelectWeapon = v.Name
                    end
                end
            end
        end)
    end
end)

sectionWeapon:AddDropdown("WeaponType", {
    Text = "Chọn Công Cụ",
    Values = {"Melee", "Sword", "Gun", "Blox Fruit"},
    Default = "Melee",
    Callback = function(v)
        _G.SelectWeapon = v
    end
})

local sectionMainFarm = tabFarming:AddSection("Main Farm")
sectionMainFarm:AddToggle("AutoFarm", {
    Text = "Auto Farm Level 1-2650",
    Desc = "Tự động farm cấp",
    Default = false,
    Callback = function(v)
        _G.AutoFarm = v
        StopTween(_G.AutoFarm)
    end
})

sectionMainFarm:AddToggle("AutoFarmLevelNew", {
    Text = "Farm Level New 2650 - 2750",
    Desc = "Cày Cấp ở Đảo Mới",
    Default = false,
    Callback = function(v)
        _G.AutoFarmLevelNew = v
        StopTween(_G.AutoFarmLevelNew)
    end
})

sectionMainFarm:AddToggle("AutoNear", {
    Text = "Auto Kill Near | Mob Aura",
    Desc = "Đánh Quái Gần",
    Default = false,
    Callback = function(v)
        _G.AutoNear = v
        StopTween(_G.AutoNear)
    end
})

local sectionSummer = tabFarming:AddSection("Farm Summer Token New")
sectionSummer:AddToggle("FarmSummer", {
    Text = "Auto Farm Summer Token",
    Desc = "Tự động Di Chuyển đến Vị Trí Summer Token Theo Sea Và Farm Quái [Electrified]",
    Default = false,
    Callback = function(v)
        _G.FarmSummer = v
        StopTween(_G.FarmSummer)
    end
})

local bossOptions = {}
if World1 then
    bossOptions = {
        "The Gorilla King",
        "Bobby",
        "Yeti",
        "Mob Leader",
        "Vice Admiral",
        "Warden",
        "Chief Warden",
        "Swan",
        "Magma Admiral",
        "Fishman Lord",
        "Wysper",
        "Thunder God",
        "Cyborg",
        "Saber Expert"
    }
elseif World2 then
    bossOptions = {
        "Diamond",
        "Jeremy",
        "Fajita",
        "Don Swan",
        "Smoke Admiral",
        "Cursed Captain",
        "Darkbeard",
        "Order",
        "Awakened Ice Admiral",
        "Tide Keeper"
    }
elseif World3 then
    bossOptions = {
        "",
        "Stone",
        "Island Empress",
        "Hydra Leader",
        "Kilo Admiral",
        "Captain Elephant",
        "Beautiful Pirate",
        "rip_indra True Form",
        "Longma",
        "Soul Reaper",
        "Cake Queen"
    }
end

local sectionBossPain = tabFarming:AddSection("Event Boss Pain New")
sectionBossPain:AddDropdown("SelectBoss", {
    Text = "Auto Select Boss",
    Values = bossOptions,
    Default = bossOptions[1],
    Callback = function(v)
        _G.SelectBoss = v
    end
})

sectionBossPain:AddToggle("BossPain", {
    Text = "Farm Boss Pain",
    Desc = "Farm Boss đã Chọn",
    Default = false,
    Callback = function(v)
        _G.BossPain = v
        StopTween(_G.BossPain)
    end
})

local sectionRaidPirate = tabFarming:AddSection("AutoRaidPirate")
sectionRaidPirate:AddToggle("AutoRaidPirate", {
    Text = "Farm Pirate",
    Desc = "Đánh Hải Tặc Trên Pháo Đài Biển",
    Default = false,
    Callback = function(v)
        _G.AutoRaidPirate = v
        StopTween(_G.AutoRaidPirate)
    end
})

local sectionTyrant = tabFarming:AddSection("TyrantoftheSkies")
local eyesLabel = sectionTyrant:AddLabel("Loading...")
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local count = 0
            local eyes = {
                workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye1"),
                workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye2"),
                workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye3"),
                workspace.Map.TikiOutpost.IslandModel:FindFirstChild("Eye4")
            }
            for _, v in ipairs(eyes) do
                if v and v:IsA("BasePart") and v.Transparency == 0 then
                    count = count + 1
                end
            end
            eyesLabel:SetText("Status: " .. count .. " Eye(s)" .. (count == 4 and " ✅" or ""))
        end)
    end
end)

sectionTyrant:AddToggle("FarmDaiBan", {
    Text = "Auto Farm Tyrant",
    Desc = "Farm Quái Và Đánh Boss Chim",
    Default = false,
    Callback = function(v)
        _G.FarmDaiBan = v
        StopTween(_G.FarmDaiBan)
    end
})

sectionTyrant:AddToggle("Farm8Binhs", {
    Text = "Summon Tyrant Of The Skies",
    Desc = "Tự động Phá Bình Để Triệu Hồi Boss",
    Default = false,
    Callback = function(v)
        _G.Farm8Binhs = v
        StopTween(_G.Farm8Binhs)
    end
})

local sectionBone = tabFarming:AddSection("Xương")
local boneLabel = sectionBone:AddLabel("Loading...")
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local bones = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
            boneLabel:SetText("You Have: " .. tostring(bones) .. " Bones")
        end)
    end
end)

sectionBone:AddToggle("FarmBone", {
    Text = "Fram Bone",
    Desc = "Fram Xương",
    Default = false,
    Callback = function(v)
        _G.FarmBone = v
        StopTween(_G.FarmBone)
    end
})

sectionBone:AddToggle("Hallow", {
    Text = "Seperator Hallow Scythe",
    Desc = "Triệu hồi và tiêu diệt Soul Reaper",
    Default = false,
    Callback = function(v)
        _G.Hallow = v
        StopTween(_G.Hallow)
    end
})

sectionBone:AddToggle("Rdbone", {
    Text = "Trade Bone",
    Desc = "Tự động đổi xương lấy phần thưởng",
    Default = false,
    Callback = function(v)
        _G.Rdbone = v
        StopTween(_G.Rdbone)
    end
})

sectionBone:AddToggle("Pray", {
    Text = "Auto Pray",
    Default = false,
    Callback = function(v)
        _G.Pray = v
        StopTween(_G.Pray)
    end
})

sectionBone:AddToggle("Trylux", {
    Text = "Auto Try Luck",
    Default = false,
    Callback = function(v)
        _G.Trylux = v
        StopTween(_G.Trylux)
    end
})

local sectionKatakuri = tabFarming:AddSection("Katakuri")
local cakeLabel = sectionKatakuri:AddLabel("Loading...")
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local data = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
            if string.len(data) == 88 then
                cakeLabel:SetText("Killed : " .. string.sub(data, 39, 41) .. " / 500")
            elseif string.len(data) == 87 then
                cakeLabel:SetText("Killed : " .. string.sub(data, 39, 40) .. " / 500")
            elseif string.len(data) == 86 then
                cakeLabel:SetText("Killed : " .. string.sub(data, 39, 39) .. " / 500")
            else
                cakeLabel:SetText("Prince King Spawned ✅")
            end
        end)
    end
end)

sectionKatakuri:AddToggle("FarmCake", {
    Text = "Farm Katakuri",
    Desc = "Fram Quái Và Đánh Hoàng Tử Bột V1",
    Default = false,
    Callback = function(v)
        _G.FarmCake = v
        StopTween(_G.FarmCake)
    end
})

sectionKatakuri:AddToggle("Fullykatakuri", {
    Text = "Farm Katakuri V2",
    Desc = "Fram Quái Và Đánh Hoàng Tử Bột V2",
    Default = false,
    Callback = function(v)
        _G.Fullykatakuri = v
        StopTween(_G.Fullykatakuri)
    end
})

local sectionChestBerry = tabFarming:AddSection("Auto Farm Chest And Berry")
sectionChestBerry:AddToggle("CollectBerry", {
    Text = "Auto Collect Berry",
    Desc = "Tự động Nhặt Berry",
    Default = false,
    Callback = function(v)
        _G.CollectBerry = v
        StopTween(_G.CollectBerry)
    end
})

sectionChestBerry:AddToggle("FarmChest", {
    Text = "Auto Farm Chest [ Tween ]",
    Desc = "Tự động Nhặt rương bằng tween",
    Default = false,
    Callback = function(v)
        _G.FarmChest = v
        StopTween(_G.FarmChest)
    end
})

local sectionBossFarm = tabFarming:AddSection("Boss Fram")
sectionBossFarm:AddButton({
    Text = "Cập Nhật Boss",
    Desc = "Làm mới danh sách boss",
    Callback = function() end
})

local bossStatusLabel = sectionBossFarm:AddLabel("Initializing...")
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if _G.SelectBoss and (game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) or game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss)) then
                bossStatusLabel:SetText("Status: Boss Spawn ✅")
            else
                bossStatusLabel:SetText("Status: Boss Not Spawn ❌")
            end
        end)
    end
end)

local bossSelectOptions = {}
if World1 then
    bossSelectOptions = {
        "The Gorilla King",
        "Bobby",
        "Yeti",
        "Mob Leader",
        "Vice Admiral",
        "Warden",
        "Chief Warden",
        "Swan",
        "Magma Admiral",
        "Fishman Lord",
        "Wysper",
        "Thunder God",
        "Cyborg",
        "Saber Expert"
    }
elseif World2 then
    bossSelectOptions = {
        "Diamond",
        "Jeremy",
        "Fajita",
        "Don Swan",
        "Smoke Admiral",
        "Cursed Captain",
        "Darkbeard",
        "Order",
        "Awakened Ice Admiral",
        "Tide Keeper"
    }
elseif World3 then
    bossSelectOptions = {
        "",
        "Tyrant of the Skies",
        "Stone",
        "Island Empress",
        "Kilo Admiral",
        "Captain Elephant",
        "Beautiful Pirate",
        "rip_indra True Form",
        "Longma",
        "Soul Reaper",
        "Cake Queen"
    }
end

sectionBossFarm:AddDropdown("SelectBossFarm", {
    Text = "Auto Select Boss",
    Values = bossSelectOptions,
    Default = bossSelectOptions[1],
    Callback = function(v)
        _G.SelectBoss = v
    end
})

sectionBossFarm:AddToggle("AutoBoss", {
    Text = "Farm Boss",
    Desc = "Farm Boss đã Chọn",
    Default = false,
    Callback = function(v)
        _G.AutoBoss = v
        StopTween(_G.AutoBoss)
    end
})

local materialOptions = {}
if World1 then
    materialOptions = {"Magma Ore", "Angel Wings", "Leather", "Scrap Metal"}
elseif World2 then
    materialOptions = {"Radioactive", "Mystic Droplet", "Magma Ore", "Leather", "Ectoplasm", "Scrap Metal"}
elseif World3 then
    materialOptions = {"Leather", "Scrap Metal", "Conjured Cocoa", "Dragon Scale", "Gunpowder", "Fish Tail", "Mini Tusk"}
end

local sectionMaterial = tabFarming:AddSection("Material")
sectionMaterial:AddDropdown("SelectMaterial", {
    Text = "Select Material",
    Values = materialOptions,
    Default = materialOptions[1],
    Callback = function(v)
        _G.SelectMaterial = v
    end
})

sectionMaterial:AddToggle("AutoFarmMaterial", {
    Text = "Start Farm",
    Desc = "Tự động farm material đã chọn",
    Default = false,
    Callback = function(v)
        _G.AutoFarmMaterial = v
        StopTween(_G.AutoFarmMaterial)
    end
})

-- Auto Fishing Tab
local tabFishing = window:AddTab("Auto Fishing")
local sectionFishing = tabFishing:AddSection("Auto Fishing | Tự động Câu Cá")
sectionFishing:AddToggle("AutoFishing", {
    Text = "Auto Fishing",
    Desc = "Tự động Câu Cá Xoá Hiệu ứng Khi Câu",
    Default = false,
    Callback = function(v)
        _G.AutoFishing = v
    end
})

sectionFishing:AddDropdown("SelectBait", {
    Text = "Select Fishing Lure",
    Values = {"Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait"},
    Default = "Basic Bait",
    Callback = function(v)
        _G.SelectedBait = v
        game:GetService("ReplicatedStorage").FishReplicated.FishingRequest:InvokeServer("SelectBait", v)
    end
})

sectionFishing:AddDropdown("SelectRod", {
    Text = "Select Fishing Rod",
    Values = {"Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod"},
    Default = "Fishing Rod",
    Callback = function(v)
        _G.SelectedRod = v
    end
})

-- Quest | Items Tab
local tabQuest = window:AddTab("Quest | Items")

if World1 then
    local sectionSea1 = tabQuest:AddSection("Quest Sea 1")
    sectionSea1:AddToggle("AutoSecondSea", {
        Text = "AutoSecondSea",
        Desc = "Tự động Auto Quest Sea 2",
        Default = false,
        Callback = function(v)
            _G.AutoSecondSea = v
            StopTween(_G.AutoSecondSea)
        end
    })

    local sectionGreybeard = tabQuest:AddSection("Boss Greybeard")
    sectionGreybeard:AddToggle("Greybeard", {
        Text = "Kill Greybeard",
        Desc = "Tự động đánh Greybeard",
        Default = false,
        Callback = function(v)
            _G.Greybeard = v
            StopTween(_G.Greybeard)
        end
    })

    local sectionSword = tabQuest:AddSection("Quest Sword")
    sectionSword:AddToggle("AutoSaber", {
        Text = "Auto Get Saber",
        Desc = "Tự động Lấy Kiếm Saber",
        Default = false,
        Callback = function(v)
            _G.AutoSaber = v
            StopTween(_G.AutoSaber)
        end
    })

    sectionSword:AddToggle("Autopole", {
        Text = "Auto Get Sword Pole",
        Desc = "Tự động Lấy Kiếm Pole",
        Default = false,
        Callback = function(v)
            _G.Autopole = v
            StopTween(_G.Autopole)
        end
    })

    sectionSword:AddToggle("Autosaw", {
        Text = "Auto Get Sword Saw",
        Desc = "Tự động Lấy Kiếm Saw",
        Default = false,
        Callback = function(v)
            _G.Autosaw = v
            StopTween(_G.Autosaw)
        end
    })

    sectionSword:AddToggle("ChiefWarden", {
        Text = "Auto Get Sword Wardens",
        Desc = "Tự động Lấy Kiếm Wardens",
        Default = false,
        Callback = function(v)
            _G.ChiefWarden = v
            StopTween(_G.ChiefWarden)
        end
    })

    sectionSword:AddToggle("Trident", {
        Text = "Auto Get Sword Trident",
        Desc = "Tự động Lấy Kiếm Trident",
        Default = false,
        Callback = function(v)
            _G.Trident = v
            StopTween(_G.Trident)
        end
    })
end

if World2 then
    local sectionSea2 = tabQuest:AddSection("Quest Sea 2")
    sectionSea2:AddToggle("AutoBartilo", {
        Text = "Auto Quest Sea Bartilo",
        Desc = "Tự động Làm Nhiệm Vụ Sea Bartilo",
        Default = false,
        Callback = function(v)
            _G.AutoBartilo = v
            StopTween(_G.AutoBartilo)
        end
    })

    sectionSea2:AddToggle("ThirdSea", {
        Text = "Auto Quest Sea 3",
        Desc = "Tự động Làm Nhiệm Vụ Sang Sea 3",
        Default = false,
        Callback = function(v)
            _G.ThirdSea = v
            StopTween(_G.ThirdSea)
        end
    })

    local sectionFactory = tabQuest:AddSection("Factory Sea 2")
    sectionFactory:AddToggle("AutoFactory", {
        Text = "Auto Factory",
        Desc = "Tự động đánh Nhà Máy",
        Default = false,
        Callback = function(v)
            _G.AutoFactory = v
            StopTween(_G.AutoFactory)
        end
    })

    local sectionDarkBeard = tabQuest:AddSection("Boss Dark Beard")
    sectionDarkBeard:AddToggle("AutoDarkBoss", {
        Text = "Auto Kill Dark Beard",
        Desc = "Tự động đánh Râu Đen",
        Default = false,
        Callback = function(v)
            _G.AutoDarkBoss = v
            StopTween(_G.AutoDarkBoss)
        end
    })

    sectionDarkBeard:AddToggle("CursedCaptain", {
        Text = "Auto Kill Cursed Captain",
        Desc = "Tự động đánh Cursed Captain",
        Default = false,
        Callback = function(v)
            _G.CursedCaptain = v
            StopTween(_G.CursedCaptain)
        end
    })

    local sectionHaki = tabQuest:AddSection("Auto Buy Haki Màu")
    sectionHaki:AddToggle("AutoBuyEnchancementColour", {
        Text = "Auto Buy Haki Colors",
        Desc = "Tự động Mua Haki",
        Default = false,
        Callback = function(v)
            _G.AutoBuyEnchancementColour = v
            StopTween(_G.AutoBuyEnchancementColour)
        end
    })

    sectionHaki:AddToggle("AutoBuyLegendarySword", {
        Text = "Auto Buy Legendary Sword",
        Default = false,
        Callback = function(v)
            _G.AutoBuyLegendarySword = v
        end
    })

    local sectionSword2 = tabQuest:AddSection("Quest Sword")
    sectionSword2:AddToggle("Longsword", {
        Text = "Auto Get Longsword",
        Desc = "Tự động Get Longsword",
        Default = false,
        Callback = function(v)
            _G.Longsword = v
            StopTween(_G.Longsword)
        end
    })

    sectionSword2:AddToggle("GravityBlade", {
        Text = "Auto Get Sword Gravity Blade",
        Desc = "Tự động Lấy Gravity Blade",
        Default = false,
        Callback = function(v)
            _G.GravityBlade = v
            StopTween(_G.GravityBlade)
        end
    })

    sectionSword2:AddToggle("SwodsFlail", {
        Text = "Auto Get Sword Flail",
        Desc = "Tự động Lấy Flail",
        Default = false,
        Callback = function(v)
            _G.SwodsFlail = v
            StopTween(_G.SwodsFlail)
        end
    })

    sectionSword2:AddToggle("AutoRengoku", {
        Text = "Auto Get Sword Rengoku",
        Desc = "Tự động Lấy Rengoku",
        Default = false,
        Callback = function(v)
            _G.AutoRengoku = v
            StopTween(_G.AutoRengoku)
        end
    })

    sectionSword2:AddToggle("SwodsDRTrident", {
        Text = "Auto Get Sword Dragon Trident",
        Desc = "Tự động Lấy Dragon Trident",
        Default = false,
        Callback = function(v)
            _G.SwodsDRTrident = v
            StopTween(_G.SwodsDRTrident)
        end
    })
end

if World3 then
    local sectionSea3 = tabQuest:AddSection("Quest Sea 3")
    local sectionRipIndra = tabQuest:AddSection("Boss Rip indra")
    sectionRipIndra:AddToggle("RipIndraKill", {
        Text = "Auto kill Rip Indra",
        Desc = "Tự động đánh Rip Indra",
        Default = false,
        Callback = function(v)
            _G.RipIndraKill = v
            StopTween(_G.RipIndraKill)
        end
    })

    sectionRipIndra:AddToggle("AutoBuyEnchancementColour", {
        Text = "Auto Haki Colors",
        Desc = "Tự động Haki Colors",
        Default = false,
        Callback = function(v)
            _G.AutoBuyEnchancementColour = v
            StopTween(_G.AutoBuyEnchancementColour)
        end
    })

    local sectionSkullGuitar = tabQuest:AddSection("Quest Skull Guitar")
    sectionSkullGuitar:AddToggle("AutoSkullGuitar", {
        Text = "Auto Skull Guitar",
        Desc = "Tự động Lấy đàn GuiTar",
        Default = false,
        Callback = function(v)
            _G.AutoSkullGuitar = v
            StopTween(_G.AutoSkullGuitar)
        end
    })

    sectionSkullGuitar:AddToggle("AutoElitehunter", {
        Text = "Kill Elite Hunter",
        Desc = "Tự động đánh Elite Hunter",
        Default = false,
        Callback = function(v)
            _G.AutoElitehunter = v
            StopTween(_G.AutoElitehunter)
        end
    })

    local sectionCDK = tabQuest:AddSection("Auto CDK")
    sectionCDK:AddToggle("AutoGetCDK", {
        Text = "Auto Cdk [Beta]",
        Desc = "Tự động Lấy Xong Kiếm Ô Đen",
        Default = false,
        Callback = function(v)
            _G.AutoGetCDK = v
            StopTween(_G.AutoGetCDK)
        end
    })

    sectionCDK:AddToggle("AutoYama", {
        Text = "Auto Get Yama",
        Desc = "Tự động Lấy Kiếm Yama",
        Default = false,
        Callback = function(v)
            _G.AutoYama = v
            StopTween(_G.AutoYama)
        end
    })

    sectionCDK:AddToggle("AutoHolyTorch", {
        Text = "Auto Holy Torch Tushita",
        Desc = "Tự động Torch Tushita",
        Default = false,
        Callback = function(v)
            _G.AutoHolyTorch = v
            StopTween(_G.AutoHolyTorch)
        end
    })

    sectionCDK:AddToggle("AutoGetTushita", {
        Text = "Auto Get Tushita",
        Desc = "Tự động Lấy Tushita",
        Default = false,
        Callback = function(v)
            _G.AutoGetTushita = v
            StopTween(_G.AutoGetTushita)
        end
    })

    local sectionSword3 = tabQuest:AddSection("Quest Sword")
    sectionSword3:AddToggle("SwodTwinHooks", {
        Text = "Auto Get Sword Twin Hooks",
        Desc = "Tự động Lấy Kiếm Twin Hooks",
        Default = false,
        Callback = function(v)
            _G.SwodTwinHooks = v
            StopTween(_G.SwodTwinHooks)
        end
    })

    sectionSword3:AddToggle("SwodCanvander", {
        Text = "Auto Get Sword Canvander",
        Desc = "Tự động Lấy Kiếm Canvander",
        Default = false,
        Callback = function(v)
            _G.SwodCanvander = v
            StopTween(_G.SwodCanvander)
        end
    })

    sectionSword3:AddToggle("SwodsBuddy", {
        Text = "Auto Get Sword Buddy",
        Desc = "Tự động Lấy Kiếm Buddy",
        Default = false,
        Callback = function(v)
            _G.SwodsBuddy = v
            StopTween(_G.SwodsBuddy)
        end
    })
end

-- Volcano Dojo Tab
local tabVolcano = window:AddTab("Volcano Dojo")
tabVolcano:AddButton({
    Text = "Tween Dragon Dojo",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.53, 1013.09, -334.96))
        topos(CFrame.new(5841.29, 1208.32, 884.31))
    end
})

tabVolcano:AddToggle("FarmBlazeEM", {
    Text = "Auto Dragon Huntery",
    Desc = "Tự động Farm Blaze",
    Default = false,
    Callback = function(v)
        _G.FarmBlazeEM = v
        StopTween(_G.FarmBlazeEM)
    end
})

local sectionVolcanic = tabVolcano:AddSection("Volcanic Island")
sectionVolcanic:AddButton({
    Text = "Craft Volcanic Magnet",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Volcanic Magnet")
    end
})

local prehistoricLabel = sectionVolcanic:AddLabel("Loading...")
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
                prehistoricLabel:SetText("Prehistoric Island Spawning ✅")
            else
                prehistoricLabel:SetText("Prehistoric Island Not Spawn ❌")
            end
        end)
    end
end)

sectionVolcanic:AddToggle("Nocliprock", {
    Text = "Auto Find Prehistoric",
    Desc = "Tự động Tìm đảo Thời Tiền Sử ( đảo Núi Lửa )",
    Default = false,
    Callback = function(v)
        _G.AutoFindPrehistoric = v
        StopTween(_G.AutoFindPrehistoric)
    end
})

sectionVolcanic:AddToggle("TweenVolcano", {
    Text = "Auto Tween Prehistoric Island",
    Desc = "Tự động Bay Vào đảo Núi Lửa Volcano",
    Default = false,
    Callback = function(v)
        _G.TweenVolcano = v
        StopTween(_G.TweenVolcano)
    end
})

sectionVolcanic:AddToggle("DefendVolcano", {
    Text = "Auto Defend Prehistoric",
    Desc = "Xoá Lava",
    Default = false,
    Callback = function(v)
        _G.DefendVolcano = v
        StopTween(_G.DefendVolcano)
    end
})

local sectionAutoSkill = tabVolcano:AddSection("Auto Skill")
sectionAutoSkill:AddToggle("UseMelee", {
    Text = "Auto Use Melee",
    Desc = "Dùng Melee để Phá Lava",
    Default = false,
    Callback = function(v)
        _G.UseMelee = v
        StopTween(_G.UseMelee)
    end
})

sectionAutoSkill:AddToggle("UseSword", {
    Text = "Auto Use Sword",
    Desc = "Dùng Sword để Phá Lava",
    Default = false,
    Callback = function(v)
        _G.UseSword = v
        StopTween(_G.UseSword)
    end
})

sectionAutoSkill:AddToggle("UseGun", {
    Text = "Auto Use Gun",
    Desc = "Dùng Gun để Phá Lava",
    Default = false,
    Callback = function(v)
        _G.UseGun = v
        StopTween(_G.UseGun)
    end
})

local sectionKillGolem = tabVolcano:AddSection("Auto Kill Golem")
sectionKillGolem:AddToggle("KillGolem", {
    Text = "Auto Kill Golem",
    Desc = "Tự động Kill Golem",
    Default = false,
    Callback = function(v)
        _G.KillGolem = v
        StopTween(_G.KillGolem)
    end
})

sectionKillGolem:AddToggle("Kill_Aura", {
    Text = "Auto Kill Aura Golem",
    Desc = "Tự động Kill Aura Golem",
    Default = false,
    Callback = function(v)
        _G.Kill_Aura = v
        StopTween(_G.Kill_Aura)
    end
})

local sectionCollect = tabVolcano:AddSection("Auto Collect Bone,Egg")
sectionCollect:AddToggle("AutoCollectBone", {
    Text = "Auto Collect Bone",
    Desc = "Tự động Nhặt Xương",
    Default = false,
    Callback = function(v)
        _G.AutoCollectBone = v
        StopTween(_G.AutoCollectBone)
    end
})

sectionCollect:AddToggle("CollectEgg", {
    Text = "Auto Collect Egg",
    Desc = "Tự động Nhặt Trứng",
    Default = false,
    Callback = function(v)
        _G.CollectEgg = v
        StopTween(_G.CollectEgg)
    end
})

-- Sea Event Tab
local tabSea = window:AddTab("Sea Event")
local sectionKitsune = tabSea:AddSection("Kitsune Island")
local kitsuneLabel = sectionKitsune:AddLabel("Loading...")
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
                kitsuneLabel:SetText("Kitsune Island Spawning ✅")
            else
                kitsuneLabel:SetText("Kitsune Island Not Spawn ❌")
            end
        end)
    end
end)

sectionKitsune:AddToggle("TweenToKitsune", {
    Text = "Auto Tween Kitsune island",
    Desc = "Bay Vô đảo Kitsune",
    Default = false,
    Callback = function(v)
        _G.TweenToKitsune = v
        StopTween(_G.TweenToKitsune)
    end
})

sectionKitsune:AddToggle("KitsuneIslandEsp", {
    Text = "Esp Kitsune Island",
    Default = false,
    Callback = function(v)
        KitsuneIslandEsp = v
        if KitsuneIslandEsp then
            task.spawn(function()
                while KitsuneIslandEsp do
                    UpdateIslandKisuneESP()
                    task.wait(1)
                end
            end)
        else
            UpdateIslandKisuneESP()
        end
    end
})

sectionKitsune:AddToggle("AutoAzuerEmber", {
    Text = "Auto Azuer Ember",
    Desc = "Tự động Nhặt Linh Hồn Xanh",
    Default = false,
    Callback = function(v)
        _G.AutoAzuerEmber = v
        StopTween(_G.AutoAzuerEmber)
    end
})

local sectionSeaEvents = tabSea:AddSection("Sea Events")
sectionSeaEvents:AddToggle("SailBoat", {
    Text = "Auto Drive Boats",
    Desc = "Tự động Lái Thuyền",
    Default = false,
    Callback = function(v)
        _G.SailBoat = v
        StopTween(_G.SailBoat)
    end
})

sectionSeaEvents:AddToggle("Autoterrorshark", {
    Text = "Auto Kill Terror Shank",
    Desc = "Tự động đánh Terror Shank",
    Default = false,
    Callback = function(v)
        _G.Autoterrorshark = v
        StopTween(_G.Autoterrorshark)
    end
})

sectionSeaEvents:AddToggle("KillShark", {
    Text = "Auto Kill Shark",
    Desc = "Tự động đánh Shark",
    Default = false,
    Callback = function(v)
        _G.KillShark = v
        StopTween(_G.KillShark)
    end
})

sectionSeaEvents:AddToggle("KillPiranha", {
    Text = "Auto Kill Piranha",
    Desc = "Tự động đánh Piranha",
    Default = false,
    Callback = function(v)
        _G.KillPiranha = v
        StopTween(_G.KillPiranha)
    end
})

sectionSeaEvents:AddToggle("KillFishCrew", {
    Text = "Auto Kill Fish Crew Member",
    Desc = "Tự động Thành viên phi hành đoàn Auto Kill Fish",
    Default = false,
    Callback = function(v)
        _G.KillFishCrew = v
        StopTween(_G.KillFishCrew)
    end
})

local sectionMirage = tabSea:AddSection("Mirage Island")
local mirageLabel = sectionMirage:AddLabel("Loading...")
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if not game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
                mirageLabel:SetText("Mirage Island Not Spawn ❌")
            else
                mirageLabel:SetText("Mirage Island Spawning ✅")
            end
        end)
    end
end)

sectionMirage:AddToggle("AutoMysticIsland", {
    Text = "Tween Mirage Island",
    Desc = "Tự động Bay Tới đảo Bí ẩn",
    Default = false,
    Callback = function(v)
        _G.AutoMysticIsland = v
        StopTween(_G.AutoMysticIsland)
    end
})

sectionMirage:AddToggle("MirageIslandESP", {
    Text = "Esp Mirage Island",
    Desc = "Đánh Vị trí đảo Bí ẩn",
    Default = false,
    Callback = function(v)
        MirageIslandESP = v
        if MirageIslandESP then
            task.spawn(function()
                while MirageIslandESP do
                    UpdateIslandMirageESP()
                    task.wait(1)
                end
            end)
        else
            UpdateIslandMirageESP()
        end
    end
})

sectionMirage:AddToggle("AutoDooHee", {
    Text = "Look Moon + Auto V3",
    Desc = "Tự động Nhìn Trăng Và Bật Tộc V3",
    Default = false,
    Callback = function(v)
        _G.AutoDooHee = v
        StopTween(_G.AutoDooHee)
    end
})

sectionMirage:AddToggle("TweenMGear", {
    Text = "Auto Tween To Gear",
    Desc = "Tự động Bay đến Gear",
    Default = false,
    Callback = function(v)
        _G.TweenMGear = v
        StopTween(_G.TweenMGear)
    end
})

-- Race V4 Tab
local tabRace = window:AddTab("Race V4")
local sectionTeleportV4 = tabRace:AddSection("Teleport V4")
sectionTeleportV4:AddButton({
    Text = "Teleport To Top GreatTree",
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3030.39453125, 2280.6171875, -7320.18359375)
    end
})

sectionTeleportV4:AddButton({
    Text = "Teleport Temple Of Time",
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
    end
})

sectionTeleportV4:AddButton({
    Text = "Teleport Lever Pull",
    Callback = function()
        topos(CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734))
    end
})

sectionTeleportV4:AddButton({
    Text = "Teleport To The Clock",
    Callback = function()
        topos(CFrame.new(29553.7812, 15066.6133, -88.2750015, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    end
})

local sectionTrial = tabRace:AddSection("Trial V4")
sectionTrial:AddButton({
    Text = "Auto Race Door",
    Callback = function()
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        wait(0.1)
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        wait(0.1)
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        wait(0.1)
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        wait(0.5)
        if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
            topos(CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
            topos(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
            topos(CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
            topos(CFrame.new(28502.681640625, 14895.9755859375, -423.7279357910156))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
            topos(CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156))
        elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
            topos(CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094))
        end
    end
})

sectionTrial:AddButton({
    Text = "Buy Acient One Quest",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
    end
})

sectionTrial:AddToggle("Kill_Aura", {
    Text = "Auto Trial Human Ghost",
    Desc = "Tự động Trial",
    Default = false,
    Callback = function(v)
        _G.Kill_Aura = v
        StopTween(_G.Kill_Aura)
    end
})

sectionTrial:AddToggle("AutoQuestRace", {
    Text = "Auto Trailer All Race",
    Desc = "Tự động Trailer All Race",
    Default = false,
    Callback = function(v)
        _G.AutoQuestRace = v
        StopTween(_G.AutoQuestRace)
    end
})

sectionTrial:AddToggle("AutoKillV4", {
    Text = "Auto Kill Player Trailer V4",
    Desc = "Đánh Người Chơi Trong Trial",
    Default = false,
    Callback = function(v)
        _G.AutoKillV4 = v
        StopTween(_G.AutoKillV4)
    end
})

local sectionSkillV4 = tabRace:AddSection("Auto Skill")
sectionSkillV4:AddToggle("XaiSkillZ", {
    Text = "Auto Skill Z",
    Desc = "Tự động Dùng Skill Z để đánh",
    Default = false,
    Callback = function(v)
        _G.XaiSkillZ = v
        StopTween(_G.XaiSkillZ)
    end
})

sectionSkillV4:AddToggle("XaiSkillX", {
    Text = "Auto Skill X",
    Desc = "Tự động Dùng Skill X để đánh",
    Default = false,
    Callback = function(v)
        _G.XaiSkillX = v
        StopTween(_G.XaiSkillX)
    end
})

sectionSkillV4:AddToggle("XaiSkillC", {
    Text = "Auto Skill C",
    Desc = "Tự động Dùng Skill C để đánh",
    Default = false,
    Callback = function(v)
        _G.XaiSkillC = v
        StopTween(_G.XaiSkillC)
    end
})

-- Raid Fruits Tab
local tabRaid = window:AddTab("Raid Fruits")
local sectionRaid = tabRaid:AddSection("Raid Fruits")
sectionRaid:AddDropdown("SelectChip", {
    Text = "Select Chip",
    Values = {
        "Flame",
        "Ice",
        "Sand",
        "Dark",
        "Light",
        "Magma",
        "Quake",
        "Buddha",
        "Spider",
        "Phoenix",
        "Lightning",
        "Dough"
    },
    Default = "Flame",
    Callback = function(v)
        _G.SelectChip = v
    end
})

sectionRaid:AddToggle("AutoBuyChip", {
    Text = "Auto Buy Chip",
    Desc = "Tự động Mua Chip Raid",
    Default = false,
    Callback = function(v)
        _G.AutoBuyChip = v
    end
})

sectionRaid:AddToggle("StartRaid", {
    Text = "Auto Start Raid",
    Desc = "Bắt đầu Raid",
    Default = false,
    Callback = function(v)
        _G.StartRaid = v
    end
})

sectionRaid:AddToggle("Dungeon", {
    Text = "Auto Farm Raid Next Island",
    Desc = "Đánh Quái Và đi chuyển đảo",
    Default = false,
    Callback = function(v)
        _G.Dungeon = v
    end
})

sectionRaid:AddToggle("Autofruit", {
    Text = "Auto Get Fruit Low Beli",
    Desc = "Tự động Lấy Trái Ít Beli",
    Default = false,
    Callback = function(v)
        _G.Autofruit = v
    end
})

local sectionLaw = tabRaid:AddSection("Raid Law Sea 2")
sectionLaw:AddButton({
    Text = "Auto Buy Chip Law",
    Desc = "Tự động Mua Chip Law Raid",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
    end
})

sectionLaw:AddButton({
    Text = "Auto Start Raid Law",
    Callback = function()
        fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    end
})

sectionLaw:AddToggle("AutoLawRaid", {
    Text = "Auto Farm Law Raid",
    Desc = "Đánh Boss Law Raid",
    Default = false,
    Callback = function(v)
        _G.AutoLawRaid = v
    end
})

-- Fruits | Check Stock Tab
local tabFruits = window:AddTab("Fruits | Check Stock")
local sectionFruits = tabFruits:AddSection("Fruits")
sectionFruits:AddToggle("RandomAuto", {
    Text = "Auto Random Fruits",
    Desc = "Tự động Random Trái Ác Quỷ",
    Default = false,
    Callback = function(v)
        _G.RandomAuto = v
    end
})

sectionFruits:AddToggle("AutoStoreFruit", {
    Text = "Auto Store Fruits",
    Desc = "Tự động Lưu Trữ Trái Ác Quỷ Vào Kho đồ",
    Default = false,
    Callback = function(v)
        getgenv().AutoStoreFruit = v
    end
})

sectionFruits:AddToggle("Tweenfruit", {
    Text = "Teleport To Fruit Spawn",
    Desc = "Tự động Nhặt Trái Ác Quỷ Nếu Xuất Hiện Trong Sever",
    Default = false,
    Callback = function(v)
        _G.Tweenfruit = v
    end
})

sectionFruits:AddToggle("Grabfruit", {
    Text = "Auto Teleport Fruits",
    Desc = "Tự động Teleport đến Trái Ác Quỷ",
    Default = false,
    Callback = function(v)
        _G.Grabfruit = v
    end
})

local function formatNumber(num)
    local str = tostring(num)
    local k
    repeat
        str, k = str:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
    until k == 0
    return str
end

local stockLabel = tabFruits:AddLabel("Đang tải dữ liệu...")
local function updateStock()
    local text = "Advance Fruit Stock\n"
    local success, data = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", true)
    end)
    if not success or not data then
        text = text .. "- ❌ Lỗi khi lấy dữ liệu.\n"
    else
        local any = false
        for _, v in pairs(data) do
            if v.OnSale then
                any = true
                text = text .. v.Name .. " - $" .. formatNumber(v.Price) .. "\n"
            end
        end
        if not any then
            text = text .. "- Không có trái nào.\n"
        end
    end
    text = text .. "\nNormal Fruit Stock\n"
    local success2, data2 = pcall(function()
        return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
    end)
    if success2 and data2 then
        local any2 = false
        for _, v in pairs(data2) do
            if v.OnSale then
                any2 = true
                text = text .. v.Name .. " - $" .. formatNumber(v.Price) .. "\n"
            end
        end
        if not any2 then
            text = text .. "- Không có trái nào.\n"
        end
    else
        text = text .. "- ❌ Lỗi khi lấy dữ liệu.\n"
    end
    stockLabel:SetText(text)
end
task.spawn(function()
    while task.wait(60) do
        pcall(updateStock)
    end
end)
pcall(updateStock)

-- Teleport Tab
local tabTeleport = window:AddTab("Teleport")
local sectionIsland = tabTeleport:AddSection("Teleport Island | Di Chuyển đến đảo")
local islandOptions = {}
if World1 then
    islandOptions = {
        "WindMill",
        "Marine",
        "Middle Town",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Snow Island",
        "MarineFord",
        "Colosseum",
        "Sky Island 1",
        "Sky Island 2",
        "Sky Island 3",
        "Prison",
        "Magma Village",
        "Under Water Island",
        "Fountain City",
        "Shank Room",
        "Mob Island"
    }
elseif World2 then
    islandOptions = {
        "The Cafe",
        "Frist Spot",
        "Dark Area",
        "Flamingo Mansion",
        "Flamingo Room",
        "Green Zone",
        "Factory",
        "Colossuim",
        "Zombie Island",
        "Two Snow Mountain",
        "Punk Hazard",
        "Cursed Ship",
        "Ice Castle",
        "Forgotten Island",
        "Ussop Island",
        "Mini Sky Island"
    }
elseif World3 then
    islandOptions = {
        "Mansion",
        "Port Town",
        "Great Tree",
        "Castle On The Sea",
        "MiniSky",
        "Hydra Island",
        "Floating Turtle",
        "Haunted Castle",
        "Ice Cream Island",
        "Peanut Island",
        "Cake Island",
        "Cocoa Island",
        "Candy Island",
        "Tiki Outpost",
        "Dragon Dojo"
    }
else
    islandOptions = {"Spawn"}
end

sectionIsland:AddDropdown("SelectIsland", {
    Text = "Select Island",
    Values = islandOptions,
    Default = islandOptions[1],
    Callback = function(v)
        _G.SelectIsland = v
    end
})

sectionIsland:AddToggle("TeleportIsland", {
    Text = "Auto Tween To Island",
    Desc = "Tự động di chuyển tới đảo đã chọn",
    Default = false,
    Callback = function(v)
        _G.TeleportIsland = v
        StopTween(_G.TeleportIsland)
    end
})

local sectionSeaTP = tabTeleport:AddSection("Teleport Sea | Di Chuyển Sea 1,2,3")
sectionSeaTP:AddButton({
    Text = "Sea 1",
    Desc = "Biển 1",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end
})
sectionSeaTP:AddButton({
    Text = "Sea 2",
    Desc = "Biển 2",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})
sectionSeaTP:AddButton({
    Text = "Sea 3",
    Desc = "Biển 3",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
})

-- PvP,Player Tab
local tabPvP = window:AddTab("PvP,Player")
local sectionTeleportPlayer = tabPvP:AddSection("Teleport Player | Di Chuyển đến Player")
sectionTeleportPlayer:AddButton({
    Text = "Get Quest Elite Players",
    Desc = "Nhận Nhiệm Vụ Người Chơi",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
    end
})

sectionTeleportPlayer:AddToggle("AutoPlayerHunter", {
    Text = "Auto Kill Player Quest",
    Desc = "Bay đến Người Chơi được Nhận Nhiệm Vụ",
    Default = false,
    Callback = function(v)
        _G.AutoPlayerHunter = v
        StopTween(_G.AutoPlayerHunter)
    end
})

sectionTeleportPlayer:AddToggle("SafeMode", {
    Text = "Auto Safe Mode",
    Desc = "Tự động An Toàn Di Chuyển Lên Trời An Toàn",
    Default = false,
    Callback = function(v)
        _G.SafeMode = v
        StopTween(_G.SafeMode)
    end
})

local sectionBuff = tabPvP:AddSection("Buff")
getgenv().WalkSpeedValue = 30
getgenv().JumpValue = 50

local function applySpeed(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        hum.WalkSpeed = getgenv().WalkSpeedValue
        hum.JumpPower = getgenv().JumpValue
        hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            hum.WalkSpeed = getgenv().WalkSpeedValue
        end)
    end
end
game.Players.LocalPlayer.CharacterAdded:Connect(applySpeed)
if game.Players.LocalPlayer.Character then
    applySpeed(game.Players.LocalPlayer.Character)
end

sectionBuff:AddSlider({
    Text = "Speed Chạy",
    Min = 26,
    Max = 300,
    Default = getgenv().WalkSpeedValue,
    Callback = function(v)
        getgenv().WalkSpeedValue = v
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = v
        end
    end
})

sectionBuff:AddSlider({
    Text = "Nhảy Cao",
    Min = 50,
    Max = 500,
    Default = getgenv().JumpValue,
    Callback = function(v)
        getgenv().JumpValue = v
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum.JumpPower = v
        end
    end
})

sectionBuff:AddToggle("RemoveLava", {
    Text = "Delete Lava",
    Desc = "Xoá Lava Tránh Bị Mất Thẻo Kid Lõi Dính Lava :))",
    Default = false,
    Callback = function(v)
        _G.RemoveLava = v
    end
})

local sectionEsp = tabPvP:AddSection("Esp | Đánh Vị trí...")
sectionEsp:AddToggle("ESPPlayer", {
    Text = "Esp Players",
    Default = false,
    Callback = function(v)
        ESPPlayer = v
        if ESPPlayer then
            task.spawn(function()
                while ESPPlayer do
                    UpdatePlayerChams()
                    task.wait(1)
                end
            end)
        else
            UpdatePlayerChams()
        end
    end
})

sectionEsp:AddToggle("ChestESP", {
    Text = "Esp Chest",
    Default = false,
    Callback = function(v)
        _G.ChestESP = v
        if not _G.ChestESP then
            UpdateChestESP()
        else
            task.spawn(function()
                while _G.ChestESP do
                    UpdateChestESP()
                    task.wait(1)
                end
            end)
        end
    end
})

sectionEsp:AddToggle("DevilFruitESP", {
    Text = "Esp Fruits",
    Default = false,
    Callback = function(v)
        DevilFruitESP = v
        if DevilFruitESP then
            task.spawn(function()
                while DevilFruitESP do
                    UpdateDevilChams()
                    task.wait(1)
                end
            end)
        else
            UpdateDevilChams()
        end
    end
})

sectionEsp:AddToggle("Berry", {
    Text = "Esp Berry",
    Default = false,
    Callback = function(v)
        Berry = v
        if not Berry then
            for _, bush in pairs(game:GetService("CollectionService"):GetTagged("BerryBush")) do
                if bush.Parent:FindFirstChild("BerryESP") then
                    bush.Parent.BerryESP:Destroy()
                end
            end
        else
            UpdateBerriesESP()
        end
    end
})

-- Shop Tab
local tabShop = window:AddTab("Shop")
local sectionMeleeV1 = tabShop:AddSection("Buy Melee V1")
sectionMeleeV1:AddButton({
    Text = "Buy Black Leg $150,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
    end
})
sectionMeleeV1:AddButton({
    Text = "Buy Electro $550,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
    end
})
sectionMeleeV1:AddButton({
    Text = "Buy Water Kung Fu $750,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    end
})
sectionMeleeV1:AddButton({
    Text = "Buy Dragon Claw 1,500F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
    end
})

local sectionMeleeV2 = tabShop:AddSection("Buy Melee V2")
sectionMeleeV2:AddButton({
    Text = "Buy Superhuman $3,000,000",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
    end
})
sectionMeleeV2:AddButton({
    Text = "Buy Death Step $5,000,000 5,000F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
    end
})
sectionMeleeV2:AddButton({
    Text = "Buy Sharkman Karate $2,500,000 5,000F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end
})
sectionMeleeV2:AddButton({
    Text = "Buy Electric Claw $3,000,000 5,000F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end
})
sectionMeleeV2:AddButton({
    Text = "Buy Dragon Talon $3,000,000 5,000F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end
})
sectionMeleeV2:AddButton({
    Text = "Buy God Human $5,000,000 5,000F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
    end
})
sectionMeleeV2:AddButton({
    Text = "Buy Sanguine Art $5,000,000 5,000F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt", true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
    end
})

local sectionSeaCraft = tabShop:AddSection("Buy Sea Event Crafting")
sectionSeaCraft:AddButton({ Text = "Craft Dragonheart", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonheart") end })
sectionSeaCraft:AddButton({ Text = "Craft Dragonstorm", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "Dragonstorm") end })
sectionSeaCraft:AddButton({ Text = "Craft DinoHood", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "DinoHood") end })
sectionSeaCraft:AddButton({ Text = "Craft SharkTooth", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkTooth") end })
sectionSeaCraft:AddButton({ Text = "Craft TerrorJaw", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "TerrorJaw") end })
sectionSeaCraft:AddButton({ Text = "Craft SharkAnchor", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "SharkAnchor") end })
sectionSeaCraft:AddButton({ Text = "Craft LeviathanCrown", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanCrown") end })
sectionSeaCraft:AddButton({ Text = "Craft LeviathanShield", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanShield") end })
sectionSeaCraft:AddButton({ Text = "Craft LeviathanBoat", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LeviathanBoat") end })
sectionSeaCraft:AddButton({ Text = "Craft LegendaryScroll", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "LegendaryScroll") end })
sectionSeaCraft:AddButton({ Text = "Craft MythicalScroll", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CraftItem", "Craft", "MythicalScroll") end })

local sectionHakiSoru = tabShop:AddSection("Buy Haki,Soru...")
sectionHakiSoru:AddButton({ Text = "Buy Geppo $10,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo") end })
sectionHakiSoru:AddButton({ Text = "Buy Buso Haki $25,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso") end })
sectionHakiSoru:AddButton({ Text = "Buy Soru $25,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru") end })
sectionHakiSoru:AddButton({ Text = "Buy Observation Haki $750,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy") end })

local sectionSwordGun = tabShop:AddSection("Buy Sword,Gun")
sectionSwordGun:AddButton({ Text = "Buy Cutlass $1,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cutlass") end })
sectionSwordGun:AddButton({ Text = "Buy Katana $1,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana") end })
sectionSwordGun:AddButton({ Text = "Buy Iron Mace $25,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace") end })
sectionSwordGun:AddButton({ Text = "Buy Dual Katana $12,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana") end })
sectionSwordGun:AddButton({ Text = "Buy Triple Katana $60,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana") end })
sectionSwordGun:AddButton({ Text = "Buy Pipe $100,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Pipe") end })
sectionSwordGun:AddButton({ Text = "Buy Dual-Headed Blade $400,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade") end })
sectionSwordGun:AddButton({ Text = "Buy Bisento $1,200,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento") end })
sectionSwordGun:AddButton({ Text = "Buy Soul Cane $750,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane") end })
sectionSwordGun:AddButton({ Text = "Buy Pole V2 5,000F", Callback = function() game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk") end })
sectionSwordGun:AddButton({ Text = "Buy Slingshot $5,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Slingshot") end })
sectionSwordGun:AddButton({ Text = "Buy Musket $8,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Musket") end })
sectionSwordGun:AddButton({ Text = "Buy Flintlock $10,500", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Flintlock") end })
sectionSwordGun:AddButton({ Text = "Refined Slingshot $30,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock") end })
sectionSwordGun:AddButton({ Text = "Buy Refined Flintlock $65,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock") end })
sectionSwordGun:AddButton({ Text = "Buy Cannon $100,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cannon") end })
sectionSwordGun:AddButton({ Text = "Buy Kabucha 1,500F", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "1") game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2") end })
sectionSwordGun:AddButton({ Text = "Buy Bizarre Rifle 250 Ectoplasm", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1) end })
sectionSwordGun:AddButton({ Text = "Buy Black Cape $50,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Black Cape") end })
sectionSwordGun:AddButton({ Text = "Swordsman Hat $150,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat") end })
sectionSwordGun:AddButton({ Text = "Buy Tomoe Ring $500,000", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring") end })

local sectionReset = tabShop:AddSection("Reset Stats , Random Race")
sectionReset:AddButton({
    Text = "Đổi Tộc Ghoul",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
    end
})
sectionReset:AddButton({
    Text = "Đổi Tộc Cyborg",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
    end
})
sectionReset:AddButton({
    Text = "Reset Stats 2,500F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
    end
})
sectionReset:AddButton({
    Text = "Random Race 3,000F",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
    end
})

-- Settings Tab
local tabSettings = window:AddTab("Settings")
local sectionFarmingSettings = tabSettings:AddSection("Settings Farming")
sectionFarmingSettings:AddLabel("Unban Fast Attack - M1 Fruit\nOn: ✅")
loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDangNhoEm/TuanAnhIOS/refs/heads/main/koby"))()

sectionFarmingSettings:AddToggle("BringMonster", {
    Text = "Bring Mod",
    Desc = "Tự động Gom Quái",
    Default = true,
    Callback = function(v)
        _G.BringMonster = v
        StopTween(_G.BringMonster)
    end
})

sectionFarmingSettings:AddToggle("CheckPoint", {
    Text = "Set Home Point",
    Desc = "Lưu điểm Hồi Sinh",
    Default = false,
    Callback = function(v)
        _G.CheckPoint = v
    end
})

sectionFarmingSettings:AddToggle("AutoHaki", {
    Text = "Infinite Soru",
    Default = false,
    Callback = function(v)
        _G.AutoHaki = v
    end
})

sectionFarmingSettings:AddToggle("AutoRaceV3", {
    Text = "Auto Active Race V3",
    Desc = "Tự động Bật Tộc V3",
    Default = false,
    Callback = function(v)
        _G.AutoRaceV3 = v
    end
})

sectionFarmingSettings:AddToggle("AutoRaceV4", {
    Text = "Auto Active Race V4",
    Desc = "Tự động Bật Tộc V4",
    Default = false,
    Callback = function(v)
        _G.AutoRaceV4 = v
    end
})

sectionFarmingSettings:AddToggle("InfiniteSoru", {
    Text = "Infinite Soru",
    Default = false,
    Callback = function(v)
        InfiniteSoru = v
    end
})

sectionFarmingSettings:AddToggle("DodgewithoutCool", {
    Text = "Dodge No CD",
    Default = false,
    Callback = function(v)
        DodgewithoutCool = v
    end
})

sectionFarmingSettings:AddToggle("InfiniteGeppo", {
    Text = "Infinite Geppo",
    Default = false,
    Callback = function(v)
        InfiniteGeppo = v
    end
})

sectionFarmingSettings:AddToggle("WalkWater", {
    Text = "Walk on Water",
    Default = true,
    Callback = function(v)
        _G.WalkWater = v
    end
})

local sectionSkillPoints = tabSettings:AddSection("Auto Increase Skill Points")
sectionSkillPoints:AddToggle("AutoMelee", {
    Text = "Melee",
    Desc = "Tự động Nâng điểm Melee",
    Default = false,
    Callback = function(v)
        v1193 = v
    end
})
sectionSkillPoints:AddToggle("AutoDefense", {
    Text = "Defense",
    Desc = "Tự động Nâng điểm Năng Lượng",
    Default = false,
    Callback = function(v)
        v1194 = v
    end
})
sectionSkillPoints:AddToggle("AutoSword", {
    Text = "Sword",
    Desc = "Tự động Nâng điểm Kiếm",
    Default = false,
    Callback = function(v)
        v1195 = v
    end
})
sectionSkillPoints:AddToggle("AutoGun", {
    Text = "Gun",
    Desc = "Tự động Nâng điểm Súng",
    Default = false,
    Callback = function(v)
        v1196 = v
    end
})
sectionSkillPoints:AddToggle("AutoFruit", {
    Text = "Fruits",
    Desc = "Tự động Nâng điểm Trái",
    Default = false,
    Callback = function(v)
        v1197 = v
    end
})

local sectionSea123 = tabSettings:AddSection("Sea 1,2,3")
sectionSea123:AddButton({
    Text = "Join Sea 1",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end
})
sectionSea123:AddButton({
    Text = "Join Sea 2",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})
sectionSea123:AddButton({
    Text = "Join Sea 3",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
})

local sectionOther = tabSettings:AddSection("Other")
sectionOther:AddButton({
    Text = "Join Pirates Team",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end
})
sectionOther:AddButton({
    Text = "Join Marines Team",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end
})
sectionOther:AddButton({
    Text = "Open Title Name",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getTitles")
        game.Players.LocalPlayer.PlayerGui.Main.Titles.Visible = true
    end
})
sectionOther:AddButton({
    Text = "FPS Boost",
    Desc = "Tăng Fps",
    Callback = function()
        settings().Rendering.QualityLevel = "Level01"
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                v.Enabled = false
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            end
        end
    end
})

local sectionCodes = tabSettings:AddSection("Auto Codes")
local codeList = {
    "NOMOREHACK",
    "BANEXPLOIT",
    "WildDares",
    "BossBuild",
    "GetPranked",
    "EARN_FRUITS",
    "FIGHT4FRUIT",
    "NOEXPLOITER",
    "NOOB2ADMIN",
    "CODESLIDE",
    "ADMINHACKED",
    "ADMINDARES",
    "fruitconcepts",
    "krazydares",
    "TRIPLEABUSE",
    "SEATROLLING",
    "24NOADMIN",
    "REWARDFUN",
    "Chandler",
    "NEWTROLL",
    "KITT_RESET",
    "Sub2CaptainMaui",
    "kittgaming",
    "Sub2Fer999",
    "Enyu_is_Pro",
    "Magicbus",
    "JCWK",
    "Starcodeheo",
    "Bluxxy",
    "fudd10_v2",
    "SUB2GAMERROBOT_EXP1",
    "Sub2NoobMaster123",
    "Sub2UncleKizaru",
    "Sub2Daigrock",
    "Axiore",
    "TantaiGaming",
    "StrawHatMaine",
    "Sub2OfficialNoobie",
    "Fudd10",
    "Bignews",
    "TheGreatAce",
    "SECRET_ADMIN",
    "SUB2GAMERROBOT_RESET1",
    "SUB2OFFICIALNOOBIE",
    "AXIORE",
    "BIGNEWS",
    "BLUXXY",
    "CHANDLER",
    "ENYU_IS_PRO",
    "FUDD10",
    "FUDD10_V2",
    "KITTGAMING",
    "MAGICBUS",
    "STARCODEHEO",
    "STRAWHATMAINE",
    "SUB2CAPTAINMAUI",
    "SUB2DAIGROCK",
    "SUB2FER999",
    "SUB2NOOBMASTER123",
    "SUB2UNCLEKIZARU",
    "TANTAIGAMING",
    "THEGREATACE"
}
sectionCodes:AddButton({
    Text = "Codes",
    Desc = "Tự động Nhập Hết Code",
    Callback = function()
        for _, code in ipairs(codeList) do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code)
            end)
            task.wait(0.1)
        end
    end
})

local sectionHop = tabSettings:AddSection("Sever Hop")
sectionHop:AddButton({
    Text = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
})
sectionHop:AddButton({
    Text = "Server Hop",
    Callback = function()
        Hop()
    end
})

-- FPS Counter (original from HAOMODHUB)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

pcall(function() setfpscap(120) end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RainbowFPS"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 1000
screenGui.IgnoreGuiInset = true
screenGui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 120, 0, 30)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundTransparency = 1
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.Font = Enum.Font.FredokaOne
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1
textLabel.TextStrokeTransparency = 0.2
textLabel.Text = "FPS: 0"
textLabel.Parent = frame

task.spawn(function()
    local hue = 0
    while true do
        hue = (hue + 0.005) % 1
        textLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        RunService.RenderStepped:Wait()
    end
end)

local frameCount = 0
local lastUpdate = tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastUpdate >= 1 then
        local fps = math.floor(frameCount / (now - lastUpdate))
        textLabel.Text = "FPS: " .. tostring(fps)
        frameCount = 0
        lastUpdate = now
    end
end)

-- End of script
