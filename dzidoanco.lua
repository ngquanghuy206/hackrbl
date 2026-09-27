local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local placeId = game.PlaceId

-- ==================== ISO CODE MAP (tên hiển thị → ISO) ====================
-- Dùng flagcdn.com: https://flagcdn.com/w160/vn.png
local COUNTRY_ISO = {
    ["Việt Nam"]="vn",["Thái Lan"]="th",["Hàn Quốc"]="kr",["Trung Quốc"]="cn",
    ["Nhật Bản"]="jp",["Thụy Điển"]="se",["Thụy Sĩ"]="ch",["Tây Ban Nha"]="es",
    ["Bồ Đào Nha"]="pt",["Hà Lan"]="nl",["Đan Mạch"]="dk",["Phần Lan"]="fi",
    ["Na Uy"]="no",["Ba Lan"]="pl",["Hy Lạp"]="gr",["Ai Cập"]="eg",
    ["Ấn Độ"]="in",["Ả Rập Xê Út"]="sa",["Nam Phi"]="za",["Nam Sudan"]="ss",
    ["Bắc Triều Tiên"]="kp",["Hoa Kỳ"]="us",["Anh"]="gb",["Pháp"]="fr",
    ["Đức"]="de",["Nga"]="ru",["Bỉ"]="be",["Áo"]="at",["Séc"]="cz",
    ["Síp"]="cy",["Úc"]="au",["Ý"]="it",["Đài Loan"]="tw",["Mông Cổ"]="mn",
    ["Thổ Nhĩ Kỳ"]="tr",["Cộng Hòa Dominican"]="do",["Philippines"]="ph",
    ["Indonesia"]="id",["Malaysia"]="my",["Singapore"]="sg",["Myanmar"]="mm",
    ["Campuchia"]="kh",["Lào"]="la",["Brunei"]="bn",["Timor-Leste"]="tl",
    ["Pakistan"]="pk",["Bangladesh"]="bd",["Sri Lanka"]="lk",["Nepal"]="np",
    ["Bhutan"]="bt",["Maldives"]="mv",["Afghanistan"]="af",["Kazakhstan"]="kz",
    ["Uzbekistan"]="uz",["Turkmenistan"]="tm",["Kyrgyzstan"]="kg",["Tajikistan"]="tj",
    ["Iran"]="ir",["Iraq"]="iq",["Syria"]="sy",["Jordan"]="jo",["Lebanon"]="lb",
    ["Israel"]="il",["Palestine"]="ps",["Yemen"]="ye",["Oman"]="om",["UAE"]="ae",
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
    ["Jamaica"]="jm",["Haiti"]="ht",["Trinidad & Tobago"]="tt",["Barbados"]="bb",
    ["Bahamas"]="bs",["Brazil"]="br",["Argentina"]="ar",["Colombia"]="co",
    ["Venezuela"]="ve",["Peru"]="pe",["Chile"]="cl",["Bolivia"]="bo",
    ["Ecuador"]="ec",["Paraguay"]="py",["Uruguay"]="uy",["Guyana"]="gy",
    ["Suriname"]="sr",["Libya"]="ly",["Tunisia"]="tn",["Algeria"]="dz",
    ["Morocco"]="ma",["Sudan"]="sd",["Nigeria"]="ng",["Ghana"]="gh",
    ["Senegal"]="sn",["Côte d'Ivoire"]="ci",["Guinea"]="gn",["Mali"]="ml",
    ["Burkina Faso"]="bf",["Niger"]="ne",["Togo"]="tg",["Benin"]="bj",
    ["Cameroon"]="cm",["Gabon"]="ga",["Congo"]="cg",["DR Congo"]="cd",
    ["Liberia"]="lr",["Sierra Leone"]="sl",["Kenya"]="ke",["Ethiopia"]="et",
    ["Tanzania"]="tz",["Uganda"]="ug",["Rwanda"]="rw",["Somalia"]="so",
    ["Mozambique"]="mz",["Zambia"]="zm",["Zimbabwe"]="zw",["Angola"]="ao",
    ["Namibia"]="na",["Botswana"]="bw",["Lesotho"]="ls",["Madagascar"]="mg",
    ["Mauritius"]="mu",["Seychelles"]="sc",["New Zealand"]="nz",
    ["Papua New Guinea"]="pg",["Fiji"]="fj",["Solomon Islands"]="sb",
    ["Vanuatu"]="vu",["Samoa"]="ws",["Tonga"]="to",
    -- Thêm nước hay xuất hiện trong game
    ["Greenland"]="gl",["Grenada"]="gd",["Bermuda"]="bm",["Puerto Rico"]="pr",
    ["Aruba"]="aw",["Curaçao"]="cw",["Martinique"]="mq",["Guadeloupe"]="gp",
    ["Réunion"]="re",["Mayotte"]="yt",["Gibraltar"]="gi",["Andorra"]="ad",
    ["San Marino"]="sm",["Vatican"]="va",["Faroe Islands"]="fo",
    ["Cayman Islands"]="ky",["Turks and Caicos"]="tc",["Virgin Islands"]="vi",
    ["Guam"]="gu",["Northern Mariana"]="mp",["American Samoa"]="as",
    ["New Caledonia"]="nc",["French Polynesia"]="pf",["Palau"]="pw",
    ["Micronesia"]="fm",["Marshall Islands"]="mh",["Kiribati"]="ki",["Nauru"]="nr",
    ["Tuvalu"]="tv",["Djibouti"]="dj",["Eritrea"]="er",["Comoros"]="km",
    ["Cape Verde"]="cv",["São Tomé and Príncipe"]="st",["Equatorial Guinea"]="gq",
    ["Central African Republic"]="cf",["South Sudan"]="ss",["Eswatini"]="sz",
    ["Malawi"]="mw",["Burundi"]="bi",["Chad"]="td",["Gambia"]="gm",
    ["Guinea-Bissau"]="gw",["Cabo Verde"]="cv",["Mauritania"]="mr",
    ["Western Sahara"]="eh",["Libya"]="ly",
}

