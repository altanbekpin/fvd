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

# Find the last row index in the sheet
last_row_index = sheet.nrows - 1

# Delete the last row by copying the contents of the previous rows
for row_index in range(last_row_index):
    for col_index in range(sheet.ncols):
        value = sheet.cell(row_index, col_index).value
        sheet_copy.write(row_index, col_index, value)

# Save the changes to a new file (or overwrite the existing one)
workbook_copy.save("modified_file.xls")

print("Last row deleted successfully!")