local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local ANSWER_MAP = {
    ["viet nam"] = "Việt Nam", ["việt nam"] = "Việt Nam", ["vietnam"] = "Việt Nam",
    ["thai lan"] = "Thái Lan", ["thái lan"] = "Thái Lan",
    ["han quoc"] = "Hàn Quốc", ["hàn quốc"] = "Hàn Quốc",
    ["trung quoc"] = "Trung Quốc", ["trung quốc"] = "Trung Quốc",
    ["nhat ban"] = "Nhật Bản", ["nhật bản"] = "Nhật Bản",
    ["thuy dien"] = "Thụy Điển", ["thụy điển"] = "Thụy Điển",
    ["thuy si"] = "Thụy Sĩ", ["thụy sĩ"] = "Thụy Sĩ",
    ["tay ban nha"] = "Tây Ban Nha", ["tây ban nha"] = "Tây Ban Nha",
    ["bo dao nha"] = "Bồ Đào Nha", ["bồ đào nha"] = "Bồ Đào Nha",
    ["ha lan"] = "Hà Lan", ["hà lan"] = "Hà Lan",
    ["dan mach"] = "Đan Mạch", ["đan mạch"] = "Đan Mạch",
    ["phan lan"] = "Phần Lan", ["phần lan"] = "Phần Lan",
    ["na uy"] = "Na Uy",
    ["ba lan"] = "Ba Lan",
    ["hy lap"] = "Hy Lạp", ["hy lạp"] = "Hy Lạp",
    ["ai cap"] = "Ai Cập", ["ai cập"] = "Ai Cập",
    ["an do"] = "Ấn Độ", ["ấn độ"] = "Ấn Độ",
    ["a rap xe ut"] = "Ả Rập Xê Út", ["ả rập xê út"] = "Ả Rập Xê Út",
    ["nam phi"] = "Nam Phi",
    ["nam sudan"] = "Nam Sudan",
    ["bac trieu tien"] = "Bắc Triều Tiên", ["bắc triều tiên"] = "Bắc Triều Tiên",
    ["hoa ky"] = "Hoa Kỳ", ["hoa kỳ"] = "Hoa Kỳ",
    ["vuong quoc anh"] = "Vương quốc Anh", ["vương quốc anh"] = "Vương quốc Anh",
    ["anh"] = "Anh",
    ["phap"] = "Pháp", ["pháp"] = "Pháp",
    ["duc"] = "Đức", ["đức"] = "Đức",
    ["nga"] = "Nga",
    ["bi"] = "Bỉ", ["bỉ"] = "Bỉ",
    ["ao"] = "Áo", ["áo"] = "Áo",
    ["sec"] = "Séc", ["séc"] = "Séc",
    ["sip"] = "Síp", ["síp"] = "Síp",
    ["uc"] = "Úc", ["úc"] = "Úc",
    ["y"] = "Ý", ["ý"] = "Ý",
    ["dai loan"] = "Đài Loan", ["đài loan"] = "Đài Loan",
    ["mong co"] = "Mông Cổ", ["mông cổ"] = "Mông Cổ",
    ["tho nhi ky"] = "Thổ Nhĩ Kỳ", ["thổ nhĩ kỳ"] = "Thổ Nhĩ Kỳ",
    ["cong hoa dominican"] = "Cộng Hòa Dominican", ["cộng hòa dominican"] = "Cộng Hòa Dominican",
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
    ["nam phi"] = "Nam Phi", ["south africa"] = "Nam Phi",
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

-- ISO code để lấy ảnh cờ từ flagcdn.com
local FLAG_CODE = {
    ["Việt Nam"]="vn",["Thái Lan"]="th",["Hàn Quốc"]="kr",["Trung Quốc"]="cn",
    ["Nhật Bản"]="jp",["Thụy Điển"]="se",["Thụy Sĩ"]="ch",["Tây Ban Nha"]="es",
    ["Bồ Đào Nha"]="pt",["Hà Lan"]="nl",["Đan Mạch"]="dk",["Phần Lan"]="fi",
    ["Na Uy"]="no",["Ba Lan"]="pl",["Hy Lạp"]="gr",["Ai Cập"]="eg",
    ["Ấn Độ"]="in",["Ả Rập Xê Út"]="sa",["Nam Phi"]="za",["Nam Sudan"]="ss",
    ["Bắc Triều Tiên"]="kp",["Hoa Kỳ"]="us",["Anh"]="gb",["Vương quốc Anh"]="gb",
    ["Pháp"]="fr",["Đức"]="de",["Nga"]="ru",["Bỉ"]="be",["Áo"]="at",
    ["Séc"]="cz",["Síp"]="cy",["Úc"]="au",["Ý"]="it",["Đài Loan"]="tw",
    ["Mông Cổ"]="mn",["Thổ Nhĩ Kỳ"]="tr",["Cộng Hòa Dominican"]="do",
    ["Philippines"]="ph",["Indonesia"]="id",["Malaysia"]="my",["Singapore"]="sg",
    ["Myanmar"]="mm",["Campuchia"]="kh",["Lào"]="la",["Brunei"]="bn",
    ["Timor-Leste"]="tl",["Pakistan"]="pk",["Bangladesh"]="bd",["Sri Lanka"]="lk",
    ["Nepal"]="np",["Bhutan"]="bt",["Maldives"]="mv",["Afghanistan"]="af",
    ["Kazakhstan"]="kz",["Uzbekistan"]="uz",["Turkmenistan"]="tm",
    ["Kyrgyzstan"]="kg",["Tajikistan"]="tj",["Iran"]="ir",["Iraq"]="iq",
    ["Syria"]="sy",["Jordan"]="jo",["Lebanon"]="lb",["Israel"]="il",
    ["Palestine"]="ps",["Yemen"]="ye",["Oman"]="om",["UAE"]="ae",
    ["Qatar"]="qa",["Bahrain"]="bh",["Kuwait"]="kw",["Azerbaijan"]="az",
    ["Armenia"]="am",["Georgia"]="ge",["Luxembourg"]="lu",["Liechtenstein"]="li",
    ["Monaco"]="mc",["Ireland"]="ie",["Iceland"]="is",["Estonia"]="ee",
    ["Latvia"]="lv",["Lithuania"]="lt",["Slovakia"]="sk",["Hungary"]="hu",
    ["Romania"]="ro",["Bulgaria"]="bg",["Serbia"]="rs",["Croatia"]="hr",
    ["Slovenia"]="si",["Bosnia"]="ba",["Montenegro"]="me",["Albania"]="al",
    ["Macedonia"]="mk",["Ukraine"]="ua",["Belarus"]="by",["Moldova"]="md",
    ["Malta"]="mt",["Kosovo"]="xk",["Canada"]="ca",["Mexico"]="mx",
    ["Guatemala"]="gt",["Belize"]="bz",["Honduras"]="hn",["El Salvador"]="sv",
    ["Nicaragua"]="ni",["Costa Rica"]="cr",["Panama"]="pa",["Cuba"]="cu",
    ["Jamaica"]="jm",["Haiti"]="ht",["Cộng Hòa Dominican"]="do",
    ["Trinidad & Tobago"]="tt",["Barbados"]="bb",["Bahamas"]="bs",
    ["Brazil"]="br",["Argentina"]="ar",["Colombia"]="co",["Venezuela"]="ve",
    ["Peru"]="pe",["Chile"]="cl",["Bolivia"]="bo",["Ecuador"]="ec",
    ["Paraguay"]="py",["Uruguay"]="uy",["Guyana"]="gy",["Suriname"]="sr",
    ["Libya"]="ly",["Tunisia"]="tn",["Algeria"]="dz",["Morocco"]="ma",
    ["Sudan"]="sd",["Nigeria"]="ng",["Ghana"]="gh",["Senegal"]="sn",
    ["Côte d'Ivoire"]="ci",["Guinea"]="gn",["Mali"]="ml",["Burkina Faso"]="bf",
    ["Niger"]="ne",["Togo"]="tg",["Benin"]="bj",["Cameroon"]="cm",
    ["Gabon"]="ga",["Congo"]="cg",["DR Congo"]="cd",["Liberia"]="lr",
    ["Sierra Leone"]="sl",["Kenya"]="ke",["Ethiopia"]="et",["Tanzania"]="tz",
    ["Uganda"]="ug",["Rwanda"]="rw",["Somalia"]="so",["Mozambique"]="mz",
    ["Zambia"]="zm",["Zimbabwe"]="zw",["Angola"]="ao",["Namibia"]="na",
    ["Botswana"]="bw",["Lesotho"]="ls",["Madagascar"]="mg",["Mauritius"]="mu",
    ["Seychelles"]="sc",["New Zealand"]="nz",["Papua New Guinea"]="pg",
    ["Fiji"]="fj",["Solomon Islands"]="sb",["Vanuatu"]="vu",["Samoa"]="ws",["Tonga"]="to",
}

local function getFlagUrl(countryName)
    local code = FLAG_CODE[countryName]
    if code then
        return "https://flagcdn.com/w160/" .. code .. ".png"
    end
    return nil
end

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

-- ==================== GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DziAutoFlag"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui

-- Main panel (title + answer)
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

-- Drag
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

-- ==================== HINT PANEL (4 nút gợi ý + preview cờ) ====================
local HintPanel = Instance.new("Frame")
HintPanel.Size = UDim2.new(0, 250, 0, 10) -- sẽ resize động
HintPanel.Position = UDim2.new(0.5, -125, 0, 90)
HintPanel.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
HintPanel.BorderSizePixel = 0
HintPanel.ZIndex = 100
HintPanel.Visible = false
HintPanel.Parent = ScreenGui
Instance.new("UICorner", HintPanel).CornerRadius = UDim.new(0, 10)
local HPS = Instance.new("UIStroke", HintPanel)
HPS.Color = Color3.fromRGB(140, 80, 200); HPS.Thickness = 1.5

-- Label "Gợi ý cờ:"
local HintTitle = Instance.new("TextLabel", HintPanel)
HintTitle.Size = UDim2.new(1, 0, 0, 18)
HintTitle.Position = UDim2.new(0, 0, 0, 4)
HintTitle.BackgroundTransparency = 1
HintTitle.Text = "🏳 GỢI Ý CỜ"
HintTitle.TextColor3 = Color3.fromRGB(180, 140, 255)
HintTitle.TextSize = 9
HintTitle.Font = Enum.Font.GothamBold
HintTitle.ZIndex = 101

-- Preview cờ (ImageLabel) - hiện khi bấm nút
local FlagPreview = Instance.new("ImageLabel", HintPanel)
FlagPreview.Size = UDim2.new(1, -12, 0, 80)
FlagPreview.Position = UDim2.new(0, 6, 0, 26)
FlagPreview.BackgroundColor3 = Color3.fromRGB(20, 14, 34)
FlagPreview.BorderSizePixel = 0
FlagPreview.Image = ""
FlagPreview.ScaleType = Enum.ScaleType.Fit
FlagPreview.ZIndex = 102
FlagPreview.Visible = false
Instance.new("UICorner", FlagPreview).CornerRadius = UDim.new(0, 6)

-- Country name label dưới ảnh cờ
local FlagName = Instance.new("TextLabel", HintPanel)
FlagName.Size = UDim2.new(1, -12, 0, 18)
FlagName.Position = UDim2.new(0, 6, 0, 110)
FlagName.BackgroundTransparency = 1
FlagName.Text = ""
FlagName.TextColor3 = Color3.fromRGB(220, 220, 255)
FlagName.TextSize = 11
FlagName.Font = Enum.Font.GothamBold
FlagName.ZIndex = 102
FlagName.Visible = false

-- 4 nút hint (tạo sẵn, ẩn/hiện + đổi text động)
local hintBtns = {}
for i = 1, 4 do
    local btn = Instance.new("TextButton", HintPanel)
    btn.Size = UDim2.new(0.5, -8, 0, 24)
    -- 2x2 grid
    local col = (i-1) % 2
    local row = math.floor((i-1) / 2)
    btn.Position = UDim2.new(col * 0.5, col == 0 and 6 or 2, 0, 132 + row * 28)
    btn.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    btn.BorderSizePixel = 0
    btn.Text = "..."
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.ZIndex = 103
    btn.Visible = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UITextSizeConstraint", btn).MaxTextSize = 11
    local bs = Instance.new("UIStroke", btn)
    bs.Color = Color3.fromRGB(100, 60, 180); bs.Thickness = 1

    hintBtns[i] = btn
end

local currentHintCountries = {}
local selectedBtn = nil

local function showFlagPreview(countryName, btn)
    -- toggle: bấm lại nút đang chọn thì ẩn
    if selectedBtn == btn then
        FlagPreview.Visible = false
        FlagName.Visible = false
        selectedBtn = nil
        -- reset màu tất cả nút
        for _, b in ipairs(hintBtns) do
            b.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
        end
        HintPanel.Size = UDim2.new(0, 250, 0, 132 + math.ceil(#currentHintCountries/2)*28 + 6)
        return
    end

    selectedBtn = btn
    -- highlight nút được chọn
    for _, b in ipairs(hintBtns) do
        b.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    end
    btn.BackgroundColor3 = Color3.fromRGB(60, 30, 100)

    local url = getFlagUrl(countryName)
    if url then
        FlagPreview.Image = url
        FlagPreview.Visible = true
        FlagName.Text = countryName
        FlagName.Visible = true
        -- resize panel để chứa preview
        HintPanel.Size = UDim2.new(0, 250, 0, 132 + math.ceil(#currentHintCountries/2)*28 + 6 + 90 + 22)
    else
        FlagPreview.Visible = false
        FlagName.Text = countryName .. " (no flag)"
        FlagName.Visible = true
        HintPanel.Size = UDim2.new(0, 250, 0, 132 + math.ceil(#currentHintCountries/2)*28 + 6 + 22)
    end
end

local function updateHintButtons(countries)
    currentHintCountries = countries
    selectedBtn = nil
    FlagPreview.Visible = false
    FlagName.Visible = false

    local n = #countries
    if n == 0 then
        HintPanel.Visible = false
        return
    end

    HintPanel.Visible = true
    local rows = math.ceil(n / 2)
    HintPanel.Size = UDim2.new(0, 250, 0, 132 + rows * 28 + 6)

    for i = 1, 4 do
        local btn = hintBtns[i]
        if countries[i] then
            btn.Text = countries[i]
            btn.Visible = true
            -- recalc position
            local col = (i-1) % 2
            local row = math.floor((i-1) / 2)
            btn.Position = UDim2.new(col * 0.5, col == 0 and 6 or 2, 0, 132 + row * 28)
            -- disconnect cũ, connect mới
            btn.MouseButton1Click:Connect(function()
                showFlagPreview(countries[i], btn)
            end)
        else
            btn.Visible = false
        end
    end
end

-- ==================== ANSWER LOGIC ====================
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

-- ==================== REMOTE HOOKS ====================
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local result = oldNamecall(self, ...)
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
        if obj:IsA("StringValue") then
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

-- ==================== SCAN GUI + LẤY 4 GỢI Ý ====================
local myTurn = false

local function tryMatch(n)
    if ANSWER_MAP[n] then return ANSWER_MAP[n] end
    local stripped = n:gsub("^nuoc ", "")
    if ANSWER_MAP[stripped] then return ANSWER_MAP[stripped] end
    return nil
end

local BLACKLIST = {
    "dzi","auto flag","hub","players","win","tham gia","cua hang",
    "kho do","troll","hang ngay","goi y","tiet lo","phan hoi",
    "lan thang","chuoi thang","tien mat","bao cao","nguoi moi",
    "x2","2x","bat dau","de ","kho ","trung binh",
}

-- Lưu 4 lựa chọn đang hiện (raw text của 4 button trong game)
local lastHintList = {}

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
                if not skip and not n:match("^[%d%$]") and not n:match("^%s*$") then
                    allTexts[#allTexts+1] = {text=t, norm=n}
                end
            end
        end
        for _, c in ipairs(obj:GetChildren()) do collect(c) end
    end

    for _, g in ipairs(player.PlayerGui:GetChildren()) do
        if g.Name ~= "DziAutoFlag" then collect(g) end
    end

    -- Tìm 4 lựa chọn (matched với ANSWER_MAP)
    local matched = {}
    local seen = {}
    for _, c in ipairs(allTexts) do
        local m = tryMatch(c.norm)
        if m and not seen[m] then
            seen[m] = true
            matched[#matched+1] = {mapped=m, raw=c.text}
        end
    end

    -- Cập nhật hint buttons nếu danh sách thay đổi
    if #matched >= 1 then
        myTurn = true

        -- Lấy tên mapped (VN) để hiện nút
        local newList = {}
        for _, v in ipairs(matched) do
            newList[#newList+1] = v.mapped
            if #newList >= 4 then break end
        end

        -- Check xem list có thay đổi không
        local changed = (#newList ~= #lastHintList)
        if not changed then
            for i, v in ipairs(newList) do
                if v ~= lastHintList[i] then changed = true; break end
            end
        end
        if changed then
            lastHintList = newList
            updateHintButtons(newList)
        end

        -- Không setAnswer nữa - để người chơi tự xem cờ rồi đoán
        -- (nếu muốn vẫn hiện đáp án thì bỏ comment dòng dưới)
        -- setAnswer("👀 Xem cờ bên dưới", false)

    elseif myTurn then
        myTurn = false
        currentFlag = nil
        lastHintList = {}
        updateHintButtons({})
        AnsLbl.Text = "⏳ Lượt đối thủ..."
        AnsLbl.TextColor3 = Color3.fromRGB(255, 165, 0)
        ABS.Color = Color3.fromRGB(150, 90, 0)
    elseif not myTurn and currentFlag == nil then
        local hasGameText = false
        for _, c in ipairs(allTexts) do
            if c.norm:find("nguoi moi",1,true) or c.norm:find("tham gia",1,true) or c.norm:find("bat dau",1,true) then
                hasGameText = true; break
            end
        end
        if hasGameText or #allTexts == 0 then
            AnsLbl.Text = "⏳ Chờ vào bàn..."
            AnsLbl.TextColor3 = Color3.fromRGB(150, 150, 150)
            ABS.Color = Color3.fromRGB(80, 80, 80)
        else
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
