
#' Export chunk plot to editable xlsx file
#'
#' @param p   ggplot object.
#' @param dir character. relative dir path string
#' @param num_section integer. default 2
#' @param num_fig character.
#' @param names_chunk  character. name  of chunk, from which the plot generateed.
#'
#' @import officer
#' @import rvg
#'
#'
#' @return output xlsx file
#' @export gg2xlsx
#'
#' @examples
#' \dontrun{
#'   p0 <- plot(1:10, 1:10)
#'   gg2xlsx(p = p0, dir="pic/ggsave-xlsx/",
#'         num_section = 5,num_fig = 2,
#'         names_chunk = "ggplot-chunk")
#' }

gg2xlsx <- function(p, dir="pic/ggsave-xlsx/",
                    num_section=2, num_fig, names_chunk){

  path_out <- paste0(dir, "Figure",
                     num_section, "-", num_fig, "-",
                     names_chunk,
                     ".xlsx")

  #my_vec_graph <- dml(code = p)
  doc <- officer::read_xlsx()
  doc <- rvg::xl_add_vg(doc, sheet = "Feuil1",code = print(p),
                   width = 12, height = 7, left = 1, top = 2 )
  print(doc, target = path_out)
}

