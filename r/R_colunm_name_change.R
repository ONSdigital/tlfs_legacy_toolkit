# Function to read CSV file
read_csv <- function(file_path) {
  
  # Simple function to read in a csv. 
    
  # Args:
    # file_path: the filepath of the file to read in 
  
  # Output:
  
    # data: an object contain the contents of the csv
  
  data <- read.csv(file_path, header = TRUE, stringsAsFactors = FALSE)
  return(data)
}

# Function to update column names
update_column_names <- function(original_data, name_changes_data) {
  
  # Simple function to alter column names in a csv
    
  # Args:
    # original_csv: filepath of the source data you wish to change
    # name_changes_csv: filepath of csv that specifies name changes to apply
        
  # Output:        
    # Updated_data: input data with new column names
  
  original_headers <- colnames(original_data)
  name_changes_dict <- setNames(name_changes_data$alternative_name, name_changes_data$standardised_name)
  updated_headers <- ifelse(original_headers %in% names(name_changes_dict), name_changes_dict[original_headers], original_headers)
  colnames(original_data) <- updated_headers
  return(original_data)
}

# Function to save CSV file
save_csv <- function(data, file_path) {
  
  # Simple function to save data in a csv. 
    
  # Args:
    # data: the input data in list format
    # file_path: the filepath to save the data to 
  
  write.csv(data, file = file_path, row.names = FALSE)
}

# Example CSV file paths
original_csv <- "original.csv"
name_changes_csv <- "name_changes.csv"
updated_csv <- "updated.csv"

dir <-"\\file\\path\\here"
setwd(dir)

# Read CSV files
original_data <- read_csv(original_csv)
name_changes_data <- read_csv(name_changes_csv)

# Apply changes to column names
updated_data <- update_column_names(original_data, name_changes_data)

# Save updated CSV
save_csv(updated_data, updated_csv)

cat("CSV file updated and saved successfully!\n")
