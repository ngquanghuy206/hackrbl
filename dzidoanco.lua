local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local ANSWER_MAP = {
    ["viet nam"]="Việt Nam",["viet nam"]="Việt Nam",["vietnam"]="Việt Nam",
    ["thai lan"]="Thái Lan",["thailand"]="Thái Lan",
    ["han quoc"]="Hàn Quốc",["south korea"]="Hàn Quốc",["korea"]="Hàn Quốc",
    ["trung quoc"]="Trung Quốc",["china"]="Trung Quốc",
    ["nhat ban"]="Nhật Bản",["japan"]="Nhật Bản",
    ["thuy dien"]="Thụy Điển",["sweden"]="Thụy Điển",
    ["thuy si"]="Thụy Sĩ",["switzerland"]="Thụy Sĩ",
    ["tay ban nha"]="Tây Ban Nha",["spain"]="Tây Ban Nha",
    ["bo dao nha"]="Bồ Đào Nha",["portugal"]="Bồ Đào Nha",
    ["ha lan"]="Hà Lan",["netherlands"]="Hà Lan",["holland"]="Hà Lan",
    ["dan mach"]="Đan Mạch",["denmark"]="Đan Mạch",
    ["phan lan"]="Phần Lan",["finland"]="Phần Lan",
    ["na uy"]="Na Uy",["norway"]="Na Uy",
    ["ba lan"]="Ba Lan",["poland"]="Ba Lan",
    ["hy lap"]="Hy Lạp",["greece"]="Hy Lạp",
    ["ai cap"]="Ai Cập",["egypt"]="Ai Cập",
    ["an do"]="Ấn Độ",["india"]="Ấn Độ",
    ["a rap xe ut"]="Ả Rập Xê Út",["saudi arabia"]="Ả Rập Xê Út",
    ["nam phi"]="Nam Phi",["south africa"]="Nam Phi",
    ["nam sudan"]="Nam Sudan",["south sudan"]="Nam Sudan",
    ["bac trieu tien"]="Bắc Triều Tiên",["north korea"]="Bắc Triều Tiên",
    ["hoa ky"]="Hoa Kỳ",["usa"]="Hoa Kỳ",["united states"]="Hoa Kỳ",["america"]="Hoa Kỳ",
    ["vuong quoc anh"]="Anh",["uk"]="Anh",["united kingdom"]="Anh",["anh"]="Anh",
    ["phap"]="Pháp",["france"]="Pháp",
    ["duc"]="Đức",["germany"]="Đức",
    ["nga"]="Nga",["russia"]="Nga",
    ["bi"]="Bỉ",["belgium"]="Bỉ",
    ["ao"]="Áo",["austria"]="Áo",
    ["sec"]="Séc",["czech"]="Séc",["czechia"]="Séc",
    ["sip"]="Síp",["cyprus"]="Síp",
    ["uc"]="Úc",["australia"]="Úc",
    ["nuoc uc"]="Úc",
    ["y"]="Ý",["italy"]="Ý",
    ["dai loan"]="Đài Loan",["taiwan"]="Đài Loan",
    ["mong co"]="Mông Cổ",["mongolia"]="Mông Cổ",
    ["tho nhi ky"]="Thổ Nhĩ Kỳ",["turkey"]="Thổ Nhĩ Kỳ",["turkiye"]="Thổ Nhĩ Kỳ",
    ["cong hoa dominican"]="Cộng Hòa Dominican",["dominican republic"]="Cộng Hòa Dominican",
    ["philippines"]="Philippines",
    ["indonesia"]="Indonesia",
    ["malaysia"]="Malaysia",
    ["singapore"]="Singapore",
    ["myanmar"]="Myanmar",
    ["campuchia"]="Campuchia",["cambodia"]="Campuchia",
    ["lao"]="Lào",["laos"]="Lào",
    ["brunei"]="Brunei",
    ["timor-leste"]="Timor-Leste",["timor leste"]="Timor-Leste",
    ["pakistan"]="Pakistan",
    ["bangladesh"]="Bangladesh",
    ["sri lanka"]="Sri Lanka",
    ["nepal"]="Nepal",["bhutan"]="Bhutan",["maldives"]="Maldives",["afghanistan"]="Afghanistan",
    ["kazakhstan"]="Kazakhstan",["uzbekistan"]="Uzbekistan",["turkmenistan"]="Turkmenistan",
    ["kyrgyzstan"]="Kyrgyzstan",["tajikistan"]="Tajikistan",
    ["iran"]="Iran",["iraq"]="Iraq",["syria"]="Syria",["jordan"]="Jordan",
    ["lebanon"]="Lebanon",["israel"]="Israel",["palestine"]="Palestine",
    ["yemen"]="Yemen",["oman"]="Oman",["uae"]="UAE",["united arab emirates"]="UAE",
    ["qatar"]="Qatar",["bahrain"]="Bahrain",["kuwait"]="Kuwait",
    ["azerbaijan"]="Azerbaijan",["armenia"]="Armenia",["georgia"]="Georgia",
    ["luxembourg"]="Luxembourg",["liechtenstein"]="Liechtenstein",["monaco"]="Monaco",
    ["ireland"]="Ireland",["iceland"]="Iceland",
    ["estonia"]="Estonia",["latvia"]="Latvia",["lithuania"]="Lithuania",
    ["slovakia"]="Slovakia",["hungary"]="Hungary",["romania"]="Romania",["bulgaria"]="Bulgaria",
    ["serbia"]="Serbia",["croatia"]="Croatia",["slovenia"]="Slovenia",["bosnia"]="Bosnia",
    ["montenegro"]="Montenegro",["albania"]="Albania",["macedonia"]="Macedonia",
    ["ukraine"]="Ukraine",["belarus"]="Belarus",["moldova"]="Moldova",
    ["malta"]="Malta",["kosovo"]="Kosovo",
    ["canada"]="Canada",["mexico"]="Mexico",["guatemala"]="Guatemala",["belize"]="Belize",
    ["honduras"]="Honduras",["el salvador"]="El Salvador",["nicaragua"]="Nicaragua",
    ["costa rica"]="Costa Rica",["panama"]="Panama",["cuba"]="Cuba",
    ["jamaica"]="Jamaica",["haiti"]="Haiti",
    ["trinidad"]="Trinidad & Tobago",["barbados"]="Barbados",["bahamas"]="Bahamas",
    ["brazil"]="Brazil",["argentina"]="Argentina",["colombia"]="Colombia",
    ["venezuela"]="Venezuela",["peru"]="Peru",["chile"]="Chile",
    ["bolivia"]="Bolivia",["ecuador"]="Ecuador",["paraguay"]="Paraguay",
    ["uruguay"]="Uruguay",["guyana"]="Guyana",["suriname"]="Suriname",
    ["libya"]="Libya",["tunisia"]="Tunisia",["algeria"]="Algeria",["morocco"]="Morocco",
    ["sudan"]="Sudan",["nigeria"]="Nigeria",["ghana"]="Ghana",["senegal"]="Senegal",
    ["ivory coast"]="Côte d'Ivoire",["guinea"]="Guinea",["mali"]="Mali",
    ["burkina faso"]="Burkina Faso",["niger"]="Niger",["togo"]="Togo",["benin"]="Benin",
    ["cameroon"]="Cameroon",["gabon"]="Gabon",["congo"]="Congo",["dr congo"]="DR Congo",
    ["liberia"]="Liberia",["sierra leone"]="Sierra Leone",["kenya"]="Kenya",
    ["ethiopia"]="Ethiopia",["tanzania"]="Tanzania",["uganda"]="Uganda",
    ["rwanda"]="Rwanda",["somalia"]="Somalia",["mozambique"]="Mozambique",
    ["zambia"]="Zambia",["zimbabwe"]="Zimbabwe",["angola"]="Angola",["namibia"]="Namibia",
    ["botswana"]="Botswana",["lesotho"]="Lesotho",["madagascar"]="Madagascar",
    ["mauritius"]="Mauritius",["seychelles"]="Seychelles",
    ["new zealand"]="New Zealand",["papua new guinea"]="Papua New Guinea",
    ["fiji"]="Fiji",["solomon islands"]="Solomon Islands",["vanuatu"]="Vanuatu",
    ["samoa"]="Samoa",["tonga"]="Tonga",
}

