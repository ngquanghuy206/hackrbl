local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local Settings = {
    JumpEnabled = false,
    JumpPower = 1,
    SpeedEnabled = false,
    SpeedPower = 1,
    GodEnabled = false,
    OneHitEnabled = false,
    NoClipEnabled = false,
}

local defaultJump = 50
local defaultSpeed = 16
local jumpCount = 0
local airWalkEnabled = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ParkourAdmin"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui

local BubbleBtn = Instance.new("ImageButton")
BubbleBtn.Name = "BubbleBtn"
BubbleBtn.Size = UDim2.new(0, 64, 0, 64)
BubbleBtn.Position = UDim2.new(0, 16, 1, -90)
BubbleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BubbleBtn.BorderSizePixel = 0
BubbleBtn.ZIndex = 10
BubbleBtn.Image = "https://cdn.upanhlaylink.com/i/nNnEGNnE.jpeg"
BubbleBtn.ScaleType = Enum.ScaleType.Crop
BubbleBtn.Parent = ScreenGui

local BubbleCorner = Instance.new("UICorner")
BubbleCorner.CornerRadius = UDim.new(1, 0)
BubbleCorner.Parent = BubbleBtn

local BubbleStroke = Instance.new("UIStroke")
BubbleStroke.Color = Color3.fromRGB(220, 220, 220)
BubbleStroke.Thickness = 2
BubbleStroke.Parent = BubbleBtn

local pulseTween = TweenService:Create(BubbleBtn, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Size = UDim2.new(0, 70, 0, 70),
    Position = UDim2.new(0, 13, 1, -93)
})
pulseTween:Play()

local bubbleDragging = false
local bubbleDragStart, bubbleStartPos

BubbleBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        bubbleDragging = false
        bubbleDragStart = i.Position
        bubbleStartPos = BubbleBtn.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if bubbleDragStart and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - bubbleDragStart
        if delta.Magnitude > 5 then
            bubbleDragging = true
            pulseTween:Pause()
            BubbleBtn.Size = UDim2.new(0, 64, 0, 64)
            BubbleBtn.Position = UDim2.new(
                bubbleStartPos.X.Scale,
                bubbleStartPos.X.Offset + delta.X,
                bubbleStartPos.Y.Scale,
                bubbleStartPos.Y.Offset + delta.Y
            )
        end
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        if not bubbleDragging then
        else
            bubbleDragging = false
            bubbleDragStart = nil
            pulseTween:Play()
        end
    end
end)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 360, 0, 560)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -280)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Color = Color3.fromRGB(200, 200, 200)
Stroke.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 60)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = Header

local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 14)
HeaderFix.Position = UDim2.new(0, 0, 1, -14)
HeaderFix.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60)),
})
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 28)
Title.Position = UDim2.new(0, 15, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "Script Hỗ Trợ Parkour"
Title.TextColor3 = Color3.fromRGB(10, 10, 10)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -20, 0, 16)
SubTitle.Position = UDim2.new(0, 15, 0, 36)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Admin Dzi Meo Meo"
SubTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
SubTitle.TextSize = 11
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 5
CloseBtn.Parent = Header

local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(1, 0)
CloseBtnCorner.Parent = CloseBtn

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -10, 1, -130)
ScrollFrame.Position = UDim2.new(0, 5, 0, 65)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 650)
ScrollFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent = ScrollFrame

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 8)
Padding.Parent = ScrollFrame

local ContactBtn = Instance.new("TextButton")
ContactBtn.Size = UDim2.new(1, -24, 0, 44)
ContactBtn.Position = UDim2.new(0, 12, 1, -58)
ContactBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContactBtn.Text = "📞  Liên Hệ Admin"
ContactBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
ContactBtn.TextSize = 14
ContactBtn.Font = Enum.Font.GothamBold
ContactBtn.BorderSizePixel = 0
ContactBtn.ZIndex = 3
ContactBtn.Parent = MainFrame

local ContactCorner = Instance.new("UICorner")
ContactCorner.CornerRadius = UDim.new(0, 10)
ContactCorner.Parent = ContactBtn

local ContactStroke = Instance.new("UIStroke")
ContactStroke.Color = Color3.fromRGB(80, 80, 80)
ContactStroke.Thickness = 1
ContactStroke.Parent = ContactBtn

local ContactGradient = Instance.new("UIGradient")
ContactGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20)),
})
ContactGradient.Rotation = 90
ContactGradient.Parent = ContactBtn

