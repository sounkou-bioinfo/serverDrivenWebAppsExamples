
dotenv::load_dot_env(file = ".env")

AMBIORIX_PORT <- Sys.getenv(
        "AMBIORIX_PORT",
        1995L) |>
        as.integer()
# load package functions
pkgload::load_all()
# run the app
build()$start(port = AMBIORIX_PORT)
