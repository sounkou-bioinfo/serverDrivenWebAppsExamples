#' crud Page
#' 
#' fetch the crud page
#' 
#' @inheritParams handler
#' 
#' @keywords internal
crud_page_get <- \(req, res) {
  res$render(
    template_path("crud.html")
  )
}


dataEnv <- new.env( parent = .GlobalEnv)

dataEnv$dogs <- data.frame(
    id = c(),
    name = c(),
    breed= c()
)

addDog <- \(name, breed, dataenv = dataEnv) {
  dataenv$dogs <- rbind(
                  dataenv$dogs, 
                  data.frame(
                  id = uuid::UUIDgenerate(),  
                  name = name, 
                  breed = breed)
                  )
  }


#' @keywords internal
dog_post <- \(req, res) {
 response <-  webutils::parse_http(
    body = req$rook.input$read(),
    content_type = req$CONTENT_TYPE
  )
  print(dataEnv$dogs)
  addDog(
    name = response$name,
   breed = response$breed,
  dataenv = dataEnv)
  res$set_status(200L)
}


addDogRow <- \(name, breed, id) {

glue::glue('
<tr class="on-hover">
<td>{{name}}</td>
<td>{{breed}}</td>
<td class="buttons">
<button
class="show-on-hover"
hx-delete="/dog/{{id}}"
hx-confirm="Are you sure?"
hx-target="closest tr"
hx-swap="delete">
</button>
</td>
</tr>
', .open = "{{", .close  = "}}")

}

#' table_rows_get
#' 
#' fetch the crud page
#' 
#' @inheritParams handler
#' 
#' @keywords internal
table_rows_get <- \(req, res) {
  rows <- NULL
  try({
  rows <- do.call("c", 
  lapply(
    1:nrow(dataEnv$dogs),
    FUN = \(row) {
      addDogRow(
      name =  dataEnv$dogs$name[row], breed = dataEnv$dogs$breed[row],
      id = dataEnv$dogs$id[row]
      )
  })) |>
  paste(x = _ , collapse = "")
 
}) 
if(is.null(rows)) {
  res$set_status(500L)
  res$send("Internal server error")
} else{
  res$set_status(200L)
  res$send(rows)
}
}


#' dog_delete
#' 
#' remove a dog from the data frame
#' 
#' @inheritParams handler
#' 
#' @keywords internal
dog_delete <- \(req, res) {
  id <- req$params$id
  dataEnv$dogs <- dataEnv$dogs[-which(dataEnv$dogs$id == id),]
  res$set_status(200L)
}
