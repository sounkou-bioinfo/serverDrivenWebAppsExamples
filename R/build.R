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

  # future mirai 
  library(future.mirai)
  plan(mirai_multisession)
  # create app instance
 
  app <- ambiorix::Ambiorix$new()

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

  # test async

  app$get("/async", \(req, res){
  future({
    Sys.sleep(1)
    res$sendf(Sys.time() |> as.character())
  })
})


  return(app)
}
