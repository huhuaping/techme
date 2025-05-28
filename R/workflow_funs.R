# Declare global variables
utils::globalVariables(c(
    "chr", "row_index", "row_end", "row_start", "col_start", "col_end",
    "year", "file_xls", "vars_tot", "value", "input", "asis", "variables",
    "varsList", "target", "file_xlsx", "units_base",
    "case", "final", "media", "col_group", "row_mark", "table_id", "start", "end"
))



#' @importFrom dplyr mutate_all filter select rename left_join bind_rows group_by mutate row_number ungroup
#' @importFrom stringr str_detect str_extract str_replace str_replace_all str_trim
#' @importFrom XLConnect loadWorkbook getSheets readWorksheet
#' @importFrom openxlsx createWorkbook addWorksheet writeData saveWorkbook write.xlsx
#' @importFrom unpivotr as_cells behead
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @importFrom mgsub mgsub
#' @importFrom purrr map_chr
#' @importFrom tibble tibble add_row add_column
#' @importFrom tidyr fill pivot_wider
#' @importFrom rlang .data

#' @title Workflow Functions: find files
#' @description Internal functions for handling various workflow tasks in the techme package.
#' @details This file contains a collection of internal functions for:
#' \itemize{
#'   \item function `create.dirTable()`: create directory table with case, media, final column
#'   \item function `choose.filePattern()`: choose the file pattern based on year, mode, and add_info
#'   \item function `wfl.findFiles()`: find files based on directory table, case, final index, and pattern
#' }
#' @keywords internal
#' @name workflow_find_files
NULL

#' @title Helper function to get the directory table
#' @description
#' This function creates a directory table that maps case names to their corresponding
#' directory paths and subdirectories. The table is used to organize and locate data files
#' in the package's data structure.#'
#' @rdname workflow_find_files
#' @details
#' The function returns a tibble with three columns:
#' \itemize{
#'   \item \code{case}: The case identifier (e.g., "agri_prod", "budget")
#'   \item \code{media}: The main directory path for the case
#'   \item \code{final}: A list of subdirectories for the case
#' }
#'
#' @return tibble. A tibble containing the directory structure with columns:
#' \itemize{
#'   \item \code{case} (character): Case identifier
#'   \item \code{media} (character): Main directory path
#'   \item \code{final} (list): Vector of subdirectory names
#' }
#'
#' @keywords internal
#' @importFrom tibble tribble
#'
#' @examples
#' \dontrun{
#' # Get the directory table
#' tbl_dir <- create.dirTable()
#'
#' # View the structure
#' str(tbl_dir)
#'
#' # Access specific case
#' tbl_dir[tbl_dir$case == "agri_prod", ]
#' }
#'
create.dirTable <- function() {
    ## collection of directory for data base
    ## the data.frame must contains "case", "media", "final" column
    tbl_dir <- tibble::tribble(
        ~case, ~media, ~final,
        "agri_prod",
        "data-raw/rural-yearbook/part03-agri-produce/",
        c("01-machine", "02-fertilizer", "03-plastic", "04-pesticide"),
        "budget",
        "data-raw/nation-yearbook/part07-finance/",
        c("01-public-income", "02-public-budget"),
        "RD_nbs", # national bureau bullets !
        "data-raw/public-site/nbs-RD-bulletin/",
        c("02-xls/"),
        "RD_over",
        "data-raw/tech-yearbook/part01-over/",
        c("01-labor-hour", "02-spend-intense", "03-spend-inner", "05-public-professionals"),
        "RD_inner",
        "data-raw/tech-yearbook/part01-over/03-spend-inner/",
        c("01-activity", "02-source", "03-purpose"),
        "RD_firm",
        "data-raw/tech-yearbook/part02-firm/",
        c(
            "00-firms", "01-employee", "03-spend-inner",
            "04-spend-outer", "05-RD-projects", "06-RD-institution",
            "07-new-product", "08-patent", "09-tech-renew"
        ),
        "RD_industry",
        "data-raw/tech-yearbook/part05-industry/",
        c("01-operation", "02-RD", "03-trade"),
        "RD_output",
        "data-raw/tech-yearbook/part08-output/",
        c(
            "01-patent", "02-enrollmark",
            "03-teckmarket-pull", "04-teckmarket-push"
        ),
        "livestock",
        "data-raw/livestock-yearbook/",
        c("02-breeding")
    )
    return(tbl_dir)
}

#' Helper function to obtain specific files regex pattern#'
#' @description
#' This function generates regex patterns for matching specific file names based on year,
#' file format, and additional information. It supports various naming patterns for raw
#' data files and edited files.
#' @rdname workflow_find_files
#' @param year numeric or numeric vector. The year(s) to include in the pattern.
#' If a vector of length 2 is provided, it represents a year range.
#' @param mode character. The pattern mode to use. Must be one of:
#' \itemize{
#'   \item \code{year_one}: Single year, xls format, eg. "^raw-2023.xls$"
#'   \item \code{year_two}: Two years, xls format, eg. "^raw-2022-2023.xls$"
#'   \item \code{year_onex}: Single year, xlsx format, eg. "^raw-2023.xlsx$"
#'   \item \code{year_twox}: Two years, xlsx format, eg. "^raw-2022-2023.xlsx$"
#'   \item \code{add_onex}: Single year with additional info, xlsx format, eg. "^raw-.+?amount-2023.xlsx$"
#'   \item \code{add_one}: Single year with additional info, xls format, eg. "^raw-.+?amount-2023.xls$"
#'   \item \code{edited_one}: Single year with additional info, edited xlsx format, eg. "^raw-.+?amount-2023-edited.xlsx$"
#'   \item \code{edited_two}: Two years, edited xlsx format, eg. "^raw-2022-2023-edited.xlsx$"
#' }
#' @param add_info character. Additional information to include in the pattern.
#'
#' @return character. A regex pattern string for matching file names.
#'
#' @keywords internal
#' @importFrom glue glue
#'
#' @examples
#' \dontrun{
#' # Single year pattern
#' choose.filePattern(year = 2022, mode = "year_onex")
#'
#' # Year range pattern
#' choose.filePattern(year = c(2022, 2023), mode = "year_twox")
#'
#' # Pattern with additional info
#' choose.filePattern(
#'     year = 2022,
#'     mode = "add_onex",
#'     add_info = "amount"
#' )
#' }
#'
choose.filePattern <- function(year, mode, add_info) {
    # Input validation
    if (!is.numeric(year)) {
        stop("'year' must be numeric")
    }
    if (!is.character(mode) || length(mode) != 1) {
        stop("'mode' must be a single character string")
    }
    if (mode %in% c("add_onex", "add_one", "edited_one") &&
        (missing(add_info) || !is.character(add_info) || length(add_info) != 1)) {
        stop("'add_info' must be a single character string for the specified mode")
    }

    # year is a vector, may contains start and end year, or may only contains one year
    if (length(year) == 1) {
        year <- year
    } else if (length(year) == 2) {
        first_year <- year[1]
        last_year <- year[2]
    } else {
        stop("'year' must be either a single number or a vector of length 2")
    }

    # mode must be one of the following:
    # year_one, year_two, year_onex, year_twox, add_onex, add_one, edited_one, edited_two
    if (mode == "year_one") {
        pattern <- glue::glue("^raw-{year}.xls$")
    } else if (mode == "year_two") {
        pattern <- glue::glue("^raw-{first_year}-{last_year}.xls$")
    } else if (mode == "year_onex") {
        pattern <- glue::glue("^raw-{year}.xlsx$")
    } else if (mode == "year_twox") {
        pattern <- glue::glue("^raw-{first_year}-{last_year}.xlsx$")
    } else if (mode == "add_onex") {
        pattern <- glue::glue("^raw-.+?{add_info}-{year}.xlsx$")
    } else if (mode == "add_one") {
        pattern <- glue::glue("^raw-.+?{add_info}-{year}.xls$")
    } else if (mode == "edited_one") {
        pattern <- glue::glue("^raw-.+?{add_info}-{year}-edited.xlsx$")
    } else if (mode == "edited_two") {
        pattern <- glue::glue("^raw-{first_year}-{last_year}-edited.xlsx$")
    } else {
        stop("Invalid 'mode' parameter. Must be one of: 'year_one', 'year_two', 'year_onex', 'year_twox', 'add_onex', 'add_one', 'edited_one', 'edited_two'")
    }
    message(glue::glue("The regex pattern is: {pattern}"))
    return(pattern)
}

