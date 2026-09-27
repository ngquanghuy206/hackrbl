local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local ANSWER_MAP = {
    ["viet nam"] = "Việt Nam", ["việt nam"] = "Việt Nam",
    ["thai lan"] = "Thái Lan", ["thái lan"] = "Thái Lan", ["thailand"] = "Thái Lan",
    ["philippines"] = "Philippines",
    ["indonesia"] = "Indonesia",
    ["malaysia"] = "Malaysia",
    ["singapore"] = "Singapore",
    ["myanmar"] = "Myanmar",
    ["campuchia"] = "Campuchia", ["cambodia"] = "Campuchia",
    ["lao"] = "Lào", ["lào"] = "Lào", ["laos"] = "Lào",
    ["brunei"] = "Brunei",
    ["timor-leste"] = "Timor-Leste", ["timor leste"] = "Timor-Leste",
    ["nhat ban"] = "Nhật Bản", ["nhật bản"] = "Nhật Bản", ["japan"] = "Nhật Bản",
    ["han quoc"] = "Hàn Quốc", ["hàn quốc"] = "Hàn Quốc", ["south korea"] = "Hàn Quốc", ["korea"] = "Hàn Quốc",
    ["trung quoc"] = "Trung Quốc", ["trung quốc"] = "Trung Quốc", ["china"] = "Trung Quốc",
    ["mong co"] = "Mông Cổ", ["mông cổ"] = "Mông Cổ", ["mongolia"] = "Mông Cổ",
    ["dai loan"] = "Đài Loan", ["đài loan"] = "Đài Loan", ["taiwan"] = "Đài Loan",
    ["bac trieu tien"] = "Bắc Triều Tiên", ["bắc triều tiên"] = "Bắc Triều Tiên", ["north korea"] = "Bắc Triều Tiên",
    ["an do"] = "Ấn Độ", ["ấn độ"] = "Ấn Độ", ["india"] = "Ấn Độ",
    ["pakistan"] = "Pakistan",
    ["bangladesh"] = "Bangladesh",
    ["sri lanka"] = "Sri Lanka",
    ["nepal"] = "Nepal",
    ["bhutan"] = "Bhutan",
    ["maldives"] = "Maldives",
    ["afghanistan"] = "Afghanistan",
    ["kazakhstan"] = "Kazakhstan",
    ["uzbekistan"] = "Uzbekistan",
    ["turkmenistan"] = "Turkmenistan",
    ["kyrgyzstan"] = "Kyrgyzstan",
    ["tajikistan"] = "Tajikistan",
    ["tho nhi ky"] = "Thổ Nhĩ Kỳ", ["thổ nhĩ kỳ"] = "Thổ Nhĩ Kỳ", ["turkey"] = "Thổ Nhĩ Kỳ", ["turkiye"] = "Thổ Nhĩ Kỳ",
    ["iran"] = "Iran",
    ["iraq"] = "Iraq",
    ["syria"] = "Syria",
    ["jordan"] = "Jordan",
    ["lebanon"] = "Lebanon",
    ["israel"] = "Israel",
    ["palestine"] = "Palestine",
    ["a rap xe ut"] = "Ả Rập Xê Út", ["ả rập xê út"] = "Ả Rập Xê Út", ["saudi arabia"] = "Ả Rập Xê Út",
    ["yemen"] = "Yemen",
    ["oman"] = "Oman",
    ["uae"] = "UAE", ["united arab emirates"] = "UAE",
    ["qatar"] = "Qatar",
    ["bahrain"] = "Bahrain",
    ["kuwait"] = "Kuwait",
    ["azerbaijan"] = "Azerbaijan",
    ["armenia"] = "Armenia",
    ["georgia"] = "Georgia",
    ["anh"] = "Anh", ["vuong quoc anh"] = "Anh", ["vương quốc anh"] = "Anh", ["uk"] = "Anh", ["united kingdom"] = "Anh",
    ["phap"] = "Pháp", ["pháp"] = "Pháp", ["france"] = "Pháp",
    ["duc"] = "Đức", ["đức"] = "Đức", ["germany"] = "Đức",
    ["y"] = "Ý", ["ý"] = "Ý", ["italy"] = "Ý",
    ["tay ban nha"] = "Tây Ban Nha", ["tây ban nha"] = "Tây Ban Nha", ["spain"] = "Tây Ban Nha",
    ["bo dao nha"] = "Bồ Đào Nha", ["bồ đào nha"] = "Bồ Đào Nha", ["portugal"] = "Bồ Đào Nha",
    ["ha lan"] = "Hà Lan", ["hà lan"] = "Hà Lan", ["netherlands"] = "Hà Lan", ["holland"] = "Hà Lan",
    ["bi"] = "Bỉ", ["bỉ"] = "Bỉ", ["belgium"] = "Bỉ",
    ["luxembourg"] = "Luxembourg",
    ["thuy si"] = "Thụy Sĩ", ["thụy sĩ"] = "Thụy Sĩ", ["switzerland"] = "Thụy Sĩ",
    ["ao"] = "Áo", ["áo"] = "Áo", ["austria"] = "Áo",
    ["liechtenstein"] = "Liechtenstein",
    ["monaco"] = "Monaco",
    ["ireland"] = "Ireland",
    ["iceland"] = "Iceland",
    ["na uy"] = "Na Uy", ["norway"] = "Na Uy",
    ["thuy dien"] = "Thụy Điển", ["thụy điển"] = "Thụy Điển", ["sweden"] = "Thụy Điển",
    ["dan mach"] = "Đan Mạch", ["đan mạch"] = "Đan Mạch", ["denmark"] = "Đan Mạch",
    ["phan lan"] = "Phần Lan", ["phần lan"] = "Phần Lan", ["finland"] = "Phần Lan",
    ["estonia"] = "Estonia",
    ["latvia"] = "Latvia",
    ["lithuania"] = "Lithuania",
    ["ba lan"] = "Ba Lan", ["poland"] = "Ba Lan",
    ["sec"] = "Séc", ["séc"] = "Séc", ["czech"] = "Séc", ["czechia"] = "Séc",
    ["slovakia"] = "Slovakia",
    ["hungary"] = "Hungary",
    ["romania"] = "Romania",
    ["bulgaria"] = "Bulgaria",
    ["serbia"] = "Serbia",
    ["croatia"] = "Croatia",
    ["slovenia"] = "Slovenia",
    ["bosnia"] = "Bosnia",
    ["montenegro"] = "Montenegro",
    ["albania"] = "Albania",
    ["macedonia"] = "Macedonia", ["north macedonia"] = "Macedonia",
    ["ukraine"] = "Ukraine",
    ["belarus"] = "Belarus",
    ["moldova"] = "Moldova",
    ["nga"] = "Nga", ["russia"] = "Nga",
    ["hy lap"] = "Hy Lạp", ["hy lạp"] = "Hy Lạp", ["greece"] = "Hy Lạp",
    ["sip"] = "Síp", ["síp"] = "Síp", ["cyprus"] = "Síp",
    ["malta"] = "Malta",
    ["kosovo"] = "Kosovo",
    ["hoa ky"] = "Hoa Kỳ", ["hoa kỳ"] = "Hoa Kỳ", ["usa"] = "Hoa Kỳ", ["united states"] = "Hoa Kỳ", ["america"] = "Hoa Kỳ",
    ["canada"] = "Canada",
    ["mexico"] = "Mexico",
    ["guatemala"] = "Guatemala",
    ["belize"] = "Belize",
    ["honduras"] = "Honduras",
    ["el salvador"] = "El Salvador",
    ["nicaragua"] = "Nicaragua",
    ["costa rica"] = "Costa Rica",
    ["panama"] = "Panama",
    ["cuba"] = "Cuba",
    ["jamaica"] = "Jamaica",
    ["haiti"] = "Haiti",
    ["cong hoa dominican"] = "Cộng Hòa Dominican", ["cộng hòa dominican"] = "Cộng Hòa Dominican", ["dominican republic"] = "Cộng Hòa Dominican",
    ["trinidad"] = "Trinidad & Tobago",
    ["barbados"] = "Barbados",
    ["bahamas"] = "Bahamas",
    ["brazil"] = "Brazil",
    ["argentina"] = "Argentina",
    ["colombia"] = "Colombia",
    ["venezuela"] = "Venezuela",
    ["peru"] = "Peru",
    ["chile"] = "Chile",
    ["bolivia"] = "Bolivia",
    ["ecuador"] = "Ecuador",
    ["paraguay"] = "Paraguay",
    ["uruguay"] = "Uruguay",
    ["guyana"] = "Guyana",
    ["suriname"] = "Suriname",
    ["ai cap"] = "Ai Cập", ["ai cập"] = "Ai Cập", ["egypt"] = "Ai Cập",
    ["libya"] = "Libya",
    ["tunisia"] = "Tunisia",
    ["algeria"] = "Algeria",
    ["morocco"] = "Morocco",
    ["sudan"] = "Sudan",
    ["nam sudan"] = "Nam Sudan", ["south sudan"] = "Nam Sudan",
    ["nigeria"] = "Nigeria",
    ["ghana"] = "Ghana",
    ["senegal"] = "Senegal",
    ["ivory coast"] = "Côte d'Ivoire",
    ["guinea"] = "Guinea",
    ["mali"] = "Mali",
    ["burkina faso"] = "Burkina Faso",
    ["niger"] = "Niger",
    ["togo"] = "Togo",
    ["benin"] = "Benin",
    ["cameroon"] = "Cameroon",
    ["gabon"] = "Gabon",
    ["congo"] = "Congo",
    ["dr congo"] = "DR Congo",
    ["liberia"] = "Liberia",
    ["sierra leone"] = "Sierra Leone",
    ["kenya"] = "Kenya",
    ["ethiopia"] = "Ethiopia",
    ["tanzania"] = "Tanzania",
    ["uganda"] = "Uganda",
    ["rwanda"] = "Rwanda",
    ["somalia"] = "Somalia",
    ["mozambique"] = "Mozambique",
    ["zambia"] = "Zambia",
    ["zimbabwe"] = "Zimbabwe",
    ["angola"] = "Angola",
    ["namibia"] = "Namibia",
    ["botswana"] = "Botswana",
    ["nam phi"] = "Nam Phi", ["nam phi"] = "Nam Phi", ["south africa"] = "Nam Phi",
    ["lesotho"] = "Lesotho",
    ["madagascar"] = "Madagascar",
    ["mauritius"] = "Mauritius",
    ["seychelles"] = "Seychelles",
    ["uc"] = "Úc", ["úc"] = "Úc", ["australia"] = "Úc",
    ["new zealand"] = "New Zealand",
    ["papua new guinea"] = "Papua New Guinea",
    ["fiji"] = "Fiji",
    ["solomon islands"] = "Solomon Islands",
    ["vanuatu"] = "Vanuatu",
    ["samoa"] = "Samoa",
    ["tonga"] = "Tonga",
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

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DziAutoFlag"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 250, 0, 76)
Main.Position = UDim2.new(0.5, -125, 0, 6)
Main.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
Main.BorderSizePixel = 0
Main.ZIndex = 100
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(140, 80, 200); MS.Thickness = 1.5

local TitleLbl = Instance.new("TextLabel", Main)
TitleLbl.Size = UDim2.new(1, 0, 0, 20)
TitleLbl.Position = UDim2.new(0, 0, 0, 3)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "DZI AUTO FLAG"
TitleLbl.TextColor3 = Color3.fromRGB(180, 140, 255)
TitleLbl.TextSize = 10
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.ZIndex = 101

local AnsLbl = Instance.new("TextLabel", Main)
AnsLbl.Size = UDim2.new(1, -10, 0, 42)
AnsLbl.Position = UDim2.new(0, 5, 0, 26)
AnsLbl.BackgroundColor3 = Color3.fromRGB(20, 14, 34)
AnsLbl.BorderSizePixel = 0
AnsLbl.Text = "⏳ Lượt đối thủ..."
AnsLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
AnsLbl.TextSize = 16
AnsLbl.Font = Enum.Font.GothamBold
AnsLbl.TextScaled = true
AnsLbl.ZIndex = 102
Instance.new("UICorner", AnsLbl).CornerRadius = UDim.new(0, 7)
Instance.new("UITextSizeConstraint", AnsLbl).MaxTextSize = 17
local ABS = Instance.new("UIStroke", AnsLbl)
ABS.Color = Color3.fromRGB(100, 60, 160); ABS.Thickness = 1

local mDrag, mStart, mPos = false, nil, nil
Main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        mDrag = true; mStart = i.Position; mPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if mDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - mStart
        Main.Position = UDim2.new(mPos.X.Scale, mPos.X.Offset+d.X, mPos.Y.Scale, mPos.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then mDrag = false end
end)

local function setAnswer(txt, correct)
    AnsLbl.Text = txt
    if correct then
        AnsLbl.TextColor3 = Color3.fromRGB(100, 255, 120)
        ABS.Color = Color3.fromRGB(60, 200, 80)
        TweenService:Create(AnsLbl, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(10, 45, 15)}):Play()
        task.delay(0.12, function()
            TweenService:Create(AnsLbl, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 14, 34)}):Play()
        end)
    else
        AnsLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        ABS.Color = Color3.fromRGB(100, 60, 160)
    end
