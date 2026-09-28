local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local placeId = game.PlaceId

local COUNTRY_ISO = {
    ["Việt Nam"]="vn",["Thái Lan"]="th",["Philippines"]="ph",
    ["Indonesia"]="id",["Malaysia"]="my",["Singapore"]="sg",
    ["Myanmar"]="mm",["Campuchia"]="kh",["Lào"]="la",
    ["Brunei"]="bn",["Timor-Leste"]="tl",
    ["Hàn Quốc"]="kr",["Trung Quốc"]="cn",["Nhật Bản"]="jp",
    ["Đài Loan"]="tw",["Mông Cổ"]="mn",["Bắc Triều Tiên"]="kp",
    ["Hồng Kông"]="hk",["Ma Cao"]="mo",
    ["Ấn Độ"]="in",["Pakistan"]="pk",["Bangladesh"]="bd",
    ["Sri Lanka"]="lk",["Nepal"]="np",["Bhutan"]="bt",
    ["Maldives"]="mv",["Afghanistan"]="af",
    ["Kazakhstan"]="kz",["Uzbekistan"]="uz",["Turkmenistan"]="tm",
    ["Kyrgyzstan"]="kg",["Tajikistan"]="tj",
    ["Iran"]="ir",["Iraq"]="iq",["Syria"]="sy",["Jordan"]="jo",
    ["Lebanon"]="lb",["Israel"]="il",["Palestine"]="ps",
    ["Yemen"]="ye",["Oman"]="om",["Ả Rập Xê Út"]="sa",
    ["Các Tiểu Vương Quốc Ả Rập"]="ae",["Qatar"]="qa",
    ["Bahrain"]="bh",["Kuwait"]="kw",["Azerbaijan"]="az",
    ["Armenia"]="am",["Georgia"]="ge",
    ["Anh"]="gb",["Pháp"]="fr",["Đức"]="de",["Ý"]="it",
    ["Tây Ban Nha"]="es",["Bồ Đào Nha"]="pt",["Hà Lan"]="nl",
    ["Bỉ"]="be",["Áo"]="at",["Thụy Sĩ"]="ch",
    ["Luxembourg"]="lu",["Liechtenstein"]="li",["Monaco"]="mc",
    ["Andorra"]="ad",["San Marino"]="sm",["Vatican"]="va",
    ["Malta"]="mt",["Ireland"]="ie",["Gibraltar"]="gi",
    ["Thụy Điển"]="se",["Đan Mạch"]="dk",["Phần Lan"]="fi",
    ["Na Uy"]="no",["Iceland"]="is",
    ["Quần Đảo Faroe"]="fo",["Greenland"]="gl",
    ["Nga"]="ru",["Ba Lan"]="pl",["Séc"]="cz",["Slovakia"]="sk",
    ["Hungary"]="hu",["Romania"]="ro",["Bulgaria"]="bg",
    ["Ukraine"]="ua",["Belarus"]="by",["Moldova"]="md",
    ["Estonia"]="ee",["Latvia"]="lv",["Lithuania"]="lt",
    ["Hy Lạp"]="gr",["Thổ Nhĩ Kỳ"]="tr",["Síp"]="cy",
    ["Serbia"]="rs",["Croatia"]="hr",["Slovenia"]="si",
    ["Bosnia"]="ba",["Montenegro"]="me",["Albania"]="al",
    ["Bắc Macedonia"]="mk",["Kosovo"]="xk",
    ["Hoa Kỳ"]="us",["Canada"]="ca",["Mexico"]="mx",
    ["Guatemala"]="gt",["Belize"]="bz",["Honduras"]="hn",
    ["El Salvador"]="sv",["Nicaragua"]="ni",
    ["Costa Rica"]="cr",["Panama"]="pa",
    ["Cuba"]="cu",["Jamaica"]="jm",["Haiti"]="ht",
    ["Cộng Hòa Dominican"]="do",["Trinidad & Tobago"]="tt",
    ["Barbados"]="bb",["Bahamas"]="bs",["Grenada"]="gd",
    ["Dominica"]="dm",["Saint Lucia"]="lc",
    ["Saint Vincent & Grenadines"]="vc",
    ["Antigua & Barbuda"]="ag",["Saint Kitts & Nevis"]="kn",
    ["Puerto Rico"]="pr",["Bermuda"]="bm",
    ["Quần Đảo Cayman"]="ky",["Turks & Caicos"]="tc",
    ["Quần Đảo Virgin Mỹ"]="vi",["Quần Đảo Virgin Anh"]="vg",
    ["Aruba"]="aw",["Curazao"]="cw",["Martinique"]="mq",
    ["Guadeloupe"]="gp",["Sint Maarten"]="sx",
    ["Anguilla"]="ai",["Montserrat"]="ms",
    ["Brazil"]="br",["Argentina"]="ar",["Colombia"]="co",
    ["Venezuela"]="ve",["Peru"]="pe",["Chile"]="cl",
    ["Bolivia"]="bo",["Ecuador"]="ec",["Paraguay"]="py",
    ["Uruguay"]="uy",["Guyana"]="gy",["Suriname"]="sr",
    ["Guiana Thuộc Pháp"]="gf",["Quần Đảo Falkland"]="fk",
    ["Ai Cập"]="eg",["Libya"]="ly",["Tunisia"]="tn",
    ["Algeria"]="dz",["Morocco"]="ma",["Sudan"]="sd",
    ["Mauritania"]="mr",["Tây Sahara"]="eh",
    ["Nigeria"]="ng",["Ghana"]="gh",["Senegal"]="sn",
    ["Bờ Biển Ngà"]="ci",["Guinea"]="gn",["Mali"]="ml",
    ["Burkina Faso"]="bf",["Niger"]="ne",["Togo"]="tg",
    ["Benin"]="bj",["Liberia"]="lr",["Sierra Leone"]="sl",
    ["Guinea-Bissau"]="gw",["Gambia"]="gm",["Cabo Verde"]="cv",
    ["Cameroon"]="cm",["Gabon"]="ga",["Congo"]="cg",
    ["Cộng Hòa Dân Chủ Congo"]="cd",["Cộng Hòa Trung Phi"]="cf",
    ["Guinea Xích Đạo"]="gq",["Sao Tome & Principe"]="st",
    ["Chad"]="td",["Angola"]="ao",
    ["Kenya"]="ke",["Ethiopia"]="et",["Tanzania"]="tz",
    ["Uganda"]="ug",["Rwanda"]="rw",["Somalia"]="so",
    ["Djibouti"]="dj",["Eritrea"]="er",["Burundi"]="bi",
    ["Nam Sudan"]="ss",["Comoros"]="km",["Seychelles"]="sc",
    ["Mauritius"]="mu",["Madagascar"]="mg",["Mozambique"]="mz",
    ["Reunion"]="re",["Mayotte"]="yt",
    ["Nam Phi"]="za",["Zambia"]="zm",["Zimbabwe"]="zw",
    ["Namibia"]="na",["Botswana"]="bw",["Lesotho"]="ls",
    ["Eswatini"]="sz",["Malawi"]="mw",
    ["Úc"]="au",["New Zealand"]="nz",["Papua New Guinea"]="pg",
    ["Fiji"]="fj",["Solomon Islands"]="sb",["Vanuatu"]="vu",
    ["Samoa"]="ws",["Tonga"]="to",["Palau"]="pw",
    ["Micronesia"]="fm",["Marshall Islands"]="mh",
    ["Kiribati"]="ki",["Nauru"]="nr",["Tuvalu"]="tv",
    ["New Caledonia"]="nc",["French Polynesia"]="pf",
    ["Guam"]="gu",["American Samoa"]="as",
    ["Northern Mariana"]="mp",["Cook Islands"]="ck",
    ["Niue"]="nu",["Tokelau"]="tk",["Wallis & Futuna"]="wf",
    ["Pitcairn"]="pn",
    ["Aland Islands"]="ax",["Svalbard"]="sj",
    ["Jersey"]="je",["Guernsey"]="gg",["Isle of Man"]="im",
    ["Saint Pierre & Miquelon"]="pm",
    ["Cocos Islands"]="cc",["Christmas Island"]="cx",
    ["Norfolk Island"]="nf",["Saint Helena"]="sh",
    ["Ascension Island"]="ac",
    ["Nam Cực"]="aq",
    ["Saint Barthélemy"]="bl",
    ["Bonaire Sint Eustatius Saba"]="bq",
    ["Bouvet Island"]="bv",
    ["Clipperton Island"]="cp",
    ["Diego Garcia"]="dg",
    ["Ceuta & Melilla"]="ea",
    ["South Georgia & South Sandwich Islands"]="gs",
    ["Heard Island & McDonald Islands"]="hm",
    ["British Indian Ocean Territory"]="io",
    ["Saint Martin"]="mf",
    ["Tristan da Cunha"]="ta",
    ["French Southern Territories"]="tf",
    ["US Minor Outlying Islands"]="um",
}

