# Create connection
con <- DBI::dbConnect(duckdb::duckdb(), dbdir = "todolist.duckdb")
# Remove any existing tables first
DBI::dbExecute(con, "DROP TABLE IF EXISTS tasks;")
DBI::dbExecute(con, "DROP TABLE IF EXISTS categories;")
DBI::dbExecute(con, "DROP SEQUENCE IF EXISTS seq_category_id;")

# Create categories table (without PRIMARY KEY constraint)
DBI::dbExecute(con, "
CREATE TABLE IF NOT EXISTS categories (
    category_id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(200)
);")

# Create sequence for categories
DBI::dbExecute(con,
"CREATE SEQUENCE IF NOT EXISTS seq_category_id START 1;")

# Create tasks table
DBI::dbExecute(con, "
CREATE TABLE IF NOT EXISTS tasks (
    task_id INTEGER PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    due_date DATE,
    status VARCHAR(20) DEFAULT 'pending',
    priority INTEGER DEFAULT 1,
    category_id INTEGER,
    created_at TIMESTAMP,
    completed_at TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);")

# Create indexes
DBI::dbExecute(con, "CREATE INDEX IF NOT EXISTS idx_tasks_status ON tasks(status);")
DBI::dbExecute(con, "CREATE INDEX IF NOT EXISTS idx_tasks_due_date ON tasks(due_date);")

# Insert categories
categories_data <- data.frame(
    category_id = 1:3,
    name = c('Work', 'Personal', 'Shopping'),
    description = c('Work-related tasks', 'Personal tasks', 'Shopping list items')
)
DBI::dbAppendTable(con, "categories", categories_data)

# Insert tasks
tasks_data <- data.frame(
    task_id = 1:5,
    title = c('Complete project report', 'Buy groceries', 'Schedule dentist appointment', 
              'Team meeting preparation', 'Gym session'),
    description = c('Write and submit Q4 project summary', 'Milk, bread, eggs, vegetables',
                   'Annual checkup', 'Prepare slides for weekly sync', 'Cardio and strength training'),
    due_date = as.Date(c('2024-01-15', '2024-01-10', '2024-01-20', '2024-01-12', '2024-01-09')),
    status = 'pending',
    priority = c(3, 2, 1, 2, 1),
    category_id = c(1, 3, 2, 1, 2),
    created_at = Sys.time(),
    completed_at = NA
)
DBI::dbAppendTable(con, "tasks", tasks_data)

# Print categories table
cat("\nCategories Table:\n")
print(DBI::dbReadTable(con, "categories"))

# Print tasks table
cat("\nTasks Table:\n")
print(DBI::dbReadTable(con, "tasks"))

# Close connection
DBI::dbDisconnect(con, shutdown = TRUE)

