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
ScreenGui.Name = "DziMeoMeo"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui

-- BONG BÓNG
local Bubble = Instance.new("ImageButton")
Bubble.Size = UDim2.new(0, 58, 0, 58)
Bubble.Position = UDim2.new(0, 12, 0.5, 0)
Bubble.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Bubble.BorderSizePixel = 0
Bubble.ZIndex = 200
Bubble.Image = ""
Bubble.ScaleType = Enum.ScaleType.Crop
Bubble.Visible = false
Bubble.Parent = ScreenGui

Instance.new("UICorner", Bubble).CornerRadius = UDim.new(1,0)
local BS = Instance.new("UIStroke", Bubble)
BS.Color = Color3.fromRGB(160, 100, 230)
BS.Thickness = 2

local BubText = Instance.new("TextLabel", Bubble)
BubText.Size = UDim2.new(1,0,1,0)
BubText.BackgroundTransparency = 1
BubText.Text = "DZI"
BubText.TextColor3 = Color3.fromRGB(255,255,255)
BubText.TextSize = 16
BubText.Font = Enum.Font.GothamBold
BubText.ZIndex = 201

local bubPulse = TweenService:Create(Bubble, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Size = UDim2.new(0,63,0,63), Position = UDim2.new(0,9,0.5,-2)
})

local bubDrag, bubDragStart, bubStartPos = false, nil, nil
Bubble.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        bubDrag = false; bubDragStart = i.Position; bubStartPos = Bubble.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if bubDragStart and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - bubDragStart
        if d.Magnitude > 6 then
            bubDrag = true; bubPulse:Pause(); Bubble.Size = UDim2.new(0,58,0,58)
            Bubble.Position = UDim2.new(bubStartPos.X.Scale, bubStartPos.X.Offset+d.X, bubStartPos.Y.Scale, bubStartPos.Y.Offset+d.Y)
        end
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        if bubDrag then bubDrag=false; bubDragStart=nil; bubPulse:Play() end
    end
end)

-- MAIN FRAME (dọc, style Lennon Hub)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 240, 0, 400)
Main.Position = UDim2.new(1, -255, 0, 60)
Main.BackgroundColor3 = Color3.fromRGB(13, 10, 20)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(140, 80, 200)
MS.Thickness = 1.5

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,54)
Header.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
Header.BorderSizePixel = 0
Header.Parent = Main

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)
local HFix = Instance.new("Frame", Header)
HFix.Size = UDim2.new(1,0,0,12); HFix.Position = UDim2.new(0,0,1,-12)
HFix.BackgroundColor3 = Color3.fromRGB(20,15,30); HFix.BorderSizePixel = 0

-- Avatar header
local HAv = Instance.new("ImageLabel", Header)
HAv.Size = UDim2.new(0,32,0,32)
HAv.Position = UDim2.new(0,10,0.5,-16)
HAv.BackgroundColor3 = Color3.fromRGB(0,0,0)
HAv.BorderSizePixel = 0
HAv.Image = ""
HAv.ScaleType = Enum.ScaleType.Crop
Instance.new("UICorner", HAv).CornerRadius = UDim.new(0,8)
local HAvS = Instance.new("UIStroke", HAv)
HAvS.Color = Color3.fromRGB(160,100,230); HAvS.Thickness = 1.5

local HAvText = Instance.new("TextLabel", HAv)
HAvText.Size = UDim2.new(1,0,1,0)
HAvText.BackgroundTransparency = 1
HAvText.Text = "DZI"
HAvText.TextColor3 = Color3.fromRGB(255,255,255)
HAvText.TextSize = 11
HAvText.Font = Enum.Font.GothamBold
HAvText.ZIndex = 5

local HTitle = Instance.new("TextLabel", Header)
HTitle.Size = UDim2.new(0,140,0,18)
HTitle.Position = UDim2.new(0,50,0,8)
HTitle.BackgroundTransparency = 1
HTitle.Text = "DZI MEO MEO"
HTitle.TextColor3 = Color3.fromRGB(240,240,240)
HTitle.TextSize = 13
HTitle.Font = Enum.Font.GothamBold
HTitle.TextXAlignment = Enum.TextXAlignment.Left

local HSub = Instance.new("TextLabel", Header)
HSub.Size = UDim2.new(0,160,0,14)
HSub.Position = UDim2.new(0,50,0,28)
HSub.BackgroundTransparency = 1
HSub.Text = "SCRIPT HỖ TRỢ PARKOUR"
HSub.TextColor3 = Color3.fromRGB(180,140,255)
HSub.TextSize = 9
HSub.Font = Enum.Font.Gotham
HSub.TextXAlignment = Enum.TextXAlignment.Left