#' @title Search for specific files (regex pattern) in a directory
#' Return the file path and also the "case" directory path
#' @rdname workflow_find_files
#' @param dt data.frame. Which must be contain "case", "media", "final" column.
#' @param dir.case character. The case name to search for files.
#' Must one of the value of the "case" column in the data.frame.
#' @param i.final number. The index of the final directory in the "final" column.
#' @param pattern character. Pattern to match files
#'
#' @return list of file paths and directory path
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' find_result <- wfl.findFiles(
#'     dt = tbl_dir, # the directory table
#'     dir.case = "agri_prod", # the case name of the target directory
#'     i.final = 1, # the index of the final subdirectory
#'     pattern = pattern_sel # the regex pattern for table identifier
#' )
#' }
wfl.findFiles <- function(dt, dir.case, i.final, pattern) {
    # dt must be a data.frame and contain "case", "media", "final" column
    if (!is.data.frame(dt)) {
        stop("'dt' must be a data.frame")
    }
    if (!"case" %in% colnames(dt)) {
        stop("'dt' must contain 'case' column")
    }
    if (!"media" %in% colnames(dt)) {
        stop("'dt' must contain 'media' column")
    }
    if (!"final" %in% colnames(dt)) {
        stop("'dt' must contain 'final' column")
    }

    # check if dir.case is one of the value of the "case" column
    if (!dir.case %in% dt$case) {
        stop("'dir.case' must be one of the value of the 'case' column")
    }

    # get the media and final directory name
    dir_media <- dt %>%
        filter(case == dir.case) %>%
        pull(media)
    dir_final <- dt %>%
        filter(case == dir.case) %>%
        pull(final) %>%
        unlist()
    # get the complete directory path for the target final directory
    file_dir <- glue::glue("{dir_media}{dir_final[i.final]}")

    # search for files with the pattern
    files <- list.files(file_dir, pattern = pattern, recursive = TRUE, full.names = TRUE)
    if (length(files) == 0) {
        stop("No files found matching the pattern: ", pattern)
    }

    # Print message based on number of files found
    if (length(files) == 1) {
        message(glue::glue("Only one file found matching the pattern: {pattern}"))
    } else {
        message(glue::glue("Multiple files found matching the pattern: {pattern}"))
    }

    # Return both file directory and files
    return(list(file_dir = file_dir, files = files))
}

#' Convert protected xls file to xlsx file, and remove unnecessary sheet.
#' This function will remove the xls file permission protected by CNKI.
#' @param file_path character. Path to the target xls file
#' @param sheet_drop character. Name of the sheet to drop
#' @return character. Path to the converted xlsx file
#' @keywords internal
#' @importFrom stringr str_replace
#' @importFrom openxlsx createWorkbook addWorksheet writeData saveWorkbook
#' @importFrom XLConnect loadWorkbook getSheets readWorksheet
#'
#' @examples
#' \dontrun{
#' wfl.Xls2Xlsx(
#'     file_path = "data-raw/example.xls",
#'     sheet_drop = c("CNKI")
#' )
#' }
#'
wfl.Xls2Xlsx <- function(file_path, sheet_drop = c("CNKI")) {
    # Check if file exists
    if (!file.exists(file_path)) {
        stop("File does not exist: ", file_path)
    }

    # Check if file is xls format
    if (!stringr::str_detect(file_path, "\\.xls$")) {
        stop("File must be xls format: ", file_path)
    }

    # Generate path for xlsx file
    file_xlsx_path <- stringr::str_replace(file_path, "\\.xls$", ".xlsx")

    # Load workbook using XLConnect to get sheet names
    wb_xlc <- XLConnect::loadWorkbook(file_path, create = TRUE)
    sheet_names <- XLConnect::getSheets(wb_xlc)
    sheet_num <- length(sheet_names)
    print(glue::glue("Total sheets: {sheet_num}"))
    print(glue::glue("Sheet names: {paste(sheet_names, collapse = ', ')}"))

    # do not use unnecessary sheet
    sheet_drop_indeed <- sheet_names[grepl(paste(sheet_drop, collapse = "|"), sheet_names)]
    sheet_names <- sheet_names[!grepl(paste(sheet_drop, collapse = "|"), sheet_names)]

    # print droped sheet names
    print(glue::glue("Dropped sheets: {paste(sheet_drop_indeed, collapse = ', ')}"))

    # Create new workbook using openxlsx
    wb_xlsx <- openxlsx::createWorkbook()

    # Read and write each sheet
    for (sheet in sheet_names) {
        # Read data from xls file using XLConnect
        data <- XLConnect::readWorksheet(wb_xlc, sheet = sheet, header = FALSE)

        # Add new sheet to xlsx workbook
        openxlsx::addWorksheet(wb_xlsx, sheetName = sheet)

        # Write data to new sheet
        openxlsx::writeData(wb_xlsx, sheet = sheet, x = data, colNames = FALSE)
    }

    # Save as xlsx file
    openxlsx::saveWorkbook(wb_xlsx, file_xlsx_path, overwrite = TRUE)
    print(glue::glue("Saved as xlsx workbook: {file_xlsx_path}"))

    # Free memory
    rm(wb_xlc, wb_xlsx)
    gc()

    # Return path of xlsx file
    return(file_xlsx_path)
}

#' @title Workflow Functions: unpivot all tables in the xlsx file
#' @description Internal functions for handling various workflow tasks in the techme package.
#' @details This file contains a collection of internal functions for:
#' \itemize{
#'   \item function `getRange()`: get the range of the pivot table in the xlsx file
#'   \item function `unpivot()`: unpivot the xlsx file
#'   \item function `getInfo()`: get the information of the xlsx file
#'   \item function `wfl.unpivotXlsx()`: unpivot the xlsx file
#' }
#' @keywords internal
#' @name workflow_funs_unpivot_xlsx
NULL

#' Get range of xlsx file's pivot table with target regex pattern
#' @details
#' This function is used to get the range of the pivot table in the xlsx file.
#' The pivot table is identified by the regex pattern for start and end identifier.
#' The function will return the row and column range of the target pivot table.
#' Note 1: there may be only one table or multiple tables in the sheet
#' Note 2: when there are multiple tables, these table's alignment may be horizontal or vertical
#' Note 3: We only assume the only multiple table's alignment is horizontal or vertical, not hybrid alignment.

