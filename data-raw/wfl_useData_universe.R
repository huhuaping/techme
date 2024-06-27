# write document
require(devtools)
library(glue)
library(here)
load_all()

source("data-raw/update-yearbook/wfl_useData.R", encoding = "UTF-8")

k <- 8 # choose k
use_list <- c(
  "PubConvergencePark",
  "PubConvergenceCluster",
  "PubConvergenceTown",
  "PubConvergenceAffirm",
  "PubAgrimodernZone" ,#5
  "PubFreshKeepCounty",
  "PubRuralInfoBase",
  "PubCars"
  )

# read data
(rda_tar <- here(glue("data-raw/public-site/{use_list[k]}.rda")))
load(file = rda_tar)

(name_dt <- use_list[k]) # change here
(which_dt <- "tbl_out")  # df_use if prefered

# use data with my custom function
use_mydata(name.dt = name_dt,
          which.dt = which_dt)

use_r(glue("{use_list[k]}.R"))
# template document parameters, my custom function
assign(name_dt, tbl_out)
do.call("document_dt", list(as.name(name_dt)))
# build the formal document
document()
