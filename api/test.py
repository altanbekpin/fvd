import pandas as pd

df = pd.read_excel("ahmettanu/classification.xlsx", usecols=[0, 1, 4])
data = df.values.tolist()[0:10]
list_of_dicts = [
    {'first_column': inner_list[0], 'second_column': inner_list[1], 'third_column': inner_list[2]}
    for inner_list in data
]
for d in list_of_dicts:
    for key, value in d.items():
        if pd.isna(value):
            d[key] = ""

print(list_of_dicts)