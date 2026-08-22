## code to prepare four `PubConvergencexxxx` datasets goes here
## we will maitain four datasets:
## - PubConvergencePark: 国家现代农业产业园创建名单
## - PubConvergenceCluster: 优势特色产业集群创建名单
## - PubConvergenceTown: 农业产业强镇创建名单
## - PubConvergenceAffirm: 国家现代农业产业园认定名单(单独进行公示) staying
## - PubConvergenceEval: 国家现代农业产业园绩效评估名单(单独进行公示) newcoming


source("data-raw/deps/load-dev.R")
library(here)

# ==== file path====
dir_media <- "data-raw/data-tidy/public-site/moa-industry-convergence/"
dir_fina <- "xlsx/"
# gen_dirs_vec(dir_media, dir_fina)

out_dir <- here::here(paste0(dir_media, dir_fina))
files_all <- list.files(out_dir)
# choose file pattern
## park-setup-year-\\d{4} for PubConvergencePark
## cluster-setup-year-\\d{4} for PubConvergenceCluster
## town-setup-year-\\d{4} for PubConvergenceTown
## park-affirm-year-\\d{4} for PubConvergenceParkAffirm
pattern_select <- c(
  "park-setup-year-\\d{4}",
  "cluster-setup-year-\\d{4}",
  "town-setup-year-\\d{4}",
  "park-affirm-year-\\d{4}"
  )
pattern_target <- pattern_select[1] # choose the pattern
(files_id <- which(str_detect(files_all, pattern_target)))
(files_sel <- files_all[files_id])
files_path <- paste0(out_dir, "/", files_sel)

# ====loop read====
df_use <- NULL
for (i in length(files_path):1) {
    df_tem <- openxlsx::read.xlsx(files_path[i]) # %>%
    # mutate(administrator = as.character(administrator))
    print(glue::glue("Reading file {files_sel[i]} has finished!"))
    Sys.sleep(0.1)
    df_use <- bind_rows(df_use, df_tem)
}

View(df_use)

# =====name data set=====

if (str_detect(pattern_target, "park-setup")) {
  case_name <- "PubConvergencePark"
  cat(glue::glue("Writing data set {case_name} has finished!"))
  PubConvergencePark <- df_use
  usethis::use_data(PubConvergencePark,
      overwrite = TRUE
  ) } else if (str_detect(pattern_target, "cluster-setup")) {
    case_name <- "PubConvergenceCluster"
    cat(glue::glue("Writing data set {case_name} has finished!"))
    PubConvergenceCluster <- df_use
    usethis::use_data(PubConvergenceCluster,
        overwrite = TRUE
    )
} else if (str_detect(pattern_target, "town-setup")) {
    case_name <- "PubConvergenceTown"
    cat(glue::glue("Writing data set {case_name} has finished!"))
    PubConvergenceTown <- df_use
    usethis::use_data(PubConvergenceTown,
        overwrite = TRUE
    )
} else if (str_detect(pattern_target, "park-affirm-year")) {
    case_name <- "PubConvergenceAffirm"
    cat(glue::glue("Writing data set {case_name} has finished!"))
    PubConvergenceParkAffirm <- df_use
    usethis::use_data(PubConvergenceParkAffirm,
        overwrite = TRUE
    )
}
# ====write document=====
source("data-raw/deps/load-dev.R")
use_r(paste0(case_name, ".R"))
document_dt(get(case_name)) #for new data set
document()
