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
  #library(future.mirai)
  #plan(mirai_multisession)
 
 
  # create app instance
  app <- ambiorix::Ambiorix$new()
  # 404 page
  app$not_found <- render_404

  # 500 server errors
  app$error <- render_500

  # serve static files
  app$static(assets_path(), "static")

  # homepage
  app$get("/", landing_get)

  # version
  app$get("/ambiorix", ambiorix_get)
  app$get("/version", ambiorix_version_get)
  # about
  app$get("/about", about_get)

  # contact
  app$get("/contact", contact_get)
  app$post("/contact", contact_post)
  
  # simple crud
  app$get("/crud", crud_page_get)
  app$post("/dog", dog_post)
  app$get("/table-rows", table_rows_get)
  app$delete("/dog/:id", dog_delete)


  # test async
  #app$get("/async", \(req, res){
  #future({
  #  Sys.sleep(1)
  #  res$sendf(Sys.time() |> as.character())
  #})
#})


  return(app)
}