-- Nút X
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0,24,0,24)
CloseBtn.Position = UDim2.new(1,-34,0.5,-12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40,50,40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200,200,200)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1,0)

-- KÉO MENU
local mDrag, mStart, mPos = false, nil, nil
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        mDrag=true; mStart=i.Position; mPos=Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if mDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - mStart
        Main.Position = UDim2.new(mPos.X.Scale, mPos.X.Offset+d.X, mPos.Y.Scale, mPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then mDrag=false end
end)

-- SCROLL
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1,-8,1,-62)
Scroll.Position = UDim2.new(0,4,0,58)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = Color3.fromRGB(160,100,230)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.CanvasSize = UDim2.new(0,0,0,0)

local SList = Instance.new("UIListLayout", Scroll)
SList.Padding = UDim.new(0,6)
SList.HorizontalAlignment = Enum.HorizontalAlignment.Center
local SPad = Instance.new("UIPadding", Scroll)
SPad.PaddingTop = UDim.new(0,4)

-- HÀM TẠO SECTION (bấm mở rộng)
local function makeSection(icon, title)
    local Sec = Instance.new("Frame", Scroll)
    Sec.Size = UDim2.new(1,-8,0,38)
    Sec.BackgroundColor3 = Color3.fromRGB(22,15,35)
    Sec.BorderSizePixel = 0
    Instance.new("UICorner", Sec).CornerRadius = UDim.new(0,8)
    local SS = Instance.new("UIStroke", Sec)
    SS.Color = Color3.fromRGB(100,60,160); SS.Thickness = 1

    local IcoLbl = Instance.new("TextLabel", Sec)
    IcoLbl.Size = UDim2.new(0,30,1,0)
    IcoLbl.Position = UDim2.new(0,8,0,0)
    IcoLbl.BackgroundTransparency = 1
    IcoLbl.Text = icon; IcoLbl.TextSize = 16; IcoLbl.Font = Enum.Font.GothamBold

    local TitLbl = Instance.new("TextLabel", Sec)
    TitLbl.Size = UDim2.new(1,-90,1,0)
    TitLbl.Position = UDim2.new(0,42,0,0)
    TitLbl.BackgroundTransparency = 1
    TitLbl.Text = title
    TitLbl.TextColor3 = Color3.fromRGB(220,220,220)
    TitLbl.TextSize = 13; TitLbl.Font = Enum.Font.GothamBold
    TitLbl.TextXAlignment = Enum.TextXAlignment.Left

    local Arrow = Instance.new("TextLabel", Sec)
    Arrow.Size = UDim2.new(0,24,1,0)
    Arrow.Position = UDim2.new(1,-30,0,0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▸"; Arrow.TextColor3 = Color3.fromRGB(180,140,255)
    Arrow.TextSize = 14; Arrow.Font = Enum.Font.GothamBold

    -- Content frame (ẩn mặc định)
    local Content = Instance.new("Frame", Scroll)
    Content.Size = UDim2.new(1,-8,0,0)
    Content.BackgroundColor3 = Color3.fromRGB(18,12,28)
    Content.BorderSizePixel = 0
    Content.Visible = false
    Instance.new("UICorner", Content).CornerRadius = UDim.new(0,8)
    local CList = Instance.new("UIListLayout", Content)
    CList.Padding = UDim.new(0,6)
    CList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    local CPad = Instance.new("UIPadding", Content)
    CPad.PaddingTop = UDim.new(0,8); CPad.PaddingBottom = UDim.new(0,8)

    local open = false
    local function toggle()
        open = not open
        Arrow.Text = open and "▾" or "▸"
        Content.Visible = open
        -- auto resize content
        if open then
            local h = CList.AbsoluteContentSize.Y + 16
            Content.Size = UDim2.new(1,-8,0,h)
        end
        Sec.BackgroundColor3 = open and Color3.fromRGB(35,20,55) or Color3.fromRGB(22,15,35)
    end

    Sec.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            toggle()
        end
    end)

    return Content, CList
end

