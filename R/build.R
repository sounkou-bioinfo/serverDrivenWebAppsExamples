#' Build
#' 
#' Build the application
#' 
#' @import ambiorix
#' 
#' @return An object of class `Ambiorix`.
#' 
#' @export 
build <- \(...) {

  
  # create app instance
 
  app <- Ambiorix$new()

  # 404 page
  app$not_found <- render_404

  # 500 server errors
  app$error <- render_500

  # serve static files
  app$static(assets_path(), "static")


  app$get("/", landing_get)

  # homepage
  app$get("/ambiorix", ambiorix_get)

  # version

  app$get("/version", ambiorix_version_get)

  # about
  app$get("/about", about_get)

  # contact
  app$get("/contact", contact_get)

  app$post("/contact", contact_post)


  return(app)
}
