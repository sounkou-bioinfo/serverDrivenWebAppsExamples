#' landing_get
#' 
#' Render the landing page.
#' 
#' @inheritParams handler
#' 
#' @name views
#' 
#' @keywords internal
landing_get <- \(req, res){
  res$render(
    template_path("landingpage.html"),
    list(
      title = "Hello from R", 
      subtitle = "This is rendered with {glue}"
    )
  )
}

#' Home
#' 
#' Render the homepage.
#' 
#' @inheritParams handler
#' 
#' @name views
#' 
#' @keywords internal
ambiorix_get <- \(req, res){
  res$render(
    template_path("ambiorix.html")
  )
}


ambiorix_version_get <- \(req, res) {
  res$sendf("Ambiorix version %s", packageVersion("ambiorix"))
}