-- HÀM TOGGLE
local function makeToggle(parent, lbl, sublbl, cb)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1,-12,0,42)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0

    local L = Instance.new("TextLabel", Row)
    L.Size = UDim2.new(1,-60,0,20)
    L.Position = UDim2.new(0,8,0,6)
    L.BackgroundTransparency = 1
    L.Text = lbl; L.TextColor3 = Color3.fromRGB(220,220,220)
    L.TextSize = 12; L.Font = Enum.Font.GothamBold
    L.TextXAlignment = Enum.TextXAlignment.Left

    local SL = Instance.new("TextLabel", Row)
    SL.Size = UDim2.new(1,-60,0,16)
    SL.Position = UDim2.new(0,8,0,26)
    SL.BackgroundTransparency = 1
    SL.Text = sublbl; SL.TextColor3 = Color3.fromRGB(160,130,200)
    SL.TextSize = 10; SL.Font = Enum.Font.Gotham
    SL.TextXAlignment = Enum.TextXAlignment.Left

    local TBg = Instance.new("Frame", Row)
    TBg.Size = UDim2.new(0,44,0,24)
    TBg.Position = UDim2.new(1,-52,0.5,-12)
    TBg.BackgroundColor3 = Color3.fromRGB(40,50,40)
    TBg.BorderSizePixel = 0
    Instance.new("UICorner", TBg).CornerRadius = UDim.new(1,0)

    local Knob = Instance.new("Frame", TBg)
    Knob.Size = UDim2.new(0,18,0,18)
    Knob.Position = UDim2.new(0,3,0.5,-9)
    Knob.BackgroundColor3 = Color3.fromRGB(120,120,120)
    Knob.BorderSizePixel = 0
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local on = false
    TBg.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            on = not on
            TweenService:Create(Knob, TweenInfo.new(0.15), {
                Position = on and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9),
                BackgroundColor3 = on and Color3.fromRGB(180,120,255) or Color3.fromRGB(120,120,120)
            }):Play()
            TweenService:Create(TBg, TweenInfo.new(0.15), {
                BackgroundColor3 = on and Color3.fromRGB(70,30,110) or Color3.fromRGB(40,50,40)
            }):Play()
            cb(on)
        end
    end)
    return Row
end

-- HÀM SLIDER
local function makeSlider(parent, lbl, minV, maxV, defV, cb)
    local Row = Instance.new("Frame", parent)
    Row.Size = UDim2.new(1,-12,0,46)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0

    local L = Instance.new("TextLabel", Row)
    L.Size = UDim2.new(0.7,0,0,18)
    L.Position = UDim2.new(0,8,0,6)
    L.BackgroundTransparency = 1
    L.Text = lbl; L.TextColor3 = Color3.fromRGB(180,180,180)
    L.TextSize = 11; L.Font = Enum.Font.Gotham
    L.TextXAlignment = Enum.TextXAlignment.Left

    local VL = Instance.new("TextLabel", Row)
    VL.Size = UDim2.new(0.28,0,0,18)
    VL.Position = UDim2.new(0.72,0,0,6)
    VL.BackgroundTransparency = 1
    VL.Text = tostring(defV)
    VL.TextColor3 = Color3.fromRGB(200,160,255)
    VL.TextSize = 12; VL.Font = Enum.Font.GothamBold
    VL.TextXAlignment = Enum.TextXAlignment.Right

    local Track = Instance.new("Frame", Row)
    Track.Size = UDim2.new(1,-16,0,5)
    Track.Position = UDim2.new(0,8,0,34)
    Track.BackgroundColor3 = Color3.fromRGB(50,30,80)
    Track.BorderSizePixel = 0
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1,0)

    local Fill = Instance.new("Frame", Track)
    Fill.Size = UDim2.new((defV-minV)/(maxV-minV),0,1,0)
    Fill.BackgroundColor3 = Color3.fromRGB(160,100,230)
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)

    local SK = Instance.new("Frame", Track)
    SK.Size = UDim2.new(0,14,0,14)
    SK.AnchorPoint = Vector2.new(0.5,0.5)
    SK.Position = UDim2.new((defV-minV)/(maxV-minV),0,0.5,0)
    SK.BackgroundColor3 = Color3.fromRGB(255,255,255)
    SK.BorderSizePixel = 0; SK.ZIndex = 5
    Instance.new("UICorner", SK).CornerRadius = UDim.new(1,0)

    local drag = false
    Track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            local r = math.clamp((i.Position.X - Track.AbsolutePosition.X)/Track.AbsoluteSize.X,0,1)
            local v = math.floor(minV+r*(maxV-minV))
            Fill.Size = UDim2.new(r,0,1,0); SK.Position = UDim2.new(r,0,0.5,0)
            VL.Text = tostring(v); cb(v)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local r = math.clamp((i.Position.X - Track.AbsolutePosition.X)/Track.AbsoluteSize.X,0,1)
            local v = math.floor(minV+r*(maxV-minV))
            Fill.Size = UDim2.new(r,0,1,0); SK.Position = UDim2.new(r,0,0.5,0)
            VL.Text = tostring(v); cb(v)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag=false end
    end)
    return Row