-- Roblox dùng rbxthumb hoặc decal, không load external HTTP image
-- Dùng Roblox asset ID cờ quốc gia (từ catalogue) - fallback dùng màu + text
-- Thực tế: dùng ImageLabel với Image = "rbxassetid://..." sẽ load được
-- Đây là list asset ID cờ phổ biến trên Roblox catalogue
local FLAG_ASSET = {
    ["Việt Nam"]    = "rbxassetid://6894555415",
    ["Thái Lan"]    = "rbxassetid://6894556321",
    ["Hàn Quốc"]   = "rbxassetid://6894553287",
    ["Trung Quốc"] = "rbxassetid://6894552010",
    ["Nhật Bản"]   = "rbxassetid://6894553731",
    ["Thụy Điển"]  = "rbxassetid://6894556073",
    ["Thụy Sĩ"]    = "rbxassetid://6894556137",
    ["Tây Ban Nha"]= "rbxassetid://6894555939",
    ["Bồ Đào Nha"] = "rbxassetid://6894554499",
    ["Hà Lan"]     = "rbxassetid://6894553199",
    ["Đan Mạch"]   = "rbxassetid://6894552374",
    ["Phần Lan"]   = "rbxassetid://6894554237",
    ["Na Uy"]      = "rbxassetid://6894553939",
    ["Ba Lan"]     = "rbxassetid://6894554345",
    ["Hy Lạp"]     = "rbxassetid://6894553375",
    ["Ai Cập"]     = "rbxassetid://6894551717",
    ["Ấn Độ"]      = "rbxassetid://6894553485",
    ["Ả Rập Xê Út"]= "rbxassetid://6894555797",
    ["Nam Phi"]    = "rbxassetid://6894553857",
    ["Bắc Triều Tiên"]="rbxassetid://6894551905",
    ["Hoa Kỳ"]     = "rbxassetid://6894556385",
    ["Anh"]        = "rbxassetid://6894551795",
    ["Pháp"]       = "rbxassetid://6894552954",
    ["Đức"]        = "rbxassetid://6894552578",
    ["Nga"]        = "rbxassetid://6894554671",
    ["Bỉ"]         = "rbxassetid://6894551983",
    ["Áo"]         = "rbxassetid://6894551873",
    ["Séc"]        = "rbxassetid://6894552122",
    ["Síp"]        = "rbxassetid://6894552202",
    ["Úc"]         = "rbxassetid://6894551839",
    ["Ý"]          = "rbxassetid://6894553589",
    ["Đài Loan"]   = "rbxassetid://6894556199",
    ["Mông Cổ"]    = "rbxassetid://6894553803",
    ["Thổ Nhĩ Kỳ"]= "rbxassetid://6894556253",
    ["Philippines"]= "rbxassetid://6894554417",
    ["Indonesia"]  = "rbxassetid://6894553531",
    ["Malaysia"]   = "rbxassetid://6894553677",
    ["Singapore"]  = "rbxassetid://6894555993",
    ["Myanmar"]    = "rbxassetid://6894553885",
    ["Campuchia"]  = "rbxassetid://6894552060",
    ["Lào"]        = "rbxassetid://6894553641",
    ["Argentina"]  = "rbxassetid://6894551761",
    ["Brazil"]     = "rbxassetid://6894552030",
    ["Canada"]     = "rbxassetid://6894552092",
    ["Mexico"]     = "rbxassetid://6894553749",
    ["Hoa Kỳ"]     = "rbxassetid://6894556385",
    ["Iran"]       = "rbxassetid://6894553547",
    ["Iraq"]       = "rbxassetid://6894553565",
    ["Israel"]     = "rbxassetid://6894553609",
    ["Ukraine"]    = "rbxassetid://6894556309",
    ["New Zealand"]= "rbxassetid://6894553969",
    ["Nam Sudan"]  = "rbxassetid://6894553909",
    ["Nam Phi"]    = "rbxassetid://6894553857",
}

