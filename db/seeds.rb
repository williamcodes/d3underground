# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# condition : {
#   city: XYZ,
#   year: YYYY,
#   temperatures: {
#     MMDD: {TEMP},
#     MMDD: {TEMP},
#     MMDD: {TEMP},
#     MMDD: {TEMP}
#     ...
#   }
# }

require 'json'

# years = ["1953", "1973", "1993", "2013"]
years2 = ["1950", "1951", "1952", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012"]
days = ["0101", "0102", "0103", "0104", "0105", "0106", "0107", "0108", "0109", "0110", "0111", "0112", "0113", "0114", "0115", "0116", "0117", "0118", "0119", "0120", "0121", "0122", "0123", "0124", "0125", "0126", "0127", "0128", "0129", "0130", "0131", "0201", "0202", "0203", "0204", "0205", "0206", "0207", "0208", "0209", "0210", "0211", "0212", "0213", "0214", "0215", "0216", "0217", "0218", "0219", "0220", "0221", "0222", "0223", "0224", "0225", "0226", "0227", "0228", "0301", "0302", "0303", "0304", "0305", "0306", "0307", "0308", "0309", "0310", "0311", "0312", "0313", "0314", "0315", "0316", "0317", "0318", "0319", "0320", "0321", "0322", "0323", "0324", "0325", "0326", "0327", "0328", "0329", "0330","0331", "0401", "0402", "0403", "0404", "0405", "0406", "0407", "0408", "0409", "0410", "0411", "0412", "0413", "0414", "0415", "0416", "0417", "0418", "0419", "0420", "0421", "0422", "0423", "0424", "0425", "0426", "0427", "0428", "0429", "0430", "0501", "0502", "0503", "0504", "0505", "0506", "0507", "0508", "0509", "0510", "0511", "0512", "0513", "0514", "0515", "0516", "0517", "0518", "0519", "0520", "0521", "0522", "0523", "0524", "0525", "0526", "0527", "0528", "0529", "0530", "0531", "0601", "0602", "0603", "0604", "0605", "0606", "0607", "0608", "0609", "0610", "0611", "0612", "0613", "0614", "0615", "0616", "0617", "0618", "0619", "0620", "0621", "0622", "0623", "0624", "0625", "0626", "0627", "0628", "0629", "0630", "0701", "0702", "0703", "0704", "0705", "0706", "0707", "0708", "0709", "0710", "0711", "0712", "0713", "0714", "0715", "0716", "0717", "0718", "0719", "0720", "0721", "0722", "0723", "0724", "0725", "0726", "0727", "0728", "0729", "0730", "0731", "0801", "0802", "0803", "0804", "0805", "0806", "0807", "0808", "0809", "0810", "0811", "0812", "0813", "0814", "0815", "0816", "0817", "0818", "0819", "0820", "0821", "0822", "0823", "0824", "0825", "0826", "0827", "0828", "0829", "0830", "0831", "0901", "0902", "0903", "0904", "0905", "0906", "0907", "0908", "0909", "0910", "0911", "0912", "0913", "0914", "0915", "0916", "0917", "0918", "0919", "0920", "0921", "0922", "0923", "0924", "0925", "0926", "0927", "0928", "0929", "0930", "1001", "1002", "1003", "1004", "1005", "1006", "1007", "1008", "1009", "1010", "1011", "1012", "1013", "1014", "1015", "1016", "1017", "1018", "1019", "1020", "1021", "1022", "1023", "1024", "1025", "1026", "1027", "1028", "1029", "1030", "1031", "1101", "1102", "1103", "1104", "1105", "1106", "1107", "1108", "1109", "1110", "1111", "1112", "1113", "1114", "1115", "1116", "1117", "1118", "1119", "1120", "1121", "1122", "1123", "1124", "1125", "1126", "1127", "1128", "1129", "1130", "1201", "1202", "1203", "1204", "1205", "1206", "1207", "1208", "1209", "1210", "1211", "1212", "1213", "1214", "1215", "1216", "1217", "1218", "1219", "1220", "1221", "1222", "1223", "1224", "1225", "1226", "1227", "1228", "1229", "1230", "1231"]

years2.each do |year|
  # city is hardcoded and needs to change in future to be variable
  year_weather = YearWeather.create(:year => year, :city => "New York")
  year_weather.temperatures = {}
  days.each_with_index do |day, i|
    data = Net::HTTP.get("api.wunderground.com", "/api/ed81498dd08a91f6/history_#{year}#{day}/q/NY/New_York.json")
    data = JSON.parse(data)
    year_weather.temperatures["#{i+1}"] = data["history"]["dailysummary"][0]["maxtempi"]
    puts "Added day #{day} for year #{year}"
  end
  year_weather.save
  sleep 0.001
end

# YearWeather.create(:year => "1953", :city => "New York", :temperatures => {"1"=>"41", "2"=>"43", "3"=>"43", "4"=>"39", "5"=>"39", "6"=>"35", "7"=>"34", "8"=>"35", "9"=>"37", "10"=>"37", "11"=>"41", "12"=>"39", "13"=>"46", "14"=>"52", "15"=>"42", "16"=>"59", "17"=>"37", "18"=>"48", "19"=>"51", "20"=>"44", "21"=>"41", "22"=>"45", "23"=>"50", "24"=>"54", "25"=>"48", "26"=>"33", "27"=>"44", "28"=>"52", "29"=>"37", "30"=>"39", "31"=>"55", "32"=>"53", "33"=>"30", "34"=>"37", "35"=>"39", "36"=>"45", "37"=>"50", "38"=>"52", "39"=>"42", "40"=>"42", "41"=>"39", "42"=>"37", "43"=>"39", "44"=>"41", "45"=>"46", "46"=>"50", "47"=>"42", "48"=>"37", "49"=>"39", "50"=>"55", "51"=>"54", "52"=>"68", "53"=>"43", "54"=>"44", "55"=>"55", "56"=>"48", "57"=>"54", "58"=>"55", "59"=>"43", "60"=>"34", "61"=>"36", "62"=>"42", "63"=>"53", "64"=>"45", "65"=>"43", "66"=>"37", "67"=>"33", "68"=>"39", "69"=>"39", "70"=>"39", "71"=>"50", "72"=>"59", "73"=>"68", "74"=>"54", "75"=>"55", "76"=>"51", "77"=>"50", "78"=>"48", "79"=>"50", "80"=>"53", "81"=>"55", "82"=>"64", "83"=>"57", "84"=>"52", "85"=>"50", "86"=>"51", "87"=>"54", "88"=>"55", "89"=>"48", "90"=>"62", "91"=>"57", "92"=>"59", "93"=>"64", "94"=>"62", "95"=>"60", "96"=>"57", "97"=>"52", "98"=>"60", "99"=>"60", "100"=>"54", "101"=>"64", "102"=>"55", "103"=>"50", "104"=>"46", "105"=>"62", "106"=>"55", "107"=>"60", "108"=>"46", "109"=>"45", "110"=>"46", "111"=>"48", "112"=>"66", "113"=>"75", "114"=>"71", "115"=>"73", "116"=>"75", "117"=>"61", "118"=>"59", "119"=>"64", "120"=>"63", "121"=>"55", "122"=>"51", "123"=>"50", "124"=>"73", "125"=>"68", "126"=>"70", "127"=>"71", "128"=>"77", "129"=>"72", "130"=>"84", "131"=>"95", "132"=>"78", "133"=>"75", "134"=>"72", "135"=>"70", "136"=>"72", "137"=>"75", "138"=>"82", "139"=>"72", "140"=>"80", "141"=>"71", "142"=>"79", "143"=>"75", "144"=>"73", "145"=>"73", "146"=>"63", "147"=>"69", "148"=>"64", "149"=>"69", "150"=>"60", "151"=>"61", "152"=>"73", "153"=>"77", "154"=>"77", "155"=>"82", "156"=>"90", "157"=>"93", "158"=>"79", "159"=>"78", "160"=>"89", "161"=>"79", "162"=>"75", "163"=>"70", "164"=>"64", "165"=>"66", "166"=>"82", "167"=>"84", "168"=>"77", "169"=>"80", "170"=>"86", "171"=>"96", "172"=>"95", "173"=>"88", "174"=>"86", "175"=>"81", "176"=>"78", "177"=>"93", "178"=>"90", "179"=>"84", "180"=>"87", "181"=>"91", "182"=>"93", "183"=>"91", "184"=>"86", "185"=>"82", "186"=>"82", "187"=>"80", "188"=>"87", "189"=>"84", "190"=>"80", "191"=>"78", "192"=>"84", "193"=>"80", "194"=>"81", "195"=>"80", "196"=>"91", "197"=>"93", "198"=>"97", "199"=>"98", "200"=>"82", "201"=>"86", "202"=>"90", "203"=>"84", "204"=>"73", "205"=>"80", "206"=>"78", "207"=>"82", "208"=>"90", "209"=>"89", "210"=>"88", "211"=>"91", "212"=>"87", "213"=>"82", "214"=>"75", "215"=>"78", "216"=>"75", "217"=>"88", "218"=>"82", "219"=>"75", "220"=>"82", "221"=>"75", "222"=>"81", "223"=>"82", "224"=>"87", "225"=>"84", "226"=>"73", "227"=>"89", "228"=>"86", "229"=>"73", "230"=>"79", "231"=>"78", "232"=>"78", "233"=>"75", "234"=>"81", "235"=>"84", "236"=>"90", "237"=>"90", "238"=>"90", "239"=>"93", "240"=>"98", "241"=>"98", "242"=>"98", "243"=>"100", "244"=>"93", "245"=>"102", "246"=>"91", "247"=>"88", "248"=>"84", "249"=>"79", "250"=>"80", "251"=>"78", "252"=>"78", "253"=>"80", "254"=>"79", "255"=>"73", "256"=>"68", "257"=>"68", "258"=>"75", "259"=>"80", "260"=>"72", "261"=>"73", "262"=>"73", "263"=>"79", "264"=>"82", "265"=>"66", "266"=>"66", "267"=>"68", "268"=>"69", "269"=>"78", "270"=>"73", "271"=>"78", "272"=>"82", "273"=>"73", "274"=>"80", "275"=>"78", "276"=>"80", "277"=>"77", "278"=>"66", "279"=>"57", "280"=>"55", "281"=>"61", "282"=>"64", "283"=>"69", "284"=>"66", "285"=>"68", "286"=>"63", "287"=>"66", "288"=>"72", "289"=>"75", "290"=>"77", "291"=>"73", "292"=>"72", "293"=>"78", "294"=>"66", "295"=>"61", "296"=>"68", "297"=>"71", "298"=>"61", "299"=>"68", "300"=>"64", "301"=>"69", "302"=>"63", "303"=>"63", "304"=>"66", "305"=>"70", "306"=>"70", "307"=>"72", "308"=>"63", "309"=>"46", "310"=>"39", "311"=>"46", "312"=>"48", "313"=>"55", "314"=>"52", "315"=>"55", "316"=>"55", "317"=>"52", "318"=>"45", "319"=>"62", "320"=>"62", "321"=>"72", "322"=>"72", "323"=>"70", "324"=>"70", "325"=>"54", "326"=>"66", "327"=>"62", "328"=>"57", "329"=>"57", "330"=>"48", "331"=>"46", "332"=>"44", "333"=>"44", "334"=>"48", "335"=>"43", "336"=>"48", "337"=>"57", "338"=>"57", "339"=>"59", "340"=>"60", "341"=>"60", "342"=>"55", "343"=>"59", "344"=>"60", "345"=>"50", "346"=>"50", "347"=>"48", "348"=>"54", "349"=>"46", "350"=>"37", "351"=>"27", "352"=>"28", "353"=>"34", "354"=>"45", "355"=>"48", "356"=>"52", "357"=>"52", "358"=>"30", "359"=>"45", "360"=>"45", "361"=>"39", "362"=>"46", "363"=>"46", "364"=>"46", "365"=>"39"})
# YearWeather.create(:year => "1973", :city => "New York", :temperatures => {"1"=>"59", "2"=>"43", "3"=>"37", "4"=>"48", "5"=>"42", "6"=>"33", "7"=>"21", "8"=>"18", "9"=>"26", "10"=>"30", "11"=>"32", "12"=>"30", "13"=>"34", "14"=>"37", "15"=>"43", "16"=>"48", "17"=>"59", "18"=>"64", "19"=>"55", "20"=>"50", "21"=>"39", "22"=>"57", "23"=>"57", "24"=>"43", "25"=>"43", "26"=>"52", "27"=>"43", "28"=>"41", "29"=>"36", "30"=>"26", "31"=>"26", "32"=>"34", "33"=>"57", "34"=>"48", "35"=>"46", "36"=>"50", "37"=>"39", "38"=>"41", "39"=>"42", "40"=>"30", "41"=>"27", "42"=>"25", "43"=>"33", "44"=>"41", "45"=>"43", "46"=>"45", "47"=>"36", "48"=>"21", "49"=>"33", "50"=>"41", "51"=>"48", "52"=>"45", "53"=>"43", "54"=>"37", "55"=>"37", "56"=>"41", "57"=>"37", "58"=>"30", "59"=>"43", "60"=>"51", "61"=>"61", "62"=>"48", "63"=>"57", "64"=>"54", "65"=>"43", "66"=>"45", "67"=>"61", "68"=>"63", "69"=>"48", "70"=>"43", "71"=>"61", "72"=>"63", "73"=>"46", "74"=>"48", "75"=>"64", "76"=>"59", "77"=>"37", "78"=>"43", "79"=>"48", "80"=>"43", "81"=>"39", "82"=>"54", "83"=>"64", "84"=>"57", "85"=>"53", "86"=>"55", "87"=>"50", "88"=>"51", "89"=>"50", "90"=>"60", "91"=>"51", "92"=>"53", "93"=>"53", "94"=>"46", "95"=>"53", "96"=>"60", "97"=>"66", "98"=>"50", "99"=>"55", "100"=>"53", "101"=>"46", "102"=>"46", "103"=>"46", "104"=>"55", "105"=>"63", "106"=>"73", "107"=>"66", "108"=>"73", "109"=>"77", "110"=>"64", "111"=>"64", "112"=>"84", "113"=>"79", "114"=>"71", "115"=>"64", "116"=>"52", "117"=>"55", "118"=>"55", "119"=>"59", "120"=>"66", "121"=>"68", "122"=>"71", "123"=>"75", "124"=>"71", "125"=>"55", "126"=>"66", "127"=>"69", "128"=>"57", "129"=>"59", "130"=>"70", "131"=>"75", "132"=>"69", "133"=>"66", "134"=>"70", "135"=>"57", "136"=>"66", "137"=>"66", "138"=>"59", "139"=>"69", "140"=>"62", "141"=>"55", "142"=>"75", "143"=>"60", "144"=>"60", "145"=>"55", "146"=>"59", "147"=>"57", "148"=>"69", "149"=>"81", "150"=>"79", "151"=>"77", "152"=>"79", "153"=>"78", "154"=>"71", "155"=>"84", "156"=>"87", "157"=>"79", "158"=>"82", "159"=>"87", "160"=>"90", "161"=>"89", "162"=>"93", "163"=>"91", "164"=>"84", "165"=>"82", "166"=>"82", "167"=>"75", "168"=>"73", "169"=>"63", "170"=>"72", "171"=>"80", "172"=>"77", "173"=>"73", "174"=>"75", "175"=>"79", "176"=>"75", "177"=>"79", "178"=>"73", "179"=>"78", "180"=>"73", "181"=>"80", "182"=>"86", "183"=>"84", "184"=>"82", "185"=>"84", "186"=>"86", "187"=>"82", "188"=>"89", "189"=>"91", "190"=>"91", "191"=>"87", "192"=>"84", "193"=>"73", "194"=>"78", "195"=>"90", "196"=>"80", "197"=>"84", "198"=>"81", "199"=>"87", "200"=>"86", "201"=>"87", "202"=>"73", "203"=>"84", "204"=>"86", "205"=>"87", "206"=>"84", "207"=>"81", "208"=>"86", "209"=>"87", "210"=>"88", "211"=>"84", "212"=>"86", "213"=>"81", "214"=>"75", "215"=>"81", "216"=>"87", "217"=>"87", "218"=>"88", "219"=>"88", "220"=>"88", "221"=>"90", "222"=>"91", "223"=>"84", "224"=>"84", "225"=>"84", "226"=>"78", "227"=>"77", "228"=>"75", "229"=>"77", "230"=>"75", "231"=>"80", "232"=>"78", "233"=>"78", "234"=>"73", "235"=>"75", "236"=>"80", "237"=>"81", "238"=>"88", "239"=>"87", "240"=>"98", "241"=>"93", "242"=>"98", "243"=>"91", "244"=>"91", "245"=>"93", "246"=>"96", "247"=>"91", "248"=>"87", "249"=>"82", "250"=>"81", "251"=>"79", "252"=>"73", "253"=>"73", "254"=>"82", "255"=>"75", "256"=>"78", "257"=>"68", "258"=>"69", "259"=>"78", "260"=>"66", "261"=>"77", "262"=>"70", "263"=>"73", "264"=>"66", "265"=>"70", "266"=>"82", "267"=>"66", "268"=>"61", "269"=>"70", "270"=>"77", "271"=>"75", "272"=>"75", "273"=>"70", "274"=>"72", "275"=>"72", "276"=>"78", "277"=>"80", "278"=>"78", "279"=>"72", "280"=>"69", "281"=>"72", "282"=>"68", "283"=>"73", "284"=>"64", "285"=>"70", "286"=>"72", "287"=>"72", "288"=>"73", "289"=>"63", "290"=>"59", "291"=>"57", "292"=>"57", "293"=>"64", "294"=>"61", "295"=>"66", "296"=>"69", "297"=>"73", "298"=>"66", "299"=>"72", "300"=>"64", "301"=>"53", "302"=>"61", "303"=>"57", "304"=>"61", "305"=>"57", "306"=>"68", "307"=>"59", "308"=>"51", "309"=>"46", "310"=>"42", "311"=>"46", "312"=>"52", "313"=>"48", "314"=>"39", "315"=>"44", "316"=>"48", "317"=>"57", "318"=>"70", "319"=>"73", "320"=>"66", "321"=>"43", "322"=>"45", "323"=>"52", "324"=>"46", "325"=>"52", "326"=>"64", "327"=>"63", "328"=>"55", "329"=>"64", "330"=>"45", "331"=>"53", "332"=>"66", "333"=>"53", "334"=>"53", "335"=>"45", "336"=>"39", "337"=>"52", "338"=>"63", "339"=>"61", "340"=>"62", "341"=>"45", "342"=>"39", "343"=>"55", "344"=>"48", "345"=>"43", "346"=>"37", "347"=>"46", "348"=>"52", "349"=>"36", "350"=>"32", "351"=>"30", "352"=>"25", "353"=>"23", "354"=>"52", "355"=>"55", "356"=>"30", "357"=>"41", "358"=>"33", "359"=>"43", "360"=>"54", "361"=>"61", "362"=>"48", "363"=>"48", "364"=>"48", "365"=>"36"})
# YearWeather.create(:year => "1993", :city => "New York", :temperatures => {"1"=>"53", "2"=>"35", "3"=>"42", "4"=>"63", "5"=>"63", "6"=>"41", "7"=>"44", "8"=>"42", "9"=>"37", "10"=>"28", "11"=>"34", "12"=>"37", "13"=>"39", "14"=>"37", "15"=>"37", "16"=>"37", "17"=>"39", "18"=>"37", "19"=>"33", "20"=>"42", "21"=>"44", "22"=>"52", "23"=>"45", "24"=>"52", "25"=>"44", "26"=>"36", "27"=>"42", "28"=>"39", "29"=>"41", "30"=>"36", "31"=>"46", "32"=>"43", "33"=>"27", "34"=>"50", "35"=>"44", "36"=>"54", "37"=>"46", "38"=>"32", "39"=>"41", "40"=>"35", "41"=>"50", "42"=>"42", "43"=>"34", "44"=>"37", "45"=>"37", "46"=>"39", "47"=>"48", "48"=>"44", "49"=>"30", "50"=>"24", "51"=>"30", "52"=>"33", "53"=>"41", "54"=>"37", "55"=>"26", "56"=>"27", "57"=>"26", "58"=>"34", "59"=>"34", "60"=>"41", "61"=>"48", "62"=>"46", "63"=>"37", "64"=>"0", "65"=>"41", "66"=>"48", "67"=>"50", "68"=>"45", "69"=>"39", "70"=>"37", "71"=>"37", "72"=>"39", "73"=>"37", "74"=>"28", "75"=>"39", "76"=>"45", "77"=>"27", "78"=>"30", "79"=>"37", "80"=>"45", "81"=>"46", "82"=>"43", "83"=>"39", "84"=>"48", "85"=>"61", "86"=>"55", "87"=>"50", "88"=>"53", "89"=>"51", "90"=>"63", "91"=>"48", "92"=>"39", "93"=>"44", "94"=>"44", "95"=>"55", "96"=>"51", "97"=>"60", "98"=>"63", "99"=>"60", "100"=>"64", "101"=>"60", "102"=>"53", "103"=>"59", "104"=>"61", "105"=>"55", "106"=>"61", "107"=>"62", "108"=>"59", "109"=>"75", "110"=>"64", "111"=>"71", "112"=>"55", "113"=>"59", "114"=>"68", "115"=>"70", "116"=>"66", "117"=>"59", "118"=>"64", "119"=>"73", "120"=>"73", "121"=>"75", "122"=>"72", "123"=>"61", "124"=>"63", "125"=>"68", "126"=>"77", "127"=>"73", "128"=>"70", "129"=>"87", "130"=>"75", "131"=>"90", "132"=>"86", "133"=>"73", "134"=>"66", "135"=>"71", "136"=>"75", "137"=>"71", "138"=>"71", "139"=>"57", "140"=>"57", "141"=>"68", "142"=>"70", "143"=>"75", "144"=>"80", "145"=>"87", "146"=>"75", "147"=>"72", "148"=>"75", "149"=>"79", "150"=>"75", "151"=>"69", "152"=>"71", "153"=>"70", "154"=>"73", "155"=>"72", "156"=>"64", "157"=>"66", "158"=>"78", "159"=>"80", "160"=>"89", "161"=>"89", "162"=>"80", "163"=>"75", "164"=>"79", "165"=>"82", "166"=>"80", "167"=>"82", "168"=>"84", "169"=>"87", "170"=>"91", "171"=>"79", "172"=>"84", "173"=>"86", "174"=>"80", "175"=>"86", "176"=>"84", "177"=>"87", "178"=>"82", "179"=>"91", "180"=>"82", "181"=>"84", "182"=>"82", "183"=>"69", "184"=>"82", "185"=>"91", "186"=>"87", "187"=>"84", "188"=>"97", "189"=>"99", "190"=>"98", "191"=>"99", "192"=>"93", "193"=>"91", "194"=>"91", "195"=>"90", "196"=>"87", "197"=>"84", "198"=>"84", "199"=>"88", "200"=>"75", "201"=>"90", "202"=>"84", "203"=>"82", "204"=>"84", "205"=>"88", "206"=>"87", "207"=>"77", "208"=>"88", "209"=>"93", "210"=>"91", "211"=>"88", "212"=>"86", "213"=>"88", "214"=>"91", "215"=>"91", "216"=>"93", "217"=>"82", "218"=>"73", "219"=>"73", "220"=>"82", "221"=>"80", "222"=>"82", "223"=>"81", "224"=>"75", "225"=>"82", "226"=>"84", "227"=>"89", "228"=>"82", "229"=>"79", "230"=>"75", "231"=>"82", "232"=>"82", "233"=>"80", "234"=>"80", "235"=>"82", "236"=>"82", "237"=>"91", "238"=>"91", "239"=>"93", "240"=>"95", "241"=>"84", "242"=>"84", "243"=>"84", "244"=>"89", "245"=>"77", "246"=>"95", "247"=>"82", "248"=>"84", "249"=>"84", "250"=>"75", "251"=>"70", "252"=>"78", "253"=>"80", "254"=>"69", "255"=>"73", "256"=>"84", "257"=>"84", "258"=>"91", "259"=>"71", "260"=>"66", "261"=>"66", "262"=>"71", "263"=>"63", "264"=>"63", "265"=>"63", "266"=>"72", "267"=>"71", "268"=>"73", "269"=>"80", "270"=>"75", "271"=>"66", "272"=>"63", "273"=>"57", "274"=>"62", "275"=>"71", "276"=>"64", "277"=>"73", "278"=>"68", "279"=>"64", "280"=>"73", "281"=>"73", "282"=>"79", "283"=>"59", "284"=>"52", "285"=>"55", "286"=>"54", "287"=>"53", "288"=>"66", "289"=>"66", "290"=>"66", "291"=>"69", "292"=>"61", "293"=>"55", "294"=>"68", "295"=>"61", "296"=>"57", "297"=>"66", "298"=>"71", "299"=>"57", "300"=>"62", "301"=>"57", "302"=>"64", "303"=>"57", "304"=>"48", "305"=>"52", "306"=>"54", "307"=>"50", "308"=>"57", "309"=>"61", "310"=>"62", "311"=>"45", "312"=>"51", "313"=>"52", "314"=>"54", "315"=>"57", "316"=>"61", "317"=>"57", "318"=>"71", "319"=>"79", "320"=>"57", "321"=>"63", "322"=>"60", "323"=>"57", "324"=>"54", "325"=>"48", "326"=>"57", "327"=>"54", "328"=>"57", "329"=>"39", "330"=>"41", "331"=>"57", "332"=>"62", "333"=>"48", "334"=>"45", "335"=>"43", "336"=>"51", "337"=>"55", "338"=>"54", "339"=>"55", "340"=>"48", "341"=>"50", "342"=>"50", "343"=>"50", "344"=>"54", "345"=>"52", "346"=>"37", "347"=>"48", "348"=>"48", "349"=>"48", "350"=>"44", "351"=>"41", "352"=>"43", "353"=>"44", "354"=>"46", "355"=>"57", "356"=>"39", "357"=>"37", "358"=>"37", "359"=>"35", "360"=>"33", "361"=>"21", "362"=>"25", "363"=>"27", "364"=>"26", "365"=>"32"})
# YearWeather.create(:year => "2013", :city => "New York", :temperatures => {"1"=>"40", "2"=>"33", "3"=>"32", "4"=>"37", "5"=>"42", "6"=>"46", "7"=>"45", "8"=>"48", "9"=>"49", "10"=>"47", "11"=>"46", "12"=>"47", "13"=>"50", "14"=>"56", "15"=>"38", "16"=>"37", "17"=>"43", "18"=>"35", "19"=>"51", "20"=>"53", "21"=>"32", "22"=>"27", "23"=>"20", "24"=>"22", "25"=>"24", "26"=>"27", "27"=>"34", "28"=>"36", "29"=>"49", "30"=>"59", "31"=>"61", "32"=>"31", "33"=>"29", "34"=>"30", "35"=>"30", "36"=>"32", "37"=>"39", "38"=>"32", "39"=>"34", "40"=>"32", "41"=>"36", "42"=>"45", "43"=>"44", "44"=>"44", "45"=>"46", "46"=>"55", "47"=>"41", "48"=>"32", "49"=>"35", "50"=>"49", "51"=>"38", "52"=>"34", "53"=>"38", "54"=>"42", "55"=>"47", "56"=>"45", "57"=>"44", "58"=>"47", "59"=>"51", "60"=>"45", "61"=>"40", "62"=>"40", "63"=>"42", "64"=>"49", "65"=>"42", "66"=>"38", "67"=>"42", "68"=>"55", "69"=>"50", "70"=>"54", "71"=>"57", "72"=>"52", "73"=>"41", "74"=>"47", "75"=>"41", "76"=>"38", "77"=>"35", "78"=>"43", "79"=>"45", "80"=>"40", "81"=>"41", "82"=>"46", "83"=>"47", "84"=>"40", "85"=>"53", "86"=>"53", "87"=>"51", "88"=>"55", "89"=>"59", "90"=>"54", "91"=>"62", "92"=>"43", "93"=>"46", "94"=>"53", "95"=>"64", "96"=>"52", "97"=>"55", "98"=>"73", "99"=>"82", "100"=>"74", "101"=>"60", "102"=>"47", "103"=>"58", "104"=>"57", "105"=>"59", "106"=>"63", "107"=>"71", "108"=>"59", "109"=>"71", "110"=>"60", "111"=>"55", "112"=>"55", "113"=>"53", "114"=>"69", "115"=>"66", "116"=>"67", "117"=>"71", "118"=>"69", "119"=>"57", "120"=>"68", "121"=>"69", "122"=>"72", "123"=>"66", "124"=>"69", "125"=>"64", "126"=>"69", "127"=>"74", "128"=>"63", "129"=>"68", "130"=>"79", "131"=>"70", "132"=>"70", "133"=>"58", "134"=>"61", "135"=>"69", "136"=>"79", "137"=>"72", "138"=>"65", "139"=>"59", "140"=>"79", "141"=>"86", "142"=>"78", "143"=>"80", "144"=>"65", "145"=>"54", "146"=>"66", "147"=>"73", "148"=>"68", "149"=>"82", "150"=>"90", "151"=>"90", "152"=>"90", "153"=>"88", "154"=>"78", "155"=>"75", "156"=>"74", "157"=>"70", "158"=>"63", "159"=>"77", "160"=>"80", "161"=>"70", "162"=>"80", "163"=>"76", "164"=>"69", "165"=>"72", "166"=>"80", "167"=>"80", "168"=>"84", "169"=>"84", "170"=>"77", "171"=>"80", "172"=>"82", "173"=>"84", "174"=>"88", "175"=>"92", "176"=>"91", "177"=>"85", "178"=>"86", "179"=>"85", "180"=>"83", "181"=>"86", "182"=>"77", "183"=>"82", "184"=>"83", "185"=>"87", "186"=>"90", "187"=>"92", "188"=>"92", "189"=>"89", "190"=>"88", "191"=>"85", "192"=>"84", "193"=>"77", "194"=>"81", "195"=>"90", "196"=>"94", "197"=>"94", "198"=>"97", "199"=>"98", "200"=>"96", "201"=>"93", "202"=>"89", "203"=>"86", "204"=>"87", "205"=>"83", "206"=>"68", "207"=>"83", "208"=>"82", "209"=>"78", "210"=>"85", "211"=>"83", "212"=>"83", "213"=>"76", "214"=>"83", "215"=>"78", "216"=>"80", "217"=>"78", "218"=>"82", "219"=>"80", "220"=>"81", "221"=>"85", "222"=>"83", "223"=>"81", "224"=>"82", "225"=>"77", "226"=>"74", "227"=>"78", "228"=>"82", "229"=>"84", "230"=>"76", "231"=>"79", "232"=>"88", "233"=>"90", "234"=>"78", "235"=>"82", "236"=>"80", "237"=>"83", "238"=>"84", "239"=>"87", "240"=>"86", "241"=>"80", "242"=>"85", "243"=>"86", "244"=>"84", "245"=>"82", "246"=>"82", "247"=>"82", "248"=>"80", "249"=>"72", "250"=>"80", "251"=>"83", "252"=>"73", "253"=>"87", "254"=>"96", "255"=>"87", "256"=>"77", "257"=>"67", "258"=>"73", "259"=>"73", "260"=>"65", "261"=>"72", "262"=>"78", "263"=>"79", "264"=>"77", "265"=>"69", "266"=>"66", "267"=>"73", "268"=>"73", "269"=>"71", "270"=>"69", "271"=>"73", "272"=>"72", "273"=>"75", "274"=>"82", "275"=>"83", "276"=>"78", "277"=>"86", "278"=>"76", "279"=>"70", "280"=>"76", "281"=>"67", "282"=>"62", "283"=>"65", "284"=>"68", "285"=>"72", "286"=>"65", "287"=>"66", "288"=>"72", "289"=>"67", "290"=>"73", "291"=>"68", "292"=>"64", "293"=>"63", "294"=>"66", "295"=>"67", "296"=>"55", "297"=>"54", "298"=>"53", "299"=>"55", "300"=>"58", "301"=>"61", "302"=>"56", "303"=>"60", "304"=>"66", "305"=>"70", "306"=>"68", "307"=>"55", "308"=>"46", "309"=>"55", "310"=>"61", "311"=>"64", "312"=>"50", "313"=>"50", "314"=>"61", "315"=>"53", "316"=>"52", "317"=>"39", "318"=>"52", "319"=>"57", "320"=>"60", "321"=>"60", "322"=>"65", "323"=>"51", "324"=>"44", "325"=>"52", "326"=>"57", "327"=>"54", "328"=>"30", "329"=>"35", "330"=>"47", "331"=>"62", "332"=>"35", "333"=>"39", "334"=>"39", "335"=>"49", "336"=>"49", "337"=>"53", "338"=>"52", "339"=>"60", "340"=>"62", "341"=>"41", "342"=>"33", "343"=>"39", "344"=>"37", "345"=>"33", "346"=>"30", "347"=>"35", "348"=>"34", "349"=>"40", "350"=>"33", "351"=>"32", "352"=>"37", "353"=>"47", "354"=>"53", "355"=>"65", "356"=>"71", "357"=>"64", "358"=>"42", "359"=>"31", "360"=>"36", "361"=>"40", "362"=>"55", "363"=>"48", "364"=>"45", "365"=>"32"})