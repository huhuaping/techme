# R包准备----
require("rvest")
require("stringr")
require("tidyverse")
require("tidyselect")
require("openxlsx")
require(techme)
require(glue)
require(here)

# 读取公示信息----

## 2011年html名单----

### 全部名单----

# files html path
files_dir <- "html/list-year-2011.html"

# xpath for data table
css_tbl <- "body > table:nth-child(4) > tbody > tr > td > table:nth-child(2) > tbody > tr > td > table:nth-child(4) > tbody > tr > td > p:nth-child(n+8)"
Year <- 2011

tbl_raw <- read_html(files_dir, encoding = "GBK") %>%
  html_nodes(css = css_tbl) %>%
  html_text() %>%
  # str_trim(., "both")
  as_tibble() %>%
  mutate(value = str_trim(value, "both"))

num_base <- c("一", "二", "三", "四", "五", "六", "七", "八", "九")

# the html show max '五十'
num_chn <- c(
  num_base, "十",
  paste0("十", num_base), "二十",
  paste0("二十", num_base), "三十",
  paste0("三十", num_base), "四十",
  paste0("四十", num_base), "五十"
)

pattern_chn <- paste0(paste0(num_chn, "、"), collapse = "|")

ptn_area_num <- glue::glue("({paste0(num_chn,collapse='|')})(?=、)")
ptn_area_name <- glue::glue("(?<={pattern_chn})(.+)")
ptn_area_filter <- glue::glue("{paste0(num_chn,'、',collapse='|')}")

ptn_type_num <- glue::glue("(?<=（)({paste0(num_chn,collapse ='|')})(?=）)")
ptn_type_name <- glue::glue("(?<={paste0('（',num_chn,'）',collapse ='|')})(.+)")
ptn_type_filter <- glue::glue("{paste0('（',num_chn,'）',collapse ='|')}")

tbl_all <- tbl_raw %>%
  # industry area
  mutate(
    area_num = str_extract(value, ptn_area_num),
    area_name = str_extract(value, ptn_area_name)
  ) %>%
  fill(., area_num, .direction = "down") %>%
  fill(., area_name, .direction = "down") %>%
  filter(!str_detect(value, ptn_area_filter)) %>%
  # type of data
  mutate(
    type_num = str_extract(value, ptn_type_num),
    type_name = str_extract(value, ptn_type_name)
  ) %>%
  fill(., type_num, .direction = "down") %>%
  fill(., type_name, .direction = "down") %>%
  filter(!str_detect(value, ptn_type_filter)) %>%
  mutate(type_cat = str_extract(type_name, "技术研发中心|技术综合试验站")) %>%
  # chairman for industry
  mutate(chairman = str_extract(value, "(?<=首席科学家：)(.+)"))


### 表1产业体系----

#### get the chairman and institution of industry----
## chairman is unique!
id_chairman_industry <- which(!is.na(tbl_all$chairman))
## search before and next near the chairman
check <- tibble(
  index_man = id_chairman_industry,
  man = tbl_all$value[id_chairman_industry],
  inst_before = tbl_all$value[id_chairman_industry - 1],
  inst_after = tbl_all$value[id_chairman_industry + 1]
) %>%
  mutate(inst_name = ifelse(!str_detect(inst_before, "站长："),
    inst_before,
    ifelse(str_detect(inst_after, "建设依托单位："),
      inst_after,
      NA
    )
  )) %>%
  mutate(index_inst = ifelse(!str_detect(inst_before, "站长："),
    index_man - 1,
    ifelse(str_detect(inst_after, "建设依托单位："),
      index_man + 1,
      NA
    )
  )) %>%
  # nrow must be the same to `num_chn`
  mutate(
    chairman_industry = str_extract(man, "(?<=：)(.+)"),
    institution_industry = str_extract(inst_name, "(?<=：)(.+)"),
    area_num = num_chn
  )

# so we can continue next

index_filter <- c(
  check$index_man,
  check$index_inst[which(!is.na(check$index_inst))]
)

