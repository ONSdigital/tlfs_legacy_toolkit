import csv
import os

def read_csv(file_path):
    
    """
    Simple function to read in a csv. 
    
    Args:
        file_path: the filepath of the file to read in 
        
    Output:        
        data: a list object containg the contents of the csv
    """
   
    
    data = []
    with open(file_path, 'r', newline='') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            data.append(row)
    return data

def update_column_names(original_csv, name_changes_csv):
    
    """
    Simple function to alter column names in a csv
    
    Args:
        original_csv: filepath of the source data you wish to change
        name_changes_csv: filepath of csv that specifies name changes to apply
        
    Output:        
        updated_data: input data with new column names
    """
    
    original_data = read_csv(original_csv)
    print(type(original_data))
    name_changes_data = read_csv(name_changes_csv)
    
    original_headers = original_data[0]
    name_changes_dict = {row[0]: row[1] for row in name_changes_data}
    
    updated_headers = [name_changes_dict.get(header, header) for header in original_headers]
    updated_data = [updated_headers] + original_data[1:]
    
    return updated_data

def save_csv(data, file_path):
    
    """
    Simple function to save data in a csv. 
    
    Args:
        data: the input data in list format
        file_path: the filepath to save the data to 
 
    """
    
    with open(file_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(data)

if __name__ == "__main__":
    # Example CSV file paths
    
    data_filepath = "\\file\\path\\here" # use "\\" not "\"
    original_csv_filename = "original.csv"
    name_changes_csv_filename = "name_changes.csv"
    updated_csv_filename = "updated.csv"    

    # Apply changes to column     
    original_csv = os.path.join(data_filepath, original_csv_filename)
    name_changes_csv = os.path.join(data_filepath, name_changes_csv_filename)
    updated_csv = os.path.join(data_filepath, updated_csv_filename)

    updated_data = update_column_names(original_csv, name_changes_csv)
    
    # Save updated CSV
    save_csv(updated_data, updated_csv)
    
    print("CSV file updated and saved successfully!")
