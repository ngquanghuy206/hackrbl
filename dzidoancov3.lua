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
    -- TEN GAME THUC TE TU ANH
    -- "Sa mac phia Tay" / "Tay Sahara"
    ["sa mac phia tay"]="Tây Sahara",["sa mạc phía tây"]="Tây Sahara",
    ["tay sahara"]="Tây Sahara",["western sahara"]="Tây Sahara",
    -- "Quan dao Bac Mariana"
    ["quan dao bac mariana"]="Northern Mariana",["quần đảo bắc mariana"]="Northern Mariana",
    ["bac mariana"]="Northern Mariana",["northern mariana islands"]="Northern Mariana",
    -- "Quan dao Cocos (Keeling)"
    ["quan dao cocos keeling"]="Cocos Islands",["quần đảo cocos keeling"]="Cocos Islands",
    ["quan dao cocos"]="Cocos Islands",["cocos keeling"]="Cocos Islands",
    -- "Dao Man" / "Đảo Man"
    ["dao man"]="Isle of Man",["đảo man"]="Isle of Man",["isle of man"]="Isle of Man",
    -- "Quan Dao Faroe" / "Quan dao Faroe"
    ["quan dao faroe"]="Quần Đảo Faroe",["quần đảo faroe"]="Quần Đảo Faroe",["faroe"]="Quần Đảo Faroe",
    -- "Ma Cao" / "Macao"
    ["macao"]="Ma Cao",["ma cao"]="Ma Cao",["macau"]="Ma Cao",
    -- "Bonaire, Sint Eustatius va Saba"
    ["bonaire sint eustatius va saba"]="Bonaire Sint Eustatius Saba",
    ["bonaire sint eustatius và saba"]="Bonaire Sint Eustatius Saba",
    ["bonaire"]="Bonaire Sint Eustatius Saba",
    -- "Bosnia va Herzegovina"
    ["bosnia va herzegovina"]="Bosnia",["bosnia và herzegovina"]="Bosnia",
    ["bosnia herzegovina"]="Bosnia",["bo xni a"]="Bosnia",
    -- "Cote d Ivoire" / "Côte d'Ivoire"
    ["cote d ivoire"]="Bờ Biển Ngà",["côte d ivoire"]="Bờ Biển Ngà",["côte d'ivoire"]="Bờ Biển Ngà",
    ["bo bien nga"]="Bờ Biển Ngà",["ivory coast"]="Bờ Biển Ngà",
    -- "Nuoc Phi-Lip-Pin" / "Nước Phi-Líp-Pin"
    ["nuoc phi lip pin"]="Philippines",["nước phi líp pin"]="Philippines",
    ["phi lip pin"]="Philippines",["phi-lip-pin"]="Philippines",
    ["nước phi-líp-pin"]="Philippines",["nuoc phi-lip-pin"]="Philippines",
    -- "Cac Tieu Vuong Quoc A Rap Thong Nhat"
    ["cac tieu vuong quoc a rap thong nhat"]="Các Tiểu Vương Quốc Ả Rập",
    ["các tiểu vương quốc ả rập thống nhất"]="Các Tiểu Vương Quốc Ả Rập",
    ["tieu vuong quoc a rap thong nhat"]="Các Tiểu Vương Quốc Ả Rập",
    -- "Cong Hoa Congo" (Congo Brazzaville - khac voi DR Congo)
    ["cong hoa congo"]="Congo",["cộng hòa congo"]="Congo",
    ["congo brazzaville"]="Congo",["republic of the congo"]="Congo",
    -- "Tay Sahara" da co, dam bao
    -- "Quần đảo Faroe" da co
    -- "Eswatini"
    ["eswatini"]="Eswatini",["swaziland"]="Eswatini",
    -- "Quân đảo Bắc Mariana"  
    ["quân đảo bắc mariana"]="Northern Mariana",
    -- Them cac ten tieng Viet co the gap
    ["nước phi-líp-pin"]="Philippines",
    ["guernsey"]="Guernsey",["gu ern xi"]="Guernsey",
    ["gambia"]="Gambia",["gam bi a"]="Gambia",
    ["niue"]="Niue",["niu e"]="Niue",
    ["tokelau"]="Tokelau",["to ke lau"]="Tokelau",
    ["mauritius"]="Mauritius",["mau ri ti us"]="Mauritius",
    ["gabon"]="Gabon",
    ["paraguay"]="Paraguay",
    ["ecuador"]="Ecuador",
    ["rwanda"]="Rwanda",
    ["uganda"]="Uganda",["u gan da"]="Uganda",
    ["haiti"]="Haiti",["ha i ti"]="Haiti",
    ["bangadesh"]="Bangladesh",["banglades"]="Bangladesh",
    -- Ten tieng Viet co "va" thay cho "&" / "and"
    ["trinidad va tobago"]="Trinidad & Tobago",
    ["trinidad và tobago"]="Trinidad & Tobago",
    ["saint vincent va grenadines"]="Saint Vincent & Grenadines",
    ["saint vincent và grenadines"]="Saint Vincent & Grenadines",
    ["antigua va barbuda"]="Antigua & Barbuda",
    ["antigua và barbuda"]="Antigua & Barbuda",
    ["saint kitts va nevis"]="Saint Kitts & Nevis",
    ["saint kitts và nevis"]="Saint Kitts & Nevis",
    ["turks va caicos"]="Turks & Caicos",
    ["turks và caicos"]="Turks & Caicos",
    ["sao tome va principe"]="Sao Tome & Principe",
    ["sao tome và principe"]="Sao Tome & Principe",
    ["wallis va futuna"]="Wallis & Futuna",
    ["wallis và futuna"]="Wallis & Futuna",
    ["south georgia va south sandwich islands"]="South Georgia & South Sandwich Islands",
    ["heard island va mcdonald islands"]="Heard Island & McDonald Islands",
    -- Vatican / Thanh pho Vatican
    ["vatican city"]="Vatican",
    ["thanh pho vatican"]="Vatican",
    ["thanh pho va ti can"]="Vatican",
    ["toa thanh vatican"]="Vatican",
    ["holy see"]="Vatican",
    -- TEN GAME HAY DUNG (tu anh)
    -- "Nước Đức", "Nước Áo", "Nước Séc" etc
    ["nuoc duc"]="Đức",["nuoc ao"]="Áo",["nuoc sec"]="Séc",
    ["nuoc anh"]="Anh",["nuoc phap"]="Pháp",["nuoc y"]="Ý",
    ["nuoc bi"]="Bỉ",["nuoc ha lan"]="Hà Lan",["nuoc nga"]="Nga",
    ["nuoc ba lan"]="Ba Lan",["nuoc ukraine"]="Ukraine",
    ["nuoc hy lap"]="Hy Lạp",["nuoc hungary"]="Hungary",
    ["nuoc romania"]="Romania",["nuoc bulgaria"]="Bulgaria",
    ["nuoc serbia"]="Serbia",["nuoc croatia"]="Croatia",
    ["nuoc slovakia"]="Slovakia",["nuoc sec"]="Séc",
    ["nuoc estonia"]="Estonia",["nuoc latvia"]="Latvia",
    ["nuoc lithuania"]="Lithuania",["nuoc moldova"]="Moldova",
    ["nuoc belarus"]="Belarus",["nuoc iceland"]="Iceland",
    ["nuoc ireland"]="Ireland",["nuoc dan mach"]="Đan Mạch",
    ["nuoc na uy"]="Na Uy",["nuoc thuy dien"]="Thụy Điển",
    ["nuoc phan lan"]="Phần Lan",["nuoc thuy si"]="Thụy Sĩ",
    ["nuoc lien bang nga"]="Nga",
    -- Vatican (game goi "Thanh pho Vatican")
    ["thanh pho vatican"]="Vatican",["toa thanh vatican"]="Vatican",
    ["thanh pho va ti can"]="Vatican",["holy see"]="Vatican",
    -- Nước Áo (game goi "Nuoc Ao" hoac "Ao")
    ["nuoc ao"]="Áo",["ao"]="Áo",["austria"]="Áo",
    -- Séc (game goi "Nuoc Sec" hoac "Sec")
    ["nuoc sec"]="Séc",["nuoc cong hoa sec"]="Séc",
    -- Bangadesh (game viet sai "Bangadesh")
    ["bangadesh"]="Bangladesh",["banglades"]="Bangladesh",
    ["bang la det"]="Bangladesh",
    -- Hồng Kông
    ["hong kong"]="Hồng Kông",["hk"]="Hồng Kông",
    -- Cộng Hòa Congo / Congo (2 loai)
    ["cong hoa congo"]="Congo",["republic congo"]="Congo",
    ["cong hoa dan chu congo"]="Cộng Hòa Dân Chủ Congo",
    ["dan chu congo"]="Cộng Hòa Dân Chủ Congo",
    ["ch dan chu congo"]="Cộng Hòa Dân Chủ Congo",
    -- Tên tiếng Anh chuẩn cho các nước hay bị miss
    ["nước đức"]="Đức",["nước áo"]="Áo",["nước séc"]="Séc",
    ["nước anh"]="Anh",["nước pháp"]="Pháp",["nước ý"]="Ý",
    ["nước bỉ"]="Bỉ",["nước hà lan"]="Hà Lan",
    ["nước nga"]="Nga",["nước ba lan"]="Ba Lan",
    ["nước ukraine"]="Ukraine",["nước hy lạp"]="Hy Lạp",
    ["nước iceland"]="Iceland",["nước ireland"]="Ireland",
    ["thành phố vatican"]="Vatican",
    ["hồng kông"]="Hồng Kông",["hong kông"]="Hồng Kông",
    ["bangadesh"]="Bangladesh",
    ["cộng hòa congo"]="Congo",
    ["cộng hòa dân chủ congo"]="Cộng Hòa Dân Chủ Congo",
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
    -- Alias bo sung tu anh
    ["thanh pho vatican"]="Vatican",["thành phố vatican"]="Vatican",
    ["toa thanh vatican"]="Vatican",["tòa thánh vatican"]="Vatican",
    ["holy see"]="Vatican",
    ["curacao"]="Curazao",["curazao"]="Curazao",["cu ra cao"]="Curazao",
    ["quan dao virgin anh"]="Quần Đảo Virgin Anh",["quần đảo virgin anh"]="Quần Đảo Virgin Anh",
    ["british virgin islands"]="Quần Đảo Virgin Anh",
    ["nuoc phi lip pin"]="Philippines",["nước phi líp pin"]="Philippines",
    ["nước phi-líp-pin"]="Philippines",["phi lip pin"]="Philippines",
    ["bonaire sint eustatius va saba"]="Bonaire Sint Eustatius Saba",
    ["bonaire, sint eustatius và saba"]="Bonaire Sint Eustatius Saba",
    ["estonia"]="Estonia",["ex to ni a"]="Estonia",
    ["kenya"]="Kenya",["libya"]="Libya",
    ["costa rica"]="Costa Rica",["palestine"]="Palestine",
    ["ba lan"]="Ba Lan",["poland"]="Ba Lan",
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
    if ANSWER_MAP[n] then return ANSWER_MAP[n] end
    -- Strip cac prefix tieng Viet pho bien
    local prefixes = {
        "nuoc ", "thanh pho ", "dao ", "quan dao ",
        "cong hoa ", "vuong quoc ", "lien bang ",
    }
    for _,p in ipairs(prefixes) do
        if n:sub(1,#p)==p then
            local s=n:sub(#p+1)
            if ANSWER_MAP[s] then return ANSWER_MAP[s] end
        end
    end
    return nil
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

pcall(function()
    local oldGui=player.PlayerGui:FindFirstChild("DziDoanCo")
    if oldGui then oldGui:Destroy() end
    local oldGui2=player.PlayerGui:FindFirstChild("DziAutoFlag")
    if oldGui2 then oldGui2:Destroy() end
end)
task.wait(0.05)
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

local TitleLbl=Instance.new("TextLabel",TitleBar)
TitleLbl.Size=UDim2.new(1,-50,1,0);TitleLbl.Position=UDim2.new(0,8,0,0)
TitleLbl.BackgroundTransparency=1;TitleLbl.Text="🏴 DZI ĐOÁN CỜ"
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
flagPage.Size=UDim2.new(1,-8,0,200)

local function mkInfoLbl(parent,text,y,h,tc,fs,align)
    local l=Instance.new("TextLabel",parent)
    l.Size=UDim2.new(1,0,0,h);l.Position=UDim2.new(0,0,0,y)
    l.BackgroundTransparency=1;l.Text=text
    l.TextColor3=tc or Color3.fromRGB(220,200,255)
    l.TextSize=fs or 11;l.Font=Enum.Font.GothamBold
    l.TextWrapped=true;l.ZIndex=203
    l.TextXAlignment=align or Enum.TextXAlignment.Center
    return l
end

mkInfoLbl(flagPage,"👑 THÔNG TIN ADMIN",0,18,Color3.fromRGB(200,160,255),12)
mkInfoLbl(flagPage,"Tên: Nguyễn Hoàng Khánh Nam",20,16,Color3.fromRGB(180,220,255),10)
mkInfoLbl(flagPage,'Biệt danh: "dzi"',38,16,Color3.fromRGB(180,220,255),10)
mkInfoLbl(flagPage,"Sinh: 30/05/2006",56,16,Color3.fromRGB(180,220,255),10)
mkInfoLbl(flagPage,"Đến từ: Hà Đông, Hà Nội, Việt Nam",74,16,Color3.fromRGB(180,220,255),10)

local clockLbl=mkInfoLbl(flagPage,"🕐 --:--:--  |  --/--/----",92,16,Color3.fromRGB(255,220,100),10)

local function updateClock()
    local t = os.time() + 7*3600
    local sec  = t % 60
    local min  = math.floor(t/60) % 60
    local hour = math.floor(t/3600) % 24
    local day  = math.floor(t/86400)
    local y,m,d = 1970,1,1
    local dpm = {31,28,31,30,31,30,31,31,30,31,30,31}
    local function isLeap(yr) return (yr%4==0 and yr%100~=0) or yr%400==0 end
    while true do
        local dy = isLeap(y) and 366 or 365
        if day < dy then break end
        day = day - dy; y = y+1
    end
    for i=1,12 do
        local dm = dpm[i]; if i==2 and isLeap(y) then dm=29 end
        if day < dm then m=i; d=day+1; break end
        day=day-dm
    end
    clockLbl.Text=string.format("🕐 %02d:%02d:%02d  |  %02d/%02d/%04d",hour,min,sec,d,m,y)
end
updateClock()

task.spawn(function()
    while flagPage.Parent do
        task.wait(1)
        pcall(updateClock)
    end
end)

local sep=Instance.new("Frame",flagPage)
sep.Size=UDim2.new(1,0,0,1);sep.Position=UDim2.new(0,0,0,112)
sep.BackgroundColor3=Color3.fromRGB(100,60,180);sep.BorderSizePixel=0;sep.ZIndex=203

mkInfoLbl(flagPage,"🔗 Liên hệ",116,16,Color3.fromRGB(200,160,255),11)

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
            btn.Text="📋 Đã copy!"
            task.delay(1.5, function() if btn.Parent then btn.Text=origText end end)
        end
    end
end

local socialLinks = {
    {label="📘 Facebook", url="https://www.facebook.com/share/1DPKeN5Kdy/?mibextid=wwXIfr", color=Color3.fromRGB(24,119,242)},
    {label="✈️ Telegram", url="https://t.me/dzimeomeo", color=Color3.fromRGB(0,136,204)},
    {label="💬 Discord", url="https://discord.gg/FEEet5G3u", color=Color3.fromRGB(88,101,242)},
    {label="💚 Zalo", url="https://zalo.me/84993329535", color=Color3.fromRGB(0,180,80)},
}

for i, s in ipairs(socialLinks) do
    local col=(i-1)%2; local row=math.floor((i-1)/2)
    local btn=Instance.new("TextButton",flagPage)
    btn.Size=UDim2.new(0.5,-6,0,28)
    btn.Position=UDim2.new(col*0.5,col==0 and 2 or 4,0,134+row*32)
    btn.BackgroundColor3=s.color;btn.BorderSizePixel=0
    btn.Text=s.label;btn.TextColor3=Color3.fromRGB(255,255,255)
    btn.TextSize=10;btn.Font=Enum.Font.GothamBold;btn.ZIndex=203
    mkCorner(btn,7)
    local url=s.url
    btn.MouseButton1Click:Connect(function() openURL(url, btn) end)
end

flagPage.Size=UDim2.new(1,-8,0,260)

-- Nút DEBUG trong tab Admin
local debugScanBtn=Instance.new("TextButton",flagPage)
debugScanBtn.Size=UDim2.new(1,-4,0,26)
debugScanBtn.Position=UDim2.new(0,2,0,202)
debugScanBtn.BackgroundColor3=Color3.fromRGB(120,40,10)
debugScanBtn.BorderSizePixel=0
debugScanBtn.Text="🔍 DEBUG: Scan data game (xem console F9)"
debugScanBtn.TextColor3=Color3.fromRGB(255,220,150)
debugScanBtn.TextSize=9;debugScanBtn.Font=Enum.Font.GothamBold
debugScanBtn.ZIndex=203;mkCorner(debugScanBtn,6)

debugScanBtn.MouseButton1Click:Connect(function()
    debugScanBtn.Text="⏳ Đang scan..."
    task.spawn(function()
        local log={}
        local function L(s) log[#log+1]=s; print("[DZI] "..s) end
        L("===SCAN START===")

        -- Hook RemoteEvent để bắt data real-time
        pcall(function()
            local rs=game:GetService("ReplicatedStorage")
            for _,obj in ipairs(rs:GetDescendants()) do
                L("RS:"..obj.ClassName..":"..obj.Name)
                if obj:IsA("StringValue") or obj:IsA("IntValue") then
                    L("  val="..tostring(obj.Value))
                end
                pcall(function()
                    for k,v in pairs(obj:GetAttributes()) do
                        L("  attr "..k.."="..tostring(v))
                    end
                end)
            end
        end)

        -- Workspace top-level objects
        pcall(function()
            for _,obj in ipairs(game:GetService("Workspace"):GetChildren()) do
                L("WS child: "..obj.ClassName..":"..obj.Name)
                for _,ch in ipairs(obj:GetChildren()) do
                    L("  WS sub: "..ch.ClassName..":"..ch.Name)
                    if ch:IsA("StringValue") then L("    val="..tostring(ch.Value)) end
                end
            end
        end)

        -- PlayerGui hidden labels
        pcall(function()
            for _,obj in ipairs(player.PlayerGui:GetDescendants()) do
                if (obj:IsA("TextLabel") or obj:IsA("StringValue")) then
                    local t=obj:IsA("StringValue") and obj.Value or obj.Text
                    if t and #t>=2 and #t<=80 and not obj.Visible then
                        L("GUI hidden: '"..t.."' name="..obj.Name)
                    end
                end
            end
        end)

        -- Scan tất cả Model có tên khớp nước trong WS
        pcall(function()
            for _,obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                if obj:IsA("Model") or obj:IsA("Folder") then
                    local n=norm(obj.Name)
                    if tryMatch(n) then
                        L("WS Model/Folder match: "..obj.Name.." parent="..tostring(obj.Parent and obj.Parent.Name))
                    end
                end
                pcall(function()
                    for k,v in pairs(obj:GetAttributes()) do
                        local vs=tostring(v)
                        if #vs>=2 and #vs<=60 then
                            L("WS attr["..obj.Name.."]."..k.."="..vs)
                        end
                    end
                end)
            end
        end)

        L("===SCAN END: "..#log.." lines===")
        _G.DziLastLog = table.concat(log, "\n")
        debugScanBtn.Text="✅ Xong! ("..#log.." dòng)"
        debugCopyBtn.BackgroundColor3=Color3.fromRGB(20,120,40)
        debugCopyBtn.Text="📋 Copy Log ("..#log.." dòng)"
        task.delay(4, function()
            if debugScanBtn.Parent then
                debugScanBtn.Text="🔍 DEBUG: Scan data game (xem console F9)"
            end
        end)
    end)
end)

local debugCopyBtn=Instance.new("TextButton",flagPage)
debugCopyBtn.Size=UDim2.new(1,-4,0,24)
debugCopyBtn.Position=UDim2.new(0,2,0,230)
debugCopyBtn.BackgroundColor3=Color3.fromRGB(30,60,30)
debugCopyBtn.BorderSizePixel=0
debugCopyBtn.Text="📋 Copy Log (scan trước)"
debugCopyBtn.TextColor3=Color3.fromRGB(180,255,180)
debugCopyBtn.TextSize=9;debugCopyBtn.Font=Enum.Font.GothamBold
debugCopyBtn.ZIndex=203;mkCorner(debugCopyBtn,6)

debugCopyBtn.MouseButton1Click:Connect(function()
    local logText=_G.DziLastLog
    if not logText or logText=="" then
        debugCopyBtn.Text="⚠️ Chưa có log! Bấm scan trước"
        task.delay(2,function()
            if debugCopyBtn.Parent then debugCopyBtn.Text="📋 Copy Log (scan trước)" end
        end)
        return
    end
    local ok=pcall(function()
        if setclipboard then setclipboard(logText)
        elseif syn and syn.setclipboard then syn.setclipboard(logText)
        elseif Clipboard and Clipboard.set then Clipboard.set(logText)
        else error("no clipboard") end
    end)
    if ok then
        debugCopyBtn.Text="✅ Đã copy! Paste vào chat/note"
        debugCopyBtn.BackgroundColor3=Color3.fromRGB(10,160,50)
    else
        debugCopyBtn.Text="❌ Executor không hỗ trợ copy"
    end
    task.delay(3,function()
        if debugCopyBtn.Parent then
            debugCopyBtn.BackgroundColor3=Color3.fromRGB(20,120,40)
            debugCopyBtn.Text="📋 Copy Log"
        end
    end)
end)


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

local CARD_H=70
local CARD_GAP=4
local CARD_IMG_H=44
local CARD_TXT_H=18

local GAME_FLAG_H=110  -- Chiều cao khung lá cờ game
local GAME_FLAG_LABEL_H=18
local GAME_FLAG_TOTAL=GAME_FLAG_H+GAME_FLAG_LABEL_H+8  -- Tổng chiều cao vùng cờ game

local hintPage=makeTab("Gợi ý","🎮",3)
hintPage.Size=UDim2.new(1,-8,0,40)

local hintNoGame=Instance.new("TextLabel",hintPage)
hintNoGame.Size=UDim2.new(1,0,0,30);hintNoGame.Position=UDim2.new(0,0,0,4)
hintNoGame.BackgroundTransparency=1;hintNoGame.Text="⏳ Chờ cờ xuất hiện..."
hintNoGame.TextColor3=Color3.fromRGB(150,140,200);hintNoGame.TextSize=11
hintNoGame.Font=Enum.Font.GothamBold;hintNoGame.ZIndex=203

-- ===== KHUNG LÁ CỜ GAME (hiển thị cờ đang hỏi) =====
local gameFlagFrame=Instance.new("Frame",hintPage)
gameFlagFrame.Size=UDim2.new(1,0,0,GAME_FLAG_TOTAL)
gameFlagFrame.Position=UDim2.new(0,0,0,0)
gameFlagFrame.BackgroundColor3=Color3.fromRGB(12,8,28)
gameFlagFrame.BorderSizePixel=0;gameFlagFrame.ZIndex=203
gameFlagFrame.Visible=false
mkCorner(gameFlagFrame,8);mkStroke(gameFlagFrame,Color3.fromRGB(120,70,200),1.5)

local gameFlagTitle=Instance.new("TextLabel",gameFlagFrame)
gameFlagTitle.Size=UDim2.new(1,0,0,16);gameFlagTitle.Position=UDim2.new(0,0,0,2)
gameFlagTitle.BackgroundTransparency=1;gameFlagTitle.Text="🏳 LÁ CỜ ĐANG HỎI"
gameFlagTitle.TextColor3=Color3.fromRGB(180,140,255);gameFlagTitle.TextSize=10
gameFlagTitle.Font=Enum.Font.GothamBold;gameFlagTitle.ZIndex=204

local gameFlagImg=Instance.new("ImageLabel",gameFlagFrame)
gameFlagImg.Size=UDim2.new(1,-8,0,GAME_FLAG_H)
gameFlagImg.Position=UDim2.new(0,4,0,20)
gameFlagImg.BackgroundColor3=Color3.fromRGB(8,5,18);gameFlagImg.BorderSizePixel=0
gameFlagImg.Image="";gameFlagImg.ScaleType=Enum.ScaleType.Fit;gameFlagImg.ZIndex=204
gameFlagImg.Visible=false
mkCorner(gameFlagImg,6)

local gameFlagNoImg=Instance.new("TextLabel",gameFlagFrame)
gameFlagNoImg.Size=UDim2.new(1,-8,0,GAME_FLAG_H)
gameFlagNoImg.Position=UDim2.new(0,4,0,20)
gameFlagNoImg.BackgroundColor3=Color3.fromRGB(8,5,18);gameFlagNoImg.BorderSizePixel=0
gameFlagNoImg.Text="⏳ Đang tải cờ..."
gameFlagNoImg.TextColor3=Color3.fromRGB(180,150,100);gameFlagNoImg.TextSize=11
gameFlagNoImg.Font=Enum.Font.GothamBold;gameFlagNoImg.TextWrapped=true
gameFlagNoImg.ZIndex=204;gameFlagNoImg.Visible=true
mkCorner(gameFlagNoImg,6)

-- ISO code của lá cờ game hiện tại
local currentGameFlagISO=nil

local function showGameFlag(iso)
    if iso==currentGameFlagISO then return end
    currentGameFlagISO=iso
    gameFlagFrame.Visible=true
    gameFlagImg.Visible=false
    gameFlagImg.Image=""
    gameFlagNoImg.Text="⏳ Đang tải cờ... ("..iso..")"
    gameFlagNoImg.Visible=true

    if flagCache[iso] then
        gameFlagImg.Image=flagCache[iso]
        gameFlagImg.Visible=true
        gameFlagNoImg.Visible=false
        return
    end

    task.spawn(function()
        local url="https://flagcdn.com/w320/"..iso..".png"
        local fname="dziflag_game_"..iso..".png"
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
                    if gameFlagImg.Parent then
                        gameFlagImg.Image=asset
                        gameFlagImg.Visible=true
                        gameFlagNoImg.Visible=false
                    end
                    return
                end
            end
        end
        local ok3=pcall(function() gameFlagImg.Image=url end)
        if ok3 then
            task.wait(1.5)
            if gameFlagImg.Parent and (gameFlagImg.Image~="" and gameFlagImg.Image~=url or gameFlagImg.Image==url) then
                gameFlagImg.Visible=true
                gameFlagNoImg.Visible=false
            else
                gameFlagNoImg.Text="❌ Không load được cờ ("..iso..")"
            end
        else
            gameFlagNoImg.Text="❌ Executor không hỗ trợ ảnh ("..iso..")"
        end
    end)
end

local function hideGameFlag()
    currentGameFlagISO=nil
    gameFlagFrame.Visible=false
    gameFlagImg.Image=""
    gameFlagImg.Visible=false
end
-- ===== END KHUNG LÁ CỜ GAME =====

local answerBanner=Instance.new("Frame",hintPage)
answerBanner.Size=UDim2.new(1,0,0,22)
answerBanner.BackgroundColor3=Color3.fromRGB(20,100,35)
answerBanner.BorderSizePixel=0;answerBanner.ZIndex=205
answerBanner.Visible=false
mkCorner(answerBanner,6);mkStroke(answerBanner,Color3.fromRGB(50,220,80),1.5)
-- Position will be set dynamically

local answerLbl=Instance.new("TextLabel",answerBanner)
answerLbl.Size=UDim2.new(1,0,1,0)
answerLbl.BackgroundTransparency=1
answerLbl.Text=""
answerLbl.TextColor3=Color3.fromRGB(180,255,180)
answerLbl.TextSize=11;answerLbl.Font=Enum.Font.GothamBold
answerLbl.ZIndex=206

local CARDS_Y_OFFSET=GAME_FLAG_TOTAL+28  -- Vị trí Y bắt đầu của 4 card (sau gameFlagFrame + answerBanner)

local hintCards={}
for i=1,4 do
    local col=(i-1)%2;local row=math.floor((i-1)/2)
    local xOff=col==0 and 0 or (CARD_GAP)
    local xScale=col*0.5
    local card=Instance.new("Frame",hintPage)
    card.Size=UDim2.new(0.5,-CARD_GAP,0,CARD_H)
    card.Position=UDim2.new(xScale,col==0 and 0 or CARD_GAP,0,CARDS_Y_OFFSET+row*(CARD_H+CARD_GAP))
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
        tabBtns[n].BackgroundColor3=n==name
            and Color3.fromRGB(60,30,120) or Color3.fromRGB(25,15,50)
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

-- Contains-check: chuoi dai, khong chong lan ten nuoc
local BLACKLIST={
    "dzi","doan co","hub","players","win","tham gia","cua hang",
    "kho do","troll","hang ngay","goi y","tiet lo","phan hoi",
    "lan thang","chuoi thang","tien mat","bao cao","nguoi moi",
    "x2 tien","x2 lan","x2 chuo",
    "bat dau","trung binh","cuc doan","luot",
    "suy nghi","x2 ","2x ",
}
-- Exact-check: chi chặn khi text ĐÚNG BẰNG chuỗi này (tranh chặn "Trung Quốc", "Bangadesh", "Nam Cực")
local BLACKLIST_EXACT={
    de=true,       -- "Dễ" difficulty
    kho=true,      -- "Khó" difficulty  
    trung=true,    -- "Trung" (mình - difficulty riêng)
    cuc=true,      -- "Cực" (riêng)
    ["de "]= true, -- "Dễ " có dấu cách
    ["kho "]=true, -- "Khó " có dấu cách
    ["luot"]=true,
    ["lượt"]=true,
}

local currentFlagName = nil

local COLOR_CORRECT  = Color3.fromRGB(30, 180, 60)
local COLOR_NORMAL   = Color3.fromRGB(18, 12, 36)
local COLOR_STROKE_C = Color3.fromRGB(50, 220, 80)
local COLOR_STROKE_N = Color3.fromRGB(100, 60, 180)

local function recalcHintLayout(n)
    -- Tính toán layout động dựa trên có/không có gameFlagFrame
    local flagFrameH = gameFlagFrame.Visible and GAME_FLAG_TOTAL or 0
    local ansY = flagFrameH + 2
    local cardsY = flagFrameH + (answerBanner.Visible and 26 or 2)

    -- Cập nhật vị trí answerBanner
    answerBanner.Position=UDim2.new(0,0,0,ansY)

    -- Cập nhật vị trí gameFlagFrame
    gameFlagFrame.Position=UDim2.new(0,0,0,0)

    -- Cập nhật vị trí từng card
    for i=1,4 do
        local col=(i-1)%2;local row=math.floor((i-1)/2)
        hintCards[i].card.Position=UDim2.new(col*0.5,col==0 and 0 or CARD_GAP,0,cardsY+row*(CARD_H+CARD_GAP))
    end

    -- Tính chiều cao tổng
    local rows=n>2 and 2 or (n>0 and 1 or 0)
    local cardsH=rows*(CARD_H+CARD_GAP)
    local h=flagFrameH+(answerBanner.Visible and 26 or 0)+(n>0 and (2+cardsH) or 40)
    hintPage.Size=UDim2.new(1,-8,0,n>0 and h or (flagFrameH>0 and flagFrameH+40 or 40))
end

local function highlightCards(correctName)
    local n=0
    for i=1,4 do
        local cd=hintCards[i]
        if cd.card.Visible then
            n=n+1
            local isRight = correctName and (norm(cd.nameLbl.Text)==norm(correctName))
            cd.card.BackgroundColor3 = isRight and COLOR_CORRECT or COLOR_NORMAL
            local stroke=cd.card:FindFirstChildOfClass("UIStroke")
            if stroke then
                stroke.Color = isRight and COLOR_STROKE_C or COLOR_STROKE_N
                stroke.Thickness = isRight and 2.5 or 1
            end
            cd.nameLbl.TextColor3 = isRight
                and Color3.fromRGB(255,255,180)
                or Color3.fromRGB(220,200,255)
        end
    end
    -- Banner "Đáp án đúng"
    if correctName then
        answerBanner.Visible=true
        answerLbl.Text="✅ Đáp án đúng: "..correctName
    else
        answerBanner.Visible=false
        answerLbl.Text=""
    end
    recalcHintLayout(n)
    if activeTab=="Gợi ý" then refreshMenuHeight() end
end

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
    -- Reset mau ve mac dinh, an banner
    answerBanner.Visible=false
    answerLbl.Text=""
    currentFlagName=nil
    for i=1,4 do
        local cd=hintCards[i]
        cd.card.BackgroundColor3=COLOR_NORMAL
        local stroke=cd.card:FindFirstChildOfClass("UIStroke")
        if stroke then stroke.Color=COLOR_STROKE_N;stroke.Thickness=1 end
        cd.nameLbl.TextColor3=Color3.fromRGB(220,200,255)
    end
    recalcHintLayout(n)
    if activeTab=="Gợi ý" then refreshMenuHeight() end

    -- ===== SO SÁNH LÁ CỜ GAME VỚI 4 GỢI Ý =====
    -- Nếu đã biết ISO cờ game, tự động tìm đáp án đúng trong list gợi ý
    if currentGameFlagISO and n>0 then
        task.defer(function()
            for _,name in ipairs(list) do
                local iso=COUNTRY_ISO[name]
                if iso and iso==currentGameFlagISO then
                    -- Tìm thấy! Highlight đáp án đúng
                    currentFlagName=name
                    answerBanner.Visible=true
                    answerLbl.Text="✅ Đáp án đúng: "..name
                    recalcHintLayout(n)
                    highlightCards(name)
                    if activeTab=="Gợi ý" then refreshMenuHeight() end
                    break
                end
            end
        end)
    end
end

-- ===== END DETECT LÁ CỜ GAME =====
-- NOTE: showGameFlag sẽ được gọi khi flagName được tìm ra từ logic scan bên dưới

local tick0=0
local questionChangedAt=0  -- Thoi diem doi cau hoi moi nhat (os.clock())
RunService.Heartbeat:Connect(function()
    tick0+=1;if tick0<4 then return end;tick0=0
    pcall(function()
        local texts={}
        local function collect(obj)
            if(obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.Visible then
                local t=obj.Text
                if t and #t>=2 and #t<=80 then
                    local n=norm(t);local skip=false
                    -- Exact match check (tranh chan "Trung Quoc", "Bangadesh", "Nam Cuc")
                    if BLACKLIST_EXACT[n] then
                        skip=true
                    else
                        -- Contains check cho chuoi dai
                        for _,bad in ipairs(BLACKLIST) do
                            if n:find(bad,1,true) then skip=true;break end
                        end
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

        -- Tim ten co dap an tu game
        local flagName=nil
        local nameCount={}

        pcall(function()
            -- COOLDOWN: Cho 2 giay sau khi doi cau hoi moi phat hien dap an
            -- Tranh false positive tu du lieu cu (stale data) trong GUI nguoi choi
            if os.clock()-questionChangedAt < 2 then return end

            -- Dem so lan xuat hien cua moi ten trong TẤT CẢ GUI (tru GUI cua minh)
            local function countTexts(root)
                for _,obj in ipairs(root:GetDescendants()) do
                    if (obj:IsA("TextLabel") or obj:IsA("TextButton")) then
                        local t=obj.Text
                        if t and #t>=2 and #t<=60 then
                            local n=norm(t)
                            -- Chi dem neu khop voi 1 trong 4 matched
                            for _,m in ipairs(matched) do
                                if norm(m)==n then
                                    nameCount[m]=(nameCount[m] or 0)+1
                                    break
                                end
                            end
                        end
                    end
                end
            end

            -- Scan PlayerGui cac player khac
            for _,plr in ipairs(game:GetService("Players"):GetPlayers()) do
                if plr~=player then
                    pcall(function() countTexts(plr.PlayerGui) end)
                end
            end

            -- Scan Workspace SurfaceGui/BillboardGui
            pcall(function()
                for _,obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
                        for _,ch in ipairs(obj:GetDescendants()) do
                            if ch:IsA("TextLabel") or ch:IsA("TextButton") then
                                local t=ch.Text
                                if t and #t>=2 and #t<=60 then
                                    local n=norm(t)
                                    for _,m in ipairs(matched) do
                                        if norm(m)==n then
                                            nameCount[m]=(nameCount[m] or 0)+10
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)

            -- Scan ReplicatedStorage StringValue
            pcall(function()
                local rs=game:GetService("ReplicatedStorage")
                for _,obj in ipairs(rs:GetDescendants()) do
                    if obj:IsA("StringValue") then
                        local n=norm(obj.Value or "")
                        for _,m in ipairs(matched) do
                            if norm(m)==n then
                                nameCount[m]=(nameCount[m] or 0)+20
                                break
                            end
                        end
                    end
                end
            end)

            -- Scan Decal/Texture ISO code
            pcall(function()
                for _,obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj:IsA("Decal") or obj:IsA("Texture") then
                        local tex=obj.Texture or ""
                        local iso=tex:match("flagcdn%.com/[^/]+/([a-z][a-z])%.png")
                            or tex:match("/([a-z][a-z])%.png$")
                        if iso then
                            for name,code in pairs(COUNTRY_ISO) do
                                if code==iso then
                                    for _,m in ipairs(matched) do
                                        if norm(m)==norm(name) then
                                            nameCount[m]=(nameCount[m] or 0)+50
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)

            -- PHUONG PHAP 1: Chi quet TextLABEL co chua TU KHOA dap an
            -- Vi du "Dap an dung: Congo" -> chac chan dung
            -- KHONG quet TextButton game (vi button "Cong Hoa Congo" cung chua "congo"!)
            pcall(function()
                local ansKw={"dap an","correct","dung la","ket qua","answer","da dung"}
                for _,obj in ipairs(player.PlayerGui:GetDescendants()) do
                    if obj:IsA("TextLabel") and obj.Visible then
                        local t=obj.Text
                        if t and #t>6 then
                            local p=obj;local own=false
                            repeat
                                if p.Name=="DziDoanCo" then own=true;break end
                                p=p.Parent
                            until not p or not p.Parent
                            if not own then
                                local n=norm(t)
                                local hasKw=false
                                for _,kw in ipairs(ansKw) do
                                    if n:find(kw,1,true) then hasKw=true;break end
                                end
                                if hasKw then
                                    for _,m in ipairs(matched) do
                                        if n:find(norm(m),1,true) then
                                            nameCount[m]=(nameCount[m] or 0)+50
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)

            -- PHUONG PHAP 2: Phat hien button doi sang MAU XANH LA sau Tiet lo
            -- Chi dung khop chinh xac (tryMatch), KHONG dung contains tranh false positive
            pcall(function()
                for _,obj in ipairs(player.PlayerGui:GetDescendants()) do
                    if (obj:IsA("TextButton") or obj:IsA("TextLabel")) and obj.Visible then
                        local p=obj;local own=false
                        repeat
                            if p.Name=="DziDoanCo" then own=true;break end
                            p=p.Parent
                        until not p or not p.Parent
                        if not own then
                            local bg=obj.BackgroundColor3
                            local r,g,b=bg.R,bg.G,bg.B
                            local isGreen=(g>0.35 and g>r*1.4 and g>b*1.4)
                            if isGreen then
                                local t=obj.Text
                                if t and #t>=2 then
                                    local mm=tryMatch(norm(t))
                                    if mm then nameCount[mm]=(nameCount[mm] or 0)+60 end
                                end
                                for _,ch in ipairs(obj:GetDescendants()) do
                                    if ch:IsA("TextLabel") and ch.Text then
                                        local mm2=tryMatch(norm(ch.Text))
                                        if mm2 then nameCount[mm2]=(nameCount[mm2] or 0)+60 end
                                    end
                                end
                            end
                        end
                    end
                end
            end)

            -- PHUONG PHAP 3: Scan ten Model/Part co chua ten nuoc trong Workspace (flag model)
            pcall(function()
                for _,obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    -- Game thuong dat ten Model/Folder theo ten nuoc hoac luu trong StringValue/Attribute
                    local checkName = nil
                    if obj:IsA("Model") or obj:IsA("Folder") or obj:IsA("Part") or obj:IsA("UnionOperation") then
                        checkName = obj.Name or ""
                    elseif obj:IsA("StringValue") or obj:IsA("LocalizationTable") then
                        checkName = (obj.Value or "")..(obj.Name or "")
                    end
                    if checkName and #checkName>=2 and #checkName<=60 then
                        local n=norm(checkName)
                        local mm=tryMatch(n)
                        if mm then
                            for _,m in ipairs(matched) do
                                if norm(m)==norm(mm) then
                                    nameCount[m]=(nameCount[m] or 0)+30
                                    break
                                end
                            end
                        end
                    end
                    -- Scan Attributes
                    pcall(function()
                        for attrName,attrVal in pairs(obj:GetAttributes()) do
                            local v=tostring(attrVal or "")
                            if #v>=2 and #v<=60 then
                                local n=norm(v)
                                local mm=tryMatch(n)
                                if mm then
                                    for _,m in ipairs(matched) do
                                        if norm(m)==norm(mm) then
                                            nameCount[m]=(nameCount[m] or 0)+40
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end)

            -- PHUONG PHAP 4: Scan BillboardGui/SurfaceGui trong Workspace (ten nuoc hien tren nen co)
            pcall(function()
                for _,obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
                        for _,ch in ipairs(obj:GetDescendants()) do
                            if ch:IsA("TextLabel") or ch:IsA("TextButton") then
                                local t=ch.Text
                                if t and #t>=2 and #t<=60 then
                                    local mm=tryMatch(norm(t))
                                    if mm then
                                        for _,m in ipairs(matched) do
                                            if norm(m)==norm(mm) then
                                                nameCount[m]=(nameCount[m] or 0)+50
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)

            -- Chon ten co diem cao nhat
            -- Ha nguong xuong 20 de detect duoc khi chi co 1 nguon (model name, attribute, billboard)
            local maxCount=20
            for name,cnt in pairs(nameCount) do
                if cnt>maxCount then maxCount=cnt;flagName=name end
            end
        end)

        -- Highlight card dung - giu xanh mai, chi doi khi co goi y moi
        if flagName and #matched>0 then
            if flagName~=currentFlagName then
                currentFlagName=flagName
                highlightCards(flagName)
                -- Hiển thị lá cờ đáp án lên khung lớn
                local iso=COUNTRY_ISO[flagName]
                if iso then showGameFlag(iso) end
            end
        end
        -- Khong reset neu khong tim duoc - giu xanh cho den khi co goi y moi

        if not listsEq(matched,lastHints) then
            lastHints=matched
            questionChangedAt=os.clock()  -- Bat dau cooldown
            -- Ẩn cờ game khi câu hỏi mới
            hideGameFlag()
            updateHintBtns(matched)
            if #matched>=1 then
                -- Tu dong mo menu neu dang thu nho
                if not menuOpen then
                    menuOpen=true
                    ToggleMenu.Text="▼"
                end
                if activeTab~="Gợi ý" then switchTab("Gợi ý") end
                refreshMenuHeight()
            end
            -- Re-highlight sau khi update cards
            task.defer(function()
                if currentFlagName then highlightCards(currentFlagName) end
            end)
        end
    end)
end)
