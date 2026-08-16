#
#
#
#
#
#
#
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
#
#
#
library(tidyverse)
library(here)
library(fs)
library(knitr)
library(techme)
library(DT)

safe_dir_tree <- function(path, ...) {
  if (!fs::dir_exists(path)) {
    cat("*目录不存在：*", path, "\n\n")
    return(invisible(NULL))
  }
  fs::dir_tree(path, ...)
}
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here::here("data-raw/public-site/nbs-RD-bulletin")
safe_dir_tree(dir_tar, recurse = FALSE)
#
#
#
#
#
techme::RDIntense %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/data-tidy/public-site/most-SKL")
safe_dir_tree(dir_tar, recurse = FALSE)
#
#
#
#
#
techme::PubSKLMost %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
techme::PubSKLMost |>
  filter(province == "陕西") |>
  DT::datatable(
    caption = "陕西省国家重点实验室",
    rownames = FALSE,
    options = list(
      dom = "tip",
      pageLength = 12
    )
  )

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- "d:/github/web-scrape/proj/torch-innocom"
safe_dir_tree(dir_tar, recurse = FALSE)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here::here("data-raw/public-site/most-jcs-open-share/")
safe_dir_tree(dir_tar, recurse = FALSE)
#
#
#
#
#
#
#
#
#
#
#
#
techme::PubOpenShare %>%
  head(100) %>%
  DT::datatable(
    rownames = TRUE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here::here("data-raw/public-site/agri-park")
safe_dir_tree(dir_tar, recurse = FALSE)
#
#
#
#
#
#
#
techme::PubAgriParkList %>%
  #head(20) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
techme::PubAgriParkCheck %>%
  #head(20) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
techme::PubAgriParkEval %>%
  #head(20) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("topic/public-site/moa-keylab")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here::here("data-raw/public-site/moa-machine-county")
safe_dir_tree(dir_tar)
#
#
#
#
#
techme::PubMachineCounty %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| echo: true
tbl_id <- tribble(
  ~id, ~cat,
  1, "农作物", # 实际上id取值小于665，都可以设定为该类别
  666, "养殖",
  777, "设施种植"#,
  #888,
)
tbl_id
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/public-site/moa-agri-system")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
techme::PubCars %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
names(techme::PubCars)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("topic/public-site/moa-agri-alliance")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/public-site/moa-firm-leader")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
#
techme::PubFirmLeader %>%
  slice_sample(n = 10, by = batch ) %>%
  DT::datatable(
    rownames = TRUE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here::here("data-raw/public-site/moa-industry-convergence")
safe_dir_tree(dir_tar, recurse = FALSE)
#
#
#
#
#
#
#
#
#
#
techme::PubConvergencePark %>%
  #head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
techme::PubConvergenceAffirm %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
techme::PubConvergenceCluster %>%
  #ead(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
techme::PubConvergenceTown %>%
  #head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
data_names <- c(
  "park-setup","cluster-setup", "town-setup",
  "park-affirm"  # 产业园认定
)
data_names
#
#
#
#
#
use_list <- c(
  "PubConvergencePark",
  "PubConvergenceCluster",
  "PubConvergenceTown",
  "PubConvergenceAffirm"  # 产业园认定
)
use_list
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/public-site/moa-agrimodern-zone")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
techme::PubAgrimodernZone %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/public-site/moa-freshkeep-county/")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
techme::PubFreshKeepCounty %>%
  #head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
(use_list <- "PubFreshKeepCounty")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
(code_file <-here("report/code/chpt02-03-moa-genetic-resource.R"))
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/public-site/moa-rural-infobase/")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
techme::PubRuralInfoBase %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
(use_list <- "PubFreshKeepCounty")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
(code_file <-here("report/code/chpt02-03-moa-genetic-resource.R"))
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("topic/public-site/moa-cooperation")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("topic/public-site/moa-seed-base")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
techme::PubSeedFirm %>%
  head(100) %>%
  DT::datatable(
    rownames = TRUE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/public-site/moa-seed-firm")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
#
#
dir_tar <- here::here("data-raw/public-site/moa-seed-firm/")
safe_dir_tree(dir_tar, recurse = TRUE)
#
#
#
#
#
#
#
#
#
#
#
#
#
ptn_raw <-c(
  "玉米、鲜食、爆裂玉米", "鲜食玉米",
  "杂交玉米", "玉米种子",
  "马铃薯种薯", "杂交稻"
)
ptn_clean <-c(
  "玉米", "玉米",
  "玉米", "玉米",
  "马铃薯", "稻"
)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/public-site/moa-genetic-resource/")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
techme::PubGeneticResource %>%
  head(100) %>%
  DT::datatable(
    rownames = TRUE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
dir_tar <- here("data-raw/public-site/observe-station")
safe_dir_tree(dir_tar)
#
#
#
#
#
#
#
#
#
#
techme::PubObsStation %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
techme::PubObsStationX %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
