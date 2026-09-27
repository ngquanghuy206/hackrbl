local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local placeId = game.PlaceId

-- ==================== ANSWER MAP ====================
local ANSWER_MAP = {
    ["viet nam"]="Việt Nam",["vietnam"]="Việt Nam",
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
    ["philippines"]="Philippines",["indonesia"]="Indonesia",["malaysia"]="Malaysia",
    ["singapore"]="Singapore",["myanmar"]="Myanmar",
    ["campuchia"]="Campuchia",["cambodia"]="Campuchia",
    ["lao"]="Lào",["laos"]="Lào",
    ["brunei"]="Brunei",["timor-leste"]="Timor-Leste",["timor leste"]="Timor-Leste",
    ["pakistan"]="Pakistan",["bangladesh"]="Bangladesh",["sri lanka"]="Sri Lanka",
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

local FLAG_ASSET = {
    ["Việt Nam"]="rbxassetid://6894555415",["Thái Lan"]="rbxassetid://6894556321",
    ["Hàn Quốc"]="rbxassetid://6894553287",["Trung Quốc"]="rbxassetid://6894552010",
    ["Nhật Bản"]="rbxassetid://6894553731",["Thụy Điển"]="rbxassetid://6894556073",
    ["Thụy Sĩ"]="rbxassetid://6894556137",["Tây Ban Nha"]="rbxassetid://6894555939",
    ["Bồ Đào Nha"]="rbxassetid://6894554499",["Hà Lan"]="rbxassetid://6894553199",
    ["Đan Mạch"]="rbxassetid://6894552374",["Phần Lan"]="rbxassetid://6894554237",
    ["Na Uy"]="rbxassetid://6894553939",["Ba Lan"]="rbxassetid://6894554345",
    ["Hy Lạp"]="rbxassetid://6894553375",["Ai Cập"]="rbxassetid://6894551717",
    ["Ấn Độ"]="rbxassetid://6894553485",["Ả Rập Xê Út"]="rbxassetid://6894555797",
    ["Nam Phi"]="rbxassetid://6894553857",["Bắc Triều Tiên"]="rbxassetid://6894551905",
    ["Hoa Kỳ"]="rbxassetid://6894556385",["Anh"]="rbxassetid://6894551795",
    ["Pháp"]="rbxassetid://6894552954",["Đức"]="rbxassetid://6894552578",
    ["Nga"]="rbxassetid://6894554671",["Bỉ"]="rbxassetid://6894551983",
    ["Áo"]="rbxassetid://6894551873",["Séc"]="rbxassetid://6894552122",
    ["Síp"]="rbxassetid://6894552202",["Úc"]="rbxassetid://6894551839",
    ["Ý"]="rbxassetid://6894553589",["Đài Loan"]="rbxassetid://6894556199",
    ["Mông Cổ"]="rbxassetid://6894553803",["Thổ Nhĩ Kỳ"]="rbxassetid://6894556253",
    ["Philippines"]="rbxassetid://6894554417",["Indonesia"]="rbxassetid://6894553531",
    ["Malaysia"]="rbxassetid://6894553677",["Singapore"]="rbxassetid://6894555993",
    ["Myanmar"]="rbxassetid://6894553885",["Campuchia"]="rbxassetid://6894552060",
    ["Lào"]="rbxassetid://6894553641",["Argentina"]="rbxassetid://6894551761",
    ["Brazil"]="rbxassetid://6894552030",["Canada"]="rbxassetid://6894552092",
    ["Mexico"]="rbxassetid://6894553749",["Iran"]="rbxassetid://6894553547",
    ["Iraq"]="rbxassetid://6894553565",["Israel"]="rbxassetid://6894553609",
    ["Ukraine"]="rbxassetid://6894556309",["New Zealand"]="rbxassetid://6894553969",
    ["Nam Sudan"]="rbxassetid://6894553909",
}

-- ==================== UTILS ====================
local function norm(s)
    return tostring(s):lower()
        :gsub("[àáảãạăắặằẳẵâấầẩẫậ]","a"):gsub("[èéẻẽẹêếềểễệ]","e")
        :gsub("[ìíỉĩị]","i"):gsub("[òóỏõọôốồổỗộơớờởỡợ]","o")
        :gsub("[ùúủũụưứừửữự]","u"):gsub("[ỳýỷỹỵ]","y"):gsub("đ","d")
        :gsub("%s+"," "):gsub("^%s*(.-)%s*$","%1")
end

local function tryMatch(n)
    local s = n:gsub("^nuoc ","")
    return ANSWER_MAP[s] or ANSWER_MAP[n]
end

local function makeDrag(frame, handle)
    handle = handle or frame
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
local function mkBtn(parent,text,x,y,w,h,bg,tc,fs)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.new(0,w,0,h);b.Position=UDim2.new(0,x,0,y)
    b.BackgroundColor3=bg;b.BorderSizePixel=0
    b.Text=text;b.TextColor3=tc;b.TextSize=fs or 12;b.Font=Enum.Font.GothamBold
    b.ZIndex=104;mkCorner(b,6)
    return b
end

-- ==================== SCREEN GUI ====================
local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="DziAutoFlag";ScreenGui.ResetOnSpawn=false
ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ScreenGui.Parent=player.PlayerGui

-- ==================== MAIN MENU (luôn hiện) ====================
local MENU_W=260
local menuOpen=true

local MenuPanel=Instance.new("Frame")
MenuPanel.Size=UDim2.new(0,MENU_W,0,28)
MenuPanel.Position=UDim2.new(0.5,-MENU_W/2,0,6)
MenuPanel.BackgroundColor3=Color3.fromRGB(10,8,22)
MenuPanel.BorderSizePixel=0;MenuPanel.ZIndex=200
MenuPanel.Parent=ScreenGui
mkCorner(MenuPanel,10);mkStroke(MenuPanel,Color3.fromRGB(140,80,200))

-- Title bar (drag handle)
local TitleBar=Instance.new("Frame",MenuPanel)
TitleBar.Size=UDim2.new(1,0,0,28);TitleBar.Position=UDim2.new(0,0,0,0)
TitleBar.BackgroundTransparency=1;TitleBar.ZIndex=201
makeDrag(MenuPanel,TitleBar)

local TitleLbl=Instance.new("TextLabel",TitleBar)
TitleLbl.Size=UDim2.new(1,-50,1,0);TitleLbl.Position=UDim2.new(0,8,0,0)
TitleLbl.BackgroundTransparency=1;TitleLbl.Text="🏴 DZI AUTO FLAG"
TitleLbl.TextColor3=Color3.fromRGB(200,160,255);TitleLbl.TextSize=11
TitleLbl.Font=Enum.Font.GothamBold;TitleLbl.TextXAlignment=Enum.TextXAlignment.Left
TitleLbl.ZIndex=202

-- Nút mở/đóng menu
local ToggleMenu=Instance.new("TextButton",TitleBar)
ToggleMenu.Size=UDim2.new(0,36,0,20);ToggleMenu.Position=UDim2.new(1,-40,0,4)
ToggleMenu.BackgroundColor3=Color3.fromRGB(50,30,90);ToggleMenu.BorderSizePixel=0
ToggleMenu.Text="▼";ToggleMenu.TextColor3=Color3.fromRGB(200,160,255)
ToggleMenu.TextSize=11;ToggleMenu.Font=Enum.Font.GothamBold;ToggleMenu.ZIndex=203
mkCorner(ToggleMenu,5)

-- Content frame
local MenuContent=Instance.new("Frame",MenuPanel)
MenuContent.Size=UDim2.new(1,0,0,0) -- set động
MenuContent.Position=UDim2.new(0,0,0,28)
MenuContent.BackgroundTransparency=1;MenuContent.ZIndex=201
MenuContent.Visible=true

-- === TAB buttons ===
local tabBtns={}
local tabPages={}
local activeTab=nil

local function makeTab(name,icon,idx)
    local tb=Instance.new("TextButton",MenuContent)
    tb.Size=UDim2.new(0,76,0,26)
    tb.Position=UDim2.new(0,6+(idx-1)*82,0,4)
    tb.BackgroundColor3=Color3.fromRGB(25,15,50)
    tb.BorderSizePixel=0;tb.Text=icon.." "..name
    tb.TextColor3=Color3.fromRGB(180,150,255);tb.TextSize=10
    tb.Font=Enum.Font.GothamBold;tb.ZIndex=202;mkCorner(tb,6)
    mkStroke(tb,Color3.fromRGB(100,60,180),1)
    tabBtns[name]=tb

    local page=Instance.new("Frame",MenuContent)
    page.Size=UDim2.new(1,-8,0,0) -- height set per page
    page.Position=UDim2.new(0,4,0,34)
    page.BackgroundTransparency=1;page.ZIndex=202;page.Visible=false
    tabPages[name]=page
    return page
end

-- === PAGE: CỜ MẪU ===
local flagPage=makeTab("Cờ mẫu","🏳",1)
flagPage.Size=UDim2.new(1,-8,0,160)

local flagSearchBox=Instance.new("TextBox",flagPage)
flagSearchBox.Size=UDim2.new(1,0,0,24);flagSearchBox.Position=UDim2.new(0,0,0,0)
flagSearchBox.BackgroundColor3=Color3.fromRGB(20,14,40);flagSearchBox.BorderSizePixel=0
flagSearchBox.Text="";flagSearchBox.PlaceholderText="🔍 Tìm nước..."
flagSearchBox.TextColor3=Color3.fromRGB(220,200,255);flagSearchBox.PlaceholderColor3=Color3.fromRGB(100,90,130)
flagSearchBox.TextSize=11;flagSearchBox.Font=Enum.Font.Gotham;flagSearchBox.ZIndex=203
mkCorner(flagSearchBox,6)

local flagImg=Instance.new("ImageLabel",flagPage)
flagImg.Size=UDim2.new(1,0,0,90);flagImg.Position=UDim2.new(0,0,0,28)
flagImg.BackgroundColor3=Color3.fromRGB(15,10,30);flagImg.BorderSizePixel=0
flagImg.Image="";flagImg.ScaleType=Enum.ScaleType.Fit;flagImg.ZIndex=203
mkCorner(flagImg,8)

local flagNameLbl=Instance.new("TextLabel",flagPage)
flagNameLbl.Size=UDim2.new(1,0,0,20);flagNameLbl.Position=UDim2.new(0,0,0,122)
flagNameLbl.BackgroundTransparency=1;flagNameLbl.Text="← gõ tên nước để xem cờ"
flagNameLbl.TextColor3=Color3.fromRGB(180,160,255);flagNameLbl.TextSize=11
flagNameLbl.Font=Enum.Font.GothamBold;flagNameLbl.ZIndex=203

local flagSuggFrame=Instance.new("Frame",flagPage)
flagSuggFrame.Size=UDim2.new(1,0,0,0);flagSuggFrame.Position=UDim2.new(0,0,0,28)
flagSuggFrame.BackgroundColor3=Color3.fromRGB(18,12,35);flagSuggFrame.BorderSizePixel=0
flagSuggFrame.ZIndex=210;flagSuggFrame.Visible=false
mkCorner(flagSuggFrame,6)

local suggBtns={}
for i=1,5 do
    local sb=Instance.new("TextButton",flagSuggFrame)
    sb.Size=UDim2.new(1,-4,0,22);sb.Position=UDim2.new(0,2,0,(i-1)*23)
    sb.BackgroundTransparency=1;sb.Text="";sb.TextColor3=Color3.fromRGB(220,200,255)
    sb.TextSize=11;sb.Font=Enum.Font.Gotham;sb.ZIndex=211
    sb.TextXAlignment=Enum.TextXAlignment.Left
    suggBtns[i]=sb
end

local function showFlag(name)
    flagImg.Visible=true;flagSuggFrame.Visible=false
    local asset=FLAG_ASSET[name]
    if asset then
        flagImg.Image=asset
        flagNameLbl.Text="🏳 "..name
    else
        flagImg.Image=""
        flagNameLbl.Text="❌ Chưa có cờ: "..name
    end
end

local function updateSuggestions(query)
    local q=norm(query)
    if #q<1 then flagSuggFrame.Visible=false;return end
    local results={}
    local seen={}
    -- tìm trong ANSWER_MAP values
    for k,v in pairs(ANSWER_MAP) do
        if norm(v):find(q,1,true) or k:find(q,1,true) then
            if not seen[v] then seen[v]=true;results[#results+1]=v end
        end
        if #results>=5 then break end
    end
    if #results==0 then flagSuggFrame.Visible=false;return end
    flagSuggFrame.Visible=true
    flagSuggFrame.Size=UDim2.new(1,0,0,#results*23)
    for i=1,5 do
        if results[i] then
            suggBtns[i].Text="  "..results[i];suggBtns[i].Visible=true
            local country=results[i]
            suggBtns[i].MouseButton1Click:Connect(function()
                flagSearchBox.Text=country
                flagSuggFrame.Visible=false
                showFlag(country)
            end)
        else
            suggBtns[i].Visible=false
        end
    end
end

flagSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateSuggestions(flagSearchBox.Text)
end)

-- === PAGE: CHUYỂN SERVER ===
local svPage=makeTab("Server","🌐",2)
svPage.Size=UDim2.new(1,-8,0,120)

local svStatus=Instance.new("TextLabel",svPage)
svStatus.Size=UDim2.new(1,0,0,20);svStatus.Position=UDim2.new(0,0,0,0)
svStatus.BackgroundTransparency=1;svStatus.Text="Bấm để tìm server đông người"
svStatus.TextColor3=Color3.fromRGB(180,180,255);svStatus.TextSize=10
svStatus.Font=Enum.Font.Gotham;svStatus.ZIndex=203
svStatus.TextWrapped=true

local svInfo=Instance.new("TextLabel",svPage)
svInfo.Size=UDim2.new(1,0,0,30);svInfo.Position=UDim2.new(0,0,0,22)
svInfo.BackgroundTransparency=1;svInfo.Text=""
svInfo.TextColor3=Color3.fromRGB(100,255,150);svInfo.TextSize=10
svInfo.Font=Enum.Font.Gotham;svInfo.ZIndex=203;svInfo.TextWrapped=true

local hopBtn=mkBtn(svPage,"🔄 Chuyển server đông",0,56,MENU_W-16,30,
    Color3.fromRGB(30,80,180),Color3.fromRGB(200,230,255),11)
mkStroke(hopBtn,Color3.fromRGB(80,150,255),1)

local minPlayersBox=Instance.new("TextBox",svPage)
minPlayersBox.Size=UDim2.new(0,80,0,22);minPlayersBox.Position=UDim2.new(0,0,0,90)
minPlayersBox.BackgroundColor3=Color3.fromRGB(20,14,40);minPlayersBox.BorderSizePixel=0
minPlayersBox.Text="3";minPlayersBox.PlaceholderText="Min players"
minPlayersBox.TextColor3=Color3.fromRGB(220,200,255);minPlayersBox.TextSize=10
minPlayersBox.Font=Enum.Font.Gotham;minPlayersBox.ZIndex=203;mkCorner(minPlayersBox,5)

local minLbl=Instance.new("TextLabel",svPage)
minLbl.Size=UDim2.new(0,140,0,22);minLbl.Position=UDim2.new(0,84,0,90)
minLbl.BackgroundTransparency=1;minLbl.Text="≥ người (không đầy)"
minLbl.TextColor3=Color3.fromRGB(150,140,200);minLbl.TextSize=10
minLbl.Font=Enum.Font.Gotham;minLbl.ZIndex=203
minLbl.TextXAlignment=Enum.TextXAlignment.Left

local isHopping=false

local function findBestServer(callback)
    -- Dùng game.PlaceId để query server list qua Roblox API
    -- Roblox executor thường cho phép gọi request() hoặc syn.request()
    local maxPlayers=game:GetService("Players").MaxPlayers
    local url="https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Desc&limit=100"
    
    local reqFn=nil
    if syn and syn.request then reqFn=syn.request
    elseif request then reqFn=request
    elseif http and http.request then reqFn=http.request
    elseif http_request then reqFn=http_request end

    if not reqFn then
        callback(nil,"Executor không hỗ trợ HTTP request")
        return
    end

    local ok,res=pcall(function()
        return reqFn({Url=url,Method="GET"})
    end)
    if not ok or not res then
        callback(nil,"Request thất bại")
        return
    end

    local ok2,data=pcall(function()
        return HttpService:JSONDecode(res.Body)
    end)
    if not ok2 or not data or not data.data then
        callback(nil,"Parse JSON thất bại")
        return
    end

    local minP=tonumber(minPlayersBox.Text) or 3
    local best=nil
    local bestCount=0

    for _,sv in ipairs(data.data) do
        local cur=sv.playing or 0
        local max=sv.maxPlayers or maxPlayers
        -- đông nhưng không đầy (còn ít nhất 1 slot)
        if cur>=minP and cur<max and cur>bestCount then
            bestCount=cur
            best=sv
        end
    end

    if best then
        callback(best,"OK: "..bestCount.."/"..best.maxPlayers.." người | "..string.sub(best.id,1,8).."...")
    else
        callback(nil,"Không tìm thấy server phù hợp (thử giảm min players)")
    end
end

hopBtn.MouseButton1Click:Connect(function()
    if isHopping then return end
    isHopping=true
    hopBtn.Text="⏳ Đang tìm..."
    hopBtn.BackgroundColor3=Color3.fromRGB(20,40,100)
    svInfo.Text=""
    svStatus.Text="Đang query server list..."

    task.spawn(function()
        findBestServer(function(sv,msg)
            svStatus.Text=msg
            if sv then
                svInfo.Text="✅ Tìm thấy! Đang chuyển..."
                hopBtn.Text="✈️ Đang bay..."
                task.wait(1)
                local ok,err=pcall(function()
                    TeleportService:TeleportToPlaceInstance(placeId, sv.id, player)
                end)
                if not ok then
                    svInfo.Text="❌ Teleport lỗi: "..(err or "unknown")
                    hopBtn.Text="🔄 Chuyển server đông"
                    hopBtn.BackgroundColor3=Color3.fromRGB(30,80,180)
                    isHopping=false
                end
            else
                svInfo.Text=""
                hopBtn.Text="🔄 Chuyển server đông"
                hopBtn.BackgroundColor3=Color3.fromRGB(30,80,180)
                isHopping=false
            end
        end)
    end)
end)

-- === PAGE: GỢI Ý CỜ (in-game) ===
local hintPage=makeTab("Gợi ý","🎮",3)
hintPage.Size=UDim2.new(1,-8,0,130)

local hintBtns={}
local hintPreviews={}
local selectedHintBtn=nil

for i=1,4 do
    local col=(i-1)%2
    local row=math.floor((i-1)/2)
    local btn=mkBtn(hintPage,"",col*(MENU_W/2-10)+2,row*30,MENU_W/2-14,26,
        Color3.fromRGB(25,15,50),Color3.fromRGB(210,190,255),10)
    mkStroke(btn,Color3.fromRGB(100,60,180),1)
    btn.Visible=false;btn.TextScaled=true
    Instance.new("UITextSizeConstraint",btn).MaxTextSize=11
    hintBtns[i]=btn
end

local hintFlagImg=Instance.new("ImageLabel",hintPage)
hintFlagImg.Size=UDim2.new(1,0,0,70);hintFlagImg.Position=UDim2.new(0,0,0,64)
hintFlagImg.BackgroundColor3=Color3.fromRGB(15,10,30);hintFlagImg.BorderSizePixel=0
hintFlagImg.Image="";hintFlagImg.ScaleType=Enum.ScaleType.Fit
hintFlagImg.ZIndex=203;hintFlagImg.Visible=false;mkCorner(hintFlagImg,6)

local hintCountryLbl=Instance.new("TextLabel",hintPage)
hintCountryLbl.Size=UDim2.new(1,0,0,16);hintCountryLbl.Position=UDim2.new(0,0,0,136)
hintCountryLbl.BackgroundTransparency=1;hintCountryLbl.Text=""
hintCountryLbl.TextColor3=Color3.fromRGB(200,255,200);hintCountryLbl.TextSize=10
hintCountryLbl.Font=Enum.Font.GothamBold;hintCountryLbl.ZIndex=203
hintCountryLbl.Visible=false

local hintNoGame=Instance.new("TextLabel",hintPage)
hintNoGame.Size=UDim2.new(1,0,0,30);hintNoGame.Position=UDim2.new(0,0,0,10)
hintNoGame.BackgroundTransparency=1;hintNoGame.Text="⏳ Chờ vào bàn chơi..."
hintNoGame.TextColor3=Color3.fromRGB(150,140,200);hintNoGame.TextSize=11
hintNoGame.Font=Enum.Font.GothamBold;hintNoGame.ZIndex=203;hintNoGame.Visible=true

local function setHintFlag(name,btn)
    if selectedHintBtn==btn then
        selectedHintBtn=nil
        hintFlagImg.Visible=false;hintCountryLbl.Visible=false
        for _,b in ipairs(hintBtns) do b.BackgroundColor3=Color3.fromRGB(25,15,50) end
        hintPage.Size=UDim2.new(1,-8,0,64+4)
        return
    end
    selectedHintBtn=btn
    for _,b in ipairs(hintBtns) do b.BackgroundColor3=Color3.fromRGB(25,15,50) end
    btn.BackgroundColor3=Color3.fromRGB(60,30,110)
    local asset=FLAG_ASSET[name]
    if asset then
        hintFlagImg.Image=asset;hintFlagImg.Visible=true
        hintCountryLbl.Text="🏳 "..name;hintCountryLbl.Visible=true
        hintPage.Size=UDim2.new(1,-8,0,64+74+20)
    else
        hintFlagImg.Visible=false
        hintCountryLbl.Text="❌ "..name.." (no asset)";hintCountryLbl.Visible=true
        hintPage.Size=UDim2.new(1,-8,0,64+20)
    end
    -- sync MenuPanel height
    refreshMenuHeight()
end

-- ==================== TAB LOGIC ====================
local TAB_HEIGHTS={["Cờ mẫu"]=160,["Server"]=120,["Gợi ý"]=68}

function refreshMenuHeight()
    if not menuOpen then
        MenuContent.Visible=false
        MenuPanel.Size=UDim2.new(0,MENU_W,0,28)
        return
    end
    MenuContent.Visible=true
    local tabH=0
    if activeTab then
        tabH=tabPages[activeTab].Size.Y.Offset
    end
    -- gợi ý tab: size dynamic
    if activeTab=="Gợi ý" then
        tabH=hintPage.Size.Y.Offset
    end
    local total=28+34+tabH+6
    MenuPanel.Size=UDim2.new(0,MENU_W,0,total)
    MenuContent.Size=UDim2.new(1,0,0,total-28)
end

local function switchTab(name)
    for n,pg in pairs(tabPages) do
        pg.Visible=(n==name)
        if tabBtns[n] then
            tabBtns[n].BackgroundColor3=n==name
                and Color3.fromRGB(60,30,120)
                or Color3.fromRGB(25,15,50)
        end
    end
    activeTab=name
    refreshMenuHeight()
end

tabBtns["Cờ mẫu"].MouseButton1Click:Connect(function() switchTab("Cờ mẫu") end)
tabBtns["Server"].MouseButton1Click:Connect(function() switchTab("Server") end)
tabBtns["Gợi ý"].MouseButton1Click:Connect(function() switchTab("Gợi ý") end)

ToggleMenu.MouseButton1Click:Connect(function()
    menuOpen=not menuOpen
    ToggleMenu.Text=menuOpen and "▼" or "▲"
    refreshMenuHeight()
end)

-- mở tab mặc định
switchTab("Cờ mẫu")

-- ==================== SCAN GUI (lấy 4 gợi ý in-game) ====================
local BLACKLIST={
    "dzi","auto flag","hub","players","win","tham gia","cua hang",
    "kho do","troll","hang ngay","goi y","tiet lo","phan hoi",
    "lan thang","chuoi thang","tien mat","bao cao","nguoi moi",
    "x2","2x","bat dau","de ","kho ","trung binh","luot","lượt",
    "suy nghi","phan hoi","bao cao","x2 tien","x2 lan","x2 chuo",
}

local lastHints={}
local inGame=false

local function listsEq(a,b)
    if #a~=#b then return false end
    for i,v in ipairs(a) do if v~=b[i] then return false end end
    return true
end

local hintConnections={}

local function updateHintBtns(list)
    -- clear old connections
    for _,c in ipairs(hintConnections) do c:Disconnect() end
    hintConnections={}

    selectedHintBtn=nil
    hintFlagImg.Visible=false;hintCountryLbl.Visible=false

    local n=#list
    if n==0 then
        hintNoGame.Text="⏳ Chờ vào bàn chơi..."
        hintNoGame.Visible=true
        for _,b in ipairs(hintBtns) do b.Visible=false end
        hintPage.Size=UDim2.new(1,-8,0,40)
        if activeTab=="Gợi ý" then refreshMenuHeight() end
        return
    end

    hintNoGame.Visible=false
    for i=1,4 do
        local btn=hintBtns[i]
        if list[i] then
            btn.Text=list[i];btn.Visible=true
            btn.BackgroundColor3=Color3.fromRGB(25,15,50)
            local country=list[i]
            local c=btn.MouseButton1Click:Connect(function()
                if btn.Text==country then setHintFlag(country,btn) end
            end)
            hintConnections[#hintConnections+1]=c
        else
            btn.Visible=false
        end
    end
    hintPage.Size=UDim2.new(1,-8,0,64+4)
    if activeTab=="Gợi ý" then refreshMenuHeight() end
end

local tick0=0
RunService.Heartbeat:Connect(function()
    tick0+=1
    if tick0<8 then return end
    tick0=0
    pcall(function()
        local allTexts={}
        local function collect(obj)
            if(obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.Visible then
                local t=obj.Text
                if t and #t>=2 and #t<=60 then
                    local n=norm(t)
                    local skip=false
                    for _,bad in ipairs(BLACKLIST) do
                        if n:find(bad,1,true) then skip=true;break end
                    end
                    if not skip and not n:match("^[%d%$%#]") and not n:match("^%s*$") then
                        allTexts[#allTexts+1]={text=t,norm=n}
                    end
                end
            end
            for _,c in ipairs(obj:GetChildren()) do collect(c) end
        end
        for _,g in ipairs(player.PlayerGui:GetChildren()) do
            if g.Name~="DziAutoFlag" then collect(g) end
        end

        local matched={};local seen={}
        for _,c in ipairs(allTexts) do
            local m=tryMatch(c.norm)
            if m and not seen[m] then seen[m]=true;matched[#matched+1]=m end
            if #matched>=4 then break end
        end

        if not listsEq(matched,lastHints) then
            lastHints=matched
            updateHintBtns(matched)
            -- auto switch sang tab Gợi ý khi vào bàn
            if #matched>=1 and activeTab~="Gợi ý" then
                switchTab("Gợi ý")
            elseif #matched==0 and activeTab=="Gợi ý" then
                -- không auto switch ra, để user tự chọn
            end
        end
    end)
end)