-- ==================== ANSWER MAP (text trong game → tên chuẩn) ====================
local ANSWER_MAP = {}
-- Build từ COUNTRY_ISO keys + thêm alias
local ALIASES = {
    -- VN names
    ["viet nam"]="Việt Nam",["thailand"]="Thái Lan",["thai lan"]="Thái Lan",
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
    ["hoa ky"]="Hoa Kỳ",["usa"]="Hoa Kỳ",["united states"]="Hoa Kỳ",
    ["vuong quoc anh"]="Anh",["uk"]="Anh",["united kingdom"]="Anh",["anh"]="Anh",
    ["phap"]="Pháp",["france"]="Pháp",
    ["duc"]="Đức",["germany"]="Đức",
    ["nga"]="Nga",["russia"]="Nga",
    ["bi"]="Bỉ",["belgium"]="Bỉ",
    ["ao"]="Áo",["austria"]="Áo",
    ["sec"]="Séc",["czech"]="Séc",["czechia"]="Séc",
    ["sip"]="Síp",["cyprus"]="Síp",
    ["uc"]="Úc",["nuoc uc"]="Úc",["australia"]="Úc",
    ["y"]="Ý",["italy"]="Ý",
    ["dai loan"]="Đài Loan",["taiwan"]="Đài Loan",
    ["mong co"]="Mông Cổ",["mongolia"]="Mông Cổ",
    ["tho nhi ky"]="Thổ Nhĩ Kỳ",["turkey"]="Thổ Nhĩ Kỳ",["turkiye"]="Thổ Nhĩ Kỳ",
    ["cong hoa dominican"]="Cộng Hòa Dominican",["dominican republic"]="Cộng Hòa Dominican",
    ["campuchia"]="Campuchia",["cambodia"]="Campuchia",
    ["lao"]="Lào",["laos"]="Lào",
    ["uae"]="UAE",["united arab emirates"]="UAE",
    ["ivory coast"]="Côte d'Ivoire",
    ["dr congo"]="DR Congo",
    ["sierra leone"]="Sierra Leone",
    ["new zealand"]="New Zealand",
    ["papua new guinea"]="Papua New Guinea",
    ["solomon islands"]="Solomon Islands",
    ["costa rica"]="Costa Rica",
    ["el salvador"]="El Salvador",
    ["burkina faso"]="Burkina Faso",
    ["trinidad"]="Trinidad & Tobago",["trinidad and tobago"]="Trinidad & Tobago",
    ["sao tome"]="São Tomé and Príncipe",
    ["equatorial guinea"]="Equatorial Guinea",
    ["central african republic"]="Central African Republic",
    ["guinea bissau"]="Guinea-Bissau",
    ["cape verde"]="Cape Verde",["cabo verde"]="Cape Verde",
    ["faroe islands"]="Faroe Islands",
    ["cayman islands"]="Cayman Islands",
    ["northern mariana"]="Northern Mariana",
    ["american samoa"]="American Samoa",
    ["new caledonia"]="New Caledonia",
    ["french polynesia"]="French Polynesia",
    ["marshall islands"]="Marshall Islands",
    ["western sahara"]="Western Sahara",
}
-- Merge ALIASES vào ANSWER_MAP
for k,v in pairs(ALIASES) do ANSWER_MAP[k]=v end
-- Thêm tất cả key trong COUNTRY_ISO theo lowercase (tên EN)
for name,_ in pairs(COUNTRY_ISO) do
    local k=name:lower()
        :gsub("[àáảãạăắặằẳẵâấầẩẫậ]","a"):gsub("[èéẻẽẹêếềểễệ]","e")
        :gsub("[ìíỉĩị]","i"):gsub("[òóỏõọôốồổỗộơớờởỡợ]","o")
        :gsub("[ùúủũụưứừửữự]","u"):gsub("[ỳýỷỹỵ]","y"):gsub("đ","d")
        :gsub("%s+"," "):gsub("^%s*(.-)%s*$","%1")
    if not ANSWER_MAP[k] then ANSWER_MAP[k]=name end