local ContactPopup = Instance.new("Frame")
ContactPopup.Name = "ContactPopup"
ContactPopup.Size = UDim2.new(0, 340, 0, 190)
ContactPopup.Position = UDim2.new(0.5, -170, 0.5, -95)
ContactPopup.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
ContactPopup.BorderSizePixel = 0
ContactPopup.Visible = false
ContactPopup.ZIndex = 20
ContactPopup.Parent = ScreenGui

local PopupCorner = Instance.new("UICorner")
PopupCorner.CornerRadius = UDim.new(0, 14)
PopupCorner.Parent = ContactPopup

local PopupStroke = Instance.new("UIStroke")
PopupStroke.Color = Color3.fromRGB(180, 180, 180)
PopupStroke.Thickness = 2
PopupStroke.Parent = ContactPopup

local PopupHeader = Instance.new("Frame")
PopupHeader.Size = UDim2.new(1, 0, 0, 44)
PopupHeader.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PopupHeader.BorderSizePixel = 0
PopupHeader.ZIndex = 20
PopupHeader.Parent = ContactPopup

local PopupHCorner = Instance.new("UICorner")
PopupHCorner.CornerRadius = UDim.new(0, 14)
PopupHCorner.Parent = PopupHeader

local PopupHFix = Instance.new("Frame")
PopupHFix.Size = UDim2.new(1, 0, 0, 14)
PopupHFix.Position = UDim2.new(0, 0, 1, -14)
PopupHFix.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PopupHFix.BorderSizePixel = 0
PopupHFix.ZIndex = 20
PopupHFix.Parent = PopupHeader

local PopupHGrad = Instance.new("UIGradient")
PopupHGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80,80,80)),
})
PopupHGrad.Rotation = 90
PopupHGrad.Parent = PopupHeader

local PopupTitle = Instance.new("TextLabel")
PopupTitle.Size = UDim2.new(1, -50, 1, 0)
PopupTitle.Position = UDim2.new(0, 14, 0, 0)
PopupTitle.BackgroundTransparency = 1
PopupTitle.Text = "📞 Liên Hệ Admin"
PopupTitle.TextColor3 = Color3.fromRGB(10, 10, 10)
PopupTitle.TextSize = 15
PopupTitle.Font = Enum.Font.GothamBold
PopupTitle.TextXAlignment = Enum.TextXAlignment.Left
PopupTitle.ZIndex = 21
PopupTitle.Parent = PopupHeader

local PopupClose = Instance.new("TextButton")
PopupClose.Size = UDim2.new(0, 28, 0, 28)
PopupClose.Position = UDim2.new(1, -36, 0.5, -14)
PopupClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PopupClose.Text = "✕"
PopupClose.TextColor3 = Color3.fromRGB(220, 220, 220)
PopupClose.TextSize = 12
PopupClose.Font = Enum.Font.GothamBold
PopupClose.BorderSizePixel = 0
PopupClose.ZIndex = 22
PopupClose.Parent = PopupHeader

local PopupCloseCorner = Instance.new("UICorner")
PopupCloseCorner.CornerRadius = UDim.new(1, 0)
PopupCloseCorner.Parent = PopupClose

local function makeContactLink(parent, yPos, icon, labelText, color)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -24, 0, 38)
    Btn.Position = UDim2.new(0, 12, 0, yPos)
    Btn.BackgroundColor3 = color
    Btn.Text = icon .. "  " .. labelText
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 13
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    Btn.ZIndex = 21
    Btn.Parent = parent
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 9)
    BtnCorner.Parent = Btn
    return Btn
end

local DiscordBtn = makeContactLink(ContactPopup, 50, "💬", "Discord: discord.gg/ESZkGwk6v", Color3.fromRGB(88, 101, 242))
local FbBtn      = makeContactLink(ContactPopup, 96, "📘", "Facebook: fb.com/dzimeomeo", Color3.fromRGB(24, 119, 242))
local ZaloBtn    = makeContactLink(ContactPopup, 142, "📱", "Zalo: 0993329535", Color3.fromRGB(0, 150, 220))