#' @rdname workflow_funs_unpivot_xlsx
#' @param dt data.frame. Which is the wb object reading from xlsx file.
#' @param ith number. when exist multiple table region in one sheet.
#' @param what character. What is the object function will return, whether "row" or "col".
#' @param reg_start character. regex pattern for start identifier.
#' @param reg_end character. regex pattern for end identifier.
#'
#' @return vector
#' @keywords internal
#' @importFrom dplyr mutate_all filter select
#' @importFrom stringr str_detect
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' wb <- loadWorkbook(path_xls, create = TRUE)
#' dt <- readWorksheet(wb, sheet = 1, header = F) %>%
#'     select_if(~ !all(is.na(.)))
#' i <- 2
#' myrows <- getRange(dt, ith = i, what = "row")
#' mycols <- getRange(dt, ith = i, what = "col")
#' }
#'
getRange <- function(dt, ith, what,
                     reg_start, reg_end) {
    # Create pattern for detection
    pattern <- paste(reg_start, reg_end, sep = "|")

    # Detect regions in data
    dt_detect_region <- dt %>%
        dplyr::mutate_all(.funs = function(x) stringr::str_detect(x, pattern))

    # Search along columns, get the index of the row (region) identifier
    range_row <- sapply(
        dt_detect_region,
        function(x) {
            which(stringr::str_detect(x, "TRUE"))
        }
    )

    # name of the last one of the range_row contains the max column number
    col_max <- length(range_row)

    ## rows start and end index
    ## note 1: there may be only one table or multiple tables in the sheet
    ## note 2: when there are multiple tables, the table's alignment may be horizontal or vertical

    # looply create the identifier data.frame
    dt_identifier <- NULL
    i <- 2
    for (i in 1:length(range_row)) {
        if (length(range_row[[i]]) != 0) {
            dt_identifier <- rbind(
                dt_identifier,
                data.frame(row = range_row[[i]], col = i)
            )
        }
    }

    # add the the odd and even mark for each col group
    ## note: the index() function is used to get the index of the row
    dt_identifier_mark <- dt_identifier %>%
        # add the the odd and even mark for each col group
        dplyr::group_by(col) %>%
        dplyr::mutate(
            col_group = ifelse(dplyr::row_number(row) %% 2 == 0, NA, dplyr::row_number(row)),
            row_mark = ifelse(dplyr::row_number(row) %% 2 == 0, "end", "start")
        ) %>%
        # fill group down, add group index completely
        tidyr::fill(col_group, .direction = "down") %>%
        dplyr::ungroup()

    # get unique col values and their next values
    tbl_distinct <- dt_identifier_mark %>%
        # get unique col values and their next values
        dplyr::distinct(col) %>%
        dplyr::mutate(
            col_end = dplyr::lead(col) - 1
        ) %>%
        # if col_end is NA, fill it with the max col number
        dplyr::mutate(
            col_end = ifelse(is.na(col_end), col_max, col_end)
        )

    # join back to original data by col
    # and add the table id
    dt_identifier_add <- tbl_distinct %>%
        # join back to original data with group and mark
        dplyr::right_join(
            dt_identifier_mark,
            by = "col"
        ) %>%
        # reorder columns to match original structure
        dplyr::select(row, col, col_group, row_mark, col_end) %>%
        ## add the table id
        ## note: one col vaule may contains multiple tables
        dplyr::group_by(col, col_group) %>%
        tibble::add_column(table_id = dplyr::group_indices(.)) %>%
        dplyr::ungroup()

    # filter the ith table's identifier
    tbl_ith <- dt_identifier_add %>%
        dplyr::filter(table_id == ith)

    # Create data frames for row and column indices
    ## data.frame of column start and end index
    df_col <- tbl_ith %>%
        dplyr::select(col, col_end) %>%
        base::unique() %>%
        dplyr::rename("col_start" = "col")

    ## data.frame of row start and end index
    df_row <- tbl_ith %>%
        dplyr::select(row, row_mark) %>%
        # pivot wider to get the start and end row index
        tidyr::pivot_wider(names_from = row_mark, values_from = row) %>%
        dplyr::select(start, end) %>%
        dplyr::rename("row_start" = "start", "row_end" = "end")

    # check the dimension of df_row and df_col must be 1 row and 2 columns
    if (nrow(df_row) != 1 || ncol(df_row) != 2) {
        stop("The dimension of df_row must be 1 row and 2 columns")
    }
    if (nrow(df_col) != 1 || ncol(df_col) != 2) {
        stop("The dimension of df_col must be 1 row and 2 columns")
    }

    # Get row and column ranges
    rows <- df_row$row_start:df_row$row_end
    cols <- df_col$col_start:df_col$col_end

    # Return appropriate range
    if (what == "row") {
        return(rows)
    } else if (what == "col") {
        return(cols)
    } else {
        stop("Invalid 'what' parameter. Must be either 'row' or 'col'")
    }
}


#' Unpivot xlsx file table
#' @rdname workflow_funs_unpivot_xlsx
#' @param dt data.frame. Which is the wb object reading from xls workbook.
#' @param cols vector. Target cols of the region contains pivot table.
#' @param rows vector. Target rows of the region contains pivot table.
#' @param cols.drop vector. Columns numbers which will be dropped, default \code{NULL}.
#' @param header.mode character. One of the four options:  'vars-year', 'vars', 'vars-vars','year'
#' @param vars.add character. if header.mode = 'year', then the vars.add must be specified,
#'   And you can use the function \code{get_vars()} to get the variable name.
#'
#' @return data.frame
#' @keywords internal
#' @importFrom dplyr select mutate if_else
#' @importFrom stringr str_extract
#' @importFrom unpivotr as_cells behead
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' wb <- loadWorkbook(path_xls, create = TRUE)
#' dt <- readWorksheet(wb, sheet = 1, header = F) %>%
#'     select_if(~ !all(is.na(.)))
#' i <- 1
#' myrows <- getRange(dt, ith = i, what = "row")
#' mycols <- getRange(dt, ith = i, what = "col")
#' cols_drop <- c(2)
#' header_mode <- c("vars", "vars-vars")
#' vars_spc <- get_vars(
#'     df = varsList, lang = "eng",
#'     block = list(
#'         block1 = "v4",
#'         block2 = "zh",
#'         block3 = "qd",
#'         block4 = "RD"
#'     ),
#'     what = "chn_block4"
#' )
#'
#' tbl_raw <- unpivot(dt,
#'     cols = mycols, rows = myrows,
#'     cols.drop = cols_drop,
#'     header.mode = header_mode[i],
#'     vars.add = vars_spc
#' )
#' }
#'
unpivot <- function(dt, rows, cols,
                    cols.drop = NULL,
                    header.mode,
                    vars.add = NULL) {
    # Input validation
    if (!is.data.frame(dt)) {
        stop("'dt' must be a data.frame")
    }
    if (!header.mode %in% c("vars-year", "vars", "vars-vars", "year")) {
        stop("'header.mode' must be one of: 'vars-year', 'vars', 'vars-vars', 'year'")
    }
    if (header.mode == "year" && is.null(vars.add)) {
        stop("'vars.add' must be specified when header.mode is 'year'")
    }

    # Drop columns if specified
    if (is.null(cols.drop)) {
        dt_cell <- dt[rows, cols]
    } else {
        dt_cell <- dt[rows, cols] %>%
            .[, -cols.drop]
    }

    # Convert to cells and arrange
    dt_cell <- dt_cell %>%
        unpivotr::as_cells() %>%
        dplyr::arrange(col, row)

    # Process based on header mode
    if (header.mode == "vars-year") { # header mode 1
        dt_cell <- dt_cell %>%
            unpivotr::behead("up-left", vars) %>%
            unpivotr::behead("up", year) %>%
            unpivotr::behead("left", province)
    } else if (header.mode == "vars") { # header mode 2
        dt_cell <- dt_cell %>%
            unpivotr::behead("up", vars) %>%
            unpivotr::behead("left", province) %>%
            tibble::add_column(year = stringr::str_extract(file_xlsx, "\\d{4}"))
    } else if (header.mode == "vars-vars") { # header mode 3
        dt_cell <- dt_cell %>%
            unpivotr::behead("up-left", vars_tot) %>%
            unpivotr::behead("up", vars) %>%
            dplyr::mutate(vars = dplyr::if_else(is.na(vars), vars_tot, vars)) %>%
            unpivotr::behead("left-up", province) %>%
            tibble::add_column(year = stringr::str_extract(file_xlsx, "\\d{4}")) %>%
            dplyr::select(-vars_tot)
    } else if (header.mode == "year") { # header mode 4
        if (length(vars.add) != 1) {
            stop("Added Vars info not correct, please specify by function 'get_vars()'")
        }
        dt_cell <- dt_cell %>%
            unpivotr::behead("up", year) %>%
            unpivotr::behead("left", province) %>%
            tibble::add_column(vars = unname(unlist(vars.add)))
    }

    # Final formatting
    dt_cell <- dt_cell %>%
        dplyr::rename(value = chr) %>%
        dplyr::select(province, year, vars, value)

    return(dt_cell)
}