local function norm(s)
    return tostring(s):lower()
        :gsub("[àáảãạăắặằẳẵâấầẩẫậ]","a")
        :gsub("[èéẻẽẹêếềểễệ]","e")
        :gsub("[ìíỉĩị]","i")
        :gsub("[òóỏõọôốồổỗộơớờởỡợ]","o")
        :gsub("[ùúủũụưứừửữự]","u")
        :gsub("[ỳýỷỹỵ]","y")
        :gsub("đ","d")
        :gsub("%s+"," "):gsub("^%s*(.-)%s*$","%1")
end

local function tryMatch(n)
    -- strip prefix "nuoc " (Nước Úc → uc, etc.)
    local stripped = n:gsub("^nuoc ","")
    if ANSWER_MAP[stripped] then return ANSWER_MAP[stripped] end
    if ANSWER_MAP[n] then return ANSWER_MAP[n] end
    return nil
end

-- ==================== GUI HELPER ====================
local function makeDrag(frame)
    local drag, ds, dp = false, nil, nil
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag=true; ds=i.Position; dp=frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            frame.Position = UDim2.new(dp.X.Scale, dp.X.Offset+d.X, dp.Y.Scale, dp.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then drag=false end
    end)
end

-- ==================== SCREEN GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DziAutoFlag"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui

