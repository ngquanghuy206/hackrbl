local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local Settings = {
    JumpEnabled = false, JumpPower = 1,
    SpeedEnabled = false, SpeedPower = 1,
    GodEnabled = false, OneHitEnabled = false, NoClipEnabled = false,
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

-- BONG BÓNG
local BubbleBtn = Instance.new("ImageButton")
BubbleBtn.Size = UDim2.new(0, 54, 0, 54)
BubbleBtn.Position = UDim2.new(0, 10, 0.5, 0)
BubbleBtn.BackgroundTransparency = 1
BubbleBtn.ZIndex = 200
BubbleBtn.Image = "https://cdn.upanhlaylink.com/i/nNnEGNnE.jpeg"
BubbleBtn.ScaleType = Enum.ScaleType.Crop
BubbleBtn.Visible = false
BubbleBtn.Parent = ScreenGui

local BC = Instance.new("UICorner")
BC.CornerRadius = UDim.new(1, 0)
BC.Parent = BubbleBtn

local BS = Instance.new("UIStroke")
BS.Color = Color3.fromRGB(255, 255, 255)
BS.Thickness = 2
BS.Parent = BubbleBtn

local pulseTween = TweenService:Create(BubbleBtn, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Size = UDim2.new(0, 58, 0, 58),
    Position = UDim2.new(0, 8, 0.5, -2)
})

-- BUBBLE DRAG
local bubDrag, bubDragStart, bubStartPos = false, nil, nil
BubbleBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        bubDrag = false
        bubDragStart = i.Position
        bubStartPos = BubbleBtn.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if bubDragStart and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - bubDragStart
        if d.Magnitude > 6 then
            bubDrag = true
            pulseTween:Pause()
            BubbleBtn.Size = UDim2.new(0, 54, 0, 54)
            BubbleBtn.Position = UDim2.new(bubStartPos.X.Scale, bubStartPos.X.Offset + d.X, bubStartPos.Y.Scale, bubStartPos.Y.Offset + d.Y)
        end
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        if bubDrag then bubDrag = false; bubDragStart = nil; pulseTween:Play() end
    end
end)
BubbleBtn.InputEnded:Connect(function(i)
    if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not bubDrag then
        pulseTween:Pause()
        BubbleBtn.Visible = false
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 420, 0, 200)
        }):Play()
    end
end)

-- MAIN FRAME (ngang)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 200)
MainFrame.Position = UDim2.new(0.5, -210, 0, 60)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MFC = Instance.new("UICorner")
MFC.CornerRadius = UDim.new(0, 12)
MFC.Parent = MainFrame

local MFS = Instance.new("UIStroke")
MFS.Thickness = 1.5
MFS.Color = Color3.fromRGB(180, 180, 180)
MFS.Parent = MainFrame

-- HEADER NHỎ
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 36)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HC = Instance.new("UICorner")
HC.CornerRadius = UDim.new(0, 12)
HC.Parent = Header

local HFix = Instance.new("Frame")
HFix.Size = UDim2.new(1, 0, 0, 12)
HFix.Position = UDim2.new(0, 0, 1, -12)
HFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
HFix.BorderSizePixel = 0
HFix.Parent = Header

local HG = Instance.new("UIGradient")
HG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80,80,80)),
})
HG.Rotation = 90
HG.Parent = Header

-- Avatar nhỏ trong header
local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(0, 26, 0, 26)
AvatarImg.Position = UDim2.new(0, 6, 0.5, -13)
AvatarImg.BackgroundTransparency = 1
AvatarImg.Image = "https://cdn.upanhlaylink.com/i/nNnEGNnE.jpeg"
AvatarImg.ScaleType = Enum.ScaleType.Crop
AvatarImg.ZIndex = 2
AvatarImg.Parent = Header