end

local currentFlag = nil

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" or method == "InvokeServer" then
    end

    if method == "FireAllClients" or method == "FireClient" or method == "OnClientEvent" then
    end

    local result = oldNamecall(self, ...)

    if method == "GetPropertyChangedSignal" then end

    return result
end)

local function scanRemotes()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            obj.OnClientEvent:Connect(function(...)
                local args = {...}
                for _, v in ipairs(args) do
                    local s = tostring(v)
                    local n = norm(s)
                    if ANSWER_MAP[n] then
                        currentFlag = ANSWER_MAP[n]
                        setAnswer("✔ " .. currentFlag, true)
                        return
                    end
                    for k, val in pairs(ANSWER_MAP) do
                        if n:find(k, 1, true) and #k > 2 then
                            currentFlag = val
                            setAnswer("✔ " .. currentFlag, true)
                            return
                        end
                    end
                end
            end)
        end
        if obj:IsA("StringValue") or obj:IsA("StringValue") then
            obj.Changed:Connect(function(v)
                local n = norm(v)
                if ANSWER_MAP[n] then
                    currentFlag = ANSWER_MAP[n]
                    setAnswer("✔ " .. currentFlag, true)
                end
            end)
        end
    end
end

game.DescendantAdded:Connect(function(obj)
    if obj:IsA("RemoteEvent") then
        obj.OnClientEvent:Connect(function(...)
            local args = {...}
            for _, v in ipairs(args) do
                local s = tostring(v)
                local n = norm(s)
                if ANSWER_MAP[n] then
                    currentFlag = ANSWER_MAP[n]
                    setAnswer("✔ " .. currentFlag, true)
                    return
                end
                for k, val in pairs(ANSWER_MAP) do
                    if n:find(k, 1, true) and #k > 2 then
                        currentFlag = val
                        setAnswer("✔ " .. currentFlag, true)
                        return
                    end
                end
            end
        end)
    end
end)

