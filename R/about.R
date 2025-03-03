#' About
#' 
#' Render the about.
#' 
#' @inheritParams handler
#' 
#' @name views
#' @keywords internal
about_get <- \(req, res) {
  res$send(
     '<a href="https://ambiorix.dev" ><img alt="ambiorix.dev" src="https://ambiorix.dev/media/ambiorix-new_hu10004670333363137900.webp" /></a>' 
  )
}