tbl_industry <- tbl_all %>%
  # match
  left_join(., select(
    check, area_num,
    chairman_industry, institution_industry
  ),
  by = "area_num"
  ) %>%
  select(-chairman) %>%
  # filter rows of chairman and institution
  .[-index_filter, ] %>%
  # filter `type_cat`
  filter(type_cat == "技术研发中心") %>%
  filter(!str_detect(value, "岗位及聘用人员："))

#### get functional research area======

tbl_func <- tbl_industry %>%
  mutate(
    func_num = str_extract(value, "(\\d{1,2})(?=、)"),
    func_name = str_extract(value, "(?<=\\d{1,2}、)(.+)")
  ) %>%
  # check sequence order of number series,totally [233 ok!]
  # tbl_func$func_num[which(!is.na(tbl_func$func_num))]
  fill(func_num) %>%
  fill(func_name) %>%
  # filter func
  filter(!str_detect(value, "\\d{1,2}、")) %>%
  mutate(func_inst = str_extract(value, "(?<=建设依托单位：)(.+)")) %>%
  # check total numbers of institution, totally [233 ok!]
  # tbl_func$func_inst[which(!is.na(tbl_func$func_inst))] %>%
  fill(func_inst) %>%
  filter(!str_detect(value, "建设依托单位：")) %>%
  # get director of func
  mutate(func_director = str_extract(value, "(?<=研究室主任：)(.+)")) %>%
  # check total numbers of director,totally [233 ok!]
  # tbl_func$func_director[which(!is.na(tbl_func$func_director))] %>%
  fill(func_director) %>%
  filter(!str_detect(value, "研究室主任：")) # %>%


#### get all researchers info =====
tbl_researcher <- tbl_func %>%
  mutate(
    researcher_area = str_extract(value, "(.+)(?=：)"),
    researcher_name = str_extract(value, "(?<=：)(.+)(?=（)"),
    researcher_inst = str_extract(value, "(?<=（)(.+)(?=）)")
  ) %>%
  select(-value) %>%
  add_column(year = Year, .before = "area_num") %>%
  add_column(index = 1:nrow(.), .before = "area_num") %>%
  # handle the chinese number
  mutate(
    area_num_eng = mgsub::mgsub(
      area_num,
      num_chn,
      str_pad(
        1:length(num_chn),
        2, "left", "0"
      )
    ),
    type_num_eng = mgsub::mgsub(
      type_num,
      num_chn,
      str_pad(
        1:length(num_chn),
        2, "left", "0"
      )
    )
  )



#### write out----
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)

tbl_sel <- tbl_researcher %>%
  select(all_of(names_sel))

xlsx_path <- "xlsx/list-industry-year-2011-wide.xlsx"
openxlsx::write.xlsx(tbl_sel, xlsx_path)



### 表2实验站----

tbl_station <- tbl_all %>%
  filter(type_cat == "技术综合试验站") %>%
  select(-chairman) %>%
  mutate(
    station_num = str_extract(value, "(\\d{1,2})(?=、)"),
    station_name = str_extract(value, "(?<=、)(.+)")
  ) %>%
  fill(station_num) %>%
  fill(station_name) %>%
  filter(!str_detect(value, "\\d{1,2}、")) %>%
  mutate(
    station_isnt = str_extract(
      value,
      "(?<=建设依托单位：)(.+)(?=；站长)"
    ),
    station_manager = str_extract(
      value,
      "(?<=站长：)(.+)"
    )
  ) %>%
  select(-value) %>%
  add_column(year = Year, .before = "area_num") %>%
  add_column(index = 1:nrow(.), .before = "area_num") %>%
  # handle the chinese number
  mutate(
    area_num_eng = mgsub::mgsub(
      area_num,
      num_chn,
      str_pad(
        1:length(num_chn),
        2, "left", "0"
      )
    ),
    type_num_eng = mgsub::mgsub(
      type_num,
      num_chn,
      str_pad(
        1:length(num_chn),
        2, "left", "0"
      )
    )
  )
# write out
xlsx_path <- "xlsx/list-site-year-2011-wide.xlsx"
openxlsx::write.xlsx(tbl_station, xlsx_path)


## 2017年xlsx名单----

Year <- 2017
# files html path
files_dir <- "html/list-year-2017.xlsx"

tbl_raw <- read.xlsx(files_dir, colNames = T, fillMergedCells = T)

