
dotenv::load_dot_env(file = ".env")


#--- Set port
AMBIORIX_PORT <- Sys.getenv(
        "AMBIORIX_PORT",
        "1995") 
# check if within shinyserver runner
AMBIORIX_PORT  <- Sys.getenv("SHINY_PORT", AMBIORIX_PORT)
AMBIORIX_PORT <- as.integer(AMBIORIX_PORT)
# load package functions
pkgload::load_all()
# run the app
build()$start(port = AMBIORIX_PORT)