end

local function norm(s)
    return tostring(s):lower()
        :gsub("[àáảãạăắặằẳẵâấầẩẫậ]","a"):gsub("[èéẻẽẹêếềểễệ]","e")
        :gsub("[ìíỉĩị]","i"):gsub("[òóỏõọôốồổỗộơớờởỡợ]","o")
        :gsub("[ùúủũụưứừửữự]","u"):gsub("[ỳýỷỹỵ]","y"):gsub("đ","d")
        :gsub("%s+"," "):gsub("^%s*(.-)%s*$","%1")
end

local function tryMatch(n)
    local s=n:gsub("^nuoc ","")
    return ANSWER_MAP[s] or ANSWER_MAP[n]
end

-- cache: iso → asset string đã load
local flagCache = {}

local function loadFlagAsync(name, imgLabel, noFlagLabel, nameLbl)
    local iso = COUNTRY_ISO[name]
    if not iso then
        imgLabel.Visible = false
        noFlagLabel.Text = "❌ Không có cờ:\n" .. name
        noFlagLabel.Visible = true
        nameLbl.Text = name; nameLbl.Visible = true
        return
    end

    -- hiện loading
    imgLabel.Visible = false
    noFlagLabel.Text = "⏳ Đang tải cờ..."
    noFlagLabel.Visible = true
    nameLbl.Text = "🏳 " .. name; nameLbl.Visible = true

    -- Nếu đã cache
    if flagCache[iso] then
        imgLabel.Image = flagCache[iso]
        imgLabel.Visible = true
        noFlagLabel.Visible = false
        return
    end

    task.spawn(function()
        local url = "https://flagcdn.com/w160/" .. iso .. ".png"
        local fname = "dziflag_" .. iso .. ".png"

        -- Thử dùng getcustomasset (Synapse X, Wave, Solara...)
        local reqFn = nil
        if syn and syn.request then reqFn = syn.request
        elseif request then reqFn = request
        elseif http_request then reqFn = http_request end

        if reqFn and writefile and getcustomasset then
            local ok, res = pcall(reqFn, {Url=url, Method="GET"})
            if ok and res and res.Body and #res.Body > 100 then
                pcall(writefile, fname, res.Body)
                local ok2, asset = pcall(getcustomasset, fname)
                if ok2 and asset then
                    flagCache[iso] = asset
                    imgLabel.Image = asset
                    imgLabel.Visible = true
                    noFlagLabel.Visible = false
                    return
                end
            end
        end

        -- Fallback: thử set URL trực tiếp (một số executor patch được)
        local ok3 = pcall(function()
            imgLabel.Image = url
        end)
        if ok3 then
            -- chờ 1s xem có load không (Image sẽ thành "" nếu fail)
            task.wait(1.5)
            if imgLabel.Image ~= "" and imgLabel.Image ~= url then
                -- đã được convert thành asset → OK
                flagCache[iso] = imgLabel.Image
                imgLabel.Visible = true
                noFlagLabel.Visible = false
                return
            elseif imgLabel.Image == url then
                -- vẫn là URL → executor không support, thử content hash
                imgLabel.Visible = true
                noFlagLabel.Visible = false
                return
            end
        end

        -- Hoàn toàn fail
        imgLabel.Visible = false
        noFlagLabel.Text = "❌ Executor không hỗ trợ load ảnh\n(" .. iso .. ")"
        noFlagLabel.Visible = true
    end)
end