-- ==================== MAIN PANEL (chỉ title, không hiện lượt) ====================
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 28)
Main.Position = UDim2.new(0.5, -110, 0, 6)
Main.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
Main.BorderSizePixel = 0
Main.ZIndex = 100
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(140, 80, 200); MS.Thickness = 1.5
makeDrag(Main)

local TitleLbl = Instance.new("TextLabel", Main)
TitleLbl.Size = UDim2.new(1, -30, 1, 0)
TitleLbl.Position = UDim2.new(0, 0, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "🏴 DZI AUTO FLAG"
TitleLbl.TextColor3 = Color3.fromRGB(180, 140, 255)
TitleLbl.TextSize = 11
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.ZIndex = 101

-- ==================== HINT PANEL ====================
local HP_W = 240
local HP_BTN_H = 28
local HP_PREVIEW_H = 90
local HP_PADDING = 6
local HP_TITLE_H = 22
local HP_NAME_H = 18

local HintPanel = Instance.new("Frame")
HintPanel.Size = UDim2.new(0, HP_W, 0, HP_TITLE_H + HP_PADDING)
HintPanel.Position = UDim2.new(0.5, -HP_W/2, 0, 40)
HintPanel.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
HintPanel.BorderSizePixel = 0
HintPanel.ZIndex = 100
HintPanel.Visible = false
HintPanel.Parent = ScreenGui
Instance.new("UICorner", HintPanel).CornerRadius = UDim.new(0, 10)
local HPS = Instance.new("UIStroke", HintPanel)
HPS.Color = Color3.fromRGB(140, 80, 200); HPS.Thickness = 1.5
makeDrag(HintPanel)

-- Title row của HintPanel
local HTitle = Instance.new("TextLabel", HintPanel)
HTitle.Size = UDim2.new(1, -28, 0, HP_TITLE_H)
HTitle.Position = UDim2.new(0, 4, 0, 2)
HTitle.BackgroundTransparency = 1
HTitle.Text = "🏳 GỢI Ý CỜ"
HTitle.TextColor3 = Color3.fromRGB(180, 140, 255)
HTitle.TextSize = 10
HTitle.Font = Enum.Font.GothamBold
HTitle.ZIndex = 101

-- Nút thu nhỏ / mở rộng
local CollapseBtn = Instance.new("TextButton", HintPanel)
CollapseBtn.Size = UDim2.new(0, 22, 0, 18)
CollapseBtn.Position = UDim2.new(1, -24, 0, 3)
CollapseBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 70)
CollapseBtn.BorderSizePixel = 0
CollapseBtn.Text = "▲"
CollapseBtn.TextColor3 = Color3.fromRGB(200, 160, 255)
CollapseBtn.TextSize = 10
CollapseBtn.Font = Enum.Font.GothamBold
CollapseBtn.ZIndex = 105
Instance.new("UICorner", CollapseBtn).CornerRadius = UDim.new(0, 4)

-- Container cho nội dung (ẩn/hiện khi collapse)
local HPContent = Instance.new("Frame", HintPanel)
HPContent.Size = UDim2.new(1, 0, 1, -HP_TITLE_H-4)
HPContent.Position = UDim2.new(0, 0, 0, HP_TITLE_H+4)
HPContent.BackgroundTransparency = 1
HPContent.ZIndex = 101
HPContent.Visible = true

