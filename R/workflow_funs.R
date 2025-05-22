#' @title Workflow Functions
#' @description Internal functions for handling various workflow tasks in the techme package.
#' @details This file contains a collection of internal functions for:
#' \itemize{
#'   \item Converting and processing Excel files
#'   \item Unpivoting data tables
#'   \item Matching and standardizing variables
#'   \item Writing output files
#' }
#' @keywords internal
#' @name workflow_funs
NULL

# Declare global variables
utils::globalVariables(c(
    "chr", "row_index", "row_end", "row_start", "col_start", "col_end",
    "year", "file_xls", "vars_tot", "value", "input", "asis", "variables",
    "varsList", "target", "file_xlsx"
))

#' @importFrom dplyr mutate filter select rename left_join bind_rows
#' @importFrom stringr str_detect str_extract str_replace str_replace_all str_trim
#' @importFrom XLConnect loadWorkbook getSheets readWorksheet
#' @importFrom openxlsx createWorkbook addWorksheet writeData saveWorkbook write.xlsx
#' @importFrom unpivotr as_cells behead
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @importFrom mgsub mgsub
#' @importFrom purrr map_chr
#' @importFrom tibble tibble add_row add_column

#' @title Search for files in a directory
#' @rdname workflow_funs
#' @param directory character. Path to search for files
#' @param pattern character. Pattern to match files
#'
#' @return character vector of file paths
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' wfl.findFiles(directory = "data-raw", pattern = "\\.xlsx$")
#' }
#'
wfl.findFiles <- function(directory, pattern) {
    files <- list.files(directory, pattern = pattern, recursive = TRUE, full.names = TRUE)
    if (length(files) == 0) {
        stop("No files found matching the pattern: ", pattern)
    }
    if (length(files) == 1) {
        print(glue::glue("Only one file found matching the pattern: {pattern}"))
        return(files)
    }
    if (length(files) > 1) {
        print(glue::glue("Multiple files found matching the pattern: {pattern}"))
        return(files)
    }
    return(files)
}

#' Convert protected xls file to xlsx file, and remove unnecessary sheet.
#' This function will remove the xls file permission protected by CNKI.
#' @rdname workflow_funs
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


#' Get range of xlsx file's pivot table with target regex pattern
#' @rdname workflow_funs
#' @param dt data.frame. Which is the wb object reading from xlsx file.
#' @param ith number. when exist multiple table region in one sheet.
#' @param what character. What is the object function will return, whether "row" or "col".
#' @param reg_start character. regex pattern for start identifier, default \code{'^地.*区'}.
#' @param reg_end character. regex pattern for end identifier, default \code{'^新.*疆'}.
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

    # Search along columns，get the index of the region identifier
    range_row <- sapply(
        dt_detect_region,
        function(x) {
            which(stringr::str_detect(x, "TRUE"))
        }
    )

    # Filter index，detect the columns which contain the region identifier
    index_row <- range_row %>%
        sapply(., function(x) {
            length(x) != 0
        })

    # Create data frames for row and column indices
    ## rows start and end index
    df_row <- range_row[which(index_row == TRUE)] %>%
        data.frame() %>%
        # rename the first column to row_index
        dplyr::rename(row_index = 1) %>%
        # create start and end columns with odd and even row index value in Column 1
        dplyr::mutate(row_start = ifelse(row_index %% 2 == 0, row_index, NA)) %>%
        dplyr::mutate(row_end = ifelse(row_index %% 2 == 1, row_index, NA)) %>%
        # lead calculation to get the end row index
        dplyr::mutate(row_end = lead(row_end)) %>%
        dplyr::select(row_start, row_end) %>%
        # tidy and filter NA
        dplyr::filter(!is.na(row_end))
    ## column start and end index
    ## max column number
    col_max <- dim(dt_detect_region)[2]
    df_col <- which(index_row == TRUE) %>%
        # t() %>%
        data.frame() %>%
        dplyr::rename(col_start = 1) %>%
        # add the last column index +1, and it will be minus 1 in the next step
        tibble::add_row(col_start = col_max + 1) %>%
        # lead calculation to get the end column index
        dplyr::mutate(col_end = lead(col_start) - 1) %>%
        # tidy and filter NA
        dplyr::filter(!is.na(col_end))

    # Check dimensions by row numbers, keep the same dimension for both row and column data.frame
    if (dim(df_row)[1] > dim(df_col)[1]) {
        message("more than one tables in one sheet and keep in the same column range.")
        # add row dimension to the column data.frame as the same dimension as row data.frame
        df_col_added <- data.frame(
            col_start = rep(NA, dim(df_row)[1] - dim(df_col)[1]),
            col_end = rep(NA, dim(df_row)[1] - dim(df_col)[1])
        )
        df_col <- dplyr::bind_rows(df_col, df_col_added) %>%
            # fill down the column index
            tidyr::fill(col_start, .direction = "down") %>%
            tidyr::fill(col_end, .direction = "down")
    } else if (dim(df_row)[1] == dim(df_col)[1]) {
        df_col <- df_col
    } else {
        stop("Row and column dimensions do not match. Please check the identifier patterns!")
    }
    n_tbl <- dim(df_col)[1]

    # Get row and column ranges
    rows <- seq(df_row[ith, "row_start"], df_row[ith, "row_end"])
    cols <- seq(df_col[ith, "col_start"], df_col[ith, "col_end"])

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
#' @rdname workflow_funs
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
            tibble::add_column(year = stringr::str_extract(file_xls, "\\d{4}"))
    } else if (header.mode == "vars-vars") { # header mode 3
        dt_cell <- dt_cell %>%
            unpivotr::behead("up-left", vars_tot) %>%
            unpivotr::behead("up", vars) %>%
            dplyr::mutate(vars = dplyr::if_else(is.na(vars), vars_tot, vars)) %>%
            unpivotr::behead("left-up", province) %>%
            tibble::add_column(year = stringr::str_extract(file_xls, "\\d{4}")) %>%
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
#' @rdname workflow_funs
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
        warning("No unit information found in the data.")
        return(character(0))
    }

    return(info_list)
}

#' Main function to loop unpivot all the sheets in the xlsx file.
#' Keep in mind that a sheet may contains multiple pivot tables.
#' @rdname workflow_funs
#' @param file character. Path to the xlsx file.
#' @param header.mode character. One of the four options:  'vars-year', 'vars', 'vars-vars','year'
#' @param vars.add character. if header.mode = 'year', then the vars.add must be specified,
#'   And you can use the function \code{get_vars()} to get the variable name.
#' @param cols.drop vector. Columns numbers which will be dropped, default \code{NULL}.
#' @param pattern.table character. Regex pattern for table identifier, default \code{'续表'}.
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
#'     pattern.table = "^地.*区"
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
        # i <- 4
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
#' @rdname workflow_funs
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
            vars = stringr::str_replace_all(vars, "_", ""),
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


#' Helper function to get the best matched of specified character vectors.
#'
#' @param word character. The word to match.
#' @param charvec character vector. The vector of words to match against.
#'
#' @return character. The best matched word from charvec.
#' @keywords internal
#' @importFrom stringdist stringsim
#'
#' @examples
#' \dontrun{
#' get.best.match("农业机械", c("农业机械", "农业机械总动力"))
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
#'
#' @rdname workflow_funs
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
    vars_tbl <- get_vars(varsList,
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



#' Left join the tidy table with the matched unified variables table.
#'
#' @rdname workflow_funs
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

    return(df_matched)
}



#' Write out xlsx with the output file which the file name is specified year and prefix label
#'
#' @rdname workflow_funs
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