#' Helper function to extract measurement information of the pivot table
#' Such as units (thousand tons, etc.),given that all variables have the same units scale in pivot table.
#' @rdname workflow_funs_unpivot_xlsx
#' @param dt data.frame. Should be characterer the type of pivot table.
#'
#' @return vector. A character vector containing the unit information.
#' @keywords internal
#' @importFrom dplyr filter mutate select
#' @importFrom stringr str_detect str_extract str_trim
#' @importFrom unpivotr as_cells
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' same_units <- getInfo(dt)
#' }
#'
getInfo <- function(dt, unit_pattern) {
    # Input validation
    if (!is.data.frame(dt)) {
        stop("'dt' must be a data.frame")
    }

    # Extract unit information
    dt_cell <- dt %>%
        unpivotr::as_cells() %>%
        dplyr::filter(stringr::str_detect(chr, unit_pattern))

    # Process unit information
    info_list <- dt_cell %>%
        dplyr::mutate(
            chr = stringr::str_extract(chr, glue::glue("(?<={unit_pattern})(.+)")),
            chr = stringr::str_trim(chr)
        ) %>%
        dplyr::select(chr) %>%
        unique() %>%
        unlist() %>%
        unname()

    # Validate results
    if (length(info_list) > 1) {
        stop("Multiple unit information found. Please check the raw xls file!")
    }
    if (length(info_list) == 0) {
        message("No unified unit information found in the data.")
        return(character(0))
    }

    return(info_list)
}

#' Main function to loop unpivot all the sheets in the xlsx file.
#' Keep in mind that a sheet may contains multiple pivot tables.
#' @details
#' This function is used to loop unpivot all the sheets in the xlsx file.
#' It will call three internal functions respectively:
#' 1. getRange(): to get the range of the pivot table in the xlsx file.
#' 2. unpivot(): to unpivot the pivot table in the xlsx file.
#' 3. getInfo(): to get the unit information of the pivot table in the xlsx file.
#' Keep in mind that a sheet may contains multiple pivot tables.
#' Note 1: there may be only one table or multiple tables in the sheet
#' Note 2: when there are multiple tables, these table's alignment may be horizontal or vertical
#' Note 3: We only assume the only multiple table's alignment is horizontal or vertical, not hybrid alignment.

#' @rdname workflow_funs_unpivot_xlsx
#' @param file character. Path to the xlsx file.
#' @param header.mode character. One of the four options:  'vars-year', 'vars', 'vars-vars','year'
#' @param vars.add character. if header.mode = 'year', then the vars.add must be specified,
#'   And you can use the function \code{get_vars()} to get the variable name.
#' @param cols.drop vector. Columns numbers which will be dropped, default \code{NULL}.
#' @param pattern.table character. Regex pattern for table identifier.
#'
#' @return data.frame. A data frame containing the unpivoted data with units information.
#' @keywords internal
#' @importFrom dplyr bind_rows mutate select_if
#' @importFrom stringr str_detect str_extract str_trim
#' @importFrom XLConnect loadWorkbook getSheets readWorksheet
#' @importFrom magrittr %>%
#' @importFrom glue glue
#'
#' @examples
#' \dontrun{
#' wfl.unpivot_xlsx(
#'     file = "data-raw/example.xlsx",
#'     header.mode = "vars-year",
#'     cols.drop = NULL,
#'     pattern.table = "^\\u5730.*\\u533a"
#' )
#' }
#'
wfl.unpivotXlsx <- function(
    file,
    header.mode = "vars-year",
    vars.add = NULL,
    cols.drop = NULL,
    pattern.table,
    reg_start, # getRange() argument
    reg_end, # getRange() argument
    unit_pattern # getInfo() argument
    ) {
    # Input validation
    if (!file.exists(file)) {
        stop("File does not exist: ", file)
    }
    if (!header.mode %in% c("vars-year", "vars", "vars-vars", "year")) {
        stop("'header.mode' must be one of: 'vars-year', 'vars', 'vars-vars', 'year'")
    }
    if (header.mode == "year" && is.null(vars.add)) {
        stop("'vars.add' must be specified when header.mode is 'year'")
    }

    # Load workbook
    wb <- XLConnect::loadWorkbook(file, create = TRUE)
    sheetnum <- length(XLConnect::getSheets(wb))

    if (sheetnum == 0) {
        stop("No sheets found in the workbook. Please check the file.")
    } else {
        message(glue::glue("Total {sheetnum} xlsx sheet(s) need to unpivot."))
    }

    # Initialize output data frame
    df_out <- NULL

    # Process each sheet
    # j <-1
    for (j in 1:sheetnum) {
        message(glue::glue("Processing sheet {j} of {sheetnum}"))

        # Load sheet data
        wb <- XLConnect::loadWorkbook(file, create = TRUE)
        dt <- XLConnect::readWorksheet(wb, sheet = j, header = FALSE) %>%
            dplyr::select_if(~ !all(is.na(.)))

        # Detect number of tables in sheet
        n_tables <- dt %>%
            dplyr::mutate_all(.funs = function(x) stringr::str_detect(x, pattern.table)) %>%
            unlist() %>%
            sum(na.rm = TRUE)

        message(glue::glue("Found {n_tables} pivot tables in sheet {j}"))

        # Process each table
        # i <- 1
        for (i in 1:n_tables) {
            # get the rows index of the table
            sel_rows <- getRange(
                dt,
                ith = i, what = "row",
                reg_start = reg_start, reg_end = reg_end
            )
            # get the columns index of the table
            sel_cols <- getRange(
                dt,
                ith = i, what = "col",
                reg_start = reg_start, reg_end = reg_end
            )

            # unpivot the table
            tbl_tem <- unpivot(
                dt = dt,
                rows = sel_rows,
                cols = sel_cols,
                cols.drop = cols.drop,
                header.mode = header.mode,
                vars.add = vars.add
            )
            message(glue::glue("Successfully unpivoted table {i} of {n_tables} in sheet {j}"))

            df_out <- dplyr::bind_rows(df_out, tbl_tem)
        } # end of table loop

        # Process units information
        same_units <- getInfo(dt, unit_pattern = unit_pattern)
        if (length(same_units) == 1) {
            message(glue::glue("Variables in sheet {j} have same units: {same_units}"))
            # Add units information to output
            df_out <- df_out %>%
                dplyr::mutate(
                    units = stringr::str_extract(vars, "(?<=\\()(.+)(?=\\))"),
                    units = stringr::str_trim(units)
                ) %>%
                dplyr::mutate(units = dplyr::if_else(is.na(units), same_units, units))
        } else if (length(same_units) == 0) {
            message(glue::glue("Variables in sheet {j} have different units"))
            # extract units from vars
            df_out <- df_out %>%
                dplyr::mutate(
                    units = stringr::str_extract(vars, "(?<=\\()(.+)(?=\\))"),
                    units = stringr::str_trim(units)
                )
        } else {
            warning(glue::glue("Please check variable units in sheet {j}"))
        }
    } # end of sheet loop

    return(df_out)
} # end of function