local AIC = Instance.new("UICorner")
AIC.CornerRadius = UDim.new(1, 0)
AIC.Parent = AvatarImg

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(0, 180, 1, 0)
TitleLbl.Position = UDim2.new(0, 38, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "Script Hỗ Trợ Parkour"
TitleLbl.TextColor3 = Color3.fromRGB(15, 15, 15)
TitleLbl.TextSize = 13
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.Parent = Header

local SubLbl = Instance.new("TextLabel")
SubLbl.Size = UDim2.new(0, 130, 0, 14)
SubLbl.Position = UDim2.new(0, 38, 0.5, 2)
SubLbl.BackgroundTransparency = 1
SubLbl.Text = "Admin Dzi Meo Meo"
SubLbl.TextColor3 = Color3.fromRGB(40, 40, 40)
SubLbl.TextSize = 9
SubLbl.Font = Enum.Font.Gotham
SubLbl.TextXAlignment = Enum.TextXAlignment.Left
SubLbl.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 5
CloseBtn.Parent = Header

local CBC = Instance.new("UICorner")
CBC.CornerRadius = UDim.new(1, 0)
CBC.Parent = CloseBtn

-- KÉO MENU
local mDrag, mDragStart, mStartPos = false, nil, nil
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        mDrag = true; mDragStart = i.Position; mStartPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if mDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - mDragStart
        MainFrame.Position = UDim2.new(mStartPos.X.Scale, mStartPos.X.Offset + d.X, mStartPos.Y.Scale, mStartPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then mDrag = false end
end)

-- CONTENT (2 cột)
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -8, 1, -44)
Content.Position = UDim2.new(0, 4, 0, 40)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- CỘT TRÁI
local ColLeft = Instance.new("Frame")
ColLeft.Size = UDim2.new(0.5, -4, 1, 0)
ColLeft.Position = UDim2.new(0, 0, 0, 0)
ColLeft.BackgroundTransparency = 1
ColLeft.Parent = Content

local LL = Instance.new("UIListLayout")
LL.Padding = UDim.new(0, 4)
LL.Parent = ColLeft

-- CỘT PHẢI
local ColRight = Instance.new("Frame")
ColRight.Size = UDim2.new(0.5, -4, 1, 0)
ColRight.Position = UDim2.new(0.5, 4, 0, 0)
ColRight.BackgroundTransparency = 1
ColRight.Parent = Content

local LR = Instance.new("UIListLayout")
LR.Padding = UDim.new(0, 4)
LR.Parent = ColRight

-- HÀM TẠO TOGGLE NHỎ
local function makeToggle(parent, icon, label, onToggle)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 36)
    Card.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Card.BorderSizePixel = 0
    Card.Parent = parent

    local CC = Instance.new("UICorner")
    CC.CornerRadius = UDim.new(0, 8)
    CC.Parent = Card

    local CS = Instance.new("UIStroke")
    CS.Color = Color3.fromRGB(45, 45, 45)
    CS.Thickness = 1
    CS.Parent = Card

    local Ico = Instance.new("TextLabel")
    Ico.Size = UDim2.new(0, 22, 1, 0)
    Ico.Position = UDim2.new(0, 6, 0, 0)
    Ico.BackgroundTransparency = 1
    Ico.Text = icon
    Ico.TextSize = 14
    Ico.Font = Enum.Font.GothamBold
    Ico.Parent = Card

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -60, 1, 0)
    Lbl.Position = UDim2.new(0, 28, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    Lbl.TextSize = 11
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.TextWrapped = true
    Lbl.Parent = Card

    local TBg = Instance.new("Frame")
    TBg.Size = UDim2.new(0, 36, 0, 18)
    TBg.Position = UDim2.new(1, -40, 0.5, -9)
    TBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TBg.BorderSizePixel = 0
    TBg.Parent = Card

    local TBC = Instance.new("UICorner")
    TBC.CornerRadius = UDim.new(1, 0)
    TBC.Parent = TBg

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new(0, 2, 0.5, -7)
    Knob.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
    Knob.BorderSizePixel = 0
    Knob.Parent = TBg

    local KC = Instance.new("UICorner")
    KC.CornerRadius = UDim.new(1, 0)
    KC.Parent = Knob

    local isOn = false
    TBg.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            isOn = not isOn
            TweenService:Create(Knob, TweenInfo.new(0.15), {
                Position = isOn and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
                BackgroundColor3 = isOn and Color3.fromRGB(10,10,10) or Color3.fromRGB(160,160,160)
            }):Play()
            TweenService:Create(TBg, TweenInfo.new(0.15), {
                BackgroundColor3 = isOn and Color3.fromRGB(200,200,200) or Color3.fromRGB(50,50,50)
            }):Play()
            onToggle(isOn)
        end
    end)
    return Card