local ANSWER_MAP = {}
local ALIASES = {
    ["viet nam"]="Việt Nam",["nuoc viet"]="Việt Nam",["vietnam"]="Việt Nam",
    ["thai lan"]="Thái Lan",["thailand"]="Thái Lan",["nuoc thai"]="Thái Lan",
    ["philippines"]="Philippines",["phi luat tan"]="Philippines",
    ["indonesia"]="Indonesia",["in do ne sia"]="Indonesia",
    ["malaysia"]="Malaysia",["ma lai"]="Malaysia",["ma lai a"]="Malaysia",
    ["singapore"]="Singapore",
    ["myanmar"]="Myanmar",["mien dien"]="Myanmar",["burma"]="Myanmar",
    ["campuchia"]="Campuchia",["cambodia"]="Campuchia",["khmer"]="Campuchia",
    ["lao"]="Lào",["laos"]="Lào",["nuoc lao"]="Lào",
    ["brunei"]="Brunei",
    ["timor leste"]="Timor-Leste",["dong timor"]="Timor-Leste",["east timor"]="Timor-Leste",
    ["han quoc"]="Hàn Quốc",["south korea"]="Hàn Quốc",["korea"]="Hàn Quốc",["nuoc han"]="Hàn Quốc",
    ["trung quoc"]="Trung Quốc",["china"]="Trung Quốc",["tau"]="Trung Quốc",["nuoc tau"]="Trung Quốc",
    ["nhat ban"]="Nhật Bản",["japan"]="Nhật Bản",["nuoc nhat"]="Nhật Bản",
    ["dai loan"]="Đài Loan",["taiwan"]="Đài Loan",["tai wan"]="Đài Loan",
    ["mong co"]="Mông Cổ",["mongolia"]="Mông Cổ",
    ["bac trieu tien"]="Bắc Triều Tiên",["north korea"]="Bắc Triều Tiên",["trieu tien"]="Bắc Triều Tiên",
    ["hong kong"]="Hồng Kông",["hk"]="Hồng Kông",["nuoc hong kong"]="Hồng Kông",
    ["ma cao"]="Ma Cao",["macao"]="Ma Cao",["macau"]="Ma Cao",
    ["an do"]="Ấn Độ",["india"]="Ấn Độ",["nuoc an do"]="Ấn Độ",
    ["pakistan"]="Pakistan",["pa ki xtan"]="Pakistan",
    ["bangladesh"]="Bangladesh",["bang la det"]="Bangladesh",
    ["sri lanka"]="Sri Lanka",["xi lan"]="Sri Lanka",
    ["nepal"]="Nepal",["ne pan"]="Nepal",
    ["bhutan"]="Bhutan",["bu tan"]="Bhutan",
    ["maldives"]="Maldives",["mal div"]="Maldives",
    ["afghanistan"]="Afghanistan",["a phu han"]="Afghanistan",
    ["kazakhstan"]="Kazakhstan",["cac xu tan"]="Kazakhstan",
    ["uzbekistan"]="Uzbekistan",["u be ki xtan"]="Uzbekistan",
    ["turkmenistan"]="Turkmenistan",["tuoc me ni xtan"]="Turkmenistan",
    ["kyrgyzstan"]="Kyrgyzstan",["cur ghi xtan"]="Kyrgyzstan",
    ["tajikistan"]="Tajikistan",["ta gich xtan"]="Tajikistan",
    ["iran"]="Iran",["ba tu"]="Iran",["persia"]="Iran",
    ["iraq"]="Iraq",["i rac"]="Iraq",
    ["syria"]="Syria",["xi ri a"]="Syria",
    ["jordan"]="Jordan",["gior dan"]="Jordan",
    ["lebanon"]="Lebanon",["li bang"]="Lebanon",
    ["israel"]="Israel",["it xa ra en"]="Israel",
    ["palestine"]="Palestine",["pa le xtin"]="Palestine",
    ["yemen"]="Yemen",["ye men"]="Yemen",
    ["oman"]="Oman",["o man"]="Oman",
    ["a rap xe ut"]="Ả Rập Xê Út",["saudi arabia"]="Ả Rập Xê Út",["saudi"]="Ả Rập Xê Út",
    ["cac tieu vuong quoc a rap"]="Các Tiểu Vương Quốc Ả Rập",
    ["cac tieu vuong quoc"]="Các Tiểu Vương Quốc Ả Rập",
    ["tieu vuong quoc a rap"]="Các Tiểu Vương Quốc Ả Rập",
    ["uae"]="Các Tiểu Vương Quốc Ả Rập",["united arab emirates"]="Các Tiểu Vương Quốc Ả Rập",
    ["emirates"]="Các Tiểu Vương Quốc Ả Rập",
    ["qatar"]="Qatar",["ca ta"]="Qatar",
    ["bahrain"]="Bahrain",["ba ren"]="Bahrain",
    ["kuwait"]="Kuwait",["coi oet"]="Kuwait",
    ["azerbaijan"]="Azerbaijan",["a dec bai gian"]="Azerbaijan",
    ["armenia"]="Armenia",["ac me ni a"]="Armenia",
    ["georgia"]="Georgia",["gru zia"]="Georgia",
    ["anh"]="Anh",["vuong quoc anh"]="Anh",["uk"]="Anh",["united kingdom"]="Anh",["england"]="Anh",["britain"]="Anh",["nuoc anh"]="Anh",
    ["phap"]="Pháp",["nuoc phap"]="Pháp",["france"]="Pháp",
    ["duc"]="Đức",["nuoc duc"]="Đức",["germany"]="Đức",
    ["y"]="Ý",["nuoc y"]="Ý",["italy"]="Ý",
    ["tay ban nha"]="Tây Ban Nha",["spain"]="Tây Ban Nha",["espana"]="Tây Ban Nha",
    ["bo dao nha"]="Bồ Đào Nha",["portugal"]="Bồ Đào Nha",
    ["ha lan"]="Hà Lan",["netherlands"]="Hà Lan",["holland"]="Hà Lan",["nuoc ha lan"]="Hà Lan",
    ["bi"]="Bỉ",["nuoc bi"]="Bỉ",["belgium"]="Bỉ",
    ["ao"]="Áo",["nuoc ao"]="Áo",["austria"]="Áo",
    ["thuy si"]="Thụy Sĩ",["switzerland"]="Thụy Sĩ",
    ["luc xam bua"]="Luxembourg",["luxembourg"]="Luxembourg",
    ["liechtenstein"]="Liechtenstein",
    ["monaco"]="Monaco",
    ["andorra"]="Andorra",
    ["san marino"]="San Marino",
    ["vatican"]="Vatican",["toa thanh vatican"]="Vatican",
    ["malta"]="Malta",["man ta"]="Malta",
    ["ireland"]="Ireland",["ai len"]="Ireland",
    ["gibraltar"]="Gibraltar",
    ["thuy dien"]="Thụy Điển",["sweden"]="Thụy Điển",
    ["dan mach"]="Đan Mạch",["denmark"]="Đan Mạch",
    ["phan lan"]="Phần Lan",["finland"]="Phần Lan",
    ["na uy"]="Na Uy",["norway"]="Na Uy",
    ["iceland"]="Iceland",["ai xo len"]="Iceland",
    ["quan dao faroe"]="Quần Đảo Faroe",["faroe"]="Quần Đảo Faroe",["faroe islands"]="Quần Đảo Faroe",
    ["greenland"]="Greenland",["dat xanh"]="Greenland",
    ["nga"]="Nga",["nuoc nga"]="Nga",["russia"]="Nga",
    ["ba lan"]="Ba Lan",["poland"]="Ba Lan",
    ["sec"]="Séc",["czech"]="Séc",["czechia"]="Séc",["czech republic"]="Séc",["cong hoa sec"]="Séc",
    ["slovakia"]="Slovakia",["xlo va kia"]="Slovakia",
    ["hungary"]="Hungary",["hung ga ri"]="Hungary",
    ["romania"]="Romania",["ru ma ni"]="Romania",
    ["bulgaria"]="Bulgaria",["bun ga ri"]="Bulgaria",
    ["ukraine"]="Ukraine",["u crai na"]="Ukraine",
    ["belarus"]="Belarus",["be la rut"]="Belarus",
    ["moldova"]="Moldova",["mo l do va"]="Moldova",
    ["estonia"]="Estonia",["ex to ni a"]="Estonia",
    ["latvia"]="Latvia",["lat vi a"]="Latvia",
    ["lithuania"]="Lithuania",["lit va"]="Lithuania",
    ["hy lap"]="Hy Lạp",["greece"]="Hy Lạp",
    ["tho nhi ky"]="Thổ Nhĩ Kỳ",["turkey"]="Thổ Nhĩ Kỳ",["turkiye"]="Thổ Nhĩ Kỳ",
    ["sip"]="Síp",["cyprus"]="Síp",
    ["serbia"]="Serbia",["ser bi a"]="Serbia",
    ["croatia"]="Croatia",["croa ti a"]="Croatia",
    ["slovenia"]="Slovenia",["xlo ve nia"]="Slovenia",
    ["bosnia"]="Bosnia",["bosna"]="Bosnia",["bosnia and herzegovina"]="Bosnia",["bosnia herzegovina"]="Bosnia",
    ["montenegro"]="Montenegro",["mon te ne gro"]="Montenegro",
    ["albania"]="Albania",["al ba ni"]="Albania",
    ["bac macedonia"]="Bắc Macedonia",["north macedonia"]="Bắc Macedonia",["macedonia"]="Bắc Macedonia",
    ["kosovo"]="Kosovo",
    ["hoa ky"]="Hoa Kỳ",["usa"]="Hoa Kỳ",["united states"]="Hoa Kỳ",["my"]="Hoa Kỳ",["nuoc my"]="Hoa Kỳ",["america"]="Hoa Kỳ",["us"]="Hoa Kỳ",
    ["canada"]="Canada",["ca na da"]="Canada",
    ["mexico"]="Mexico",["me hi co"]="Mexico",
    ["guatemala"]="Guatemala",
    ["belize"]="Belize",
    ["honduras"]="Honduras",
    ["el salvador"]="El Salvador",
    ["nicaragua"]="Nicaragua",
    ["costa rica"]="Costa Rica",
    ["panama"]="Panama",
    ["cuba"]="Cuba",
    ["jamaica"]="Jamaica",
    ["haiti"]="Haiti",
    ["cong hoa dominican"]="Cộng Hòa Dominican",["dominican republic"]="Cộng Hòa Dominican",["dominican"]="Cộng Hòa Dominican",
    ["trinidad"]="Trinidad & Tobago",["trinidad and tobago"]="Trinidad & Tobago",["trinidad tobago"]="Trinidad & Tobago",
    ["barbados"]="Barbados",
    ["bahamas"]="Bahamas",
    ["grenada"]="Grenada",
    ["dominica"]="Dominica",
    ["saint lucia"]="Saint Lucia",
    ["saint vincent"]="Saint Vincent & Grenadines",["saint vincent and the grenadines"]="Saint Vincent & Grenadines",
    ["antigua"]="Antigua & Barbuda",["antigua and barbuda"]="Antigua & Barbuda",
    ["saint kitts"]="Saint Kitts & Nevis",["saint kitts and nevis"]="Saint Kitts & Nevis",
    ["puerto rico"]="Puerto Rico",
    ["bermuda"]="Bermuda",
    ["quan dao cayman"]="Quần Đảo Cayman",["cayman islands"]="Quần Đảo Cayman",["cayman"]="Quần Đảo Cayman",
    ["turks caicos"]="Turks & Caicos",["turks and caicos"]="Turks & Caicos",
    ["quan dao virgin my"]="Quần Đảo Virgin Mỹ",["us virgin islands"]="Quần Đảo Virgin Mỹ",["virgin islands"]="Quần Đảo Virgin Mỹ",
    ["quan dao virgin anh"]="Quần Đảo Virgin Anh",["british virgin islands"]="Quần Đảo Virgin Anh",
    ["aruba"]="Aruba",
    ["curazao"]="Curazao",["curacao"]="Curazao",
    ["martinique"]="Martinique",
    ["guadeloupe"]="Guadeloupe",
    ["sint maarten"]="Sint Maarten",
    ["anguilla"]="Anguilla",
    ["montserrat"]="Montserrat",
    ["brazil"]="Brazil",["bra xin"]="Brazil",["nuoc brazil"]="Brazil",
    ["argentina"]="Argentina",["ac hen ti na"]="Argentina",
    ["colombia"]="Colombia",["co lom bi a"]="Colombia",
    ["venezuela"]="Venezuela",["ve ne zu e la"]="Venezuela",
    ["peru"]="Peru",["pe ru"]="Peru",
    ["chile"]="Chile",["chi le"]="Chile",
    ["bolivia"]="Bolivia",["bo li vi a"]="Bolivia",
    ["ecuador"]="Ecuador",["ec ua do"]="Ecuador",
    ["paraguay"]="Paraguay",["pa ra guay"]="Paraguay",
    ["uruguay"]="Uruguay",["u ru guay"]="Uruguay",
    ["guyana"]="Guyana",
    ["suriname"]="Suriname",["xu ri nam"]="Suriname",
    ["guiana thuoc phap"]="Guiana Thuộc Pháp",["french guiana"]="Guiana Thuộc Pháp",
    ["quan dao falkland"]="Quần Đảo Falkland",["falkland islands"]="Quần Đảo Falkland",["falkland"]="Quần Đảo Falkland",
    ["ai cap"]="Ai Cập",["egypt"]="Ai Cập",["nuoc ai cap"]="Ai Cập",
    ["libya"]="Libya",["li bi"]="Libya",
    ["tunisia"]="Tunisia",["tu ni di"]="Tunisia",
    ["algeria"]="Algeria",["an ge ri"]="Algeria",
    ["morocco"]="Morocco",["ma roc"]="Morocco",
    ["sudan"]="Sudan",
    ["mauritania"]="Mauritania",["mau ri ta ni"]="Mauritania",
    ["tay sahara"]="Tây Sahara",["western sahara"]="Tây Sahara",
    ["nigeria"]="Nigeria",["ni ge ri a"]="Nigeria",
    ["ghana"]="Ghana",
    ["senegal"]="Senegal",["xe ne gan"]="Senegal",
    ["bo bien nga"]="Bờ Biển Ngà",["ivory coast"]="Bờ Biển Ngà",["cote d ivoire"]="Bờ Biển Ngà",
    ["guinea"]="Guinea",
    ["mali"]="Mali",
    ["burkina faso"]="Burkina Faso",
    ["niger"]="Niger",
    ["togo"]="Togo",
    ["benin"]="Benin",
    ["liberia"]="Liberia",
    ["sierra leone"]="Sierra Leone",
    ["guinea bissau"]="Guinea-Bissau",
    ["gambia"]="Gambia",
    ["cabo verde"]="Cabo Verde",["cape verde"]="Cabo Verde",
    ["cameroon"]="Cameroon",["ca me run"]="Cameroon",
    ["gabon"]="Gabon",
    ["congo"]="Congo",["congo brazzaville"]="Congo",["republic of the congo"]="Congo",
    ["cong hoa dan chu congo"]="Cộng Hòa Dân Chủ Congo",["dr congo"]="Cộng Hòa Dân Chủ Congo",["democratic republic of the congo"]="Cộng Hòa Dân Chủ Congo",["drc"]="Cộng Hòa Dân Chủ Congo",["congo kinshasa"]="Cộng Hòa Dân Chủ Congo",["zaire"]="Cộng Hòa Dân Chủ Congo",
    ["cong hoa trung phi"]="Cộng Hòa Trung Phi",["central african republic"]="Cộng Hòa Trung Phi",["car"]="Cộng Hòa Trung Phi",
    ["guinea xich dao"]="Guinea Xích Đạo",["equatorial guinea"]="Guinea Xích Đạo",
    ["sao tome"]="Sao Tome & Principe",["sao tome and principe"]="Sao Tome & Principe",
    ["chad"]="Chad",
    ["angola"]="Angola",
    ["kenya"]="Kenya",
    ["ethiopia"]="Ethiopia",["e ti o pi a"]="Ethiopia",
    ["tanzania"]="Tanzania",["tan za ni a"]="Tanzania",
    ["uganda"]="Uganda",
    ["rwanda"]="Rwanda",
    ["somalia"]="Somalia",["xu ma li"]="Somalia",
    ["djibouti"]="Djibouti",["gi bu ti"]="Djibouti",
    ["eritrea"]="Eritrea",["e ri tre a"]="Eritrea",
    ["burundi"]="Burundi",
    ["nam sudan"]="Nam Sudan",["south sudan"]="Nam Sudan",
    ["comoros"]="Comoros",["co mo"]="Comoros",
    ["seychelles"]="Seychelles",["xe sel"]="Seychelles",
    ["mauritius"]="Mauritius",["mau ri xo"]="Mauritius",
    ["madagascar"]="Madagascar",["ma da ga xca"]="Madagascar",
    ["mozambique"]="Mozambique",["mo dam bich"]="Mozambique",
    ["reunion"]="Reunion",["re u niong"]="Reunion",
    ["mayotte"]="Mayotte",
    ["nam phi"]="Nam Phi",["south africa"]="Nam Phi",["nuoc nam phi"]="Nam Phi",
    ["zambia"]="Zambia",["dam bi a"]="Zambia",
    ["zimbabwe"]="Zimbabwe",["dim ba bue"]="Zimbabwe",
    ["namibia"]="Namibia",
    ["botswana"]="Botswana",["bot xoa na"]="Botswana",
    ["lesotho"]="Lesotho",["le xo to"]="Lesotho",
    ["eswatini"]="Eswatini",["swaziland"]="Eswatini",
    ["malawi"]="Malawi",
    ["uc"]="Úc",["nuoc uc"]="Úc",["australia"]="Úc",
    ["new zealand"]="New Zealand",["tan tay lan"]="New Zealand",
    ["papua new guinea"]="Papua New Guinea",
    ["fiji"]="Fiji",
    ["solomon islands"]="Solomon Islands",["dao solomon"]="Solomon Islands",
    ["vanuatu"]="Vanuatu",
    ["samoa"]="Samoa",
    ["tonga"]="Tonga",
    ["palau"]="Palau",
    ["micronesia"]="Micronesia",
    ["marshall islands"]="Marshall Islands",["dao marshall"]="Marshall Islands",
    ["kiribati"]="Kiribati",
    ["nauru"]="Nauru",
    ["tuvalu"]="Tuvalu",
    ["new caledonia"]="New Caledonia",["tan caledonia"]="New Caledonia",
    ["french polynesia"]="French Polynesia",["polynesia thuoc phap"]="French Polynesia",
    ["guam"]="Guam",
    ["american samoa"]="American Samoa",["samoa my"]="American Samoa",
    ["northern mariana"]="Northern Mariana",["bac mariana"]="Northern Mariana",
    ["cook islands"]="Cook Islands",["dao cook"]="Cook Islands",
    ["niue"]="Niue",
    ["tokelau"]="Tokelau",
    ["wallis futuna"]="Wallis & Futuna",["wallis and futuna"]="Wallis & Futuna",
    ["pitcairn"]="Pitcairn",
    ["aland islands"]="Aland Islands",["quan dao aland"]="Aland Islands",
    ["svalbard"]="Svalbard",
    ["jersey"]="Jersey",
    ["guernsey"]="Guernsey",
    ["isle of man"]="Isle of Man",["dao man"]="Isle of Man",
    ["saint pierre miquelon"]="Saint Pierre & Miquelon",
    ["cocos islands"]="Cocos Islands",["dao cocos"]="Cocos Islands",
    ["christmas island"]="Christmas Island",["dao giang sinh"]="Christmas Island",
    ["norfolk island"]="Norfolk Island",["dao norfolk"]="Norfolk Island",
    ["saint helena"]="Saint Helena",
    ["ascension island"]="Ascension Island",["ascension"]="Ascension Island",["dao ascension"]="Ascension Island",
    ["nam cuc"]="Nam Cực",["antarctic"]="Nam Cực",["antarctica"]="Nam Cực",
    ["saint barthelemy"]="Saint Barthélemy",["st barthelemy"]="Saint Barthélemy",["st barths"]="Saint Barthélemy",["barthelemy"]="Saint Barthélemy",
    ["bonaire"]="Bonaire Sint Eustatius Saba",["sint eustatius"]="Bonaire Sint Eustatius Saba",["saba"]="Bonaire Sint Eustatius Saba",
    ["bouvet"]="Bouvet Island",["dao bouvet"]="Bouvet Island",
    ["clipperton"]="Clipperton Island",["dao clipperton"]="Clipperton Island",
    ["diego garcia"]="Diego Garcia",
    ["ceuta melilla"]="Ceuta & Melilla",["ceuta"]="Ceuta & Melilla",["melilla"]="Ceuta & Melilla",
    ["south georgia"]="South Georgia & South Sandwich Islands",["dao nam georgia"]="South Georgia & South Sandwich Islands",
    ["heard island"]="Heard Island & McDonald Islands",["dao heard"]="Heard Island & McDonald Islands",
    ["british indian ocean"]="British Indian Ocean Territory",["biot"]="British Indian Ocean Territory",
    ["saint martin"]="Saint Martin",["st martin"]="Saint Martin",["sant martin"]="Saint Martin",
    ["tristan da cunha"]="Tristan da Cunha",["tristan"]="Tristan da Cunha",
    ["french southern territories"]="French Southern Territories",["lanh tho phia nam phap"]="French Southern Territories",
    ["us minor outlying"]="US Minor Outlying Islands",["dao nho my"]="US Minor Outlying Islands",
    ["vn"]="Việt Nam",["th"]="Thái Lan",["ph"]="Philippines",
    ["sg"]="Singapore",["id"]="Indonesia",["mm"]="Myanmar",
    ["kh"]="Campuchia",["bn"]="Brunei",["tl"]="Timor-Leste",
    ["kr"]="Hàn Quốc",["cn"]="Trung Quốc",["jp"]="Nhật Bản",
    ["tw"]="Đài Loan",["mn"]="Mông Cổ",["kp"]="Bắc Triều Tiên",
    ["hk"]="Hồng Kông",["mo"]="Ma Cao",
    ["in"]="Ấn Độ",["pk"]="Pakistan",["bd"]="Bangladesh",
    ["lk"]="Sri Lanka",["np"]="Nepal",["bt"]="Bhutan",["mv"]="Maldives",["af"]="Afghanistan",
    ["kz"]="Kazakhstan",["uz"]="Uzbekistan",["tm"]="Turkmenistan",["kg"]="Kyrgyzstan",["tj"]="Tajikistan",
    ["ir"]="Iran",["iq"]="Iraq",["sy"]="Syria",["jo"]="Jordan",["lb"]="Lebanon",
    ["il"]="Israel",["ps"]="Palestine",["ye"]="Yemen",["om"]="Oman",["sa"]="Ả Rập Xê Út",
    ["ae"]="Các Tiểu Vương Quốc Ả Rập",["qa"]="Qatar",["bh"]="Bahrain",["kw"]="Kuwait",
    ["az"]="Azerbaijan",["am"]="Armenia",["ge"]="Georgia",
    ["gb"]="Anh",["de"]="Đức",["it"]="Ý",
    ["es"]="Tây Ban Nha",["pt"]="Bồ Đào Nha",["nl"]="Hà Lan",
    ["be"]="Bỉ",["at"]="Áo",["ch"]="Thụy Sĩ",
    ["lu"]="Luxembourg",["li"]="Liechtenstein",["mc"]="Monaco",
    ["ad"]="Andorra",["sm"]="San Marino",["va"]="Vatican",["mt"]="Malta",["ie"]="Ireland",
    ["se"]="Thụy Điển",["dk"]="Đan Mạch",["fi"]="Phần Lan",["no"]="Na Uy",["is"]="Iceland",
    ["ru"]="Nga",["pl"]="Ba Lan",["cz"]="Séc",["sk"]="Slovakia",
    ["hu"]="Hungary",["ro"]="Romania",["bg"]="Bulgaria",
    ["ua"]="Ukraine",["by"]="Belarus",["md"]="Moldova",
    ["ee"]="Estonia",["lv"]="Latvia",["lt"]="Lithuania",
    ["gr"]="Hy Lạp",["tr"]="Thổ Nhĩ Kỳ",["cy"]="Síp",
    ["rs"]="Serbia",["hr"]="Croatia",["si"]="Slovenia",
    ["ba"]="Bosnia",["me"]="Montenegro",["al"]="Albania",["mk"]="Bắc Macedonia",
    ["ca"]="Canada",["mx"]="Mexico",
    ["gt"]="Guatemala",["bz"]="Belize",["hn"]="Honduras",
    ["sv"]="El Salvador",["ni"]="Nicaragua",["cr"]="Costa Rica",["pa"]="Panama",
    ["cu"]="Cuba",["jm"]="Jamaica",["ht"]="Haiti",
    ["do"]="Cộng Hòa Dominican",["tt"]="Trinidad & Tobago",
    ["bb"]="Barbados",["bs"]="Bahamas",["gd"]="Grenada",
    ["dm"]="Dominica",["lc"]="Saint Lucia",["vc"]="Saint Vincent & Grenadines",
    ["ag"]="Antigua & Barbuda",["kn"]="Saint Kitts & Nevis",
    ["br"]="Brazil",["ar"]="Argentina",["co"]="Colombia",
    ["ve"]="Venezuela",["pe"]="Peru",["cl"]="Chile",
    ["bo"]="Bolivia",["ec"]="Ecuador",["py"]="Paraguay",
    ["uy"]="Uruguay",["gy"]="Guyana",["sr"]="Suriname",
    ["eg"]="Ai Cập",["ly"]="Libya",["tn"]="Tunisia",
    ["dz"]="Algeria",["ma"]="Morocco",["sd"]="Sudan",["mr"]="Mauritania",
    ["ng"]="Nigeria",["gh"]="Ghana",["sn"]="Senegal",
    ["ci"]="Bờ Biển Ngà",["gn"]="Guinea",["ml"]="Mali",
    ["bf"]="Burkina Faso",["ne"]="Niger",["tg"]="Togo",
    ["bj"]="Benin",["lr"]="Liberia",["sl"]="Sierra Leone",
    ["gw"]="Guinea-Bissau",["gm"]="Gambia",["cv"]="Cabo Verde",
    ["cm"]="Cameroon",["ga"]="Gabon",["cg"]="Congo",
    ["cd"]="Cộng Hòa Dân Chủ Congo",["cf"]="Cộng Hòa Trung Phi",
    ["gq"]="Guinea Xích Đạo",["st"]="Sao Tome & Principe",["td"]="Chad",["ao"]="Angola",
    ["ke"]="Kenya",["et"]="Ethiopia",["tz"]="Tanzania",
    ["ug"]="Uganda",["rw"]="Rwanda",["so"]="Somalia",
    ["dj"]="Djibouti",["er"]="Eritrea",["bi"]="Burundi",
    ["ss"]="Nam Sudan",["km"]="Comoros",["sc"]="Seychelles",
    ["mu"]="Mauritius",["mg"]="Madagascar",["mz"]="Mozambique",
    ["za"]="Nam Phi",["zm"]="Zambia",["zw"]="Zimbabwe",
    ["na"]="Namibia",["bw"]="Botswana",["ls"]="Lesotho",["sz"]="Eswatini",["mw"]="Malawi",
    ["au"]="Úc",["nz"]="New Zealand",["pg"]="Papua New Guinea",
    ["fj"]="Fiji",["sb"]="Solomon Islands",["vu"]="Vanuatu",
    ["ws"]="Samoa",["to"]="Tonga",["pw"]="Palau",
    ["fm"]="Micronesia",["mh"]="Marshall Islands",
    ["ki"]="Kiribati",["nr"]="Nauru",["tv"]="Tuvalu",
    ["nc"]="New Caledonia",["pf"]="French Polynesia",
    ["gu"]="Guam",["as"]="American Samoa",["mp"]="Northern Mariana",
    ["ck"]="Cook Islands",["nu"]="Niue",["tk"]="Tokelau",["wf"]="Wallis & Futuna",["pn"]="Pitcairn",
    ["ax"]="Aland Islands",["sj"]="Svalbard",["je"]="Jersey",["gg"]="Guernsey",["im"]="Isle of Man",
    ["pm"]="Saint Pierre & Miquelon",["cc"]="Cocos Islands",["cx"]="Christmas Island",
    ["nf"]="Norfolk Island",["sh"]="Saint Helena",["ac"]="Ascension Island",["aq"]="Nam Cực",
    ["bl"]="Saint Barthélemy",["bq"]="Bonaire Sint Eustatius Saba",["bv"]="Bouvet Island",
    ["gs"]="South Georgia & South Sandwich Islands",["io"]="British Indian Ocean Territory",
    ["mf"]="Saint Martin",["ta"]="Tristan da Cunha",["tf"]="French Southern Territories",
    ["thanh lucia"]="Saint Lucia",["saint lucia"]="Saint Lucia",
    ["hong kong"]="Hồng Kông",["hong cong"]="Hồng Kông",
    ["cong hoa congo"]="Congo",["republic of congo"]="Congo",
    ["cong hoa dan chu congo"]="Cộng Hòa Dân Chủ Congo",
    ["seychelles"]="Seychelles",["se sel"]="Seychelles",
    ["liechtenstein"]="Liechtenstein",
    ["moldova"]="Moldova",
    ["sierra leone"]="Sierra Leone",
    ["suriname"]="Suriname",
    ["guinea"]="Guinea",
    ["jamaica"]="Jamaica",
    ["nicaragua"]="Nicaragua",
    ["chile"]="Chile",["dai loan"]="Đài Loan",["libya"]="Libya",
    ["saint vincent grenadines"]="Saint Vincent & Grenadines",["thanh vincent"]="Saint Vincent & Grenadines",
    ["antigua barbuda"]="Antigua & Barbuda",
    ["eswatini"]="Eswatini",["swaziland"]="Eswatini",
    ["dong timor"]="Timor-Leste",["timor leste"]="Timor-Leste",
    ["bac macedonia"]="Bắc Macedonia",["north macedonia"]="Bắc Macedonia",
}