-- Preview ảnh cờ
local FlagPreview = Instance.new("ImageLabel", HPContent)
FlagPreview.Size = UDim2.new(1, -12, 0, HP_PREVIEW_H)
FlagPreview.Position = UDim2.new(0, 6, 0, 0)
FlagPreview.BackgroundColor3 = Color3.fromRGB(20, 14, 34)
FlagPreview.BorderSizePixel = 0
FlagPreview.Image = ""
FlagPreview.ScaleType = Enum.ScaleType.Fit
FlagPreview.ZIndex = 102
FlagPreview.Visible = false
Instance.new("UICorner", FlagPreview).CornerRadius = UDim.new(0, 6)

-- Tên nước đang xem
local FlagName = Instance.new("TextLabel", HPContent)
FlagName.Size = UDim2.new(1, -12, 0, HP_NAME_H)
FlagName.Position = UDim2.new(0, 6, 0, HP_PREVIEW_H + 2)
FlagName.BackgroundTransparency = 1
FlagName.Text = ""
FlagName.TextColor3 = Color3.fromRGB(220, 220, 255)
FlagName.TextSize = 11
FlagName.Font = Enum.Font.GothamBold
FlagName.TextXAlignment = Enum.TextXAlignment.Center
FlagName.ZIndex = 102
FlagName.Visible = false