end

-- HÀM TẠO SLIDER NHỎ
local function makeSlider(parent, label, minV, maxV, defV, onChange)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 44)
    Card.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Card.BorderSizePixel = 0
    Card.Parent = parent

    local CC = Instance.new("UICorner")
    CC.CornerRadius = UDim.new(0, 8)
    CC.Parent = Card

    local CS = Instance.new("UIStroke")
    CS.Color = Color3.fromRGB(45, 45, 45)
    CS.Thickness = 1
    CS.Parent = Card

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.7, 0, 0, 18)
    Lbl.Position = UDim2.new(0, 8, 0, 4)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    Lbl.TextSize = 10
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = Card

    local ValLbl = Instance.new("TextLabel")
    ValLbl.Size = UDim2.new(0.28, 0, 0, 18)
    ValLbl.Position = UDim2.new(0.72, 0, 0, 4)
    ValLbl.BackgroundTransparency = 1
    ValLbl.Text = tostring(defV)
    ValLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValLbl.TextSize = 11
    ValLbl.Font = Enum.Font.GothamBold
    ValLbl.TextXAlignment = Enum.TextXAlignment.Right
    ValLbl.Parent = Card

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -16, 0, 5)
    Track.Position = UDim2.new(0, 8, 0, 28)
    Track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Track.BorderSizePixel = 0
    Track.Parent = Card

    local TC = Instance.new("UICorner")
    TC.CornerRadius = UDim.new(1, 0)
    TC.Parent = Track

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((defV-minV)/(maxV-minV), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track

    local FC = Instance.new("UICorner")
    FC.CornerRadius = UDim.new(1, 0)
    FC.Parent = Fill

    local SK = Instance.new("Frame")
    SK.Size = UDim2.new(0, 13, 0, 13)
    SK.AnchorPoint = Vector2.new(0.5, 0.5)
    SK.Position = UDim2.new((defV-minV)/(maxV-minV), 0, 0.5, 0)
    SK.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SK.BorderSizePixel = 0
    SK.ZIndex = 5
    SK.Parent = Track

    local SKC = Instance.new("UICorner")
    SKC.CornerRadius = UDim.new(1, 0)
    SKC.Parent = SK

    local drag = false
    Track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            local r = math.clamp((i.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
            local v = math.floor(minV + r*(maxV-minV))
            Fill.Size = UDim2.new(r, 0, 1, 0)
            SK.Position = UDim2.new(r, 0, 0.5, 0)
            ValLbl.Text = tostring(v)
            onChange(v)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local r = math.clamp((i.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
            local v = math.floor(minV + r*(maxV-minV))
            Fill.Size = UDim2.new(r, 0, 1, 0)
            SK.Position = UDim2.new(r, 0, 0.5, 0)
            ValLbl.Text = tostring(v)
            onChange(v)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end
    end)
    return Card
end

-- CỘT TRÁI: toggle + slider nhảy, toggle + slider chạy
makeToggle(ColLeft, "⬆️", "Nhảy Cao", function(on)
    Settings.JumpEnabled = on
    if not on then humanoid.JumpPower = defaultJump end
end)
makeSlider(ColLeft, "Nhảy (x lần)", 1, 100, 1, function(v)
    Settings.JumpPower = v
    if Settings.JumpEnabled then humanoid.JumpPower = defaultJump * v end
end)
makeToggle(ColLeft, "🏃", "Chạy Nhanh", function(on)
    Settings.SpeedEnabled = on
    if not on then humanoid.WalkSpeed = defaultSpeed end
end)
makeSlider(ColLeft, "Tốc độ (x lần)", 1, 100, 1, function(v)
    Settings.SpeedPower = v
    if Settings.SpeedEnabled then humanoid.WalkSpeed = defaultSpeed * v end
end)

-- CỘT PHẢI: bất tử, onehit, đi trên không, liên hệ
makeToggle(ColRight, "🛡️", "Bất Tử", function(on)
    Settings.GodEnabled = on
    if on then humanoid.MaxHealth = math.huge; humanoid.Health = math.huge
    else humanoid.MaxHealth = 100; humanoid.Health = 100 end
end)
makeToggle(ColRight, "💀", "One Hit", function(on)
    Settings.OneHitEnabled = on
end)
makeToggle(ColRight, "🌫️", "Đi Trên Không", function(on)
    airWalkEnabled = on
    if not on then Settings.NoClipEnabled = false end
end)

-- NÚT LIÊN HỆ cột phải
local CBtn = Instance.new("TextButton")
CBtn.Size = UDim2.new(1, 0, 0, 36)
CBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CBtn.Text = "📞 Liên Hệ"
CBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
CBtn.TextSize = 11
CBtn.Font = Enum.Font.GothamBold
CBtn.BorderSizePixel = 0
CBtn.Parent = ColRight

local CBTC = Instance.new("UICorner")
CBTC.CornerRadius = UDim.new(0, 8)
CBTC.Parent = CBtn

local CBTS = Instance.new("UIStroke")
CBTS.Color = Color3.fromRGB(70, 70, 70)
CBTS.Thickness = 1
CBTS.Parent = CBtn

-- POPUP LIÊN HỆ
local Popup = Instance.new("Frame")
Popup.Size = UDim2.new(0, 260, 0, 170)
Popup.Position = UDim2.new(0.5, -130, 0.5, -85)
Popup.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Popup.BorderSizePixel = 0
Popup.Visible = false
Popup.ZIndex = 50
Popup.Parent = ScreenGui

local PC = Instance.new("UICorner")
PC.CornerRadius = UDim.new(0, 12)
PC.Parent = Popup

local PS = Instance.new("UIStroke")
PS.Color = Color3.fromRGB(180, 180, 180)
PS.Thickness = 1.5
PS.Parent = Popup

local PH = Instance.new("Frame")
PH.Size = UDim2.new(1, 0, 0, 36)
PH.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PH.BorderSizePixel = 0
PH.ZIndex = 51
PH.Parent = Popup

local PHC = Instance.new("UICorner")
PHC.CornerRadius = UDim.new(0, 12)
PHC.Parent = PH

local PHFix = Instance.new("Frame")
PHFix.Size = UDim2.new(1, 0, 0, 12)
PHFix.Position = UDim2.new(0, 0, 1, -12)
PHFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PHFix.BorderSizePixel = 0
PHFix.ZIndex = 51
PHFix.Parent = PH

local PHG = Instance.new("UIGradient")
PHG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(80,80,80))})
PHG.Rotation = 90
PHG.Parent = PH

local PTit = Instance.new("TextLabel")
PTit.Size = UDim2.new(1, -40, 1, 0)
PTit.Position = UDim2.new(0, 10, 0, 0)
PTit.BackgroundTransparency = 1
PTit.Text = "📞 Liên Hệ Admin"
PTit.TextColor3 = Color3.fromRGB(15, 15, 15)
PTit.TextSize = 13
PTit.Font = Enum.Font.GothamBold
PTit.TextXAlignment = Enum.TextXAlignment.Left
PTit.ZIndex = 52
PTit.Parent = PH

local PClose = Instance.new("TextButton")
PClose.Size = UDim2.new(0, 24, 0, 24)
PClose.Position = UDim2.new(1, -30, 0.5, -12)
PClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PClose.Text = "✕"
PClose.TextColor3 = Color3.fromRGB(220, 220, 220)
PClose.TextSize = 11
PClose.Font = Enum.Font.GothamBold
PClose.BorderSizePixel = 0
PClose.ZIndex = 53
PClose.Parent = PH

local PCC = Instance.new("UICorner")
PCC.CornerRadius = UDim.new(1, 0)
PCC.Parent = PClose

local function makeLink(yPos, icon, txt, color, link)
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1, -20, 0, 32)
    B.Position = UDim2.new(0, 10, 0, yPos)
    B.BackgroundColor3 = color
    B.Text = icon .. "  " .. txt
    B.TextColor3 = Color3.fromRGB(255,255,255)
    B.TextSize = 11
    B.Font = Enum.Font.GothamBold
    B.BorderSizePixel = 0
    B.ZIndex = 52
    B.Parent = Popup
    local BC2 = Instance.new("UICorner")
    BC2.CornerRadius = UDim.new(0, 7)
    BC2.Parent = B
    B.MouseButton1Click:Connect(function()
        local T = Instance.new("TextLabel")
        T.Size = UDim2.new(0, 220, 0, 30)
        T.Position = UDim2.new(0.5, -110, 0, 20)
        T.BackgroundColor3 = Color3.fromRGB(30,30,30)
        T.Text = "✅ Đã copy!"
        T.TextColor3 = Color3.fromRGB(200,200,200)
        T.TextSize = 11
        T.Font = Enum.Font.Gotham
        T.BorderSizePixel = 0
        T.ZIndex = 100
        T.Parent = ScreenGui
        local TC2 = Instance.new("UICorner")
        TC2.CornerRadius = UDim.new(0, 7)
        TC2.Parent = T
        setclipboard(link)
        task.delay(2, function()
            TweenService:Create(T, TweenInfo.new(0.3), {TextTransparency=1, BackgroundTransparency=1}):Play()
            task.delay(0.3, function() T:Destroy() end)
        end)
    end)
