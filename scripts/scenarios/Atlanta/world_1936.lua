local t = {
  custom_map = true,
  custom_scenario = true,
  id = "WW2",
  lands = {
    Undeveloped_land = {
      allies = {},
      color = { 170, 170, 170 },
      enemies = {},
      name = "undeveloped_land",
      pacts = {}
    },
    civ_0 = {
      allies = {},
      capital = 672,
      color = { 180, 15, 55 },
      enemies = {},
      name = "СССР",
      pacts = {}
    },
    civ_1 = {
      allies = {},
      capital = 526,
      color = { 185, 55, 55 },
      enemies = {},
      name = "Украина",
      pacts = {},
      vassal = "civ_0"
    },
    civ_10 = {
      allies = { "civ_11", "civ_12", "civ_13" },
      capital = 631,
      color = { 150, 75, 170 },
      enemies = {},
      name = "Канада",
      pacts = {},
      vassal = "civ_8"
    },
    civ_11 = {
      allies = { "civ_8", "civ_9", "civ_10" },
      capital = 511,
      color = { 40, 140, 240 },
      enemies = {},
      name = "Франция",
      pacts = {}
    },
    civ_12 = {
      allies = { "civ_8", "civ_9", "civ_10" },
      capital = 137,
      color = { 55, 125, 205 },
      enemies = {},
      name = "Французская Африка",
      pacts = {},
      vassal = "civ_11"
    },
    civ_13 = {
      allies = { "civ_8", "civ_9", "civ_10" },
      capital = 129,
      color = { 80, 140, 225 },
      enemies = {},
      name = "Сирия",
      pacts = {},
      vassal = "civ_11"
    },
    civ_14 = {
      allies = { "civ_20" },
      capital = 310,
      color = { 25, 155, 100 },
      enemies = {},
      name = "Италия",
      pacts = {}
    },
    civ_15 = {
      allies = { "civ_20" },
      capital = 91,
      color = { 45, 135, 95 },
      enemies = {},
      name = "Ливия",
      pacts = {},
      vassal = "civ_14"
    },
    civ_16 = {
      allies = {},
      capital = 276,
      color = { 185, 155, 80 },
      enemies = { "civ_17" },
      name = "Испания",
      pacts = {}
    },
    civ_17 = {
      allies = {},
      capital = 319,
      color = { 185, 85, 75 },
      enemies = { "civ_16" },
      name = "Франкисты",
      pacts = {}
    },
    civ_18 = {
      allies = {},
      capital = 236,
      color = { 85, 160, 55 },
      enemies = {},
      name = "Португалия",
      pacts = {}
    },
    civ_19 = {
      allies = {},
      capital = 616,
      color = { 70, 175, 115 },
      enemies = {},
      name = "Ирландия",
      pacts = {}
    },
    civ_2 = {
      allies = {},
      capital = 506,
      color = { 165, 25, 75 },
      enemies = {},
      name = "Казахстан",
      pacts = {},
      vassal = "civ_0"
    },
    civ_20 = {
      allies = { "civ_14", "civ_15" },
      capital = 612,
      color = { 75, 85, 125 },
      enemies = {},
      name = "Третий Рейх",
      pacts = {}
    },
    civ_21 = {
      allies = {},
      capital = 527,
      color = { 90, 173, 180 },
      enemies = {},
      name = "Чехословакия",
      pacts = {}
    },
    civ_22 = {
      allies = {},
      capital = 486,
      color = { 150, 180, 200 },
      enemies = {},
      name = "Австрия",
      pacts = {}
    },
    civ_23 = {
      allies = {},
      capital = 462,
      color = { 160, 0, 90 },
      enemies = {},
      name = "Швейцария",
      pacts = {}
    },
    civ_24 = {
      allies = {},
      capital = 542,
      color = { 35, 205, 150 },
      enemies = {},
      name = "Люксембург",
      pacts = {}
    },
    civ_25 = {
      allies = {},
      capital = 607,
      color = { 205, 85, 80 },
      enemies = {},
      name = "Нидерланды",
      pacts = {}
    },
    civ_26 = {
      allies = {},
      capital = 556,
      color = { 215, 170, 75 },
      enemies = {},
      name = "Бельгия",
      pacts = {}
    },
    civ_27 = {
      allies = {},
      capital = 473,
      color = { 25, 135, 120 },
      enemies = {},
      name = "Венгрия",
      pacts = {}
    },
    civ_28 = {
      allies = {},
      capital = 350,
      color = { 85, 65, 190 },
      enemies = {},
      name = "Югославия",
      pacts = {}
    },
    civ_29 = {
      allies = {},
      capital = 387,
      color = { 190, 125, 70 },
      enemies = {},
      name = "Румыния",
      pacts = {}
    },
    civ_3 = {
      allies = {},
      capital = 306,
      color = { 150, 5, 50 },
      enemies = {},
      name = "Кавказ",
      pacts = {},
      vassal = "civ_0"
    },
    civ_30 = {
      allies = {},
      capital = 313,
      color = { 100, 155, 55 },
      enemies = {},
      name = "Болгария",
      pacts = {}
    },
    civ_31 = {
      allies = {},
      capital = 282,
      color = { 125, 20, 80 },
      enemies = {},
      name = "Албания",
      pacts = {}
    },
    civ_32 = {
      allies = {},
      capital = 221,
      color = { 55, 185, 215 },
      enemies = {},
      name = "Греция",
      pacts = {}
    },
    civ_33 = {
      allies = {},
      capital = 599,
      color = { 175, 115, 155 },
      enemies = {},
      name = "Польша",
      pacts = {}
    },
    civ_34 = {
      allies = {},
      capital = 665,
      color = { 170, 90, 170 },
      enemies = {},
      name = "Данциг",
      pacts = {},
      vassal = "civ_33"
    },
    civ_35 = {
      allies = {},
      capital = 692,
      color = { 130, 185, 60 },
      enemies = {},
      name = "Литва",
      pacts = {}
    },
    civ_36 = {
      allies = {},
      capital = 713,
      color = { 140, 10, 105 },
      enemies = {},
      name = "Латвия",
      pacts = {}
    },
    civ_37 = {
      allies = {},
      capital = 747,
      color = { 50, 130, 225 },
      enemies = {},
      name = "Эстония",
      pacts = {}
    },
    civ_38 = {
      allies = {},
      capital = 687,
      color = { 170, 155, 135 },
      enemies = {},
      name = "Дания",
      pacts = {}
    },
    civ_39 = {
      allies = {},
      capital = 856,
      color = { 170, 130, 130 },
      enemies = {},
      name = "Гренландия",
      pacts = {},
      vassal = "civ_38"
    },
    civ_4 = {
      allies = {},
      capital = 249,
      color = { 160, 145, 125 },
      enemies = {},
      name = "Турция",
      pacts = {}
    },
    civ_40 = {
      allies = {},
      capital = 820,
      color = { 125, 150, 110 },
      enemies = {},
      name = "Исландия",
      pacts = {},
      vassal = "civ_38"
    },
    civ_41 = {
      allies = {},
      capital = 758,
      color = { 140, 85, 95 },
      enemies = {},
      name = "Норвегия",
      pacts = {}
    },
    civ_42 = {
      allies = {},
      capital = 776,
      color = { 160, 180, 220 },
      enemies = {},
      name = "Финляндия",
      pacts = {}
    },
    civ_43 = {
      allies = {},
      capital = 759,
      color = { 45, 155, 190 },
      enemies = {},
      name = "Швеция",
      pacts = {}
    },
    civ_44 = {
      allies = {},
      capital = 56,
      color = { 50, 145, 55 },
      enemies = {},
      name = "Мексика",
      pacts = {}
    },
    civ_45 = {
      allies = {},
      capital = 6,
      color = { 215, 135, 135 },
      enemies = {},
      name = "Гватемала",
      pacts = {}
    },
    civ_46 = {
      allies = {},
      capital = 121,
      color = { 193, 0, 83 },
      enemies = {},
      name = "Куба",
      pacts = {}
    },
    civ_47 = {
      allies = {},
      capital = 77,
      color = { 50, 180, 155 },
      enemies = {},
      name = "Гаити",
      pacts = {}
    },
    civ_48 = {
      allies = {},
      capital = 67,
      color = { 165, 125, 105 },
      enemies = {},
      name = "Доминикана",
      pacts = {}
    },
    civ_49 = {
      allies = {},
      capital = 57,
      color = { 75, 85, 205 },
      enemies = {},
      name = "Пуэрто-Рико",
      pacts = {},
      vassal = "civ_50"
    },
    civ_5 = {
      allies = {},
      capital = 175,
      color = { 65, 175, 135 },
      enemies = {},
      name = "Иран",
      pacts = {}
    },
    civ_50 = {
      allies = {},
      capital = 475,
      color = { 30, 90, 235 },
      enemies = {},
      name = "США",
      pacts = {}
    },
    civ_6 = {
      allies = {},
      capital = 134,
      color = { 130, 120, 200 },
      enemies = {},
      name = "Ирак",
      pacts = {}
    },
    civ_7 = {
      allies = {},
      capital = 31,
      color = { 120, 142, 115 },
      enemies = {},
      name = "Саудовская Аравия",
      pacts = {}
    },
    civ_8 = {
      allies = { "civ_11", "civ_12", "civ_13" },
      capital = 577,
      color = { 155, 15, 155 },
      enemies = {},
      name = "Британия",
      pacts = {}
    },
    civ_9 = {
      allies = { "civ_11", "civ_12", "civ_13" },
      capital = 62,
      color = { 140, 45, 125 },
      enemies = {},
      name = "Египет",
      pacts = {},
      vassal = "civ_8"
    }
  },
  map = "Atlanta",
  pacts_data = {},
  player_land = "Civilization",
  provinces = { {
      water = true
    }, {
      b = {},
      o = "civ_41"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_45"
    }, {
      b = {},
      o = "civ_8"
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_9"
    }, {
      b = {},
      o = "civ_9"
    }, {
      b = {},
      o = "civ_9"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_7"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_8"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_9"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_48"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_49"
    }, {
      b = {},
      o = "civ_9"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_47"
    }, {
      b = {},
      o = "civ_9"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_5"
    }, {
      b = {},
      o = "civ_48"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_47"
    }, {
      b = {},
      o = "civ_9"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_9"
    }, {
      b = {},
      o = "civ_9"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_5"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_15"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_7"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_46"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_15"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_12"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_44"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_5"
    }, {
      b = {},
      o = "civ_5"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_46"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_44"
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_46"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_5"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_46"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_13"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_18"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_6"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_5"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_11"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_13"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_5"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_13"
    }, {
      b = {},
      o = "civ_13"
    }, {
      b = {},
      o = "civ_12"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_13"
    }, {
      b = {},
      o = "civ_5"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_13"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_44"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_13"
    }, {
      b = {},
      o = "civ_5"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_6"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_13"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_13"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_12"
    }, {
      b = {},
      o = "civ_5"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_4"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_16"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_5"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_4"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_14"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_5"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_18"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_16"
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_16"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_16"
    }, {
      b = {},
      o = "civ_18"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_16"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_18"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_44"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_44"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_4"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_18"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_31"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_16"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_18"
    }, {
      water = true
    }, {
      b = {
        fortress = 5
      },
      o = "civ_16"
    }, {
      b = {},
      o = "civ_14"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_17"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_31"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_4"
    }, {
      b = {},
      o = "civ_3"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_16"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_32"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_28"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_18"
    }, {
      b = {},
      o = "civ_16"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_30"
    }, {
      b = {},
      o = "civ_31"
    }, {
      b = {},
      o = "civ_30"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_30"
    }, {
      b = {},
      o = "civ_17"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_17"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_39"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_3"
    }, {
      b = {},
      o = "civ_0"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_30"
    }, {
      b = {},
      o = "civ_16"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_30"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_28"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_30"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_11"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_29"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_29"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_28"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_14"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_28"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_28"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_28"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_14"
    }, {
      b = {},
      o = "civ_27"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {
        fortress = 5
      },
      o = "civ_23"
    }, {
      b = {
        fortress = 5
      },
      o = "civ_23"
    }, {
      b = {},
      o = "civ_27"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_27"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_2"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_27"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_22"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {
        fortress = 5
      },
      o = "civ_23"
    }, {
      b = {},
      o = "civ_22"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_2"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_22"
    }, {
      b = {},
      o = "civ_22"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_22"
    }, {
      b = {},
      o = "civ_27"
    }, {
      b = {},
      o = "civ_27"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_20"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {
        fortress = 5
      },
      o = "civ_11"
    }, {
      b = {},
      o = "civ_22"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_22"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_2"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_29"
    }, {
      b = {},
      o = "civ_2"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_11"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {
        fortress = 5
      },
      o = "civ_11"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_20"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_2"
    }, {
      b = {},
      o = "civ_24"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_26"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_21"
    }, {
      b = {},
      o = "civ_20"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_26"
    }, {
      b = {
        fortress = 5
      },
      o = "civ_8"
    }, {
      b = {},
      o = "civ_11"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_1"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {
        bank = 1,
        mint = 1
      },
      o = "civ_20"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {
        bank = 1,
        mint = 1
      },
      o = "civ_20"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_0"
    }, {
      water = true
    }, {
      b = {
        fortress = 5
      },
      o = "civ_8"
    }, {
      b = {},
      o = "civ_26"
    }, {
      b = {},
      o = "civ_26"
    }, {
      b = {
        fortress = 5
      },
      o = "civ_8"
    }, {
      b = {},
      o = "civ_25"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {
        bank = 1,
        mint = 1
      },
      o = "civ_20"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {
        bank = 1,
        mint = 1
      },
      o = "civ_20"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_19"
    }, {
      b = {
        fortress = 5
      },
      o = "civ_8"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_25"
    }, {
      b = {},
      o = "civ_25"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {
        bank = 1,
        mint = 1
      },
      o = "civ_20"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_19"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_25"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_19"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {
        bank = 1,
        mint = 1
      },
      o = "civ_20"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_19"
    }, {
      b = {
        bank = 1,
        mint = 1
      },
      o = "civ_20"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_0"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_35"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_34"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_8"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_20"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_38"
    }, {
      b = {},
      o = "civ_33"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_38"
    }, {
      b = {},
      o = "civ_50"
    }, {
      b = {},
      o = "civ_35"
    }, {
      b = {},
      o = "civ_38"
    }, {
      b = {},
      o = "civ_38"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_35"
    }, {
      b = {},
      o = "civ_35"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_8"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_0"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_36"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_36"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_36"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_38"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_36"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_37"
    }, {
      b = {},
      o = "civ_10"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_37"
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_37"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_37"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_37"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_42"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_41"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_42"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_38"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_8"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_43"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_40"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_40"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_0"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_40"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_43"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_40"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_40"
    }, {
      b = {},
      o = "civ_0"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_43"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_42"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      water = true
    }, {
      water = true
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_43"
    }, {
      b = {},
      o = "civ_39"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_39"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_42"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_42"
    }, {
      b = {},
      o = "civ_39"
    }, {
      b = {},
      o = "civ_41"
    }, {
      b = {},
      o = "civ_0"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_39"
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_41"
    }, {
      water = true
    }, {
      b = {},
      o = "civ_10"
    }, {
      b = {},
      o = "civ_39"
    }, {
      b = {},
      o = "civ_39"
    } },
  scenario_n = 2,
  technology_lvl = 13,
  year = 1936
}
return t