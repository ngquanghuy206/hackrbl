local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local FLAGS = {
    ["vietnam"] = "Việt Nam", ["viet nam"] = "Việt Nam",
    ["thailand"] = "Thái Lan", ["thai lan"] = "Thái Lan",
    ["philippines"] = "Philippines",
    ["indonesia"] = "Indonesia",
    ["malaysia"] = "Malaysia",
    ["singapore"] = "Singapore",
    ["myanmar"] = "Myanmar",
    ["cambodia"] = "Campuchia", ["campuchia"] = "Campuchia",
    ["laos"] = "Lào", ["lào"] = "Lào",
    ["brunei"] = "Brunei",
    ["timor"] = "Timor-Leste", ["timor-leste"] = "Timor-Leste",
    ["japan"] = "Nhật Bản", ["nhat ban"] = "Nhật Bản", ["nhật bản"] = "Nhật Bản",
    ["south korea"] = "Hàn Quốc", ["han quoc"] = "Hàn Quốc", ["korea"] = "Hàn Quốc",
    ["china"] = "Trung Quốc", ["trung quoc"] = "Trung Quốc",
    ["mongolia"] = "Mông Cổ",
    ["taiwan"] = "Đài Loan",
    ["north korea"] = "Bắc Triều Tiên",
    ["india"] = "Ấn Độ", ["an do"] = "Ấn Độ",
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
    ["turkey"] = "Thổ Nhĩ Kỳ", ["tho nhi ky"] = "Thổ Nhĩ Kỳ",
    ["iran"] = "Iran",
    ["iraq"] = "Iraq",
    ["syria"] = "Syria",
    ["jordan"] = "Jordan",
    ["lebanon"] = "Lebanon",
    ["israel"] = "Israel",
    ["palestine"] = "Palestine",
    ["saudi arabia"] = "Ả Rập Xê Út", ["a rap xe ut"] = "Ả Rập Xê Út",
    ["yemen"] = "Yemen",
    ["oman"] = "Oman",
    ["uae"] = "UAE", ["united arab emirates"] = "UAE",
    ["qatar"] = "Qatar",
    ["bahrain"] = "Bahrain",
    ["kuwait"] = "Kuwait",
    ["azerbaijan"] = "Azerbaijan",
    ["armenia"] = "Armenia",
    ["georgia"] = "Georgia",
    ["uk"] = "Anh", ["united kingdom"] = "Anh", ["england"] = "Anh", ["anh"] = "Anh", ["vuong quoc anh"] = "Anh", ["vương quốc anh"] = "Anh",
    ["france"] = "Pháp", ["phap"] = "Pháp",
    ["germany"] = "Đức", ["duc"] = "Đức",
    ["italy"] = "Ý",
    ["spain"] = "Tây Ban Nha", ["tay ban nha"] = "Tây Ban Nha",
    ["portugal"] = "Bồ Đào Nha",
    ["netherlands"] = "Hà Lan", ["ha lan"] = "Hà Lan",
    ["belgium"] = "Bỉ",
    ["luxembourg"] = "Luxembourg",
    ["switzerland"] = "Thụy Sĩ", ["thuy si"] = "Thụy Sĩ",
    ["austria"] = "Áo",
    ["liechtenstein"] = "Liechtenstein",
    ["monaco"] = "Monaco",
    ["ireland"] = "Ireland",
    ["iceland"] = "Iceland",
    ["norway"] = "Na Uy", ["na uy"] = "Na Uy",
    ["sweden"] = "Thụy Điển", ["thuy dien"] = "Thụy Điển",
    ["denmark"] = "Đan Mạch",
    ["finland"] = "Phần Lan",
    ["estonia"] = "Estonia",
    ["latvia"] = "Latvia",
    ["lithuania"] = "Lithuania",
    ["poland"] = "Ba Lan",
    ["czech"] = "Séc", ["czechia"] = "Séc",
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
    ["north macedonia"] = "Macedonia", ["macedonia"] = "Macedonia",
    ["ukraine"] = "Ukraine",
    ["belarus"] = "Belarus",
    ["moldova"] = "Moldova",
    ["russia"] = "Nga", ["nga"] = "Nga",
    ["greece"] = "Hy Lạp",
    ["cyprus"] = "Síp",
    ["malta"] = "Malta",
    ["kosovo"] = "Kosovo",
    ["usa"] = "Hoa Kỳ", ["united states"] = "Hoa Kỳ", ["america"] = "Hoa Kỳ", ["hoa ky"] = "Hoa Kỳ",
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
    ["dominican republic"] = "Cộng Hòa Dominican",
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
    ["egypt"] = "Ai Cập",
    ["libya"] = "Libya",
    ["tunisia"] = "Tunisia",
    ["algeria"] = "Algeria",
    ["morocco"] = "Morocco",
    ["sudan"] = "Sudan",
    ["south sudan"] = "Nam Sudan",
    ["nigeria"] = "Nigeria",
    ["ghana"] = "Ghana",
    ["senegal"] = "Senegal",
    ["ivory coast"] = "Côte d'Ivoire", ["cote d'ivoire"] = "Côte d'Ivoire",
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
    ["south africa"] = "Nam Phi", ["nam phi"] = "Nam Phi",
    ["lesotho"] = "Lesotho",
    ["madagascar"] = "Madagascar",
    ["mauritius"] = "Mauritius",
    ["seychelles"] = "Seychelles",
    ["australia"] = "Úc",
    ["new zealand"] = "New Zealand",
    ["papua new guinea"] = "Papua New Guinea",
    ["fiji"] = "Fiji",
    ["solomon islands"] = "Solomon Islands",
    ["vanuatu"] = "Vanuatu",
    ["samoa"] = "Samoa",
    ["tonga"] = "Tonga",
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DziAutoFlag"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 240, 0, 80)
Main.Position = UDim2.new(0.5, -120, 0, 5)
Main.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
Main.BorderSizePixel = 0
Main.ZIndex = 100
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(140, 80, 200); MS.Thickness = 1.5

local TitleLbl = Instance.new("TextLabel", Main)
TitleLbl.Size = UDim2.new(1, 0, 0, 22)
TitleLbl.Position = UDim2.new(0, 0, 0, 4)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "DZI AUTO FLAG"
TitleLbl.TextColor3 = Color3.fromRGB(180, 140, 255)
TitleLbl.TextSize = 11
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.ZIndex = 101

local AnsLbl = Instance.new("TextLabel", Main)
AnsLbl.Size = UDim2.new(1, -10, 0, 44)
AnsLbl.Position = UDim2.new(0, 5, 0, 28)
AnsLbl.BackgroundColor3 = Color3.fromRGB(20, 14, 34)
AnsLbl.BorderSizePixel = 0
AnsLbl.Text = "Đang chờ câu hỏi..."
AnsLbl.TextColor3 = Color3.fromRGB(255, 220, 80)
AnsLbl.TextSize = 15
AnsLbl.Font = Enum.Font.GothamBold
AnsLbl.TextScaled = true
AnsLbl.ZIndex = 102
Instance.new("UICorner", AnsLbl).CornerRadius = UDim.new(0, 7)
Instance.new("UITextSizeConstraint", AnsLbl).MaxTextSize = 16
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
        Main.Position = UDim2.new(mPos.X.Scale, mPos.X.Offset + d.X, mPos.Y.Scale, mPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then mDrag = false end
end)

local lastAnswer = ""

local function normalize(s)
    return s:lower()
        :gsub("à","a"):gsub("á","a"):gsub("ả","a"):gsub("ã","a"):gsub("ạ","a")
        :gsub("ă","a"):gsub("ắ","a"):gsub("ặ","a"):gsub("ằ","a"):gsub("ẳ","a"):gsub("ẵ","a")
        :gsub("â","a"):gsub("ấ","a"):gsub("ầ","a"):gsub("ẩ","a"):gsub("ẫ","a"):gsub("ậ","a")
        :gsub("è","e"):gsub("é","e"):gsub("ẻ","e"):gsub("ẽ","e"):gsub("ẹ","e")
        :gsub("ê","e"):gsub("ế","e"):gsub("ề","e"):gsub("ể","e"):gsub("ễ","e"):gsub("ệ","e")
        :gsub("ì","i"):gsub("í","i"):gsub("ỉ","i"):gsub("ĩ","i"):gsub("ị","i")
        :gsub("ò","o"):gsub("ó","o"):gsub("ỏ","o"):gsub("õ","o"):gsub("ọ","o")
        :gsub("ô","o"):gsub("ố","o"):gsub("ồ","o"):gsub("ổ","o"):gsub("ỗ","o"):gsub("ộ","o")
        :gsub("ơ","o"):gsub("ớ","o"):gsub("ờ","o"):gsub("ở","o"):gsub("ỡ","o"):gsub("ợ","o")
        :gsub("ù","u"):gsub("ú","u"):gsub("ủ","u"):gsub("ũ","u"):gsub("ụ","u")
        :gsub("ư","u"):gsub("ứ","u"):gsub("ừ","u"):gsub("ử","u"):gsub("ữ","u"):gsub("ự","u")
        :gsub("ỳ","y"):gsub("ý","y"):gsub("ỷ","y"):gsub("ỹ","y"):gsub("ỵ","y")
        :gsub("đ","d")
        :gsub("%s+", " "):gsub("^%s*(.-)%s*$", "%1")
end

local function findAnswer(texts)
    for _, txt in ipairs(texts) do
        local norm = normalize(txt)
        if FLAGS[norm] then
            return FLAGS[norm], txt
        end
        for key, val in pairs(FLAGS) do
            if norm:find(key, 1, true) then
                return val, txt
            end
        end
    end
    return nil, nil
end

local function getAllTexts()
    local result = {}
    local function scan(obj)
        if obj:IsA("TextLabel") or obj:IsA("TextButton") then
            local t = obj.Text
            if t and #t > 1 and #t < 60 then
                result[#result+1] = t
            end
        end
        for _, child in ipairs(obj:GetChildren()) do
            scan(child)
        end
    end
    for _, gui in ipairs(player.PlayerGui:GetChildren()) do
        if gui.Name ~= "DziAutoFlag" and gui.Name ~= "DziCoDoan" and gui.Name ~= "DziMeoMeo" then
            scan(gui)
        end
    end
    return result
end

local pulse = false
RunService.Heartbeat:Connect(function()
    local texts = getAllTexts()
    local answer, rawText = findAnswer(texts)
    if answer and answer ~= lastAnswer then
        lastAnswer = answer
        AnsLbl.Text = "✔ " .. answer
        AnsLbl.TextColor3 = Color3.fromRGB(100, 255, 120)
        ABS.Color = Color3.fromRGB(60, 200, 80)
        if not pulse then
            pulse = true
            TweenService:Create(AnsLbl, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(15, 50, 20)}):Play()
            task.delay(0.15, function()
                TweenService:Create(AnsLbl, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 14, 34)}):Play()
                pulse = false
            end)
        end
    elseif not answer then
        if lastAnswer ~= "" then
            lastAnswer = ""
            AnsLbl.Text = "Đang chờ câu hỏi..."
            AnsLbl.TextColor3 = Color3.fromRGB(255, 220, 80)
            ABS.Color = Color3.fromRGB(100, 60, 160)
        end
    end
end)
