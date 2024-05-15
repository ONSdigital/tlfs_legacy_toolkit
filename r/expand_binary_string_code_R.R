split_binary_string_columns <- function(df, binary_columns, none_of_these, missing_values) {
  
  # A simple function that splits binary strings of the format 01010 into separate columns
  
  
  # Args:
  #  df: the input dataframe with binary strings
  #  binary_columns: the columns to convert
  #  none_of_these: the value in the data that means none of the options were selected
  #  missing_values: Any values in the data that relate to missingness
  
  # Output:        
  #  df: a dataframe with binary strings expanded
  
  split_binary_string <- function(string, no_value, yes_value, max_length) {
    
    # function that returns a list representing the binary string
        
    # Args:
    #   string: the value of the binary string
    #   no_value: value to use for no
    #   yes_value: value to use for yes
    #   max_length: length of the binary strings
     
    if (string == none_of_these) {
       return(rep(c(no_value),each=max_length))
    } else if (string %in% missing_values) {
      return(rep(c(string),each=max_length))
    } else {
      return (as.numeric(unlist(rapply(strsplit(string,""), f=function(x) ifelse(x==0,no_value,yes_value), how="replace"))))
    }
  }
  
  for (col in binary_columns) {
    max_length <- max(nchar(df[[col]]))
    binary_columns_df <- as.data.frame(t(sapply(df[[col]], split_binary_string, no_value = 2, yes_value = 1, max_length)), row.names = FALSE)
    colnames(binary_columns_df) <- paste0(col, "_", 0:(ncol(binary_columns_df) - 1))
    df <- cbind(df, binary_columns_df)
    df <- df[, !names(df) %in% col, drop = FALSE]
  }
  
  return(df)
}

# Example usage:
data <- data.frame(
  binary_string1 = c("-10", "010100", "010110", "000100", "010111"),
  binary_string2 = c("110011", "101010", "-9", "-8", "001101"),
  text_col = c('a', 'b', 'c', 'd', 'e'),
  int_col = c(1, 2, 3, 4, 5)
)

# The columns to act on
binary_columns <- c('binary_string1', 'binary_string2')

# Special values
none_of_these <- "-10"   # A shortcut respondents can provide. Essentially means no to options
missing_values <- c("-8", "-9")  # Keep as is. Means missing

# Call the function
modified_df <- split_binary_string_columns(data, binary_columns, none_of_these, missing_values)

# Print the result
print(modified_df)

