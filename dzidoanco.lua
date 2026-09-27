local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local FLAGS = {
    { name="Việt Nam",        c1={206,17,38},    c2={255,255,0},   c3=nil,           sym="★" },
    { name="Thái Lan",        c1={165,25,43},    c2={255,255,255}, c3={0,45,116},    sym="▬" },
    { name="Philippines",     c1={0,56,168},     c2={206,17,38},   c3={255,205,0},   sym="☀" },
    { name="Indonesia",       c1={206,17,38},    c2={255,255,255}, c3=nil,           sym="▬" },
    { name="Malaysia",        c1={204,0,0},      c2={255,255,255}, c3={0,51,160},    sym="☽" },
    { name="Singapore",       c1={239,51,64},    c2={255,255,255}, c3=nil,           sym="☽★" },
    { name="Myanmar",         c1={252,209,22},   c2={52,178,51},   c3={234,36,40},   sym="★" },
    { name="Campuchia",       c1={0,57,166},     c2={230,0,0},     c3=nil,           sym="🏛" },
    { name="Lào",             c1={206,17,38},    c2={0,46,143},    c3={255,255,255}, sym="○" },
    { name="Brunei",          c1={245,209,66},   c2={255,255,255}, c3={0,0,0},       sym="☽" },
    { name="Timor-Leste",     c1={220,0,0},      c2={0,0,0},       c3={255,204,0},   sym="★" },
    { name="Nhật Bản",        c1={255,255,255},  c2={188,0,45},    c3=nil,           sym="●" },
    { name="Hàn Quốc",        c1={255,255,255},  c2={205,46,58},   c3={0,71,160},    sym="☯" },
    { name="Trung Quốc",      c1={222,41,16},    c2={255,222,0},   c3=nil,           sym="★" },
    { name="Mông Cổ",         c1={196,40,27},    c2={0,98,163},    c3={244,194,13},  sym="☸" },
    { name="Đài Loan",        c1={255,0,0},      c2={0,0,149},     c3={255,255,255}, sym="☀" },
    { name="Bắc Triều Tiên",  c1={024,061,132},  c2={205,46,58},   c3={255,255,255}, sym="★" },
    { name="Ấn Độ",           c1={255,153,51},   c2={255,255,255}, c3={19,136,8},    sym="☸" },
    { name="Pakistan",        c1={1,119,62},     c2={255,255,255}, c3=nil,           sym="☽★" },
    { name="Bangladesh",      c1={0,106,78},     c2={244,42,65},   c3=nil,           sym="●" },
    { name="Sri Lanka",       c1={139,28,28},    c2={255,184,28},  c3={0,139,69},    sym="🦁" },
    { name="Nepal",           c1={0,56,147},     c2={215,40,40},   c3=nil,           sym="☽" },
    { name="Bhutan",          c1={255,134,0},    c2={255,255,255}, c3={99,0,127},    sym="🐉" },
    { name="Maldives",        c1={0,115,58},     c2={213,43,30},   c3={255,255,255}, sym="☽" },
    { name="Afghanistan",     c1={0,0,0},        c2={209,0,0},     c3={0,100,0},     sym="☪" },
    { name="Kazakhstan",      c1={0,175,219},    c2={255,215,0},   c3=nil,           sym="☀🦅" },
    { name="Uzbekistan",      c1={30,178,166},   c2={255,255,255}, c3={28,128,62},   sym="☽" },
    { name="Turkmenistan",    c1={0,145,82},     c2={199,0,57},    c3=nil,           sym="☽★" },
    { name="Kyrgyzstan",      c1={229,0,0},      c2={255,215,0},   c3=nil,           sym="☀" },
    { name="Tajikistan",      c1={204,0,0},      c2={255,255,255}, c3={006,111,059}, sym="☀" },
    { name="Thổ Nhĩ Kỳ",     c1={227,10,23},    c2={255,255,255}, c3=nil,           sym="☽★" },
    { name="Iran",            c1={0,103,71},     c2={255,255,255}, c3={218,0,0},     sym="☪" },
    { name="Iraq",            c1={0,0,0},        c2={255,255,255}, c3={206,17,38},   sym="نص" },
    { name="Syria",           c1={0,0,0},        c2={255,255,255}, c3={206,17,38},   sym="★★" },
    { name="Jordan",          c1={0,0,0},        c2={255,255,255}, c3={0,122,61},    sym="★" },
    { name="Lebanon",         c1={255,255,255},  c2={237,41,57},   c3={0,136,0},     sym="🌲" },
    { name="Israel",          c1={255,255,255},  c2={0,56,184},    c3=nil,           sym="✡" },
    { name="Palestine",       c1={0,0,0},        c2={255,255,255}, c3={206,17,38},   sym="▲" },
    { name="Ả Rập Xê Út",    c1={0,106,78},     c2={255,255,255}, c3=nil,           sym="☪" },
    { name="Yemen",           c1={206,17,38},    c2={255,255,255}, c3={0,0,0},       sym="▬" },
    { name="Oman",            c1={219,0,0},      c2={255,255,255}, c3={0,107,63},    sym="⚔" },
    { name="UAE",             c1={0,115,47},     c2={255,255,255}, c3={0,0,0},       sym="▬" },
    { name="Qatar",           c1={255,255,255},  c2={128,0,32},    c3=nil,           sym="▲" },
    { name="Bahrain",         c1={255,255,255},  c2={206,17,38},   c3=nil,           sym="▲▲▲" },
    { name="Kuwait",          c1={0,0,0},        c2={255,255,255}, c3={0,155,58},    sym="▬" },
    { name="Azerbaijan",      c1={0,181,226},    c2={0,122,61},    c3={239,51,64},   sym="☽★" },
    { name="Armenia",         c1={216,28,28},    c2={0,51,160},    c3={255,165,0},   sym="▬" },
    { name="Georgia",         c1={255,255,255},  c2={220,20,20},   c3=nil,           sym="✚" },
    { name="Anh",             c1={255,255,255},  c2={0,36,125},    c3={207,20,43},   sym="✚" },
    { name="Pháp",            c1={0,35,149},     c2={255,255,255}, c3={237,41,57},   sym="▬" },
    { name="Đức",             c1={0,0,0},        c2={221,0,0},     c3={255,204,0},   sym="▬" },
    { name="Ý",               c1={0,140,69},     c2={255,255,255}, c3={206,43,55},   sym="▬" },
    { name="Tây Ban Nha",     c1={170,21,27},    c2={241,191,0},   c3=nil,           sym="🛡" },
    { name="Bồ Đào Nha",      c1={0,102,0},      c2={255,0,0},     c3={255,215,0},   sym="⚜" },
    { name="Hà Lan",          c1={174,28,40},    c2={255,255,255}, c3={33,70,139},   sym="▬" },
    { name="Bỉ",              c1={0,0,0},        c2={255,215,0},   c3={255,0,0},     sym="▬" },
    { name="Luxembourg",      c1={239,51,64},    c2={255,255,255}, c3={0,163,224},   sym="▬" },
    { name="Thụy Sĩ",         c1={255,0,0},      c2={255,255,255}, c3=nil,           sym="✚" },
    { name="Áo",              c1={237,41,57},    c2={255,255,255}, c3=nil,           sym="▬" },
    { name="Liechtenstein",   c1={0,38,115},     c2={200,16,46},   c3={255,215,0},   sym="👑" },
    { name="Monaco",          c1={206,17,38},    c2={255,255,255}, c3=nil,           sym="▬" },
    { name="Ireland",         c1={22,155,98},    c2={255,255,255}, c3={255,136,62},  sym="▬" },
    { name="Iceland",         c1={0,56,151},     c2={255,255,255}, c3={215,40,40},   sym="✚" },
    { name="Na Uy",           c1={186,12,47},    c2={255,255,255}, c3={0,40,104},    sym="✚" },
    { name="Thụy Điển",       c1={0,106,167},    c2={254,204,0},   c3=nil,           sym="✚" },
    { name="Đan Mạch",        c1={198,12,48},    c2={255,255,255}, c3=nil,           sym="✚" },
    { name="Phần Lan",        c1={255,255,255},  c2={0,56,168},    c3=nil,           sym="✚" },
    { name="Estonia",         c1={0,114,206},    c2={0,0,0},       c3={255,255,255}, sym="▬" },
    { name="Latvia",          c1={155,0,0},      c2={255,255,255}, c3=nil,           sym="▬" },
    { name="Lithuania",       c1={253,185,19},   c2={0,106,68},    c3={192,10,10},   sym="▬" },
    { name="Ba Lan",          c1={255,255,255},  c2={220,20,60},   c3=nil,           sym="▬" },
    { name="Séc",             c1={215,20,26},    c2={255,255,255}, c3={17,69,126},   sym="▲" },
    { name="Slovakia",        c1={14,93,172},    c2={255,255,255}, c3={238,28,37},   sym="🛡" },
    { name="Hungary",         c1={206,41,57},    c2={255,255,255}, c3={67,111,67},   sym="▬" },
    { name="Romania",         c1={0,43,127},     c2={252,209,22},  c3={206,17,38},   sym="▬" },
    { name="Bulgaria",        c1={255,255,255},  c2={0,150,110},   c3={214,38,18},   sym="▬" },
    { name="Serbia",          c1={198,54,60},    c2={0,82,165},    c3={255,255,255}, sym="🛡" },
    { name="Croatia",         c1={255,0,0},      c2={255,255,255}, c3={0,0,255},     sym="🛡" },
    { name="Slovenia",        c1={0,62,168},     c2={255,255,255}, c3={227,0,34},    sym="🏔" },
    { name="Bosnia",          c1={0,52,144},     c2={255,196,37},  c3={255,255,255}, sym="★" },
    { name="Montenegro",      c1={215,163,23},   c2={0,94,184},    c3={206,17,38},   sym="🦅" },
    { name="Albania",         c1={230,0,0},      c2={0,0,0},       c3=nil,           sym="🦅" },
    { name="Macedonia",       c1={206,32,40},    c2={255,215,0},   c3=nil,           sym="☀" },
    { name="Ukraine",         c1={0,91,187},     c2={255,213,0},   c3=nil,           sym="▬" },
    { name="Belarus",         c1={0,120,57},     c2={207,34,39},   c3={255,255,255}, sym="▬" },
    { name="Moldova",         c1={0,68,166},     c2={255,204,0},   c3={204,9,47},    sym="🦅" },
    { name="Nga",             c1={255,255,255},  c2={0,57,166},    c3={213,43,30},   sym="▬" },
    { name="Hy Lạp",          c1={0,118,186},    c2={255,255,255}, c3=nil,           sym="✚" },
    { name="Síp",             c1={255,255,255},  c2={255,130,0},   c3={0,100,0},     sym="🌿" },
    { name="Malta",           c1={255,255,255},  c2={207,20,43},   c3=nil,           sym="✚" },
    { name="Kosovo",          c1={244,189,65},   c2={255,255,255}, c3={1,59,128},    sym="★" },
    { name="Hoa Kỳ",          c1={179,25,66},    c2={255,255,255}, c3={0,40,104},    sym="★" },
    { name="Canada",          c1={255,0,0},      c2={255,255,255}, c3=nil,           sym="🍁" },
    { name="Mexico",          c1={0,104,71},     c2={255,255,255}, c3={206,17,38},   sym="🦅" },
    { name="Guatemala",       c1={74,144,226},   c2={255,255,255}, c3=nil,           sym="🐦" },
    { name="Belize",          c1={0,50,148},     c2={255,0,0},     c3={255,255,255}, sym="●" },
    { name="Honduras",        c1={0,90,181},     c2={255,255,255}, c3=nil,           sym="★★★" },
    { name="El Salvador",     c1={0,56,168},     c2={255,255,255}, c3=nil,           sym="🛡" },
    { name="Nicaragua",       c1={75,107,175},   c2={255,255,255}, c3=nil,           sym="🌈" },
    { name="Costa Rica",      c1={0,56,168},     c2={255,255,255}, c3={230,0,0},     sym="▬" },
    { name="Panama",          c1={255,255,255},  c2={0,56,168},    c3={213,43,30},   sym="★" },
    { name="Cuba",            c1={0,0,153},      c2={255,255,255}, c3={203,0,0},     sym="★" },
    { name="Jamaica",         c1={0,0,0},        c2={0,162,68},    c3={254,209,0},   sym="✦" },
    { name="Haiti",           c1={0,20,136},     c2={165,0,33},    c3=nil,           sym="🌴" },
    { name="Cộng Hòa Dominican",c1={0,45,98},   c2={255,255,255}, c3={206,17,38},   sym="✚" },
    { name="Puerto Rico",     c1={0,37,84},      c2={255,255,255}, c3={220,0,0},     sym="★" },
    { name="Trinidad & Tobago",c1={0,0,0},       c2={255,255,255}, c3={206,0,0},     sym="✦" },
    { name="Barbados",        c1={0,0,188},      c2={255,215,0},   c3=nil,           sym="🔱" },
    { name="Bahamas",         c1={0,169,183},    c2={255,215,0},   c3={0,0,0},       sym="▲" },
    { name="Brazil",          c1={0,155,58},     c2={255,223,0},   c3={0,39,118},    sym="★" },
    { name="Argentina",       c1={116,172,223},  c2={255,255,255}, c3=nil,           sym="☀" },
    { name="Colombia",        c1={255,205,0},    c2={0,56,168},    c3={206,17,38},   sym="▬" },
    { name="Venezuela",       c1={207,0,48},     c2={0,42,110},    c3={255,214,0},   sym="★" },
    { name="Peru",            c1={215,0,0},      c2={255,255,255}, c3=nil,           sym="▬" },
    { name="Chile",           c1={255,255,255},  c2={0,0,153},     c3={213,43,30},   sym="★" },
    { name="Bolivia",         c1={215,0,0},      c2={240,209,0},   c3={0,122,51},    sym="▬" },
    { name="Ecuador",         c1={255,215,0},    c2={0,56,147},    c3={206,17,38},   sym="🛡" },
    { name="Paraguay",        c1={213,43,30},    c2={255,255,255}, c3={0,56,168},    sym="★" },
    { name="Uruguay",         c1={255,255,255},  c2={0,56,168},    c3=nil,           sym="☀" },
    { name="Guyana",          c1={0,100,0},      c2={255,255,255}, c3={255,204,0},   sym="★" },
    { name="Suriname",        c1={0,114,68},     c2={255,255,255}, c3={179,0,0},     sym="★" },
    { name="Ai Cập",          c1={0,0,0},        c2={255,255,255}, c3={206,17,38},   sym="🦅" },
    { name="Libya",           c1={0,0,0},        c2={255,255,255}, c3={0,122,61},    sym="☽★" },
    { name="Tunisia",         c1={231,11,21},    c2={255,255,255}, c3=nil,           sym="☽★" },
    { name="Algeria",         c1={0,98,51},      c2={255,255,255}, c3={255,0,0},     sym="☽★" },
    { name="Morocco",         c1={196,35,59},    c2={0,98,51},     c3=nil,           sym="★" },
    { name="Sudan",           c1={0,0,0},        c2={255,255,255}, c3={0,112,45},    sym="▲" },
    { name="Nam Sudan",       c1={0,0,0},        c2={255,255,255}, c3={0,122,61},    sym="★" },
    { name="Nigeria",         c1={0,128,0},      c2={255,255,255}, c3=nil,           sym="▬" },
    { name="Ghana",           c1={255,215,0},    c2={0,106,78},    c3={206,17,38},   sym="★" },
    { name="Senegal",         c1={0,138,46},     c2={255,215,0},   c3={188,0,45},    sym="★" },
    { name="Côte d'Ivoire",   c1={249,102,14},   c2={255,255,255}, c3={0,133,67},    sym="▬" },
    { name="Guinea",          c1={206,17,38},    c2={255,215,0},   c3={0,152,56},    sym="▬" },
    { name="Mali",            c1={20,145,50},    c2={255,207,0},   c3={196,17,17},   sym="▬" },
    { name="Burkina Faso",    c1={239,43,45},    c2={20,145,50},   c3={255,215,0},   sym="★" },
    { name="Niger",           c1={255,141,0},    c2={255,255,255}, c3={0,153,57},    sym="●" },
    { name="Togo",            c1={0,130,56},     c2={255,215,0},   c3={215,0,47},    sym="★" },
    { name="Benin",           c1={0,138,81},     c2={255,215,0},   c3={229,0,0},     sym="▬" },
    { name="Cameroon",        c1={0,117,52},     c2={255,215,0},   c3={206,17,38},   sym="★" },
    { name="Gabon",           c1={0,158,96},     c2={255,215,0},   c3={0,68,176},    sym="▬" },
    { name="Congo",           c1={0,134,79},     c2={255,215,0},   c3={220,20,20},   sym="▬" },
    { name="DR Congo",        c1={0,0,204},      c2={255,215,0},   c3={206,17,38},   sym="★" },
    { name="Liberia",         c1={191,0,0},      c2={255,255,255}, c3={0,46,127},    sym="★" },
    { name="Sierra Leone",    c1={0,155,72},     c2={255,255,255}, c3={0,101,179},   sym="▬" },
    { name="Guinea-Bissau",   c1={206,17,38},    c2={255,215,0},   c3={0,155,72},    sym="★" },
    { name="Gambia",          c1={0,115,200},    c2={255,255,255}, c3={0,170,0},     sym="▬" },
    { name="Cape Verde",      c1={0,44,130},     c2={255,255,255}, c3={206,17,38},   sym="★" },
    { name="Guinea Xích Đạo", c1={0,150,57},     c2={255,255,255}, c3={213,43,30},   sym="★" },
    { name="São Tomé",        c1={12,104,54},    c2={255,215,0},   c3={204,16,28},   sym="★" },
    { name="Kenya",           c1={0,0,0},        c2={255,255,255}, c3={0,152,54},    sym="🛡" },
    { name="Ethiopia",        c1={0,140,69},     c2={255,215,0},   c3={218,18,26},   sym="★" },
    { name="Tanzania",        c1={0,0,0},        c2={31,148,192},  c3={0,172,103},   sym="▬" },
    { name="Uganda",          c1={0,0,0},        c2={255,255,255}, c3={252,209,22},  sym="🐦" },
    { name="Rwanda",          c1={32,172,70},    c2={250,210,1},   c3={0,97,165},    sym="☀" },
    { name="Somalia",         c1={74,155,204},   c2={255,255,255}, c3=nil,           sym="★" },
    { name="Djibouti",        c1={110,196,232},  c2={255,255,255}, c3={0,125,72},    sym="★" },
    { name="Eritrea",         c1={0,138,81},     c2={79,38,131},   c3={74,144,226},  sym="⚙" },
    { name="Mozambique",      c1={0,100,0},      c2={255,255,255}, c3={252,209,22},  sym="★" },
    { name="Zambia",          c1={0,0,0},        c2={255,165,0},   c3={0,150,57},    sym="🦅" },
    { name="Zimbabwe",        c1={0,0,0},        c2={255,215,0},   c3={0,150,57},    sym="★" },
    { name="Malawi",          c1={0,0,0},        c2={0,180,0},     c3={206,17,38},   sym="☀" },
    { name="Angola",          c1={255,0,0},      c2={0,0,0},       c3=nil,           sym="⚙" },
    { name="Namibia",         c1={0,154,68},     c2={0,47,108},    c3={255,255,255}, sym="☀" },
    { name="Botswana",        c1={117,189,209},  c2={0,0,0},       c3={255,255,255}, sym="▬" },
    { name="Nam Phi",         c1={0,0,0},        c2={0,119,73},    c3={222,56,57},   sym="✦" },
    { name="Lesotho",         c1={0,119,73},     c2={255,255,255}, c3={0,53,148},    sym="👒" },
    { name="Eswatini",        c1={0,0,128},      c2={255,215,0},   c3={190,0,0},     sym="🛡" },
    { name="Madagascar",      c1={255,255,255},  c2={252,0,32},    c3={0,161,72},    sym="▬" },
    { name="Mauritius",       c1={234,52,37},    c2={0,100,58},    c3={0,82,147},    sym="▬" },
    { name="Seychelles",      c1={0,63,135},     c2={0,196,55},    c3={255,215,0},   sym="▬" },
    { name="Comoros",         c1={0,150,57},     c2={255,255,255}, c3=nil,           sym="☽★" },
    { name="Úc",              c1={0,0,139},      c2={255,255,255}, c3={255,0,0},     sym="★✚" },
    { name="New Zealand",     c1={0,0,128},      c2={255,255,255}, c3={255,0,0},     sym="★✚" },
    { name="Papua New Guinea",c1={0,0,0},        c2={255,0,0},     c3={255,215,0},   sym="★" },
    { name="Fiji",            c1={104,196,222},  c2={255,255,255}, c3={0,47,135},    sym="🛡" },
    { name="Solomon Islands", c1={0,128,0},      c2={0,0,128},     c3={255,215,0},   sym="★" },
    { name="Vanuatu",         c1={0,144,0},      c2={255,215,0},   c3={0,0,0},       sym="▼" },
    { name="Samoa",           c1={206,17,38},    c2={0,0,128},     c3={255,255,255}, sym="★" },
    { name="Tonga",           c1={195,0,0},      c2={255,255,255}, c3=nil,           sym="✚" },
    { name="Kiribati",        c1={0,90,170},     c2={255,255,255}, c3={255,0,0},     sym="☀" },
    { name="Micronesia",      c1={117,190,209},  c2={255,255,255}, c3=nil,           sym="★★★★" },
    { name="Palau",           c1={93,179,217},   c2={255,215,0},   c3=nil,           sym="●" },
    { name="Marshall Islands",c1={0,56,168},     c2={255,255,255}, c3={255,165,0},   sym="★" },
    { name="Nauru",           c1={0,0,128},      c2={255,215,0},   c3={255,255,255}, sym="★" },
    { name="Tuvalu",          c1={0,153,198},    c2={255,215,0},   c3=nil,           sym="★" },
}
local function rgb(t) return Color3.fromRGB(t[1], t[2], t[3]) end
local function shuffle(t)
    local s = {}
    for _, v in ipairs(t) do s[#s+1] = v end
    for i = #s, 2, -1 do
        local j = math.random(i)
        s[i], s[j] = s[j], s[i]
    end
    return s
end
local currentIndex = 1
local shuffled = shuffle(FLAGS)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DziCoDoan"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player.PlayerGui
local Bubble = Instance.new("ImageButton")
Bubble.Size = UDim2.new(0, 58, 0, 58)
Bubble.Position = UDim2.new(0, 12, 0.5, 0)
Bubble.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Bubble.BorderSizePixel = 0
Bubble.ZIndex = 200
Bubble.Visible = false
Bubble.Parent = ScreenGui
Instance.new("UICorner", Bubble).CornerRadius = UDim.new(1, 0)
local BS = Instance.new("UIStroke", Bubble)
BS.Color = Color3.fromRGB(160, 100, 230); BS.Thickness = 2
local BubText = Instance.new("TextLabel", Bubble)
BubText.Size = UDim2.new(1, 0, 1, 0)
BubText.BackgroundTransparency = 1
BubText.Text = "🚩"
BubText.TextColor3 = Color3.fromRGB(255, 255, 255)
BubText.TextSize = 22
BubText.Font = Enum.Font.GothamBold
BubText.ZIndex = 201
local bubPulse = TweenService:Create(Bubble, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Size = UDim2.new(0, 63, 0, 63), Position = UDim2.new(0, 9, 0.5, -2)
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
            bubDrag = true; bubPulse:Pause(); Bubble.Size = UDim2.new(0, 58, 0, 58)
            Bubble.Position = UDim2.new(bubStartPos.X.Scale, bubStartPos.X.Offset + d.X, bubStartPos.Y.Scale, bubStartPos.Y.Offset + d.Y)
        end
    end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        if bubDrag then bubDrag = false; bubDragStart = nil; bubPulse:Play() end
    end
end)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 270, 0, 400)
Main.Position = UDim2.new(0.5, -135, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(13, 10, 20)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MS = Instance.new("UIStroke", Main)
MS.Color = Color3.fromRGB(140, 80, 200); MS.Thickness = 1.5
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 54)
Header.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)
local HFix = Instance.new("Frame", Header)
HFix.Size = UDim2.new(1, 0, 0, 12); HFix.Position = UDim2.new(0, 0, 1, -12)
HFix.BackgroundColor3 = Color3.fromRGB(20, 15, 30); HFix.BorderSizePixel = 0
local HAv = Instance.new("TextLabel", Header)
HAv.Size = UDim2.new(0, 32, 0, 32); HAv.Position = UDim2.new(0, 10, 0.5, -16)
HAv.BackgroundColor3 = Color3.fromRGB(30, 20, 50); HAv.BorderSizePixel = 0
HAv.Text = "🚩"; HAv.TextSize = 18; HAv.Font = Enum.Font.GothamBold
HAv.TextColor3 = Color3.fromRGB(255, 255, 255); HAv.TextXAlignment = Enum.TextXAlignment.Center
Instance.new("UICorner", HAv).CornerRadius = UDim.new(0, 8)
local HAvS = Instance.new("UIStroke", HAv)
HAvS.Color = Color3.fromRGB(160, 100, 230); HAvS.Thickness = 1.5
local HTitle = Instance.new("TextLabel", Header)
HTitle.Size = UDim2.new(0, 160, 0, 18); HTitle.Position = UDim2.new(0, 50, 0, 8)
HTitle.BackgroundTransparency = 1; HTitle.Text = "DZI MEO MEO"
HTitle.TextColor3 = Color3.fromRGB(240, 240, 240); HTitle.TextSize = 13
HTitle.Font = Enum.Font.GothamBold; HTitle.TextXAlignment = Enum.TextXAlignment.Left
local HSub = Instance.new("TextLabel", Header)
HSub.Size = UDim2.new(0, 180, 0, 14); HSub.Position = UDim2.new(0, 50, 0, 28)
HSub.BackgroundTransparency = 1; HSub.Text = "GAME ĐOÁN CỜ - " .. #FLAGS .. " NƯỚC"
HSub.TextColor3 = Color3.fromRGB(180, 140, 255); HSub.TextSize = 9
HSub.Font = Enum.Font.Gotham; HSub.TextXAlignment = Enum.TextXAlignment.Left
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 24, 0, 24); CloseBtn.Position = UDim2.new(1, -34, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 40); CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200); CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
local mDrag, mStart, mPos = false, nil, nil
Header.InputBegan:Connect(function(i)
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
local Body = Instance.new("Frame", Main)
Body.Size = UDim2.new(1, -20, 1, -64)
Body.Position = UDim2.new(0, 10, 0, 60)
Body.BackgroundTransparency = 1
local CounterLbl = Instance.new("TextLabel", Body)
CounterLbl.Size = UDim2.new(1, 0, 0, 18)
CounterLbl.Position = UDim2.new(0, 0, 0, 0)
CounterLbl.BackgroundTransparency = 1
CounterLbl.TextColor3 = Color3.fromRGB(160, 120, 220)
CounterLbl.TextSize = 11; CounterLbl.Font = Enum.Font.Gotham
CounterLbl.TextXAlignment = Enum.TextXAlignment.Center
local FlagBox = Instance.new("Frame", Body)
FlagBox.Size = UDim2.new(1, 0, 0, 150)
FlagBox.Position = UDim2.new(0, 0, 0, 22)
FlagBox.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
FlagBox.BorderSizePixel = 0
FlagBox.ClipsDescendants = true
Instance.new("UICorner", FlagBox).CornerRadius = UDim.new(0, 10)
local FBS = Instance.new("UIStroke", FlagBox)
FBS.Color = Color3.fromRGB(100, 60, 160); FBS.Thickness = 1.5
local Strip1 = Instance.new("Frame", FlagBox)
Strip1.BorderSizePixel = 0; Strip1.Size = UDim2.new(0.333, 0, 1, 0); Strip1.Position = UDim2.new(0, 0, 0, 0)
local Strip2 = Instance.new("Frame", FlagBox)
Strip2.BorderSizePixel = 0; Strip2.Size = UDim2.new(0.334, 0, 1, 0); Strip2.Position = UDim2.new(0.333, 0, 0, 0)
local Strip3 = Instance.new("Frame", FlagBox)
Strip3.BorderSizePixel = 0; Strip3.Size = UDim2.new(0.333, 0, 1, 0); Strip3.Position = UDim2.new(0.667, 0, 0, 0)
local SymLbl = Instance.new("TextLabel", FlagBox)
SymLbl.Size = UDim2.new(1, 0, 1, 0)
SymLbl.BackgroundTransparency = 1
SymLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
SymLbl.TextSize = 42
SymLbl.Font = Enum.Font.GothamBold
SymLbl.TextXAlignment = Enum.TextXAlignment.Center
SymLbl.TextYAlignment = Enum.TextYAlignment.Center
SymLbl.ZIndex = 5
local NameLbl = Instance.new("TextLabel", Body)
NameLbl.Size = UDim2.new(1, 0, 0, 54)
NameLbl.Position = UDim2.new(0, 0, 0, 180)
NameLbl.BackgroundColor3 = Color3.fromRGB(22, 15, 35)
NameLbl.BorderSizePixel = 0
NameLbl.TextColor3 = Color3.fromRGB(255, 220, 80)
NameLbl.TextSize = 22
NameLbl.Font = Enum.Font.GothamBold
NameLbl.TextXAlignment = Enum.TextXAlignment.Center
NameLbl.TextYAlignment = Enum.TextYAlignment.Center
NameLbl.TextScaled = true
Instance.new("UICorner", NameLbl).CornerRadius = UDim.new(0, 10)
local NBS = Instance.new("UIStroke", NameLbl)
NBS.Color = Color3.fromRGB(140, 80, 200); NBS.Thickness = 1.5
Instance.new("UITextSizeConstraint", NameLbl).MaxTextSize = 22
local ColorInfoLbl = Instance.new("TextLabel", Body)
ColorInfoLbl.Size = UDim2.new(1, 0, 0, 20)
ColorInfoLbl.Position = UDim2.new(0, 0, 0, 242)
ColorInfoLbl.BackgroundTransparency = 1
ColorInfoLbl.TextColor3 = Color3.fromRGB(150, 120, 190)
ColorInfoLbl.TextSize = 10; ColorInfoLbl.Font = Enum.Font.Gotham
ColorInfoLbl.TextXAlignment = Enum.TextXAlignment.Center
local PrevBtn = Instance.new("TextButton", Body)
PrevBtn.Size = UDim2.new(0.48, 0, 0, 38)
PrevBtn.Position = UDim2.new(0, 0, 0, 268)
PrevBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
PrevBtn.BorderSizePixel = 0
PrevBtn.Text = "◀ Trước"
PrevBtn.TextColor3 = Color3.fromRGB(200, 170, 255)
PrevBtn.TextSize = 12; PrevBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", PrevBtn).CornerRadius = UDim.new(0, 8)
local PrS = Instance.new("UIStroke", PrevBtn)
PrS.Color = Color3.fromRGB(100, 60, 160); PrS.Thickness = 1
local NextBtn = Instance.new("TextButton", Body)
NextBtn.Size = UDim2.new(0.48, 0, 0, 38)
NextBtn.Position = UDim2.new(0.52, 0, 0, 268)
NextBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 180)
NextBtn.BorderSizePixel = 0
NextBtn.Text = "Tiếp ▶"
NextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NextBtn.TextSize = 12; NextBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", NextBtn).CornerRadius = UDim.new(0, 8)
local ShuffleBtn = Instance.new("TextButton", Body)
ShuffleBtn.Size = UDim2.new(1, 0, 0, 28)
ShuffleBtn.Position = UDim2.new(0, 0, 0, 314)
ShuffleBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
ShuffleBtn.BorderSizePixel = 0
ShuffleBtn.Text = "🔀  Xáo Ngẫu Nhiên"
ShuffleBtn.TextColor3 = Color3.fromRGB(160, 120, 220)
ShuffleBtn.TextSize = 11; ShuffleBtn.Font = Enum.Font.Gotham
Instance.new("UICorner", ShuffleBtn).CornerRadius = UDim.new(0, 7)
local SBS = Instance.new("UIStroke", ShuffleBtn)
SBS.Color = Color3.fromRGB(80, 50, 120); SBS.Thickness = 1
local function loadFlag()
    local f = shuffled[currentIndex]
    local col1 = rgb(f.c1)
    local col2 = f.c2 and rgb(f.c2) or col1
    local col3 = f.c3 and rgb(f.c3) or col2
    Strip1.BackgroundColor3 = col1
    Strip2.BackgroundColor3 = col2
    Strip3.BackgroundColor3 = col3
    SymLbl.Text = f.sym or ""
    NameLbl.Text = f.name
    local colorNames = {}
    colorNames[#colorNames+1] = "RGB("..f.c1[1]..","..f.c1[2]..","..f.c1[3]..")"
    if f.c2 then colorNames[#colorNames+1] = "RGB("..f.c2[1]..","..f.c2[2]..","..f.c2[3]..")" end
    if f.c3 then colorNames[#colorNames+1] = "RGB("..f.c3[1]..","..f.c3[2]..","..f.c3[3]..")" end
    ColorInfoLbl.Text = table.concat(colorNames, "  |  ")
    CounterLbl.Text = "🌍  " .. currentIndex .. " / " .. #shuffled
end
NextBtn.MouseButton1Click:Connect(function()
    currentIndex = currentIndex + 1
    if currentIndex > #shuffled then
        shuffled = shuffle(FLAGS); currentIndex = 1
    end
    loadFlag()
    TweenService:Create(FlagBox, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
    task.delay(0.1, function()
        TweenService:Create(FlagBox, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
end)
PrevBtn.MouseButton1Click:Connect(function()
    currentIndex = currentIndex - 1
    if currentIndex < 1 then currentIndex = #shuffled end
    loadFlag()
end)
ShuffleBtn.MouseButton1Click:Connect(function()
    shuffled = shuffle(FLAGS); currentIndex = 1
    loadFlag()
    local orig = ShuffleBtn.Text
    ShuffleBtn.Text = "✔ Đã xáo!"
    ShuffleBtn.TextColor3 = Color3.fromRGB(100, 220, 100)
    task.delay(1.2, function()
        ShuffleBtn.Text = orig
        ShuffleBtn.TextColor3 = Color3.fromRGB(160, 120, 220)
    end)
end)
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 270, 0, 0)
    }):Play()
    task.delay(0.2, function()
        Main.Visible = false; Bubble.Visible = true; bubPulse:Play()
    end)
end)
Bubble.InputEnded:Connect(function(i)
    if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and not bubDrag then
        bubPulse:Pause(); Bubble.Visible = false
        Main.Visible = true; Main.Size = UDim2.new(0, 270, 0, 0)
        TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 270, 0, 400)
        }):Play()
    end
end)
loadFlag()