for k,v in pairs(ALIASES) do ANSWER_MAP[k]=v end
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

    imgLabel.Visible = false
    noFlagLabel.Text = "⏳ Đang tải cờ..."
    noFlagLabel.Visible = true
    nameLbl.Text = "🏳 " .. name; nameLbl.Visible = true

    if flagCache[iso] then
        imgLabel.Image = flagCache[iso]
        imgLabel.Visible = true
        noFlagLabel.Visible = false
        return
    end

    task.spawn(function()
        local url = "https://flagcdn.com/w160/" .. iso .. ".png"
        local fname = "dziflag_" .. iso .. ".png"

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

        local ok3 = pcall(function()
            imgLabel.Image = url
        end)
        if ok3 then
            task.wait(1.5)
            if imgLabel.Image ~= "" and imgLabel.Image ~= url then
                flagCache[iso] = imgLabel.Image
                imgLabel.Visible = true
                noFlagLabel.Visible = false
                return
            elseif imgLabel.Image == url then
                imgLabel.Visible = true
                noFlagLabel.Visible = false
                return
            end
        end

        imgLabel.Visible = false
        noFlagLabel.Text = "❌ Executor không hỗ trợ load ảnh\n(" .. iso .. ")"
        noFlagLabel.Visible = true
    end)