end

-- SECTION: NHẢY CAO
local jumpContent, jumpList = makeSection("^", "Nhảy Cao")
makeToggle(jumpContent, "Nhảy Cao", "Bật để nhảy cao hơn bình thường", function(on)
    Settings.JumpEnabled = on
    if not on then humanoid.JumpPower = defaultJump end
end)
makeSlider(jumpContent, "Độ nhảy (x lần)", 1, 100, 1, function(v)
    Settings.JumpPower = v
    if Settings.JumpEnabled then humanoid.JumpPower = defaultJump * v end
end)

-- SECTION: CHẠY NHANH
local speedContent, speedList = makeSection(">", "Chạy Nhanh")
makeToggle(speedContent, "Chạy Nhanh", "Bật để tăng tốc độ di chuyển", function(on)
    Settings.SpeedEnabled = on
    if not on then humanoid.WalkSpeed = defaultSpeed end
end)
makeSlider(speedContent, "Tốc độ (x lần)", 1, 100, 1, function(v)
    Settings.SpeedPower = v
    if Settings.SpeedEnabled then humanoid.WalkSpeed = defaultSpeed * v end
end)

-- SECTION: BẤT TỬ
local godContent, _ = makeSection("*", "Bất Tử")
makeToggle(godContent, "Bất Tử", "Không thể bị giết bởi bất kỳ thứ gì", function(on)
    Settings.GodEnabled = on
    if on then humanoid.MaxHealth = math.huge; humanoid.Health = math.huge
    else humanoid.MaxHealth = 100; humanoid.Health = 100 end
end)

-- SECTION: ONE HIT
local hitContent, _ = makeSection("X", "One Hit Kill")
makeToggle(hitContent, "One Hit Kill", "Lại gần < 5 studs = đối thủ chết", function(on)
    Settings.OneHitEnabled = on
end)

-- SECTION: ĐI TRÊN KHÔNG
local airContent, _ = makeSection("~", "Đi Trên Không")
makeToggle(airContent, "Đi Trên Không", "Nhảy 2x = bay | Nhảy 3x = huỷ", function(on)
    airWalkEnabled = on
    if not on then Settings.NoClipEnabled = false end
end)

-- NÚT LIÊN HỆ (dưới cùng)
local ContactRow = Instance.new("Frame", Scroll)
ContactRow.Size = UDim2.new(1,-8,0,34)
ContactRow.BackgroundColor3 = Color3.fromRGB(30,15,50)
ContactRow.BorderSizePixel = 0
Instance.new("UICorner", ContactRow).CornerRadius = UDim.new(0,8)
local CS2 = Instance.new("UIStroke", ContactRow)
CS2.Color = Color3.fromRGB(160,100,230); CS2.Thickness = 1

local CLbl = Instance.new("TextLabel", ContactRow)
CLbl.Size = UDim2.new(1,0,1,0)
CLbl.BackgroundTransparency = 1
CLbl.Text = "Lien He Admin"
CLbl.TextColor3 = Color3.fromRGB(190,150,255)
CLbl.TextSize = 12; CLbl.Font = Enum.Font.GothamBold

ContactRow.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        ContactPopup.Visible = not ContactPopup.Visible
    end
end)

-- POPUP LIÊN HỆ
local ContactPopup = Instance.new("Frame", ScreenGui)
ContactPopup.Size = UDim2.new(0,260,0,175)
ContactPopup.Position = UDim2.new(0.5,-130,0.5,-87)
ContactPopup.BackgroundColor3 = Color3.fromRGB(13,10,20)
ContactPopup.BorderSizePixel = 0
ContactPopup.Visible = false
ContactPopup.ZIndex = 50
Instance.new("UICorner", ContactPopup).CornerRadius = UDim.new(0,12)
local CPS = Instance.new("UIStroke", ContactPopup)
CPS.Color = Color3.fromRGB(160,100,230); CPS.Thickness = 1.5

