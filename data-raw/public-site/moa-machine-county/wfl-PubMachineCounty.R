## code to prepare dataset family: `wfl_useData_PubMachineCounty`, `wfl_useData_PubMachineCountyCase` and `wfl_useData_PubMachineCountyResearch`

# ==== prepare ====
## load pacakge
source("data-raw/deps/load-dev.R")
source("data-raw/set-global.R")

# ==== file path====
dir_media <- "data-raw/data-tidy/public-site/moa-machine-county/"
dir_fina <- "xlsx/"
# gen_dirs_vec(dir_media, dir_fina)

out_dir <- here::here(paste0(dir_media, dir_fina))
files_all <- list.files(out_dir)
# choose file pattern
## list-year-\\d{4} for PubMachineCounty
## case-year-\\d{4}-batch\\d{2}\\.yaml for PubMachineCountyCase
pattern_select <- c("list-year-\\d{4}", "batch\\d{2}\\.xlsx")
(files_id <- which(str_detect(files_all, pattern_select[2])))
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
# PubMachineCounty <- df_use
# PubMachineCountyCase <- df_use
# PubMachineCountyResearch <- df_use
PubMachineCountyCase <- df_use
usethis::use_data(PubMachineCountyCase,
    overwrite = TRUE
)

# ====write document=====
source("data-raw/deps/load-dev.R")
use_r("PubMachineCountyCase.R")
document_dt(PubMachineCountyCase) #for new data set
document()