-- ==================== GUI HELPERS ====================
local function makeDrag(frame,handle)
    handle=handle or frame
    local drag,ds,dp=false,nil,nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then
            drag=true;ds=i.Position;dp=frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and(i.UserInputType==Enum.UserInputType.MouseMovement
        or i.UserInputType==Enum.UserInputType.Touch) then
            local d=i.Position-ds
            frame.Position=UDim2.new(dp.X.Scale,dp.X.Offset+d.X,dp.Y.Scale,dp.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1
        or i.UserInputType==Enum.UserInputType.Touch then drag=false end
    end)
end
local function mkCorner(p,r) Instance.new("UICorner",p).CornerRadius=UDim.new(0,r or 8) end
local function mkStroke(p,c,t) local s=Instance.new("UIStroke",p);s.Color=c;s.Thickness=t or 1.5;return s end

-- ==================== SCREEN GUI ====================
local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="DziAutoFlag";ScreenGui.ResetOnSpawn=false
ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ScreenGui.Parent=player.PlayerGui

local MENU_W=260
local menuOpen=true
local activeTab=nil

-- Main panel
local MenuPanel=Instance.new("Frame")
MenuPanel.Size=UDim2.new(0,MENU_W,0,28)
MenuPanel.Position=UDim2.new(0.5,-MENU_W/2,0,6)
MenuPanel.BackgroundColor3=Color3.fromRGB(10,8,22)
MenuPanel.BorderSizePixel=0;MenuPanel.ZIndex=200
MenuPanel.Parent=ScreenGui
mkCorner(MenuPanel,10);mkStroke(MenuPanel,Color3.fromRGB(140,80,200))

local TitleBar=Instance.new("Frame",MenuPanel)
TitleBar.Size=UDim2.new(1,0,0,28);TitleBar.BackgroundTransparency=1;TitleBar.ZIndex=201
makeDrag(MenuPanel,TitleBar)

local TitleLbl=Instance.new("TextLabel",TitleBar)
TitleLbl.Size=UDim2.new(1,-50,1,0);TitleLbl.Position=UDim2.new(0,8,0,0)
TitleLbl.BackgroundTransparency=1;TitleLbl.Text="🏴 DZI AUTO FLAG"
TitleLbl.TextColor3=Color3.fromRGB(200,160,255);TitleLbl.TextSize=11
TitleLbl.Font=Enum.Font.GothamBold
TitleLbl.TextXAlignment=Enum.TextXAlignment.Left;TitleLbl.ZIndex=202

local ToggleMenu=Instance.new("TextButton",TitleBar)
ToggleMenu.Size=UDim2.new(0,36,0,20);ToggleMenu.Position=UDim2.new(1,-40,0,4)
ToggleMenu.BackgroundColor3=Color3.fromRGB(50,30,90);ToggleMenu.BorderSizePixel=0
ToggleMenu.Text="▼";ToggleMenu.TextColor3=Color3.fromRGB(200,160,255)
ToggleMenu.TextSize=11;ToggleMenu.Font=Enum.Font.GothamBold;ToggleMenu.ZIndex=203
mkCorner(ToggleMenu,5)

local MenuContent=Instance.new("Frame",MenuPanel)
MenuContent.Size=UDim2.new(1,0,0,0)
MenuContent.Position=UDim2.new(0,0,0,28)
MenuContent.BackgroundTransparency=1;MenuContent.ZIndex=201;MenuContent.Visible=true

-- Tab buttons row
local tabBtns={};local tabPages={}
local function makeTab(name,icon,idx)
    local tb=Instance.new("TextButton",MenuContent)
    tb.Size=UDim2.new(0,76,0,26);tb.Position=UDim2.new(0,6+(idx-1)*82,0,4)
    tb.BackgroundColor3=Color3.fromRGB(25,15,50);tb.BorderSizePixel=0
    tb.Text=icon.." "..name;tb.TextColor3=Color3.fromRGB(180,150,255)
    tb.TextSize=10;tb.Font=Enum.Font.GothamBold;tb.ZIndex=202;mkCorner(tb,6)
    mkStroke(tb,Color3.fromRGB(100,60,180),1);tabBtns[name]=tb

    local page=Instance.new("Frame",MenuContent)
    page.Size=UDim2.new(1,-8,0,10)
    page.Position=UDim2.new(0,4,0,34)
    page.BackgroundTransparency=1;page.ZIndex=202;page.Visible=false
    tabPages[name]=page;return page
end