#' Tidy dataset from unpivot yearbook table
#'
#' @param dt data.frame. typically the yearbook unpivot table by use \code{unpivot}.
#'
#' @return data.frame
#' @keywords internal
#' @importFrom dplyr mutate filter
#' @importFrom stringr str_extract str_replace str_replace_all str_trim str_detect
#' @importFrom mgsub mgsub
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' df_tidy <- wfl.tidyTable(dt = df_out)
#' }
#'
wfl.tidyTable <- function(dt) {
    # Input validation
    if (!is.data.frame(dt)) {
        stop("'dt' must be a data.frame")
    }
    required_cols <- c("value", "year", "province", "vars")
    missing_cols <- setdiff(required_cols, names(dt))
    if (length(missing_cols) > 0) {
        stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
    }

    dt_tidy <- dt %>%
        dplyr::mutate(
            value = as.numeric(value),
            year = stringr::str_extract(year, "\\d{4}")
        ) %>%
        dplyr::mutate(
            province = stringr::str_replace(province, " ", ""),
            province = stringr::str_replace(province, "\u5730\u65b9\u5408\u8ba1", "\u5168\u56fd") # total of province, total of nation
        ) %>%
        dplyr::filter(!stringr::str_detect(province, "\u4e1c\u90e8|\u4e2d\u90e8|\u897f\u90e8|\u4e1c\u5317")) %>% # east|middle|west|northeast
        dplyr::mutate(
            vars = stringr::str_trim(vars),
            # handle cell contain both chn and eng names
            vars = stringr::str_replace_all(vars, "\\r\\n", "_"),
            vars = stringr::str_replace(vars, "(_[a-zA-Z].+)", ""),
            vars = stringr::str_replace_all(vars, "_|,", ""),
            # handle newline break
            vars = mgsub::mgsub(
                vars,
                c(fixed("\u00a0"), fixed("\n"), " "),
                c("", "", "")
            ),
            # handle cell begin with number followed by dot
            vars = stringr::str_replace(vars, "\\d", ""),
            vars = stringr::str_replace(vars, "\\.", ""),
            # handle cell contains units within round brackets
            vars = stringr::str_replace(vars, "(\\(.+\\))", ""),
            vars = mgsub::mgsub(
                vars,
                c(" ", "#", "R&D"),
                c("", "", "")
            )
        )

    # Check for missing values
    if (any(is.na(dt_tidy$year))) {
        warning("Variable 'year' missing in some rows, please check.")
    }
    if (any(is.na(dt_tidy$vars))) {
        warning("Variable 'vars' missing in some rows, please check.")
    }
    if (any(is.na(dt_tidy$value))) {
        warning("Variable 'value' contains NA values after conversion to numeric.")
    }

    return(dt_tidy)
}

#' @title Workflow Functions: match variables
#' @description Internal functions for handling various workflow tasks in the techme package.
#' @details This file contains a collection of internal functions for:
#' \itemize{
#'   \item function `get.targetList()`: get the target list
#'   \item function `get.vars()`: get the variables from the package data `varsList`
#'   \item function `get.best.match()`: get the best match
#'   \item function `wfl.matchVars()`: match the variables with the tidy data.frame
#' }
#' @keywords internal
#' @name workflow_funs_match_vars
NULL

#' Helper function to create target list collection by interactive selection with R console
#' @description
#' This function provides an interactive way to select a target list from a predefined collection
#' used for filtering and organizing data in the package. The lists are organized by different
#' categories (v4, v6, v7, v8) and contain block identifiers for data filtering.
#'
#' @rdname workflow_funs_match_vars
#' @details
#' The target lists are organized into several categories:
#' \itemize{
#'   \item v4: Research and Development related lists (RDnbs, RDinner, RDfirm, etc.)
#'   \item v6: Budget related lists
#'   \item v7: Agricultural production related lists (machine, fertilizer, plastic, pesticide)
#'   \item v8: Livestock related lists (t1-t9)
#' }
#' Each list contains block identifiers (block1, block2, block3) used for filtering data.
#'
#' @return list. List of target list with block identifiers.
#'
#' @keywords internal
#' @importFrom glue glue
#'
#' @examples
#' \dontrun{
#' # Interactive selection of target list
#' target_list <- get.targetList()
#' }
#'
get.targetList <- function() {
    # Define full list collection
    full_list <- list(
        v7_machine = list(
            block1 = "v7", block2 = "sctj",
            block3 = "nyjx"
        ),
        v7_fertilizer = list(
            block1 = "v7", block2 = "sctj",
            block3 = c("nyhf")
        ),
        v7_plastic = list(
            block1 = "v7", block2 = "sctj",
            block3 = c("nybm")
        ),
        v7_pesticide = list(
            block1 = "v7", block2 = "sctj",
            block3 = c("cyny")
        ),
        v6_budget = list(
            block1 = "v6", block2 = "cz",
            block3 = "yszc"
        ),
        v4_RDnbs = list(
            block1 = "v4", block2 = "ztr",
            block3 = c("jf", "qd")
        ),
        v4_RDinner = list(
            block1 = "v4", block2 = "zh",
            block3 = "nbzc"
        ),
        v4_RDfirm = list(
            block1 = "v4", block2 = "qy",
            block3 = "qysl"
        ),
        v4_RDpull = list(
            block1 = "v4", block2 = "cg",
            block3 = "jssr"
        ),
        v4_RDpush = list(
            block1 = "v4", block2 = "cg",
            block3 = "jssc"
        ),
        v4_operation = list(
            block1 = "v4", block2 = "cy",
            block3 = "scjy"
        ),
        v4_RDtrade = list(
            block1 = "v4", block2 = "cy",
            block3 = "my"
        ),
        v4_IndustryRD = list(
            block1 = "v4", block2 = "cy",
            block3 = c("RDhd", "xcp", "qyzl", "jsgz")
        ),
        v8_livestock_t1 = list(
            block1 = "v8", block2 = "t1",
            block3 = c("zcqc")
        ),
        v8_livestock_t2 = list(
            block1 = "v8", block2 = "t2",
            block3 = c("zcqc")
        ),
        v8_livestock_t3 = list(
            block1 = "v8", block2 = "t3",
            block3 = c("zcqc", "nmcl")
        ),
        v8_livestock_t4 = list(
            block1 = "v8", block2 = "t4",
            block3 = c("zcqc", "nmcl")
        ),
        v8_livestock_t5 = list(
            block1 = "v8", block2 = c("t5"),
            block3 = c("zcqc", "nmcl")
        ),
        v8_livestock_t6 = list(
            block1 = "v8", block2 = c("t6"),
            block3 = c("nfmccl")
        ),
        v8_livestock_t7 = list(
            block1 = "v8", block2 = c("t7"),
            block3 = c("nfmccl", "cczcq")
        ),
        v8_livestock_t8 = list(
            block1 = "v8", block2 = c("t8"),
            block3 = c("cczcq", "scpt")
        ),
        v8_livestock_t9 = list(
            block1 = "v8", block2 = c("t9"),
            block3 = c("scpt", "scjy")
        )
    )

    # Display all options
    cat("Available target list options:\n")
    for (i in seq_along(full_list)) {
        cat(sprintf("%2d: %s\n", i, names(full_list)[i]))
    }

    # Interactive selection
    repeat {
        choice <- readline(prompt = "\nEnter option number (1-21): ")
        choice <- as.integer(choice)

        if (!is.na(choice) && choice >= 1 && choice <= length(full_list)) {
            selected_name <- names(full_list)[choice]
            selected_list <- full_list[[choice]]
            cat(sprintf("\nSelected: %s\n", selected_name))
            cat("Block identifiers:\n")
            cat(paste(names(selected_list), selected_list, sep = ": ", collapse = "\n"), "\n")
            return(selected_list)
        } else {
            cat("Invalid option, please try again\n")
        }
    }
}