end

makeLink(42, "💬", "Discord", Color3.fromRGB(88,101,242), "https://discord.gg/ESZkGwk6v")
makeLink(82, "📘", "Facebook", Color3.fromRGB(24,119,242), "https://www.facebook.com/share/14rHaf7efam/?mibextid=wwXIfr")
makeLink(122, "📱", "Zalo: 0993329535", Color3.fromRGB(0,150,220), "84993329535")

PClose.MouseButton1Click:Connect(function() Popup.Visible = false end)
CBtn.MouseButton1Click:Connect(function() Popup.Visible = not Popup.Visible end)

-- ĐÓNG MENU
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 420, 0, 0)
    }):Play()
    task.delay(0.2, function()
        MainFrame.Visible = false
        BubbleBtn.Visible = true
        pulseTween:Play()
    end)
end)

-- LOGIC
humanoid.StateChanged:Connect(function(_, new)
    if new == Enum.HumanoidStateType.Jumping then
        jumpCount += 1
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
    for _, op in ipairs(Players:GetPlayers()) do
        if op ~= player then
            local oc = op.Character
            if oc then
                local or2 = oc:FindFirstChild("HumanoidRootPart")
                local oh = oc:FindFirstChild("Humanoid")
                if or2 and oh and (rootPart.Position - or2.Position).Magnitude < 5 then
                    oh.Health = 0
                end
            end
        end
    end
end)

player.CharacterAdded:Connect(function(c)
    character = c
    humanoid = c:WaitForChild("Humanoid")
    rootPart = c:WaitForChild("HumanoidRootPart")
    jumpCount = 0
    Settings.NoClipEnabled = false
end)