local CPH = Instance.new("Frame", ContactPopup)
CPH.Size = UDim2.new(1,0,0,38)
CPH.BackgroundColor3 = Color3.fromRGB(30,15,50)
CPH.BorderSizePixel = 0; CPH.ZIndex = 51
Instance.new("UICorner", CPH).CornerRadius = UDim.new(0,12)
local CPHFix = Instance.new("Frame", CPH)
CPHFix.Size = UDim2.new(1,0,0,12); CPHFix.Position = UDim2.new(0,0,1,-12)
CPHFix.BackgroundColor3 = Color3.fromRGB(30,15,50); CPHFix.BorderSizePixel = 0; CPHFix.ZIndex = 51

local CPTitle = Instance.new("TextLabel", CPH)
CPTitle.Size = UDim2.new(1,-40,1,0); CPTitle.Position = UDim2.new(0,12,0,0)
CPTitle.BackgroundTransparency = 1; CPTitle.Text = "Lien He Admin"
CPTitle.TextColor3 = Color3.fromRGB(190,150,255); CPTitle.TextSize = 13
CPTitle.Font = Enum.Font.GothamBold; CPTitle.TextXAlignment = Enum.TextXAlignment.Left; CPTitle.ZIndex = 52

local CPClose = Instance.new("TextButton", CPH)
CPClose.Size = UDim2.new(0,24,0,24); CPClose.Position = UDim2.new(1,-30,0.5,-12)
CPClose.BackgroundColor3 = Color3.fromRGB(40,55,40); CPClose.Text = "X"
CPClose.TextColor3 = Color3.fromRGB(200,200,200); CPClose.TextSize = 11
CPClose.Font = Enum.Font.GothamBold; CPClose.BorderSizePixel = 0; CPClose.ZIndex = 53
Instance.new("UICorner", CPClose).CornerRadius = UDim.new(1,0)
CPClose.MouseButton1Click:Connect(function() ContactPopup.Visible = false end)

local function makeLink(yPos, icon, txt, color, link)
    local B = Instance.new("TextButton", ContactPopup)
    B.Size = UDim2.new(1,-20,0,32); B.Position = UDim2.new(0,10,0,yPos)
    B.BackgroundColor3 = color; B.Text = icon.."  "..txt
    B.TextColor3 = Color3.fromRGB(255,255,255); B.TextSize = 11
    B.Font = Enum.Font.GothamBold; B.BorderSizePixel = 0; B.ZIndex = 52
    Instance.new("UICorner", B).CornerRadius = UDim.new(0,7)
    B.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(link) end)
        local T = Instance.new("TextLabel", ScreenGui)
        T.Size = UDim2.new(0,200,0,28); T.Position = UDim2.new(0.5,-100,0,20)
        T.BackgroundColor3 = Color3.fromRGB(20,40,20); T.Text = "Da copy!"
        T.TextColor3 = Color3.fromRGB(80,220,80); T.TextSize = 11
        T.Font = Enum.Font.Gotham; T.BorderSizePixel = 0; T.ZIndex = 100
        Instance.new("UICorner", T).CornerRadius = UDim.new(0,7)
        task.delay(2, function()
            TweenService:Create(T, TweenInfo.new(0.3), {TextTransparency=1, BackgroundTransparency=1}):Play()
            task.delay(0.3, function() T:Destroy() end)
        end)
    end)
end
makeLink(44, "Discord", "Discord", Color3.fromRGB(88,101,242), "https://discord.gg/ESZkGwk6v")
makeLink(82, "Facebook", "Facebook", Color3.fromRGB(24,119,242), "https://www.facebook.com/share/14rHaf7efam/?mibextid=wwXIfr")
makeLink(120, "Zalo", "Zalo: 0993329535", Color3.fromRGB(0,150,220), "84993329535")

-- ĐÓNG/MỞ
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0,240,0,0)
    }):Play()
    task.delay(0.2, function()
        Main.Visible = false; Bubble.Visible = true; bubPulse:Play()
    end)
end)

Bubble.InputEnded:Connect(function(i)
    if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not bubDrag then
        bubPulse:Pause(); Bubble.Visible = false
        Main.Visible = true; Main.Size = UDim2.new(0,240,0,0)
        TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0,240,0,400)
        }):Play()
    end
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
                Settings.NoClipEnabled = false; jumpCount = 0
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            end
        end
    elseif new == Enum.HumanoidStateType.Landed then
        jumpCount = 0; Settings.NoClipEnabled = false
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
    jumpCount = 0; Settings.NoClipEnabled = false
end)