#' Get names from basic variables table
#' @rdname workflow_funs_match_vars
#' @description
#' This function retrieves variable names from a basic variables table based on specified
#' language and block criteria. It supports filtering variables by hierarchical block
#' structure in both English and Chinese.
#'
#' @details
#' The function filters variables based on a hierarchical block structure (block1-4)
#' and returns the specified variable names. It supports both English and Chinese
#' variable names through the language parameter. The block4 parameter is optional
#' in the block list.
#'
#' @param df data.frame. The input data frame containing variable information.
#' @param lang character. The language of variables to select. Must be either "eng" (default)
#'   or "chn".
#' @param block list. A list which the length is not greater than 4 with names "block1", "block2", "block3", "block4".
#'   Each element contains the block identifiers to filter by. Note that block4 is optional.
#' @param what character. The type of variable names to return. Options include:
#'   \itemize{
#'     \item "variables" (default): Full variable names
#'     \item "short_chn": Short Chinese names
#'     \item "short_eng": Short English names
#'     \item "chn_block4": Chinese block4 names
#'     \item "eng_block4": English block4 names
#'     \item other: other variable names in the input data frame (typically `varList`)
#'   }
#'
#' @return data.frame. A data frame containing the filtered variable names.
#'
#' @keywords internal
#' @importFrom dplyr filter select one_of
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom glue glue
#'
#' @examples
#' \dontrun{
#' options(encoding = "UTF-8")
#' block_sel <- list(
#'     block1 = "v7",
#'     block2 = "sctj",
#'     block3 = "nyjx"
#' )
#'
#' vars_set <- get.vars(df = varsList, block = block_sel, what = "variables")
#' }
#'
get.vars <- function(df, lang = "eng", block, what = "variables") {
    # Input validation
    if (!is.data.frame(df)) {
        stop("'df' must be a data frame")
    }
    if (!lang %in% c("eng", "chn")) {
        stop("'lang' must be either 'eng' or 'chn'")
    }
    if (!is.list(block) || length(block) > 4) {
        stop("'block' must be a list of length not greater than 4")
    }

    # Check required block names (block1-3 are required, block4 is optional)
    required_blocks <- c("block1", "block2", "block3")
    if (!all(required_blocks %in% names(block))) {
        stop("'block' must have names: block1, block2, block3 (block4 is optional)")
    }

    # Check for invalid block names
    valid_blocks <- c("block1", "block2", "block3", "block4")
    invalid_blocks <- setdiff(names(block), valid_blocks)
    if (length(invalid_blocks) > 0) {
        stop("Invalid block names found: ", paste(invalid_blocks, collapse = ", "))
    }

    if (lang == "chn") {
        if (!is.null(block$block1)) {
            df <- df %>% filter(.data$chn_block1 %in% block$block1)
        }

        if (!is.null(block$block2)) {
            df <- df %>% filter(.data$chn_block2 %in% block$block2)
        }

        if (!is.null(block$block3)) {
            df <- df %>% filter(.data$chn_block3 %in% block$block3)
        }

        if (!is.null(block$block4)) {
            df <- df %>% filter(.data$chn_block4 %in% block$block4)
        }
    } else if (lang == "eng") {
        if (!is.null(block$block1)) {
            df <- df %>% filter(.data$block1 %in% block$block1)
        }

        if (!is.null(block$block2)) {
            df <- df %>% filter(.data$block2 %in% block$block2)
        }

        if (!is.null(block$block3)) {
            df <- df %>% filter(.data$block3 %in% block$block3)
        }

        if (!is.null(block$block4)) {
            df <- df %>% filter(.data$block4 %in% block$block4)
        }
    }

    vars <- df %>%
        dplyr::select(one_of(what))

    message(glue::glue("`get.vars()` get variables in {what}: {paste0(vars, collapse = ', ')}\n"))
    return(vars)
}

#' Helper function to get the best matched of specified character vectors.
#' @rdname workflow_funs_match_vars
#' @param word character. The word to match.
#' @param charvec character vector. The vector of words to match against.
#'
#' @return character. The best matched word from charvec.
#' @keywords internal
#' @importFrom stringdist stringsim
#'
#' @examples
#' \dontrun{
#' get.best.match(
#'     "\u519c\u4e1a\u673a\u68b0",
#'     c(
#'         "\u519c\u4e1a\u673a\u68b0",
#'         "\u519c\u4e1a\u673a\u68b0\u603b\u52a8\u529b"
#'     )
#' )
#' }
#'
get.best.match <- function(word, charvec) {
    # Input validation
    if (!is.character(word) || length(word) != 1) {
        stop("'word' must be a single character string")
    }
    if (!is.character(charvec) || length(charvec) == 0) {
        stop("'charvec' must be a non-empty character vector")
    }

    max_index <- which.max(stringdist::stringsim(word, charvec,
        method = "jw"
    ))
    return(charvec[max_index])
}

#' Match 'vars' to target variables list in chinese block.
#' @rdname workflow_funs_match_vars
#' @param dt data.frame. The input data frame containing a 'vars' column.
#' @param block_target list. Names of the list should be part or all of: block1, block2, block3, block4.
#' @param block_lang character. Specify which language to use, either 'eng'(default) or 'chn'.
#'
#' @return data.frame. A data frame containing the matched variables.
#' @keywords internal
#' @importFrom dplyr mutate rename left_join
#' @importFrom purrr map_chr
#' @importFrom glue glue
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' target <- list(block1 = "v7", block2 = "sctj", block3 = "nyjx")
#' df_vars_matched <- wfl.matchVars(dt = df_tidy, block_target = target)
#' }
#'
wfl.matchVars <- function(dt, block_target, block_lang = "eng") {
    # Input validation
    if (!is.data.frame(dt)) {
        stop("'dt' must be a data.frame")
    }
    if (!"vars" %in% names(dt)) {
        stop("'dt' must contain a 'vars' column")
    }
    if (!is.list(block_target)) {
        stop("'block_target' must be a list")
    }
    if (!block_lang %in% c("eng", "chn")) {
        stop("'block_lang' must be either 'eng' or 'chn'")
    }

    # Get unique variables
    input <- unique(dt$vars)

    # Load required data
    if (!requireNamespace("techme", quietly = TRUE)) {
        stop("Package 'techme' is required but not installed")
    }
    varsList <- get("varsList", envir = asNamespace("techme"))

    # Get variables table
    vars_tbl <- get.vars(varsList,
        lang = block_lang,
        block = block_target,
        what = c("variables", "chn_block4")
    )

    # Match variables
    vec <- vars_tbl$chn_block4
    vector_results <- purrr::map_chr(input, ~ get.best.match(.x, charvec = vec))

    # Create matched variables table
    vars_matched <- tibble::tibble(input = input, target = vector_results) %>%
        dplyr::mutate(asis = ifelse(input == target, TRUE, FALSE)) %>%
        dplyr::rename(chn_block4 = "target") %>%
        dplyr::left_join(., vars_tbl, by = "chn_block4")

    # Check for mismatches
    if (any(!vars_matched$asis)) {
        msg_warning <- glue::glue(
            "Variable(s) are not the same. Please check variables in rows: \n",
            "{paste0(vars_matched$input[which(!vars_matched$asis)], collapse = '; ')}"
        )
        warning(msg_warning)
    }

    # Check for missing matches
    if (any(is.na(vars_matched$chn_block4))) {
        stop("Error: raw variables not contained in target variable table.")
    }

    return(vars_matched)
}

#' @title Workflow Functions: add variables to the data.frame
#' @description Internal functions for handling various workflow tasks in the techme package.
#' @details This file contains a collection of internal functions for:
#' \itemize{
#'   \item function `get.chnPattern()`: get the pattern for Chinese variables
#'   \item function `wfl.addVars()`: add the variables to the data.frame
#' }
#' @keywords internal
#' @name workflow_funs_add_vars
NULL