names(tbl_raw)
names_eng <- c("index", "area_name", "func_name", "researcher_area", "researcher_name", "researcher_inst")
tbl_out <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_eng) %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  mutate(
    area_num_eng = NA,
    chairman_industry = NA,
    institution_industry = NA,
    func_num = NA,
    func_inst = NA,
    func_director = NA,
  )




# write out
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)

tbl_sel <- tbl_out %>%
  select(all_of(names_sel))

write.xlsx(tbl_sel, "xlsx/list-industry-year-2017-wide.xlsx")


## 2019年html名单----

# files html path
files_dir <- "html/list-year-2019.html"

# xpath for data table
xpath_tbl <- "/html/body/div[3]/div/div[2]/div/div/div/div/div/div/span/div/table"

Year <- 2019

tbl_raw <- read_html(files_dir, encoding = "UTF-8") %>%
  html_nodes(xpath = xpath_tbl) %>%
  html_table(header = T) %>%
  .[[1]] %>%
  as_tibble()

# names(tbl_raw)
names_eng <- c("index", "area_name", "func_name", "researcher_area", "researcher_name", "researcher_inst")

tbl_out <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_eng) %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  mutate(
    area_num_eng = NA,
    chairman_industry = NA,
    institution_industry = NA,
    func_num = NA,
    func_inst = NA,
    func_director = NA,
  )


# write out
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)

tbl_sel <- tbl_out %>%
  select(all_of(names_sel))

write.xlsx(tbl_sel, "xlsx/list-industry-year-2019-wide.xlsx")


## 2021年xlsx名单----

Year <- 2021
# files html path
files_dir <- "html/list-year-2021.xlsx"

tbl_raw <- read.xlsx(files_dir, colNames = T, fillMergedCells = T)

names(tbl_raw)

# target uniform columns names
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)


### 岗位科学家名单----


names_func <- c(
  "cat", "index",
  # "area_name", "func_name",
  "researcher_name", "researcher_area", "researcher_inst"
)

# knows which varialbes need to be added
sort(setdiff(names_sel, names_func))

tbl_func <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_func) %>%
  # filter 'cat'
  filter(cat == "岗位科学家") %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  # use `setdiff()` to check
  mutate(
    area_name = NA, area_num_eng = NA,
    chairman_industry = NA,
    func_director = NA, func_inst = NA, func_name = NA, func_num = NA,
    institution_industry = NA
  ) %>%
  mutate(researcher_area = mgsub::mgsub(
    researcher_area,
    c(fixed("\u00a0"), fixed("\n"), " "),
    c("", "", "")
  )) %>%
  # get 'area_name'
  mutate(area_name = str_extract(
    researcher_area,
    "(?<=（)(.+)(?=体系）)"
  )) %>%
  mutate(area_name = mgsub::mgsub(
    area_name,
    "(.+）（)",
    ""
  )) %>%
  # removed last "（）（）"
  mutate(researcher_area = str_replace(
    researcher_area,
    "(?<=）)(（.*体系）)", ""
  )) %>%
  # removed "（体系）"
  mutate(researcher_area = str_replace(
    researcher_area,
    "(（.*体系）)", ""
  ))



### 首席科学家名单----


# helper
names(tbl_raw)
sort(setdiff(names_sel, names_chairman))



names_chairman <- c(
  "cat", "index",
  # "func_name",
  # "researcher_area", "researcher_name", "researcher_inst",
  "chairman_industry", "area_name", "institution_industry"
)

tbl_chairman <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_chairman) %>%
  filter(cat == "首席科学家") %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  # use `setdiff()` to check
  mutate(
    area_num_eng = NA,
    func_name = NA, func_num = NA, func_inst = NA, func_director = NA,
    researcher_area = NA, researcher_inst = NA, researcher_name = NA
  ) %>%
  mutate(area_name = str_extract(area_name, ".+(?=体系)"))



### 合并两个名单----


# write out functional researcher list

tbl_out <- bind_rows(tbl_func, tbl_chairman) %>%
  select(all_of(names_sel))

write.xlsx(tbl_out, "xlsx/list-industry-year-2021-wide.xlsx")


## 2022年xlsx名单----