-- ==================== SHARED FLAG VIEWER ====================
local function makeFlagViewer(parent, yOffset)
    local container=Instance.new("Frame",parent)
    container.Size=UDim2.new(1,0,0,0)
    container.Position=UDim2.new(0,0,0,yOffset)
    container.BackgroundTransparency=1;container.ZIndex=203

    local img=Instance.new("ImageLabel",container)
    img.Size=UDim2.new(1,-4,0,90);img.Position=UDim2.new(0,2,0,0)
    img.BackgroundColor3=Color3.fromRGB(15,10,30);img.BorderSizePixel=0
    img.Image="";img.ScaleType=Enum.ScaleType.Fit;img.ZIndex=204;img.Visible=false
    mkCorner(img,8)

    local noFlag=Instance.new("TextLabel",container)
    noFlag.Size=UDim2.new(1,-4,0,90);noFlag.Position=UDim2.new(0,2,0,0)
    noFlag.BackgroundColor3=Color3.fromRGB(15,10,30);noFlag.BorderSizePixel=0
    noFlag.Text=""
    noFlag.TextColor3=Color3.fromRGB(200,150,100);noFlag.TextSize=11
    noFlag.Font=Enum.Font.GothamBold;noFlag.TextWrapped=true
    noFlag.TextXAlignment=Enum.TextXAlignment.Center
    noFlag.ZIndex=204;noFlag.Visible=false;mkCorner(noFlag,8)

    local lbl=Instance.new("TextLabel",container)
    lbl.Size=UDim2.new(1,-4,0,18);lbl.Position=UDim2.new(0,2,0,94)
    lbl.BackgroundTransparency=1;lbl.Text=""
    lbl.TextColor3=Color3.fromRGB(200,255,200);lbl.TextSize=10
    lbl.Font=Enum.Font.GothamBold;lbl.ZIndex=204;lbl.Visible=false

    local function show(name)
        container.Size=UDim2.new(1,0,0,116)
        loadFlagAsync(name, img, noFlag, lbl)
    end
    local function hide()
        img.Visible=false;noFlag.Visible=false;lbl.Visible=false
        img.Image=""
        container.Size=UDim2.new(1,0,0,0)
    end
    return container,show,hide
end

-- ==================== TAB: CỜ MẪU ====================
local flagPage=makeTab("Cờ mẫu","🏳",1)

local searchBox=Instance.new("TextBox",flagPage)
searchBox.Size=UDim2.new(1,0,0,26);searchBox.Position=UDim2.new(0,0,0,0)
searchBox.BackgroundColor3=Color3.fromRGB(20,14,40);searchBox.BorderSizePixel=0
searchBox.Text="";searchBox.PlaceholderText="🔍 Gõ tên nước..."
searchBox.TextColor3=Color3.fromRGB(220,200,255)
searchBox.PlaceholderColor3=Color3.fromRGB(100,90,140)
searchBox.TextSize=11;searchBox.Font=Enum.Font.Gotham;searchBox.ZIndex=203
mkCorner(searchBox,6)

-- Suggestion list
local suggFrame=Instance.new("Frame",flagPage)
suggFrame.Size=UDim2.new(1,0,0,0);suggFrame.Position=UDim2.new(0,0,0,30)
suggFrame.BackgroundColor3=Color3.fromRGB(18,12,38);suggFrame.BorderSizePixel=0
suggFrame.ZIndex=210;suggFrame.Visible=false;mkCorner(suggFrame,6)
mkStroke(suggFrame,Color3.fromRGB(100,60,180),1)

local SUGG_N=6
local suggBtns={}
for i=1,SUGG_N do
    local sb=Instance.new("TextButton",suggFrame)
    sb.Size=UDim2.new(1,-4,0,22);sb.Position=UDim2.new(0,2,0,(i-1)*23+2)
    sb.BackgroundTransparency=1;sb.Text=""
    sb.TextColor3=Color3.fromRGB(220,200,255);sb.TextSize=11
    sb.Font=Enum.Font.Gotham;sb.ZIndex=211
    sb.TextXAlignment=Enum.TextXAlignment.Left;suggBtns[i]=sb
end

local fvContainer,fvShow,fvHide=makeFlagViewer(flagPage,30)
local suggVisible=false

local function hideSugg()
    suggVisible=false;suggFrame.Visible=false
end