#' Helper function to replace variables names in the tidy table
#' @rdname workflow_funs_add_vars
#' @description
#' This function provides an interactive way to select a collection of Chinese text patterns
#' and their replacements for standardizing variable names in the tidy table. It supports
#' various categories including agricultural machinery, fertilizer, plastic, budget, R&D,
#' and livestock data.
#'
#' @details
#' The function maintains a predefined table of patterns and replacements for different
#' categories of data. Each category may have multiple patterns and corresponding
#' replacements. The table is soft-coded in the package and can be modified as needed.
#'
#' @return list or NULL. A list containing:
#'   \itemize{
#'     \item ptn: The pattern(s) to match
#'     \item rpl: The replacement(s) for the pattern(s)
#'     \item tbl_pattern: The full pattern-replacement table
#'   }
#'   Returns NULL if option 0 is selected.
#'
#' @keywords internal
#' @importFrom dplyr filter pull
#' @importFrom tibble tribble
#' @importFrom magrittr %>%
#' @importFrom glue glue
#'
#' @examples
#' \dontrun{
#' # Interactive selection of pattern-replacement pairs
#' patterns <- get.chnPattern()
#' }
#'
get.chnPattern <- function() {
    # Define pattern-replacement table
    tbl_pattern <- tibble::tribble(
        ~case, ~ptn, ~rpl,
        "machine", c("谷物联合收割机"), c("联合收获机"),
        "fertilizer", c("农用化肥施用量"), c("化肥使用量"),
        "plastic", c("农用塑料薄膜使用量"), c("农用薄膜使用量"),
        "budget",
        c("地方一般公共预算支出", "教育支出", "科学技术支出", "农林水支出"),
        c("合计", "教育", "科学技术", "农林水"),
        "RDinner",
        c("经费内部支出"),
        c("合计"),
        "RD",
        c("有研发机构的企业数", "有R&D活动的企业数"),
        c("有研发机构", "有RD活动"),
        "IndustryRD",
        c(
            "新产品开发项目数", "新产品开发经费支出",
            "新产品销售收入", "有效发明专利数",
            "引进境外技术经费支出", "引进境外技术消化吸收经费支出"
        ),
        c(
            "开发项目数", "开发经费支出",
            "销售收入", "有效专利数",
            "技术引进经费支出", "消化吸收经费支出"
        ),
        "operation", c("营业收入"), c("主营业务收入"),
        "trade", c("进出口贸易总额"), c("贸易总额"),
        "livestock tab01", c("种畜禽场总数"), c("总数"),
        "livestock tab04",
        c("祖代及以上场", "祖代蛋鸡场", "父母代场"),
        c("祖代及以上蛋鸡场", "祖代及以上蛋鸡场", "父母代蛋鸡场"),
        "livestock tab07", c("种羊细场毛"), c("种细毛羊场"),
        "livestock tab08",
        c("祖代蛋鸡场", "祖代以上肉鸡场"),
        c("祖代及以上蛋鸡场", "祖代及以上肉鸡场")
    )

    # Display all options
    cat("Available pattern categories:\n")
    cat(" 0: Return NULL\n")
    for (i in seq_along(tbl_pattern$case)) {
        cat(sprintf("%2d: %s\n", i, tbl_pattern$case[i]))
    }

    # Interactive selection
    repeat {
        choice <- readline(prompt = "\nEnter option number (0-14): ")
        choice <- as.integer(choice)

        if (!is.na(choice)) {
            if (choice == 0) {
                cat("\nReturning NULL as requested\n")
                return(NULL)
            } else if (choice >= 1 && choice <= nrow(tbl_pattern)) {
                selected_case <- tbl_pattern$case[choice]
                selected_ptn <- tbl_pattern$ptn[[choice]]
                selected_rpl <- tbl_pattern$rpl[[choice]]

                # Display selection details
                cat(sprintf("\nSelected category: %s\n", selected_case))
                cat("Patterns to match:\n")
                for (i in seq_along(selected_ptn)) {
                    cat(sprintf("  %d. %s\n", i, selected_ptn[i]))
                }
                cat("Replacements:\n")
                for (i in seq_along(selected_rpl)) {
                    cat(sprintf("  %d. %s\n", i, selected_rpl[i]))
                }

                return(list(
                    ptn = selected_ptn,
                    rpl = selected_rpl,
                    tbl_pattern = tbl_pattern
                ))
            } else {
                cat("Invalid option, please try again\n")
            }
        } else {
            cat("Invalid input, please enter a number\n")
        }
    }
}


#' Left join the tidy table with the matched unified variables table.
#' @rdname workflow_funs_add_vars
#' @param dt_left data.frame. The tidy unpivot table.
#' @param dt_right data.frame. The matched variables table and should be checked.
#'
#' @return data.frame. A data frame containing the joined and processed data.
#' @keywords internal
#' @importFrom dplyr mutate rename left_join select filter
#' @importFrom mgsub mgsub
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' df_matched <- wfl.addVars(dt_left = df_tidy, dt_right = vars_matched)
#' }
#'
wfl.addVars <- function(dt_left, dt_right) {
    # Input validation
    if (!is.data.frame(dt_left)) {
        stop("'dt_left' must be a data.frame")
    }
    if (!is.data.frame(dt_right)) {
        stop("'dt_right' must be a data.frame")
    }
    if (!"vars" %in% names(dt_left)) {
        stop("'dt_left' must contain a 'vars' column")
    }
    if (!all(c("input", "chn_block4", "variables") %in% names(dt_right))) {
        stop("'dt_right' must contain 'input', 'chn_block4', and 'variables' columns")
    }

    # Check for required package
    if (!requireNamespace("mgsub", quietly = TRUE)) {
        stop("Package 'mgsub' is required but not installed")
    }

    # Process data
    df_matched <- dt_left %>%
        dplyr::mutate(
            vars = mgsub::mgsub(
                vars,
                pattern = dt_right$input,
                replacement = dt_right$chn_block4
            )
        ) %>%
        dplyr::rename(chn_block4 = "vars") %>%
        dplyr::left_join(., dt_right, by = "chn_block4") %>%
        dplyr::select(-input, -asis) %>%
        dplyr::filter(!is.na(variables))

    # Check results
    if (nrow(df_matched) == 0) {
        warning("No rows remained after filtering. Please check the input data.")
    }
    if (any(is.na(df_matched$chn_block4))) {
        warning("Some 'chn_block4' values are NA after joining. Please check the matching process.")
    }
    message(glue::glue("`wfl.addVars()` successfully added variables to the tidy table"))

    return(df_matched)
}



#' Write out xlsx with the output file which the file name is specified year and prefix label

#' @param dt data.frame. The data frame to write out.
#' @param file_source character. The path of the source file.
#' @param year_target numeric. The year to write out.
#' @param prefix_label character. The prefix label of the file name, default is NULL. Other value may be "funds", "ammount", etc.
#'
#' @return NULL
#' @keywords internal
#' @importFrom dplyr filter
#' @importFrom stringr str_replace_all str_detect
#' @importFrom openxlsx write.xlsx
#' @importFrom glue glue
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' wfl.writeXlsx(
#'     dt = df_matched,
#'     file_source = "data-raw/df-matched.xlsx",
#'     year_target = 2019,
#'     prefix_label = "funds"
#' )
#' }
#'
wfl.writeXlsx <- function(
    dt, file_source = file_xlsx,
    year_target, prefix_label = NULL) {
    # Input validation
    if (!is.data.frame(dt)) {
        stop("'dt' must be a data.frame")
    }
    if (!"year" %in% names(dt)) {
        stop("'dt' must contain a 'year' column")
    }
    if (!is.character(file_source)) {
        stop("'file_source' must be a character string")
    }
    if (!is.numeric(year_target)) {
        stop("'year_target' must be numeric")
    }
    if (!is.null(prefix_label) && !is.character(prefix_label)) {
        stop("'prefix_label' must be NULL or a character string")
    }

    # Get the target directory
    dir_target <- dirname(file_source) %>%
        stringr::str_replace_all("data-raw", "data-raw/data-tidy")

    # Generate the target file names
    if (is.null(prefix_label)) {
        file_target <- paste0(dir_target, "/", year_target, ".xlsx")
    } else {
        file_target <- paste0(dir_target, "/", prefix_label, "-", year_target, ".xlsx")
    }

    # Display target file paths and ask for confirmation
    message(glue::glue("The following files will be created:"))
    for (file in file_target) {
        message(glue::glue("\n{file}"))
    }

    # Interactive confirmation
    repeat {
        response <- readline(prompt = "\nDo you want to proceed? (y/n): ")
        if (tolower(response) %in% c("y", "n")) {
            break
        }
        message("Please enter 'y' for yes or 'n' for no")
    }

    if (tolower(response) == "n") {
        message("Operation cancelled by user")
        return(invisible(NULL))
    }

    # Create target directory if it doesn't exist
    if (!dir.exists(dir_target)) {
        dir.create(dir_target, recursive = TRUE)
        message(glue::glue("Created directory: {dir_target}"))
    }

    # Loop to write out the data
    for (id_year in year_target) {
        # Filter the data by year
        dt_year <- dt %>%
            # convert year to character
            dplyr::mutate(year = as.character(year)) %>%
            # filter the data by year
            dplyr::filter(year == as.character(id_year))
        n_rows <- nrow(dt_year)
        # Check if data exists for the year
        if (n_rows == 0) {
            warning(glue::glue("No data found for year {id_year}"))
            next
        }

        file_out <- file_target[which(stringr::str_detect(file_target, as.character(id_year)))]

        # Write out the data
        tryCatch(
            {
                openxlsx::write.xlsx(dt_year, file_out)
                message(glue::glue("Successfully exported file for year {id_year} with {n_rows} rows"))
            },
            error = function(e) {
                warning(glue::glue("Failed to export file for year {id_year}: {e$message}"))
            }
        )

        Sys.sleep(0.1)
    }
}

