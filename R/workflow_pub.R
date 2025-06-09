# Declare global variables
utils::globalVariables(c(
    "index", "city_extract", "province_extract"
))

#' Query Institution Information and Match Province
#'
#' @description
#' This internal function matches institution names with their corresponding provinces
#' using two matching strategies:
#' \itemize{
#'   \item Direct matching with the `queryTianyan` dataset
#'   \item Pattern matching using province and city information from `ProvinceCity` dataset
#' }
#' @rdname workflow_pub_site
#' @details
#' The function performs the following operations:
#' \itemize{
#'   \item First attempts to match institution names with the `queryTianyan` dataset
#'   \item For unmatched records, extracts province information using regex patterns
#'   \item For remaining unmatched records, attempts to match city names and derive province
#'   \item Returns a list containing the matched data and information about unmatched records
#' }
#'
#' @param dt A data frame containing an 'institution' column with organization names
#'
#' @return A list containing:
#' \itemize{
#'   \item tbl_out: A data frame with the original data plus a new 'province' column
#'   \item tbl_unmatched: A data frame of unmatched institutions (if any)
#'   \item num_unmatched: Number of unmatched institutions
#' }
#'
#' @importFrom dplyr left_join select filter arrange mutate
#' @importFrom stringr str_extract
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # Example usage
#' dt <- data.frame(institution = c("Example Corp", "Test Company"))
#' result <- wfl.queryInstituton(dt)
#' }
wfl.queryInstituton <- function(dt) {
    # Input validation
    if (!is.data.frame(dt)) {
        stop("Input 'dt' must be a data frame")
    }

    if (!"institution" %in% names(dt)) {
        stop("Input data frame must contain an 'institution' column")
    }

    # Load required data
    utils::data("queryTianyan", package = "techme", envir = environment())
    utils::data("ProvinceCity", package = "techme", envir = environment())

    # Prepare matching data from queryTianyan
    dt_match <- queryTianyan %>%
        select(name_origin, province) %>%
        rename(institution = "name_origin")

    # Perform matching according to queryTianyan
    result <- dt %>%
        left_join(dt_match, by = "institution")

    # Perform matching according to ProvinceCity
    dt_city <- ProvinceCity %>%
        select(city_clean, province_clean)

    ptn_province <- paste0(unique(ProvinceCity$province_clean), collapse = "|")
    ptn_city <- paste0(unique(ProvinceCity$city_clean), collapse = "|")

    result_out <- result %>%
        mutate(
            province_extract = str_extract(institution, ptn_province),
            city_extract = str_extract(institution, ptn_city)
        ) %>%
        mutate(
            province = ifelse(is.na(province), province_extract, province)
        ) %>%
        left_join(dt_city, by = c("city_extract" = "city_clean")) %>%
        mutate(
            province = ifelse(is.na(province), province_clean, province)
        ) %>%
        select(-province_extract, -city_extract, -province_clean)

    # Check for unmatched records
    unmatched <- sum(is.na(result_out$province))
    if (unmatched > 0) {
        warning(sprintf("Found %d unmatched institutions", unmatched))
    } else {
        message("All institutions matched province info successfully")
    }

    # Prepare unmatched results
    if (unmatched > 0) {
        result_unmatched <- result_out %>%
            filter(is.na(province)) %>%
            select(institution) %>%
            arrange(institution) %>%
            unique() %>%
            mutate(index = row_number()) %>%
            select(index, institution)
    } else {
        result_unmatched <- data.frame(
            index = integer(0),
            institution = character(0)
        )
    }

    return(
        list(
            tbl_out = result_out,
            tbl_unmatched = result_unmatched,
            num_unmatched = unmatched
        )
    )
}

#' Write Unmatched Institutions to Ship Directory as Excel File
#'
#' @description
#' This internal function writes unmatched institutions to a specific directory
#' for further manual processing. The output file is named with the pattern
#' "ship-tot`number`-`date`.xlsx", where number is automatically calculated
#' from the input data frame.
#' @rdname workflow_pub_site
#' @details
#' The function performs the following operations:
#' \itemize{
#'   \item Validates input parameters for data frame and date
#'   \item Calculates the number of unmatched institutions from the input data
#'   \item Creates the ship directory if it doesn't exist
#'   \item Writes the unmatched institutions to an Excel file
#'   \item Provides feedback about the file location
#' }
#'
#' @param dt A data frame containing unmatched institutions with two columns:
#' \itemize{
#'   \item index: A numeric column for row identification
#'   \item institution: A character column containing institution names
#' }
#' @param date A character string representing the current date in YYYY-MM-DD format
#'
#' @return NULL (invisible)
#'
#' @importFrom openxlsx write.xlsx
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # Example usage
#' dt <- data.frame(
#'     index = 1:2,
#'     institution = c("Example Corp", "Test Company")
#' )
#' wfl.write2ship(dt, date = "2025-06-06")
#' }
wfl.write2ship <- function(dt, date) {
    # Input validation
    ## dt must be a data frame contains two columns: index and institution
    if (!is.data.frame(dt)) {
        stop("Input 'dt' must be a data frame")
    }

    if (!"index" %in% names(dt) || !"institution" %in% names(dt)) {
        stop("Input data frame must contain 'index' and 'institution' columns")
    }

    ## date must be a character string,
    ## format: YYYY-MM-DD
    if (!is.character(date) || !grepl("^\\d{4}-\\d{2}-\\d{2}$", date)) {
        stop("Input 'date' must be a character string in YYYY-MM-DD format")
    }

    ## create the ship directory
    dir_ship <- "data-raw/data-tidy/hack-tianyan/ship/"
    if (!dir.exists(dir_ship)) {
        dir.create(dir_ship, recursive = TRUE)
    }

    num <- nrow(dt) ## get the number of unmatched institutions

    ## write the unmatched institutions to the ship directory
    file_ship <- paste0("ship-tot", num, "-", date, ".xlsx")
    file_path <- file.path(dir_ship, file_ship)

    openxlsx::write.xlsx(dt, file_path)

    ## print the file path, and the number of unmatched institutions with line break
    message(sprintf(
        "Unmatched institutions table has been written to: %s \n
        and the number of unmatched institutions is: %d \n",
        file_path, num
    ))

    ## do not return anything
    return(invisible(NULL))
}