local function showCopyToast(msg)
    local Toast = Instance.new("TextLabel")
    Toast.Size = UDim2.new(0, 260, 0, 36)
    Toast.Position = UDim2.new(0.5, -130, 0, 30)
    Toast.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Toast.Text = "✅ " .. msg
    Toast.TextColor3 = Color3.fromRGB(200, 200, 200)
    Toast.TextSize = 12
    Toast.Font = Enum.Font.Gotham
    Toast.BorderSizePixel = 0
    Toast.ZIndex = 30
    Toast.Parent = ScreenGui
    local TC = Instance.new("UICorner")
    TC.CornerRadius = UDim.new(0, 8)
    TC.Parent = Toast
    task.delay(2.5, function()
        TweenService:Create(Toast, TweenInfo.new(0.4), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        task.delay(0.4, function() Toast:Destroy() end)
    end)
end

DiscordBtn.MouseButton1Click:Connect(function()
    showCopyToast("Discord đã copy!")
    setclipboard("https://discord.gg/ESZkGwk6v")
end)

FbBtn.MouseButton1Click:Connect(function()
    showCopyToast("Facebook đã copy link!")
    setclipboard("https://www.facebook.com/share/14rHaf7efam/?mibextid=wwXIfr")
end)

ZaloBtn.MouseButton1Click:Connect(function()
    showCopyToast("Zalo đã copy số!")
    setclipboard("84993329535")
end)

PopupClose.MouseButton1Click:Connect(function()
    ContactPopup.Visible = false
end)

ContactBtn.MouseButton1Click:Connect(function()
    ContactPopup.Visible = not ContactPopup.Visible
end)

local function createToggleSection(parent, labelText, subText, onToggle)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -16, 0, 56)
    Card.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Card.BorderSizePixel = 0
    Card.Parent = parent

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 10)
    CardCorner.Parent = Card

    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Color3.fromRGB(50, 50, 50)
    CardStroke.Thickness = 1
    CardStroke.Parent = Card

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 0.55, 0)
    Label.Position = UDim2.new(0, 14, 0, 6)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 14
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Card

    local SubLabel = Instance.new("TextLabel")
    SubLabel.Size = UDim2.new(0.65, 0, 0.4, 0)
    SubLabel.Position = UDim2.new(0, 14, 0.55, 0)
    SubLabel.BackgroundTransparency = 1
    SubLabel.Text = subText
    SubLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
    SubLabel.TextSize = 10
    SubLabel.Font = Enum.Font.Gotham
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubLabel.Parent = Card

    local ToggleBg = Instance.new("Frame")
    ToggleBg.Size = UDim2.new(0, 50, 0, 26)
    ToggleBg.Position = UDim2.new(1, -64, 0.5, -13)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleBg.BorderSizePixel = 0
    ToggleBg.Parent = Card

    local ToggleBgCorner = Instance.new("UICorner")
    ToggleBgCorner.CornerRadius = UDim.new(1, 0)
    ToggleBgCorner.Parent = ToggleBg

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(0, 3, 0.5, -10)
    Knob.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    Knob.BorderSizePixel = 0
    Knob.Parent = ToggleBg

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    local isOn = false

    local function toggle()
        isOn = not isOn
        local goal = isOn and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
        local bgColor = isOn and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(50, 50, 50)
        local knobColor = isOn and Color3.fromRGB(10, 10, 10) or Color3.fromRGB(180, 180, 180)
        TweenService:Create(Knob, TweenInfo.new(0.15), {Position = goal, BackgroundColor3 = knobColor}):Play()
        TweenService:Create(ToggleBg, TweenInfo.new(0.15), {BackgroundColor3 = bgColor}):Play()
        onToggle(isOn)
    end

    ToggleBg.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            toggle()
        end
    end)

    return Card
end

local function createSlider(parent, labelText, minVal, maxVal, defaultVal, onChange)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -16, 0, 70)
    Card.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Card.BorderSizePixel = 0
    Card.Parent = parent

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 10)
    CardCorner.Parent = Card

    local CardStroke = Instance.new("UIStroke")
    CardStroke.Color = Color3.fromRGB(50, 50, 50)
    CardStroke.Thickness = 1
    CardStroke.Parent = Card

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0, 22)
    Label.Position = UDim2.new(0, 14, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Card

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.25, 0, 0, 22)
    ValueLabel.Position = UDim2.new(0.75, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(defaultVal)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.TextSize = 14
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = Card

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -28, 0, 6)
    Track.Position = UDim2.new(0, 14, 0, 40)
    Track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Track.BorderSizePixel = 0
    Track.Parent = Card

    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(1, 0)
    TrackCorner.Parent = Track

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill

    local SliderKnob = Instance.new("Frame")
    SliderKnob.Size = UDim2.new(0, 16, 0, 16)
    SliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
    SliderKnob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 0.5, 0)
    SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderKnob.BorderSizePixel = 0
    SliderKnob.ZIndex = 5
    SliderKnob.Parent = Track

    local SKCorner = Instance.new("UICorner")
    SKCorner.CornerRadius = UDim.new(1, 0)
    SKCorner.Parent = SliderKnob

    local dragging = false

    local function updateSlider(input)
        local trackPos = Track.AbsolutePosition.X
        local trackSize = Track.AbsoluteSize.X
        local relative = math.clamp((input.Position.X - trackPos) / trackSize, 0, 1)
        local value = math.floor(minVal + relative * (maxVal - minVal))
        Fill.Size = UDim2.new(relative, 0, 1, 0)
        SliderKnob.Position = UDim2.new(relative, 0, 0.5, 0)
        ValueLabel.Text = tostring(value)
        onChange(value)
    end

    Track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(i)
        end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(i)
        end
    end)

    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    return Card
