
require("here")

# read the province info
basic_province <- openxlsx::read.xlsx("data-proc/basic-province.xlsx")
levels_dry <- c("北京","天津","河北","山西","内蒙古","辽宁","吉林","黑龙江","山东","河南","西藏","陕西","甘肃","青海","宁夏","新疆")
levels_province<-c("全国","北京","天津","河北","山西","内蒙古","辽宁","吉林","黑龙江","上海","江苏","浙江","安徽","福建","江西","山东","河南","湖北","湖南","广东","广西","海南","重庆","四川","贵州","云南","西藏","陕西","甘肃","青海","宁夏","新疆")

# read the latest variables system
dir_variables <- here("data-proc","basic-vars-update.xlsx")
basic_vars <- openxlsx::read.xlsx(dir_variables) %>%
  mutate(variables= str_c(block1, block2, block3, block4, sep = "_"))


# handle the extra info
list_extra <- c("大连","青岛", "宁波", "厦门", "深圳")
list_norm <- c("辽宁", "山东","浙江", "福建", "广东")

pattern_list <- paste0("(", 
                       paste0(
                         c(levels_province, list_extra),
                         collapse = "|"),
                       ")")


