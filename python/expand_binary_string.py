import pandas as pd


def split_binary_string_columns(df, binary_columns, none_of_these, missing_values):
       
    """
    function that takes columns of form "0101011" and splits out to 
    individual columns for each individual value
    
    Args:
        df: the input dataframe with binary strings
        binary_columns: the columns to convert
        none_of_these: the value in the data that means none of the options 
        were selected
        missing_values: Any values in the data that relate to missingness
    
    Output:        
        df: a dataframe with binary strings expanded
    """
     
    
    def split_binary_string(string): 
        
        """
        function that returns a list representing the binary string
        
        Args:
            string: the value of the binary string    
            
        """
        
        if string == none_of_these:
            return [int(no_value) for char in range(max_length)]
        elif string in missing_values:
            return [int(string) for char in range(max_length)]
        else:
            return [int(no_value) if char =='0' else yes_value for char in string]    
            
    for col in binary_columns:     
        max_length = df[col].map(len).max()  # determines lenghts of strings
        binary_columns_df = pd.DataFrame(df[col].apply(split_binary_string).tolist())
        binary_columns_df.columns = [f'{col}_{i}' for i in range(binary_columns_df.shape[1])]
        df = pd.concat([df, binary_columns_df], axis=1)
        df.drop(columns=[col], inplace=True)

    return df

"""
Example usage: 
    
Usage here assumes data has been read into a Pandas dataframe
    
"""
data = {
    'binary_string1': ["-10", "010100", "010110", "000100", "010111"],
    'binary_string2': ["110011", "101010", "-9", "-8", "001101"],
    'text_col': ['a', 'b', 'c', 'd', 'e'],
    'int_col': [1, 2, 3, 4, 5]
}

# create pandas dataframe
df = pd.DataFrame(data)

# the columsn to act on
binary_columns = ['binary_string1', 'binary_string2']

# special values
none_of_these = "-10"   # equivalent to no to all options
no_value = "2" # value to use for 'no' answers
missing_values = ["-8", "-9"]  # Missing
yes_value = "1" # value to use for 'yes' answers

# call the function
modified_df = split_binary_string_columns(df, binary_columns,
                                          none_of_these, missing_values)

#prints the result
with pd.option_context('display.max_rows', None,
                       'display.max_columns', None,
                       'display.precision', 3,
                       ):
    print(modified_df)