### 岗位科学家名单----
Year <- 2022
# files html path
files_dir <- "html/list-year-2022.xlsx"

tbl_raw <- read.xlsx(
  files_dir,
  sheet = 2,
  colNames = T,
  fillMergedCells = F
) %>%
  fill(`体系名称`, .direction = "down")

names(tbl_raw)

# target uniform columns names
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)



names_func <- c(
  "cat", "index",
  "area_name", # "func_name",
  "researcher_area", "researcher_name", "researcher_inst"
)

# knows which varialbes need to be added
sort(setdiff(names_sel, names_func))

tbl_func <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_func) %>%
  # filter 'cat'
  filter(cat == "岗位科学家") %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  # use `setdiff()` to check
  mutate( # area_name = NA,
    area_num_eng = NA,
    chairman_industry = NA,
    func_director = NA, func_inst = NA, func_name = NA, func_num = NA,
    institution_industry = NA
  ) %>%
  mutate(researcher_area = mgsub::mgsub(
    researcher_area,
    c(fixed("\u00a0"), fixed("\n"), " "),
    c("", "", "")
  )) %>%
  select(all_of(names_sel)) # uniform names

### 首席科学家名单----
Year <- 2022
# files html path
files_dir <- "html/list-year-2022.xlsx"

tbl_raw <- read.xlsx(
  files_dir,
  sheet = 1,
  colNames = T,
  fillMergedCells = F
)

names(tbl_raw)

# target uniform columns names
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)

names_chairman <- c(
  "cat", "index",
  # "func_name",
  # "researcher_area", "researcher_name", "researcher_inst",
  "area_name",
  "chairman_industry",
  "institution_industry"
)

# helper check names list
sort(setdiff(names_sel, names_chairman))

tbl_chairman <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_chairman) %>%
  filter(cat == "首席科学家") %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  # use `setdiff()` to check
  mutate(
    area_num_eng = NA,
    func_director = NA,
    func_inst = NA,
    func_name = NA,
    func_num = NA,
    researcher_area = NA,
    researcher_inst = NA,
    researcher_name = NA
  ) %>%
  select(all_of(names_sel)) # uniform names

### 合并两个名单----
# check two table's name
identical(
  names(tbl_func),
  names(tbl_chairman)
)

# write out functional researcher list
tbl_out <- bind_rows(
  tbl_func,
  tbl_chairman
) %>%
  # tidy
  mutate(
    researcher_inst = mgsub::mgsub(
      researcher_inst,
      c(
        fixed("\u00a0"), fixed("\n"), " ",
        "中国农业科学院西部农业研究中心"
      ),
      c(
        "", "", "",
        "中国农业科学院西部农业研究中心（新疆）"
      )
    )
  )

write.xlsx(tbl_out, "xlsx/list-industry-year-2022-wide.xlsx")


## 2023年html转xlsx名单----

Year <- 2023
# files html path
dir_path <- here("data-raw/public-site/moa-agri-system/html/")
file_path <- glue("list-year-{Year}.xlsx")
(file_tar <- glue("{dir_path}/{file_path}"))
# xpath for data table

### 岗位科学家名单----
tbl_raw <- read.xlsx(
  file_tar,
  sheet = "scientist",
  colNames = T,
  fillMergedCells = F
) # %>%
# fill(`体系名称`,.direction = "down")

# target uniform columns names
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)

names_func <- c(
  "cat", "index",
  "area_name", # "func_name",
  "researcher_area", "researcher_name", "researcher_inst"
)

# knows which varialbes need to be added
sort(setdiff(names_sel, names_func))

tbl_func <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_func) %>%
  # filter 'cat'
  filter(cat == "岗位科学家") %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  # use `setdiff()` to check
  mutate( # area_name = NA,
    area_num_eng = NA,
    chairman_industry = NA,
    func_director = NA, func_inst = NA, func_name = NA, func_num = NA,
    institution_industry = NA
  ) %>%
  mutate(researcher_area = mgsub::mgsub(
    researcher_area,
    c(fixed("\u00a0"), fixed("\n"), " "),
    c("", "", "")
  )) %>%
  select(all_of(names_sel)) # uniform names