end

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

local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="DziDoanCo";ScreenGui.ResetOnSpawn=false
ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ScreenGui.Parent=player.PlayerGui

local MENU_W=260
local menuOpen=true
local activeTab=nil

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

local titleIco=Instance.new("ImageLabel",TitleBar)
titleIco.Size=UDim2.new(0,14,0,14);titleIco.Position=UDim2.new(0,6,0.5,-7)
titleIco.BackgroundTransparency=1;titleIco.Image="rbxassetid://6031280882"
titleIco.ImageColor3=Color3.fromRGB(200,160,255);titleIco.ZIndex=203
local TitleLbl=Instance.new("TextLabel",TitleBar)
TitleLbl.Size=UDim2.new(1,-50,1,0);TitleLbl.Position=UDim2.new(0,24,0,0)
TitleLbl.BackgroundTransparency=1;TitleLbl.Text="DZI ĐOÁN CỜ"
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

local tabBtns={};local tabPages={}

local TAB_ICONS={
    ["Admin"]="rbxassetid://7059346373",
    ["Server"]="rbxassetid://6031068421",
    ["Gợi ý"]="rbxassetid://6031280882",
}

local function makeTab(name,icon,idx)
    local tb=Instance.new("TextButton",MenuContent)
    tb.Size=UDim2.new(0,76,0,26);tb.Position=UDim2.new(0,6+(idx-1)*82,0,4)
    tb.BackgroundColor3=Color3.fromRGB(25,15,50);tb.BorderSizePixel=0
    tb.Text="";tb.TextColor3=Color3.fromRGB(180,150,255)
    tb.TextSize=10;tb.Font=Enum.Font.GothamBold;tb.ZIndex=202;mkCorner(tb,6)
    mkStroke(tb,Color3.fromRGB(100,60,180),1);tabBtns[name]=tb

    if TAB_ICONS[name] then
        local ico=Instance.new("ImageLabel",tb)
        ico.Size=UDim2.new(0,14,0,14);ico.Position=UDim2.new(0,6,0.5,-7)
        ico.BackgroundTransparency=1;ico.Image=TAB_ICONS[name]
        ico.ImageColor3=Color3.fromRGB(180,150,255);ico.ZIndex=203
    end
    local nameLbl=Instance.new("TextLabel",tb)
    nameLbl.Size=UDim2.new(1,-24,1,0);nameLbl.Position=UDim2.new(0,22,0,0)
    nameLbl.BackgroundTransparency=1;nameLbl.Text=name
    nameLbl.TextColor3=Color3.fromRGB(180,150,255);nameLbl.TextSize=10
    nameLbl.Font=Enum.Font.GothamBold;nameLbl.ZIndex=203
    nameLbl.TextXAlignment=Enum.TextXAlignment.Left
    tb._nameLbl=nameLbl

    local page=Instance.new("Frame",MenuContent)
    page.Size=UDim2.new(1,-8,0,10)
    page.Position=UDim2.new(0,4,0,34)
    page.BackgroundTransparency=1;page.ZIndex=202;page.Visible=false
    tabPages[name]=page;return page