-- 4 nút gợi ý (2x2)
local hintBtns = {}
local BTN_Y_BASE = 0 -- sẽ set động
for i = 1, 4 do
    local btn = Instance.new("TextButton", HPContent)
    btn.Size = UDim2.new(0.5, -8, 0, HP_BTN_H - 4)
    btn.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.TextColor3 = Color3.fromRGB(210, 190, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.ZIndex = 103
    btn.Visible = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UITextSizeConstraint", btn).MaxTextSize = 12
    local bs = Instance.new("UIStroke", btn)
    bs.Color = Color3.fromRGB(100, 60, 180); bs.Thickness = 1
    hintBtns[i] = btn
end

-- ==================== STATE ====================
local collapsed = false
local selectedBtn = nil
local currentHints = {}
local showingPreview = false

local function calcPanelHeight()
    local rows = math.ceil(math.max(#currentHints, 1) / 2)
    local btnArea = rows * HP_BTN_H
    local previewArea = showingPreview and (HP_PREVIEW_H + HP_NAME_H + 4) or 0
    return HP_TITLE_H + 4 + previewArea + btnArea + HP_PADDING
end

local function refreshLayout()
    local rows = math.ceil(math.max(#currentHints, 1) / 2)
    local btnArea = rows * HP_BTN_H
    local previewArea = showingPreview and (HP_PREVIEW_H + HP_NAME_H + 4) or 0

    -- Vị trí nút bên dưới preview
    local btnY = previewArea
    for i = 1, 4 do
        local btn = hintBtns[i]
        local col = (i-1) % 2
        local row = math.floor((i-1) / 2)
        btn.Position = UDim2.new(col * 0.5, col == 0 and 6 or 2, 0, btnY + row * HP_BTN_H)
    end

    FlagPreview.Position = UDim2.new(0, 6, 0, 0)
    FlagName.Position = UDim2.new(0, 6, 0, HP_PREVIEW_H + 2)

    if collapsed then
        HPContent.Visible = false
        HintPanel.Size = UDim2.new(0, HP_W, 0, HP_TITLE_H + 8)
    else
        HPContent.Visible = true
        HPContent.Size = UDim2.new(1, 0, 0, previewArea + btnArea + HP_PADDING)
        HintPanel.Size = UDim2.new(0, HP_W, 0, HP_TITLE_H + 4 + previewArea + btnArea + HP_PADDING)
    end
end

CollapseBtn.MouseButton1Click:Connect(function()
    collapsed = not collapsed
    CollapseBtn.Text = collapsed and "▼" or "▲"
    refreshLayout()
end)

local function showPreview(name, btn)
    if selectedBtn == btn then
        -- toggle off
        showingPreview = false
        selectedBtn = nil
        FlagPreview.Visible = false
        FlagName.Visible = false
        for _, b in ipairs(hintBtns) do
            b.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
        end
        refreshLayout()
        return
    end
    selectedBtn = btn
    for _, b in ipairs(hintBtns) do b.BackgroundColor3 = Color3.fromRGB(30, 20, 50) end
    btn.BackgroundColor3 = Color3.fromRGB(70, 35, 120)

    local asset = FLAG_ASSET[name]
    if asset then
        FlagPreview.Image = asset
        FlagPreview.Visible = true
        FlagName.Text = name
        FlagName.Visible = true
        showingPreview = true
    else
        -- Không có asset: chỉ hiện tên
        FlagPreview.Visible = false
        FlagName.Text = "🏴 " .. name
        FlagName.Visible = true
        showingPreview = true
    end
    refreshLayout()
end

local function updateHints(list)
    -- Reset preview khi đổi câu hỏi
    selectedBtn = nil
    showingPreview = false
    FlagPreview.Visible = false
    FlagName.Visible = false

    currentHints = list
    local n = #list

    for i = 1, 4 do
        local btn = hintBtns[i]
        if list[i] then
            btn.Text = list[i]
            btn.Visible = true
            -- reconnect (dùng tag để tránh double connect)
            local country = list[i]
            btn.MouseButton1Click:Connect(function()
                if btn.Text == country then
                    showPreview(country, btn)
                end
            end)
        else
            btn.Text = ""
            btn.Visible = false
        end
    end

    if n > 0 then
        HintPanel.Visible = true
    else
        HintPanel.Visible = false
    end
    refreshLayout()
end

-- ==================== REMOTE HOOKS ====================
local function scanRemotes()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            obj.OnClientEvent:Connect(function(...)
                -- passive scan only, no auto-answer
            end)
        end
    end
end

local function hookFireClient()
    local mt = getrawmetatable(game)
    local old_nc = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        return old_nc(self, ...)
    end)
    setreadonly(mt, true)
end

pcall(hookFireClient)
pcall(scanRemotes)

-- ==================== SCAN GUI ====================
local BLACKLIST = {
    "dzi","auto flag","hub","players","win","tham gia","cua hang",
    "kho do","troll","hang ngay","goi y","tiet lo","phan hoi",
    "lan thang","chuoi thang","tien mat","bao cao","nguoi moi",
    "x2","2x","bat dau","de ","kho ","trung binh","lượt","luot",
    "suy nghi","diem","$","#",
}

local lastHints = {}
local myTurn = false

local function listsEqual(a, b)
    if #a ~= #b then return false end
    for i,v in ipairs(a) do if v ~= b[i] then return false end end
    return true
end

local function scanGUI()
    local allTexts = {}
    local function collect(obj)
        if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.Visible then
            local t = obj.Text
            if t and #t >= 2 and #t <= 60 then
                local n = norm(t)
                local skip = false
                for _, bad in ipairs(BLACKLIST) do
                    if n:find(bad, 1, true) then skip = true; break end
                end
                if not skip and not n:match("^[%d%$%#]") and not n:match("^%s*$") then
                    allTexts[#allTexts+1] = {text=t, norm=n}
                end
            end
        end
        for _, c in ipairs(obj:GetChildren()) do collect(c) end
    end

    for _, g in ipairs(player.PlayerGui:GetChildren()) do
        if g.Name ~= "DziAutoFlag" then collect(g) end
    end

    local matched = {}
    local seen = {}
    for _, c in ipairs(allTexts) do
        local m = tryMatch(c.norm)
        if m and not seen[m] then
            seen[m] = true
            matched[#matched+1] = m
            if #matched >= 4 then break end
        end
    end

    if #matched >= 1 then
        myTurn = true
        if not listsEqual(matched, lastHints) then
            lastHints = matched
            updateHints(matched)
        end
    elseif myTurn then
        myTurn = false
        lastHints = {}
        updateHints({})
    end
end

local tick0 = 0
game:GetService("RunService").Heartbeat:Connect(function()
    tick0 += 1
    if tick0 >= 8 then
        tick0 = 0
        pcall(scanGUI)
    end
end)