### 首席科学家名单----
tbl_raw <- read.xlsx(
  file_tar,
  sheet = "chairman",
  colNames = T,
  fillMergedCells = F
)

names(tbl_raw)

# target uniform columns names
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)

names_chairman <- c(
  "cat", "index",
  # "func_name",
  # "researcher_area", "researcher_name", "researcher_inst",
  "area_name",
  "chairman_industry",
  "institution_industry"
)

# helper check names list
sort(setdiff(names_sel, names_chairman))

tbl_chairman <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_chairman) %>%
  filter(cat == "首席科学家") %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  # use `setdiff()` to check
  mutate(
    area_num_eng = NA,
    func_director = NA,
    func_inst = NA,
    func_name = NA,
    func_num = NA,
    researcher_area = NA,
    researcher_inst = NA,
    researcher_name = NA
  ) %>%
  select(all_of(names_sel)) # uniform names

### 合并两个名单----
# check two table's name
identical(
  names(tbl_func),
  names(tbl_chairman)
)

# write out functional researcher list
tbl_out <- bind_rows(
  tbl_func,
  tbl_chairman
) %>%
  # tidy
  mutate(
    researcher_inst = mgsub::mgsub(
      researcher_inst,
      c(
        fixed("\u00a0"), fixed("\n"), " ",
        "中国农业科学院西部农业研究中心"
      ),
      c(
        "", "", "",
        "中国农业科学院西部农业研究中心（新疆）"
      )
    )
  )

### 导出年度xlsx----

dir_path <- here("data-raw/public-site/moa-agri-system/xlsx/")
file_path <- glue("list-industry-year-{Year}-wide.xlsx")
(file_tar <- glue("{dir_path}/{file_path}"))
write.xlsx(tbl_out, file_tar)


## 2024年html转xlsx名单----

Year <- 2024
# files html path
dir_path <- here("data-raw/public-site/moa-agri-system/html/")
file_path <- glue("list-year-{Year}.xlsx")
(file_tar <- glue("{dir_path}/{file_path}"))
# xpath for data table

### 岗位科学家名单----
tbl_raw <- read.xlsx(
  file_tar,
  sheet = "scientist",
  colNames = T,
  fillMergedCells = F
) # %>%
# fill(`体系名称`,.direction = "down")

View(tbl_raw)

# target uniform columns names
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)

names_func <- c(
  "cat", "index",
  "area_name", # "func_name",
  "researcher_area", "researcher_name", "researcher_inst"
)

# knows which varialbes need to be added
sort(setdiff(names_sel, names_func))

tbl_func <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_func) %>%
  # filter 'cat'
  filter(cat == "岗位科学家") %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  # use `setdiff()` to check
  mutate( # area_name = NA,
    area_num_eng = NA,
    chairman_industry = NA,
    func_director = NA, func_inst = NA, func_name = NA, func_num = NA,
    institution_industry = NA
  ) %>%
  mutate(researcher_area = mgsub::mgsub(
    researcher_area,
    c(fixed("\u00a0"), fixed("\n"), " "),
    c("", "", "")
  )) %>%
  select(all_of(names_sel)) # uniform names

### 首席科学家名单----
tbl_raw <- read.xlsx(
  file_tar,
  sheet = "chairman",
  colNames = T,
  fillMergedCells = F
)

names(tbl_raw)

# target uniform columns names
names_sel <- c(
  "year", "index",
  "area_num_eng", "area_name",
  "chairman_industry", "institution_industry",
  "func_num", "func_name", "func_inst", "func_director",
  "researcher_area", "researcher_name", "researcher_inst"
)

names_chairman <- c(
  "cat", "index",
  # "func_name",
  # "researcher_area", "researcher_name", "researcher_inst",
  "area_name",
  "chairman_industry",
  "institution_industry"
)

# helper check names list
sort(setdiff(names_sel, names_chairman))

tbl_chairman <- tbl_raw %>%
  rename_at(vars(names(.)), ~names_chairman) %>%
  filter(cat == "首席科学家") %>%
  mutate(index = 1:nrow(.)) %>%
  add_column(year = Year, .before = "index") %>%
  # use `setdiff()` to check
  mutate(
    area_num_eng = NA,
    func_director = NA,
    func_inst = NA,
    func_name = NA,
    func_num = NA,
    researcher_area = NA,
    researcher_inst = NA,
    researcher_name = NA
  ) %>%
  select(all_of(names_sel)) # uniform names