end

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

local flagPage=makeTab("Admin","👤",1)

local function openURL(url, btn)
    local opened = false
    local origText = btn and btn.Text or ""
    pcall(function() if openBrowser then openBrowser(url); opened=true end end)
    if not opened then pcall(function() if open_browser then open_browser(url); opened=true end end) end
    if not opened then pcall(function() if openbrowser then openbrowser(url); opened=true end end) end
    if not opened then pcall(function() if shellexecute then shellexecute(url); opened=true end end) end
    if not opened then
        pcall(function() if setclipboard then setclipboard(url) end end)
        if btn then
            btn.Text="📋 Đã copy link!"
            task.delay(2, function() if btn.Parent then btn.Text=origText end end)
        end
    end
end

local ROW_ICONS={
    ["👤"]="rbxassetid://6031094670",
    ["🎭"]="rbxassetid://6031280882",
    ["🎂"]="rbxassetid://6031068421",
    ["📍"]="rbxassetid://6031225819",
}
local function mkRow(parent, icon, label, value, y)
    local row=Instance.new("Frame",parent)
    row.Size=UDim2.new(1,0,0,20);row.Position=UDim2.new(0,0,0,y)
    row.BackgroundColor3=Color3.fromRGB(22,15,45);row.BorderSizePixel=0;row.ZIndex=203
    mkCorner(row,5)
    if ROW_ICONS[icon] then
        local ico=Instance.new("ImageLabel",row)
        ico.Size=UDim2.new(0,13,0,13);ico.Position=UDim2.new(0,4,0.5,-6)
        ico.BackgroundTransparency=1;ico.Image=ROW_ICONS[icon]
        ico.ImageColor3=Color3.fromRGB(200,160,255);ico.ZIndex=204
    else
        local ico=Instance.new("TextLabel",row)
        ico.Size=UDim2.new(0,22,1,0);ico.Position=UDim2.new(0,2,0,0)
        ico.BackgroundTransparency=1;ico.Text=icon
        ico.TextSize=11;ico.Font=Enum.Font.GothamBold
        ico.TextColor3=Color3.fromRGB(200,160,255);ico.ZIndex=204
    end
    local lbl=Instance.new("TextLabel",row)
    lbl.Size=UDim2.new(0.42,0,1,0);lbl.Position=UDim2.new(0,22,0,0)
    lbl.BackgroundTransparency=1;lbl.Text=label
    lbl.TextSize=9;lbl.Font=Enum.Font.GothamBold
    lbl.TextColor3=Color3.fromRGB(140,120,200);lbl.ZIndex=204
    lbl.TextXAlignment=Enum.TextXAlignment.Left
    local val=Instance.new("TextLabel",row)
    val.Size=UDim2.new(0.56,-4,1,0);val.Position=UDim2.new(0.44,0,0,0)
    val.BackgroundTransparency=1;val.Text=value
    val.TextSize=9;val.Font=Enum.Font.GothamBold
    val.TextColor3=Color3.fromRGB(230,215,255);val.ZIndex=204
    val.TextXAlignment=Enum.TextXAlignment.Left
    val.TextTruncate=Enum.TextTruncate.AtEnd
    return row