local function scanValues()
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("StringValue") then
            local n = norm(obj.Value)
            if ANSWER_MAP[n] then
                currentFlag = ANSWER_MAP[n]
                setAnswer("✔ " .. currentFlag, true)
            end
            obj.Changed:Connect(function(v)
                local n2 = norm(v)
                if ANSWER_MAP[n2] then
                    currentFlag = ANSWER_MAP[n2]
                    setAnswer("✔ " .. currentFlag, true)
                end
            end)
        end
    end
end

local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
    return oldIndex(self, key)
end)

local function hookFireClient()
    local mt = getrawmetatable(game)
    local old_nc = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if (method == "FireServer" or method == "InvokeServer") then
            for _, v in ipairs(args) do
                local s = tostring(v)
                local n = norm(s)
                if ANSWER_MAP[n] then
                    currentFlag = ANSWER_MAP[n]
                    setAnswer("✔ " .. currentFlag, true)
                end
            end
        end
        return old_nc(self, ...)
    end)
    setreadonly(mt, true)
end

pcall(hookFireClient)
pcall(scanRemotes)
pcall(scanValues)

local myTurn = false

local function scanGUI()
    local BLACKLIST = {
        ["dzi"] = true, ["script"] = true, ["hub"] = true,
        ["$"] = true, ["players"] = true, ["goi y"] = true,
        ["tiet lo"] = true, ["de"] = true, ["kho"] = true,
        ["trung binh"] = true, ["diem"] = true, ["tim"] = true,
    }

    local candidates = {}
    local function collect(obj)
        if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.Visible then
            local t = obj.Text
            if t and #t >= 2 and #t <= 50 then
                local n = norm(t)
                local skip = false
                for bad in pairs(BLACKLIST) do
                    if n:find(bad, 1, true) then skip = true; break end
                end
                if not skip and not n:match("^%d") then
                    candidates[#candidates+1] = {text=t, norm=n, obj=obj}
                end
            end
        end
        for _, c in ipairs(obj:GetChildren()) do collect(c) end
    end

    for _, g in ipairs(player.PlayerGui:GetChildren()) do
        if g.Name ~= "DziAutoFlag" then collect(g) end
    end

    local counts = {}
    for _, c in ipairs(candidates) do
        counts[c.norm] = (counts[c.norm] or 0) + 1
    end

    local choices = {}
    for _, c in ipairs(candidates) do
        if counts[c.norm] == 1 then
            if ANSWER_MAP[c.norm] then
                choices[#choices+1] = {mapped=ANSWER_MAP[c.norm], raw=c.text}
            else
                for k, v in pairs(ANSWER_MAP) do
                    if c.norm == k then
                        choices[#choices+1] = {mapped=v, raw=c.text}
                        break
                    end
                end
            end
        end
    end

    if #choices == 1 then
        myTurn = true
        if currentFlag ~= choices[1].mapped then
            currentFlag = choices[1].mapped
            setAnswer("✔ " .. currentFlag, true)
        end
    elseif #choices == 0 then
        if myTurn then
            myTurn = false
            currentFlag = nil
            AnsLbl.Text = "⏳ Lượt đối thủ..."
            AnsLbl.TextColor3 = Color3.fromRGB(255, 165, 0)
            ABS.Color = Color3.fromRGB(150, 90, 0)
        end
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