#' @title Workflow Functions: use data
#' @description Internal functions for handling various workflow tasks in the techme package.
#' @details This file contains a collection of internal functions for:
#' \itemize{
#'   \item function `choose.nameData()`: choose the name of `use_data()`
#'   \item function `wfl.useData()`: use the data with `use_data()`
#' }
#' @keywords internal
#' @name workflow_funs_use_data
NULL

#' Helper function to choose the name of `use_data()`
#' @rdname workflow_funs_use_data
#' @description
#' This function provides an interactive way to select a data name from a predefined list.
#' It displays all available options and allows the user to choose by entering a number.
#'
#' @param name.dt character. The name of the data frame.
#' @return character or NULL. The selected data name from the list, or NULL if option 0 is selected.
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # Interactive selection of data name
#' selected_name <- choose.nameData()
#' }
#'
choose.nameData <- function() {
    ## settings: available data name items
    ## the data name has uniform format style as "AgriMachine", "LivestockBreeding", etc.
    ## this table is soft-coded in the package, you can change the data name as you need
    use_list <- c(
        "AgriMachine",
        "AgriFertilizer",
        "AgriPlastic",
        "AgriPesticide",
        "PublicBudget", # 5
        "RDIntense",
        "RDActivity",
        "MarketPull",
        "MarketPush",
        "HitechFirmsPub", # 10
        "IndustryTrade",
        "IndustryRD",
        "IndustryOperation",
        "LivestockBreeding" # 14
    )

    # Display all options
    cat("Available data name options:\n")
    cat(" 0: Return NULL\n")
    for (i in seq_along(use_list)) {
        cat(sprintf("%2d: %s\n", i, use_list[i]))
    }

    # Interactive selection
    repeat {
        choice <- readline(prompt = "\nEnter option number (0-14): ")
        choice <- as.integer(choice)

        if (!is.na(choice)) {
            if (choice == 0) {
                cat("\nReturning NULL as requested\n")
                return(NULL)
            } else if (choice >= 1 && choice <= length(use_list)) {
                selected_name <- use_list[choice]
                cat(sprintf("\nSelected: %s\n", selected_name))
                return(selected_name)
            } else {
                cat("Invalid option, please try again\n")
            }
        } else {
            cat("Invalid input, please enter a number\n")
        }
    }
}

#' Read the raw xlsx files and use the specified data.frame by use_data()
#' @rdname workflow_funs_use_data
#' @param directory.source character. The path of the source xlsx files.
#' @param file.pattern character. The pattern of the file name.
#' @param name.dt character. The name of the data frame.
#' And the name has uniform format style as "AgriMachine", "LivestockBreeding", etc.
#' @param which.dt character. The name of the data frame to use, default is "df_use".
#'
#' @return NULL
#' @keywords internal
#' @importFrom openxlsx read.xlsx
#' @importFrom dplyr mutate rename left_join select bind_rows
#' @importFrom stringr str_detect
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @importFrom usethis use_data
#' @importFrom rlang .data
#'
#' @examples
#' \dontrun{
#' wfl.useData(
#'     directory.source = "data-raw/data-tidy/",
#'     file.pattern = "\\d{4}",
#'     name.dt = "AgriMachine",
#'     which.dt = "df_use"
#' )
#' }
#'
wfl.useData <- function(
    directory.source, file.pattern,
    name.dt,
    which.dt = "df_use") {
    # Input validation
    if (!is.character(directory.source) || length(directory.source) != 1) {
        stop("'directory.source' must be a single character string")
    }
    if (!is.character(file.pattern) || length(file.pattern) != 1) {
        stop("'file.pattern' must be a single character string")
    }
    if (!is.character(name.dt) || length(name.dt) != 1) {
        stop("'name.dt' must be a single character string")
    }
    if (!is.character(which.dt) || length(which.dt) != 1) {
        stop("'which.dt' must be a single character string")
    }
    if (!which.dt %in% c("df_use", "df_units")) {
        stop("'which.dt' must be either 'df_use' or 'df_units'")
    }

    # Check if directory exists
    if (!dir.exists(directory.source)) {
        stop("Directory does not exist: ", directory.source)
    }

    # loop read raw xlsx files with specific pattern
    files_all <- list.files(directory.source)
    files_id <- which(stringr::str_detect(files_all, file.pattern))
    files_sel <- files_all[files_id]
    files_path <- paste0(directory.source, "/", files_sel)

    if (length(files_path) == 0) {
        stop("No files found matching the pattern: ", file.pattern)
    } else {
        message(glue::glue("Found {length(files_path)} files matching the pattern: {paste0(files_sel, collapse = ', ')}"))
    }

    # loop read xlsx files
    df_use <- NULL
    i <- 1
    for (i in length(files_path):1) {
        tryCatch(
            {
                df_tem <- openxlsx::read.xlsx(files_path[i]) %>%
                    dplyr::mutate(units = as.character(units))
                message(glue::glue("Read file {files_sel[i]} has finished!"))
                Sys.sleep(0.1)
                df_use <- dplyr::bind_rows(df_use, df_tem)
            },
            error = function(e) {
                warning(glue::glue("Failed to read file {files_sel[i]}: {e$message}"))
            }
        )
    }

    if (is.null(df_use)) {
        stop("No data was successfully read from any files")
    } else {
        message(glue::glue("Successfully read {nrow(df_use)} rows from {length(files_path)} files"))
    }

    # assign data to the global environment on condition with `which_dt`
    if (which.dt == "df_use") {
        ## assign data table
        do.call("assign", list(name.dt, as.name(which.dt)))
        message("assign type of `df_use` data set successed!")
    } else if (which.dt == "df_units") {
        ## prepare system variables table
        if (!requireNamespace("techme", quietly = TRUE)) {
            stop("Package 'techme' is required but not installed")
        }
        varsList <- get("varsList", envir = asNamespace("techme"))
        ## selected system variables table
        df_base <- varsList %>%
            dplyr::select(variables, units) %>%
            dplyr::rename(units_base = "units")
        ## match units
        df_units <- dplyr::left_join(df_use, df_base, by = "variables") %>%
            dplyr::mutate(units = !!sym("units_base")) %>%
            dplyr::select(-!!sym("units_base"))

        ## assign data table
        do.call("assign", list(name.dt, as.name(which.dt)))
        message("assign type of `df_units` data set successed!")
    }

    ## use data
    do.call("use_data", list(as.name(name.dt), overwrite = TRUE))
    message(glue::glue("use_data() for `{name.dt}` successed!"))
}

#' Help Document the Variables List of Data Set for Package Development

#' @description
#' This function generates documentation template for data frame variables in Roxygen2 format.
#' It creates a list of variable entries that can be used in the \code{@format} section
#' of data documentation.
#'
#' @details
#' The function takes a data frame as input and generates documentation entries for each variable
#' in the format required by Roxygen2. This is particularly useful when documenting datasets
#' in R packages.
#'
#' @param df data.frame. The data frame to document.
#'
#' @return NULL. The function prints the documentation template to the console.
#'
#' @keywords internal
#' @importFrom utils str
#'
#' @examples
#' \dontrun{
#' data(ProvinceCity)
#' help.document(ProvinceCity)
#' }
#'
help.document <- function(df) {
    # Input validation
    if (!is.data.frame(df)) {
        stop("'df' must be a data frame")
    }
    if (ncol(df) == 0) {
        stop("'df' must have at least one column")
    }

    # Get variable names and their classes
    var_names <- names(df)
    var_classes <- sapply(df, function(x) class(x)[1])

    # Generate documentation entries
    doc_entries <- paste0(
        "#'   \\item{", var_names, "}{",
        "\\code{", var_classes, "}. }"
    )

    # Print header
    cat("#' @format A data frame with", nrow(df), "rows and", ncol(df), "variables:\n")
    cat("#' \\describe{\n")

    # Print variable documentation
    cat(paste(doc_entries, collapse = "\n"), "\n")

    # Print footer
    cat("#' }\n")
}