end

local adBg=Instance.new("Frame",flagPage)
adBg.Size=UDim2.new(1,0,0,116);adBg.Position=UDim2.new(0,0,0,0)
adBg.BackgroundColor3=Color3.fromRGB(14,9,30);adBg.BorderSizePixel=0;adBg.ZIndex=202
mkCorner(adBg,8);mkStroke(adBg,Color3.fromRGB(120,70,210),1)

local titleRow=Instance.new("Frame",adBg)
titleRow.Size=UDim2.new(1,0,0,26);titleRow.Position=UDim2.new(0,0,0,0)
titleRow.BackgroundColor3=Color3.fromRGB(60,20,120);titleRow.BorderSizePixel=0;titleRow.ZIndex=203
mkCorner(titleRow,8)
local titleLbl=Instance.new("TextLabel",titleRow)
titleLbl.Size=UDim2.new(1,0,1,0);titleLbl.BackgroundTransparency=1
titleLbl.Text="👑  THÔNG TIN ADMIN";titleLbl.TextColor3=Color3.fromRGB(255,230,100)
titleLbl.TextSize=11;titleLbl.Font=Enum.Font.GothamBold;titleLbl.ZIndex=204

mkRow(adBg,"👤","Tên","Nguyễn Hoàng Khánh Nam",30)
mkRow(adBg,"🎭","Biệt danh","dzi",53)
mkRow(adBg,"🎂","Sinh","30 / 05 / 2006",76)
mkRow(adBg,"📍","Đến từ","Hà Đông, Hà Nội 🇻🇳",99)