### 合并两个名单----
# check two table's name
identical(
  names(tbl_func),
  names(tbl_chairman)
)

# write out functional researcher list
tbl_out <- bind_rows(
  tbl_func,
  tbl_chairman
) %>%
  # tidy
  mutate(
    researcher_inst = mgsub::mgsub(
      researcher_inst,
      c(
        fixed("\u00a0"), fixed("\n"), " ",
        "中国农业科学院西部农业研究中心"
      ),
      c(
        "", "", "",
        "中国农业科学院西部农业研究中心（新疆）"
      )
    )
  )

View(tbl_out)

### 导出年度xlsx----

dir_path <- here("data-raw/public-site/moa-agri-system/xlsx/")
file_path <- glue("list-industry-year-{Year}-wide.xlsx")
(file_tar <- glue("{dir_path}/{file_path}"))
write.xlsx(tbl_out, file_tar)

# 查询机构的省份信息：初步处理----

## 合并全部数据（2011-2023）----

file_dir <- "xlsx/"
file_name <- list.files(file_dir)
file_target <- file_name[which(str_detect(file_name, "list-industry-"))]
file_path <- paste0(file_dir, file_target)

read_file <- function(path) {
  df <- openxlsx::read.xlsx(path) %>%
    mutate_all(., .funs = as.character)
}

tbl_out <- tibble(url = file_path) %>%
  mutate(dt = map(url, read_file)) %>%
  select(-url) %>%
  unnest(dt) %>%
  # handle string newline
  mutate_all(.,
    .funs = str_replace,
    pattern = "\n",
    replacement = ""
  )



## 机构名称列表（唯一化处理）----

require("techme")

data("queryTianyan")
dt_match <- queryTianyan %>%
  select(name_origin, province) %>%
  rename(institution = "name_origin")

data("BasicProvince")
ptn_province <- paste0(BasicProvince$province, collapse = "|")


list_institution <- tibble(
  institution = c(
    tbl_out$institution_industry,
    tbl_out$researcher_inst
  )
) %>%
  select(institution) %>%
  unique() %>%
  filter(!is.na(institution)) %>%
  left_join(., dt_match, by = "institution") %>%
  # filter obvious province info
  mutate(
    province_raw = str_extract(
      institution, ptn_province
    )
  ) %>%
  mutate(province = ifelse(
    is.na(province),
    province_raw, province
  )) %>%
  filter(is.na(province)) %>%
  select(institution) %>%
  arrange(institution)

# check
check <- sum(is.na(list_institution$institution))
if (check > 0) stop("please check the name of institution!")

## So lucky! all institution matched province!

dir_xlsx <- "d:/github/techme/data-raw/data-tidy/hack-tianyan/ship/"
file_xlsx <- glue::glue("ship-tot{nrow(list_institution)}-{Sys.Date()}.xlsx")
path_xlsx <- paste0(dir_xlsx, file_xlsx)

openxlsx::write.xlsx(list_institution, path_xlsx)



## 在R包techme中进行天眼查----

# - 循环查询
#
# - 得到结果，并人工确认
#
# - 重新整合更新`qureyTianyan`
#
# - build 并push `techme`


# 导出到techme数据集rda----

## 准备基本参数----

dir_path <- "data-raw/public-site/moa-agri-system/xlsx/"
(files_xlsx <- list.files(here(dir_path)))


## 循环读取年度xlsx----
k <- 1 # 选择
data_names <- c("list-industry")
(type_tar <- data_names[k])
(files_target <- files_xlsx[which(str_detect(files_xlsx, type_tar))])
url_xlsx <- paste0(dir_path, "/", files_target)
years_target <- str_extract_all(files_target, "(\\d{4})") %>%
  unlist() %>%
  as.numeric(.)

