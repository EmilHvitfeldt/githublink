githublink <- function() {
  description <- desc::desc()

  urls <- description$get_urls()
  package_name <- description$get("Package")

  # This feel non-ideal
  url <- urls[grepl("github.com/.*/.*", urls)]

  ctx <- rstudioapi::getActiveDocumentContext()

  start <- ctx$selection[[1]]$range$start[[1]]
  end <- ctx$selection[[1]]$range$end[[1]]

  # This feel non-ideal
  file_path <- sub(paste0(".*", package_name, "?"), "", ctx$path)

  range <- ifelse(
    start == end,
    paste0("L", start),
    paste0("L", start, "-", "L", end)
  )


  if (clipr::clipr_available()) {
    x <- paste0(url, "/blob/main", file_path, "#", range)
    clipr::write_clip(x)
    cat("[Path copied to clipboard]")
  }
}