local clockBg=Instance.new("Frame",flagPage)
clockBg.Size=UDim2.new(1,0,0,24);clockBg.Position=UDim2.new(0,0,0,120)
clockBg.BackgroundColor3=Color3.fromRGB(30,12,60);clockBg.BorderSizePixel=0;clockBg.ZIndex=202
mkCorner(clockBg,6);mkStroke(clockBg,Color3.fromRGB(180,100,255),1)
local clockLbl=Instance.new("TextLabel",clockBg)
clockLbl.Size=UDim2.new(1,0,1,0);clockLbl.BackgroundTransparency=1
clockLbl.Text="🕐  --:--:--   📅  --/--/----"
clockLbl.TextColor3=Color3.fromRGB(255,220,80);clockLbl.TextSize=10
clockLbl.Font=Enum.Font.GothamBold;clockLbl.ZIndex=203

local function updateClock()
    local t = os.time() + 7*3600
    local sec=t%60;local min=math.floor(t/60)%60;local hour=math.floor(t/3600)%24
    local day=math.floor(t/86400);local y,m,d=1970,1,1
    local dpm={31,28,31,30,31,30,31,31,30,31,30,31}
    local function isLeap(yr) return (yr%4==0 and yr%100~=0) or yr%400==0 end
    while true do local dy=isLeap(y) and 366 or 365;if day<dy then break end;day=day-dy;y=y+1 end
    for i=1,12 do local dm=dpm[i];if i==2 and isLeap(y) then dm=29 end;if day<dm then m=i;d=day+1;break end;day=day-dm end
    clockLbl.Text=string.format("🕐  %02d:%02d:%02d   📅  %02d/%02d/%04d",hour,min,sec,d,m,y)
end
updateClock()
task.spawn(function() while flagPage.Parent do task.wait(1);pcall(updateClock) end end)

local divLbl=Instance.new("TextLabel",flagPage)
divLbl.Size=UDim2.new(1,0,0,16);divLbl.Position=UDim2.new(0,0,0,148)
divLbl.BackgroundTransparency=1;divLbl.Text="── 🔗  Liên hệ ──"
divLbl.TextColor3=Color3.fromRGB(160,100,255);divLbl.TextSize=10
divLbl.Font=Enum.Font.GothamBold;divLbl.ZIndex=203

local socialLinks = {
    {label="Facebook", img="rbxassetid://5673787769", url="https://www.facebook.com/share/1DPKeN5Kdy/?mibextid=wwXIfr", c1=Color3.fromRGB(10,60,180), c2=Color3.fromRGB(24,119,242)},
    {label="Telegram", img="rbxassetid://5673789623", url="https://t.me/dzimeomeo", c1=Color3.fromRGB(0,95,160), c2=Color3.fromRGB(0,136,204)},
    {label="Discord",  img="rbxassetid://5673788181", url="https://discord.gg/FEEet5G3u", c1=Color3.fromRGB(55,60,180), c2=Color3.fromRGB(88,101,242)},
    {label="Zalo",     img="rbxassetid://6031094672", url="https://zalo.me/84993329535", c1=Color3.fromRGB(0,130,55), c2=Color3.fromRGB(0,180,75)},
}

for i,s in ipairs(socialLinks) do
    local col=(i-1)%2;local row=math.floor((i-1)/2)
    local btn=Instance.new("TextButton",flagPage)
    btn.Size=UDim2.new(0.5,-5,0,32)
    btn.Position=UDim2.new(col*0.5,col==0 and 0 or 5,0,166+row*36)
    btn.BackgroundColor3=s.c2;btn.BorderSizePixel=0
    btn.Text="";btn.ZIndex=203
    mkCorner(btn,9);mkStroke(btn,s.c1,1)
    local gradient=Instance.new("UIGradient",btn)
    gradient.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,s.c2),ColorSequenceKeypoint.new(1,s.c1)})
    gradient.Rotation=135
    local icoImg=Instance.new("ImageLabel",btn)
    icoImg.Size=UDim2.new(0,16,0,16);icoImg.Position=UDim2.new(0,8,0.5,-8)
    icoImg.BackgroundTransparency=1;icoImg.Image=s.img
    icoImg.ZIndex=204
    local txtLbl=Instance.new("TextLabel",btn)
    txtLbl.Size=UDim2.new(1,-30,1,0);txtLbl.Position=UDim2.new(0,28,0,0)
    txtLbl.BackgroundTransparency=1;txtLbl.Text=s.label
    txtLbl.TextColor3=Color3.fromRGB(255,255,255);txtLbl.TextSize=11
    txtLbl.Font=Enum.Font.GothamBold;txtLbl.ZIndex=204
    txtLbl.TextXAlignment=Enum.TextXAlignment.Left
    local url=s.url
    btn.MouseButton1Click:Connect(function()
        openURL(url,txtLbl)
    end)
    btn.MouseEnter:Connect(function() gradient.Rotation=90 end)
    btn.MouseLeave:Connect(function() gradient.Rotation=135 end)
end

