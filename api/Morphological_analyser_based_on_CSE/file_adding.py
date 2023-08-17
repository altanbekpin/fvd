import xlrd
from xlutils.copy import copy
import os

# Load the existing workbook
affixes_fn = os.path.join(os.path.dirname(__file__), "Endings.xls")
workbook = xlrd.open_workbook("Endings.xls")
sheet = workbook.sheet_by_index(0)  # Assuming you want to work with the first sheet

# Create a copy of the workbook for editing
workbook_copy = copy(workbook)
sheet_copy = workbook_copy.get_sheet(0)

# Data for the new row (assuming a list of values)
new_row_data = ["ылса", "<NB>*ыл<pl>*са<pl>"]

# Find the last row index in the sheet
last_row_index = sheet.nrows

# Add the new row data to the copy of the sheet
for col_index, value in enumerate(new_row_data):
    sheet_copy.write(last_row_index, col_index, value)

# Save the changes to a new file (or overwrite the existing one)
workbook_copy.save("modified_file.xls")

print("Row added successfully!")
