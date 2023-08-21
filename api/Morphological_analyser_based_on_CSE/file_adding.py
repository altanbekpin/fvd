import xlrd
from xlutils.copy import copy
import os

def addRowTofile(new_row_data):
    # Load the existing workbook
    affixes_fn = os.path.join(os.path.dirname(__file__), "Endings.xls")
    workbook = xlrd.open_workbook(affixes_fn)
    sheet = workbook.sheet_by_index(0)  # Assuming you want to work with the first sheet

    # Create a copy of the workbook for editing
    workbook_copy = copy(workbook)
    sheet_copy = workbook_copy.get_sheet(0)

    # Find the last row index in the sheet
    last_row_index = sheet.nrows

    # Add the new row data to the copy of the sheet
    for col_index, value in enumerate(new_row_data):
        sheet_copy.write(last_row_index, col_index, value)

    # Save the changes to the existing file (overwrite it)
    workbook_copy.save(affixes_fn)

    print("Row added successfully and file overwritten!")
    return 'Row added successfully and file overwritten!'

# Example data
new_row_data = ["ылса", "<NB>*ыл<pl>*са<pl>"]