flagPage.Size=UDim2.new(1,-8,0,234)

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
hopBtn.Text="Chuyển server đông người";hopBtn.TextColor3=Color3.fromRGB(200,230,255)
hopBtn.TextSize=11;hopBtn.Font=Enum.Font.GothamBold;hopBtn.ZIndex=203
mkCorner(hopBtn,8);mkStroke(hopBtn,Color3.fromRGB(80,140,255),1)
local hopIco=Instance.new("ImageLabel",hopBtn)
hopIco.Size=UDim2.new(0,16,0,16);hopIco.Position=UDim2.new(0,8,0.5,-8)
hopIco.BackgroundTransparency=1;hopIco.Image="rbxassetid://6031094670"
hopIco.ImageColor3=Color3.fromRGB(180,220,255);hopIco.ZIndex=204

local isHopping=false
hopBtn.MouseButton1Click:Connect(function()
    if isHopping then return end
    isHopping=true;hopBtn.Text="Đang tìm..."
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
            hopBtn.Text="Đang chuyển..."
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

local CARD_H=70
local CARD_GAP=4
local CARD_IMG_H=44
local CARD_TXT_H=18

local hintPage=makeTab("Gợi ý","🎮",3)
hintPage.Size=UDim2.new(1,-8,0,40)

local hintNoGame=Instance.new("TextLabel",hintPage)
hintNoGame.Size=UDim2.new(1,0,0,30);hintNoGame.Position=UDim2.new(0,0,0,4)
hintNoGame.BackgroundTransparency=1;hintNoGame.Text="Chờ cờ xuất hiện..."
hintNoGame.TextColor3=Color3.fromRGB(150,140,200);hintNoGame.TextSize=11
hintNoGame.Font=Enum.Font.GothamBold;hintNoGame.ZIndex=203

local hintCards={}
for i=1,4 do
    local col=(i-1)%2;local row=math.floor((i-1)/2)
    local xOff=col==0 and 0 or (CARD_GAP)
    local xScale=col*0.5
    local card=Instance.new("Frame",hintPage)
    card.Size=UDim2.new(0.5,-CARD_GAP,0,CARD_H)
    card.Position=UDim2.new(xScale,col==0 and 0 or CARD_GAP,0,row*(CARD_H+CARD_GAP))
    card.BackgroundColor3=Color3.fromRGB(18,12,36);card.BorderSizePixel=0
    card.ZIndex=203;card.Visible=false
    mkCorner(card,7);mkStroke(card,Color3.fromRGB(100,60,180),1)

    local img=Instance.new("ImageLabel",card)
    img.Size=UDim2.new(1,-4,0,CARD_IMG_H);img.Position=UDim2.new(0,2,0,2)
    img.BackgroundColor3=Color3.fromRGB(10,8,22);img.BorderSizePixel=0
    img.Image="";img.ScaleType=Enum.ScaleType.Fit;img.ZIndex=204
    mkCorner(img,5)

    local noFlagLbl=Instance.new("TextLabel",card)
    noFlagLbl.Size=UDim2.new(1,-4,0,CARD_IMG_H);noFlagLbl.Position=UDim2.new(0,2,0,2)
    noFlagLbl.BackgroundColor3=Color3.fromRGB(10,8,22);noFlagLbl.BorderSizePixel=0
    noFlagLbl.Text="";noFlagLbl.TextColor3=Color3.fromRGB(180,120,80)
    noFlagLbl.TextSize=9;noFlagLbl.Font=Enum.Font.Gotham
    noFlagLbl.TextWrapped=true;noFlagLbl.ZIndex=204;noFlagLbl.Visible=false
    mkCorner(noFlagLbl,5)

    local nameLbl=Instance.new("TextLabel",card)
    nameLbl.Size=UDim2.new(1,-4,0,CARD_TXT_H)
    nameLbl.Position=UDim2.new(0,2,0,CARD_IMG_H+4)
    nameLbl.BackgroundTransparency=1;nameLbl.Text=""
    nameLbl.TextColor3=Color3.fromRGB(220,200,255);nameLbl.TextSize=10
    nameLbl.Font=Enum.Font.GothamBold;nameLbl.TextScaled=false
    nameLbl.TextTruncate=Enum.TextTruncate.AtEnd
    nameLbl.ZIndex=204

    hintCards[i]={card=card,img=img,noFlagLbl=noFlagLbl,nameLbl=nameLbl}
end

local hintConns={}
local selectedHintBtn=nil
local hvContainer,hvShow,hvHide=makeFlagViewer(hintPage,0)
hvContainer.Visible=false

local function setHintFlag() end

local function loadCardFlag(c,name)
    local iso=COUNTRY_ISO[name]
    c.img.Image=""
    c.img.Visible=false
    c.noFlagLbl.Visible=false
    if not iso then
        c.noFlagLbl.Text="?"
        c.noFlagLbl.Visible=true
        return
    end
    if flagCache[iso] then
        c.img.Image=flagCache[iso];c.img.Visible=true;return
    end
    task.spawn(function()
        local url="https://flagcdn.com/w160/"..iso..".png"
        local fname="dziflag_"..iso..".png"
        local reqFn=nil
        if syn and syn.request then reqFn=syn.request
        elseif request then reqFn=request
        elseif http_request then reqFn=http_request end
        if reqFn and writefile and getcustomasset then
            local ok,res=pcall(reqFn,{Url=url,Method="GET"})
            if ok and res and res.Body and #res.Body>100 then
                pcall(writefile,fname,res.Body)
                local ok2,asset=pcall(getcustomasset,fname)
                if ok2 and asset then
                    flagCache[iso]=asset
                    if c.img.Parent then c.img.Image=asset;c.img.Visible=true end
                    return
                end
            end
        end
        local ok3=pcall(function() c.img.Image=url end)
        if ok3 then
            task.wait(1.5)
            if c.img.Parent and c.img.Image~="" then
                c.img.Visible=true
            else
                c.noFlagLbl.Text="?"
                c.noFlagLbl.Visible=true
            end
        else
            c.noFlagLbl.Text="?"
            c.noFlagLbl.Visible=true
        end
    end)
end

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
        local isActive=(n==name)
        local btn=tabBtns[n]
        btn.BackgroundColor3=isActive and Color3.fromRGB(60,30,120) or Color3.fromRGB(25,15,50)
        if btn._nameLbl then
            btn._nameLbl.TextColor3=isActive and Color3.fromRGB(255,220,100) or Color3.fromRGB(180,150,255)
        end
        for _,ch in ipairs(btn:GetChildren()) do
            if ch:IsA("ImageLabel") then
                ch.ImageColor3=isActive and Color3.fromRGB(255,220,100) or Color3.fromRGB(180,150,255)
            end
        end
    end
    activeTab=name;refreshMenuHeight()
end

tabBtns["Admin"].MouseButton1Click:Connect(function() switchTab("Admin") end)
tabBtns["Server"].MouseButton1Click:Connect(function() switchTab("Server") end)
tabBtns["Gợi ý"].MouseButton1Click:Connect(function() switchTab("Gợi ý") end)

ToggleMenu.MouseButton1Click:Connect(function()
    menuOpen=not menuOpen
    ToggleMenu.Text=menuOpen and "▼" or "▲"
    refreshMenuHeight()
end)

switchTab("Admin")

local BLACKLIST={
    "dzi","doan co","hub","players","win","tham gia","cua hang",
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
    local n=#list
    hintNoGame.Visible=(n==0)
    for i=1,4 do
        local c=hintCards[i]
        if list[i] then
            local name=list[i]
            c.nameLbl.Text=name
            c.img.Image=""
            c.img.Visible=false
            c.noFlagLbl.Visible=false
            c.card.Visible=true
            loadCardFlag(c,name)
        else
            c.card.Visible=false
        end
    end
    local rows=n>2 and 2 or (n>0 and 1 or 0)
    local h=rows*(CARD_H+CARD_GAP)+(n>0 and 0 or 40)
    hintPage.Size=UDim2.new(1,-8,0,n>0 and h or 40)
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
            if g.Name~="DziDoanCo" then collect(g) end
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