end

createToggleSection(ScrollFrame, "⬆️  Nhảy Cao", "Bật/tắt nhảy cao hơn bình thường", function(on)
    Settings.JumpEnabled = on
    if not on then humanoid.JumpPower = defaultJump end
end)

createSlider(ScrollFrame, "Độ nhảy cao (x lần)", 1, 100, 1, function(val)
    Settings.JumpPower = val
    if Settings.JumpEnabled then humanoid.JumpPower = defaultJump * val end
end)

createToggleSection(ScrollFrame, "🏃  Chạy Nhanh", "Bật/tắt tốc độ chạy tăng cao", function(on)
    Settings.SpeedEnabled = on
    if not on then humanoid.WalkSpeed = defaultSpeed end
end)

createSlider(ScrollFrame, "Tốc độ chạy (x lần)", 1, 100, 1, function(val)
    Settings.SpeedPower = val
    if Settings.SpeedEnabled then humanoid.WalkSpeed = defaultSpeed * val end
end)

createToggleSection(ScrollFrame, "🛡️  Bất Tử", "Không thể bị giết bởi bất kỳ thứ gì", function(on)
    Settings.GodEnabled = on
    if on then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
end)

createToggleSection(ScrollFrame, "💀  One Hit Kill", "Một đấm = đối thủ chết ngay lập tức", function(on)
    Settings.OneHitEnabled = on
end)

createToggleSection(ScrollFrame, "🌫️  Đi Trên Không", "Nhảy 2 lần = bay | Nhảy 3 lần = huỷ", function(on)
    airWalkEnabled = on
    if not on then Settings.NoClipEnabled = false end
end)

humanoid.StateChanged:Connect(function(_, new)
    if new == Enum.HumanoidStateType.Jumping then
        jumpCount = jumpCount + 1
        if airWalkEnabled then
            if jumpCount == 2 then
                Settings.NoClipEnabled = true
                rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
                humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
            elseif jumpCount >= 3 then
                Settings.NoClipEnabled = false
                jumpCount = 0
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            end
        end
    elseif new == Enum.HumanoidStateType.Landed then
        jumpCount = 0
        Settings.NoClipEnabled = false
    end
end)

RunService.Heartbeat:Connect(function()
    if not character or not humanoid then return end
    if Settings.SpeedEnabled then humanoid.WalkSpeed = defaultSpeed * Settings.SpeedPower end
    if Settings.JumpEnabled then humanoid.JumpPower = defaultJump * Settings.JumpPower end
    if Settings.GodEnabled then humanoid.Health = humanoid.MaxHealth end
    if Settings.NoClipEnabled then
        rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
        rootPart.Anchored = false
    end
end)

RunService.Stepped:Connect(function()
    if not Settings.OneHitEnabled then return end
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherChar = otherPlayer.Character
            if otherChar then
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                local otherHuman = otherChar:FindFirstChild("Humanoid")
                if otherRoot and otherHuman then
                    if (rootPart.Position - otherRoot.Position).Magnitude < 5 then
                        otherHuman.Health = 0
                    end
                end
            end
        end
    end
end)

local draggingGui, dragStart, startPos = false, nil, nil

Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingGui = true
        dragStart = i.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if draggingGui and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local delta = i.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingGui = false
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 360, 0, 0),
        Position = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset + 280)
    }):Play()
    task.delay(0.25, function()
        MainFrame.Visible = false
        BubbleBtn.Visible = true
        pulseTween:Play()
    end)
end)

BubbleBtn.InputEnded:Connect(function(i)
    if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not bubbleDragging then
        pulseTween:Pause()
        BubbleBtn.Visible = false
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 360, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 360, 0, 560)
        }):Play()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    jumpCount = 0
    Settings.NoClipEnabled = false
end)