local function updateSugg(query)
    local q=norm(query)
    if #q<1 then hideSugg();return end
    local results={};local seen={}
    -- tìm trong COUNTRY_ISO keys
    for name,_ in pairs(COUNTRY_ISO) do
        local nname=norm(name)
        if nname:find(q,1,true) and not seen[name] then
            seen[name]=true;results[#results+1]=name
        end
        if #results>=SUGG_N then break end
    end
    -- tìm thêm từ ALIASES nếu chưa đủ
    if #results<SUGG_N then
        for k,v in pairs(ALIASES) do
            if k:find(q,1,true) and not seen[v] then
                seen[v]=true;results[#results+1]=v
            end
            if #results>=SUGG_N then break end
        end
    end
    if #results==0 then hideSugg();return end
    suggFrame.Visible=true;suggVisible=true
    suggFrame.Size=UDim2.new(1,0,0,math.min(#results,SUGG_N)*23+4)
    for i=1,SUGG_N do
        if results[i] then
            local country=results[i]
            suggBtns[i].Text="  "..country;suggBtns[i].Visible=true
            suggBtns[i].MouseButton1Click:Connect(function()
                searchBox.Text=country;hideSugg()
                fvShow(country)
                -- update page size
                flagPage.Size=UDim2.new(1,-8,0,30+116)
                refreshMenuHeight()
            end)
        else
            suggBtns[i].Visible=false
        end
    end
    -- sugg frame nằm đè lên fvContainer → đẩy fvContainer xuống
    fvContainer.Position=UDim2.new(0,0,0,30+suggFrame.Size.Y.Offset+2)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    fvHide();flagPage.Size=UDim2.new(1,-8,0,58)
    updateSugg(searchBox.Text)
    refreshMenuHeight()
end)

flagPage.Size=UDim2.new(1,-8,0,58)

-- ==================== TAB: SERVER ====================
local svPage=makeTab("Server","🌐",2)
svPage.Size=UDim2.new(1,-8,0,118)

local function mkLbl(parent,text,y,h,tc,fs)
    local l=Instance.new("TextLabel",parent)
    l.Size=UDim2.new(1,0,0,h);l.Position=UDim2.new(0,0,0,y)
    l.BackgroundTransparency=1;l.Text=text
    l.TextColor3=tc or Color3.fromRGB(180,180,255)
    l.TextSize=fs or 10;l.Font=Enum.Font.Gotham
    l.TextWrapped=true;l.ZIndex=203
    l.TextXAlignment=Enum.TextXAlignment.Left
    return l
end

mkLbl(svPage,"Min players (không đầy):",0,16,Color3.fromRGB(150,140,200))
local minBox=Instance.new("TextBox",svPage)
minBox.Size=UDim2.new(0,60,0,22);minBox.Position=UDim2.new(0,0,0,18)
minBox.BackgroundColor3=Color3.fromRGB(20,14,40);minBox.BorderSizePixel=0
minBox.Text="3";minBox.TextColor3=Color3.fromRGB(220,200,255)
minBox.TextSize=11;minBox.Font=Enum.Font.Gotham;minBox.ZIndex=203;mkCorner(minBox,5)

local svStatusLbl=mkLbl(svPage,"Sẵn sàng tìm server.",44,16,Color3.fromRGB(150,150,200))
local svResultLbl=mkLbl(svPage,"",62,22,Color3.fromRGB(100,255,150))

local hopBtn=Instance.new("TextButton",svPage)
hopBtn.Size=UDim2.new(1,0,0,30);hopBtn.Position=UDim2.new(0,0,0,86)
hopBtn.BackgroundColor3=Color3.fromRGB(20,60,160);hopBtn.BorderSizePixel=0
hopBtn.Text="🔄  Chuyển server đông người";hopBtn.TextColor3=Color3.fromRGB(200,230,255)
hopBtn.TextSize=11;hopBtn.Font=Enum.Font.GothamBold;hopBtn.ZIndex=203
mkCorner(hopBtn,8);mkStroke(hopBtn,Color3.fromRGB(80,140,255),1)

local isHopping=false
hopBtn.MouseButton1Click:Connect(function()
    if isHopping then return end
    isHopping=true;hopBtn.Text="⏳ Đang tìm..."
    hopBtn.BackgroundColor3=Color3.fromRGB(15,40,100)
    svStatusLbl.Text="Đang query server list...";svResultLbl.Text=""

    task.spawn(function()
        local reqFn=nil
        if syn and syn.request then reqFn=syn.request
        elseif request then reqFn=request
        elseif http_request then reqFn=http_request end

        if not reqFn then
            svStatusLbl.Text="❌ Executor không hỗ trợ HTTP"
            hopBtn.Text="🔄  Chuyển server đông người"
            hopBtn.BackgroundColor3=Color3.fromRGB(20,60,160)
            isHopping=false;return
        end

        local maxPl=Players.MaxPlayers
        local url="https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Desc&limit=100"
        local ok,res=pcall(reqFn,{Url=url,Method="GET"})
        if not ok or not res then
            svStatusLbl.Text="❌ Request thất bại"
            hopBtn.Text="🔄  Chuyển server đông người"
            hopBtn.BackgroundColor3=Color3.fromRGB(20,60,160)
            isHopping=false;return
        end

        local ok2,data=pcall(function() return HttpService:JSONDecode(res.Body) end)
        if not ok2 or not data or not data.data then
            svStatusLbl.Text="❌ Parse JSON thất bại"
            hopBtn.Text="🔄  Chuyển server đông người"
            hopBtn.BackgroundColor3=Color3.fromRGB(20,60,160)
            isHopping=false;return
        end

        local minP=tonumber(minBox.Text) or 3
        local best=nil;local bestCount=0
        for _,sv in ipairs(data.data) do
            local cur=sv.playing or 0
            local mx=sv.maxPlayers or maxPl
            if cur>=minP and cur<mx and cur>bestCount then
                bestCount=cur;best=sv
            end
        end

        if best then
            svStatusLbl.Text="✅ Tìm thấy server!"
            svResultLbl.Text=bestCount.."/"..best.maxPlayers.." người | "..string.sub(best.id,1,8).."..."
            hopBtn.Text="✈️  Đang chuyển..."
            task.wait(0.8)
            local ok3,err=pcall(function()
                TeleportService:TeleportToPlaceInstance(placeId,best.id,player)
            end)
            if not ok3 then
                svStatusLbl.Text="❌ Teleport lỗi: "..(tostring(err):sub(1,40))
                hopBtn.Text="🔄  Chuyển server đông người"
                hopBtn.BackgroundColor3=Color3.fromRGB(20,60,160)
                isHopping=false
            end
        else
            svStatusLbl.Text="❌ Không tìm thấy (thử giảm min)"
            svResultLbl.Text=""
            hopBtn.Text="🔄  Chuyển server đông người"
            hopBtn.BackgroundColor3=Color3.fromRGB(20,60,160)
            isHopping=false
        end
    end)
end)

-- ==================== TAB: GỢI Ý ====================
local hintPage=makeTab("Gợi ý","🎮",3)
hintPage.Size=UDim2.new(1,-8,0,40)

local hintNoGame=Instance.new("TextLabel",hintPage)
hintNoGame.Size=UDim2.new(1,0,0,30);hintNoGame.Position=UDim2.new(0,0,0,4)
hintNoGame.BackgroundTransparency=1;hintNoGame.Text="⏳ Chờ vào bàn chơi..."
hintNoGame.TextColor3=Color3.fromRGB(150,140,200);hintNoGame.TextSize=11
hintNoGame.Font=Enum.Font.GothamBold;hintNoGame.ZIndex=203

local hintBtns={}
for i=1,4 do
    local col=(i-1)%2;local row=math.floor((i-1)/2)
    local btn=Instance.new("TextButton",hintPage)
    btn.Size=UDim2.new(0.5,-8,0,26)
    btn.Position=UDim2.new(col*0.5,col==0 and 4 or 4,0,row*30)
    btn.BackgroundColor3=Color3.fromRGB(25,15,50);btn.BorderSizePixel=0
    btn.Text="";btn.TextColor3=Color3.fromRGB(210,190,255)
    btn.TextSize=10;btn.Font=Enum.Font.GothamBold
    btn.TextScaled=true;btn.ZIndex=203;btn.Visible=false
    mkCorner(btn,6);mkStroke(btn,Color3.fromRGB(100,60,180),1)
    Instance.new("UITextSizeConstraint",btn).MaxTextSize=11
    hintBtns[i]=btn
end

local hvContainer,hvShow,hvHide=makeFlagViewer(hintPage,64)
local selectedHintBtn=nil

local function setHintFlag(name,btn)
    if selectedHintBtn==btn then
        selectedHintBtn=nil
        for _,b in ipairs(hintBtns) do b.BackgroundColor3=Color3.fromRGB(25,15,50) end
        hvHide();hintPage.Size=UDim2.new(1,-8,0,64)
        refreshMenuHeight();return
    end
    selectedHintBtn=btn
    for _,b in ipairs(hintBtns) do b.BackgroundColor3=Color3.fromRGB(25,15,50) end
    btn.BackgroundColor3=Color3.fromRGB(60,30,110)
    hvShow(name)
    hintPage.Size=UDim2.new(1,-8,0,64+116)
    refreshMenuHeight()
end

-- ==================== TAB SWITCH + HEIGHT ====================
function refreshMenuHeight()
    if not menuOpen then
        MenuContent.Visible=false
        MenuPanel.Size=UDim2.new(0,MENU_W,0,28)
        return
    end
    MenuContent.Visible=true
    local ph=activeTab and tabPages[activeTab].Size.Y.Offset or 0
    local total=28+34+ph+6
    MenuPanel.Size=UDim2.new(0,MENU_W,0,total)
    MenuContent.Size=UDim2.new(1,0,0,total-28)
end

local function switchTab(name)
    for n,pg in pairs(tabPages) do
        pg.Visible=(n==name)
        tabBtns[n].BackgroundColor3=n==name
            and Color3.fromRGB(60,30,120) or Color3.fromRGB(25,15,50)
    end
    activeTab=name;refreshMenuHeight()
end

tabBtns["Cờ mẫu"].MouseButton1Click:Connect(function() switchTab("Cờ mẫu") end)
tabBtns["Server"].MouseButton1Click:Connect(function() switchTab("Server") end)
tabBtns["Gợi ý"].MouseButton1Click:Connect(function() switchTab("Gợi ý") end)

ToggleMenu.MouseButton1Click:Connect(function()
    menuOpen=not menuOpen
    ToggleMenu.Text=menuOpen and "▼" or "▲"
    refreshMenuHeight()
end)

switchTab("Cờ mẫu")

-- ==================== SCAN GUI ====================
local BLACKLIST={
    "dzi","auto flag","hub","players","win","tham gia","cua hang",
    "kho do","troll","hang ngay","goi y","tiet lo","phan hoi",
    "lan thang","chuoi thang","tien mat","bao cao","nguoi moi",
    "x2","2x","bat dau","de ","kho ","trung binh","luot","lượt",
    "suy nghi","bao cao","x2 tien","x2 lan","x2 chuo","phan hoi",
    "cuc doan","khó","kho","de","trung","cuc",
}

local lastHints={};local hintConns={}

local function listsEq(a,b)
    if #a~=#b then return false end
    for i,v in ipairs(a) do if v~=b[i] then return false end end
    return true
end

local function updateHintBtns(list)
    for _,c in ipairs(hintConns) do c:Disconnect() end
    hintConns={}
    selectedHintBtn=nil;hvHide()

    local n=#list
    hintNoGame.Visible=(n==0)
    for i=1,4 do
        local btn=hintBtns[i]
        if list[i] then
            btn.Text=list[i];btn.Visible=true
            btn.BackgroundColor3=Color3.fromRGB(25,15,50)
            local country=list[i]
            local c=btn.MouseButton1Click:Connect(function()
                if btn.Text==country then setHintFlag(country,btn) end
            end)
            hintConns[#hintConns+1]=c
        else
            btn.Visible=false
        end
    end
    hintPage.Size=UDim2.new(1,-8,0,n>0 and 64 or 40)
    if activeTab=="Gợi ý" then refreshMenuHeight() end
end

local tick0=0
RunService.Heartbeat:Connect(function()
    tick0+=1;if tick0<8 then return end;tick0=0
    pcall(function()
        local texts={}
        local function collect(obj)
            if(obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.Visible then
                local t=obj.Text
                if t and #t>=2 and #t<=60 then
                    local n=norm(t);local skip=false
                    for _,bad in ipairs(BLACKLIST) do
                        if n:find(bad,1,true) then skip=true;break end
                    end
                    if not skip and not n:match("^[%d%$%#%+]") and not n:match("^%s*$") then
                        texts[#texts+1]={text=t,norm=n}
                    end
                end
            end
            for _,c in ipairs(obj:GetChildren()) do collect(c) end
        end
        for _,g in ipairs(player.PlayerGui:GetChildren()) do
            if g.Name~="DziAutoFlag" then collect(g) end
        end

        local matched={};local seen={}
        for _,c in ipairs(texts) do
            local m=tryMatch(c.norm)
            if m and not seen[m] then seen[m]=true;matched[#matched+1]=m end
            if #matched>=4 then break end
        end

        if not listsEq(matched,lastHints) then
            lastHints=matched
            updateHintBtns(matched)
            if #matched>=1 and activeTab~="Gợi ý" then
                switchTab("Gợi ý")
            end
        end
    end)
end)