tbl_read <- NULL
i <- 1
for (i in length(files_target):1) {
  tbl_tem <- read.xlsx(url_xlsx[i]) %>%
    mutate_at(
      vars(c("index"), "func_num"),
      as.numeric
    ) %>%
    mutate_at(
      vars(c(
        "chairman_industry",
        "institution_industry",
        "func_name", "area_num_eng",
        "func_inst", "func_director"
      )),
      as.character
    )
  tbl_read <- bind_rows(tbl_read, tbl_tem)
  cat(years_target[i], sep = "\n")
}

tbl_read <- tbl_read %>%
  # tidy
  mutate(
    researcher_inst = mgsub::mgsub(
      researcher_inst,
      c(
        fixed("\u00a0"), fixed("\n"), " ",
        "中国农业科学院西部农业研究中心"
      ),
      c(
        "", "", "",
        "中国农业科学院西部农业研究中心（新疆）"
      )
    )
  )


## 匹配省区信息：添加机构的省份----

### step 0/3 辅助函数----

#' Helper Function to match and get province of target institution
#'
#' @param df, data frame, contains the target institution column
#' @param target_institution, character, the column name of target institution
#' @param target_province, character, the target output column name for province variable.
#'
#' @return out
#' @export get_province_of_institution
#'
#' @examples
#' tbl_industry <- get_province_of_institution(
#'   df = tbl_read,
#'   target_institution = "institution_industry",
#'   target_province = "province_industry"
#' )
#'
get_province_of_institution <- function(
    df, target_institution, target_province) {
  # =====match data=====
  require("techme")
  data("queryTianyan")
  dt_match <- queryTianyan %>%
    select(name_origin, province) %>%
    rename(institution = "name_origin")

  data("ProvinceCity")
  dt_city <- ProvinceCity %>%
    select(city_clean, province_clean)

  ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")
  ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse = "|")

  list_exclude <- c("province_raw", "province_clean", "city_clean")

  # match and get
  out <- df %>%
    rename(institution = target_institution) %>%
    left_join(., dt_match, by = "institution") %>%
    # filter obvious province info
    mutate(province_raw = str_extract(institution, ptn_province)) %>%
    mutate(province = ifelse(is.na(province), province_raw, province)) %>%
    # match city
    mutate(city_clean = str_extract(institution, ptn_city)) %>%
    left_join(., dt_city, by = "city_clean") %>%
    mutate(province = ifelse(is.na(province), province_clean, province)) %>%
    dplyr::select(-one_of(list_exclude)) %>%
    # check here, see codes below
    rename_at(
      all_of(c("institution", "province")),
      ~ all_of(c(target_institution, target_province))
    )
  return(out)
}

### ====== step 1/3 match 'institution_industry'====

tbl_industry <- get_province_of_institution(
  df = tbl_read,
  target_institution = "institution_industry",
  target_province = "province_industry"
)

# check begin
tbl_industry %>%
  select(institution_industry, province_industry) %>%
  filter(!is.na(institution_industry), is.na(province_industry))

### ====== step 2/3 match 'func_inst'====

tbl_func <- get_province_of_institution(
  df = tbl_industry,
  target_institution = "func_inst",
  target_province = "province_func"
)

# check begin
tbl_func %>%
  select(func_inst, province_func) %>%
  filter(!is.na(func_inst), is.na(province_func))

### ====== step 3/3 match  'researcher_inst'====

tbl_researcher <- get_province_of_institution(
  df = tbl_func,
  target_institution = "researcher_inst",
  target_province = "province_researcher"
)

# check begin
tbl_researcher %>%
  select(researcher_inst, province_researcher) %>%
  filter(!is.na(researcher_inst), is.na(province_researcher))

# check all type province
noProvince <- tbl_researcher %>%
  filter(
    is.na(tbl_researcher$province_industry),
    is.na(tbl_researcher$province_func),
    is.na(tbl_researcher$province_researcher)
  ) %>%
  nrow()


### 导出到techme/data-raw/public----

use_list <- c("PubCars")
dir_path <- "D:/github/techme/data-raw/public-site/"
(data_path <- glue("{dir_path}{use_list[k]}.rda"))
tbl_out <- tbl_researcher
save(tbl_out, file = data_path)



# 在techme包项目中更新----

#### "D:/github/techme/data-raw/wfl_useData_universe.R"
# use_data()
# use_r()
# document()
