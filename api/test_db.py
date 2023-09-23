import pandas as pd
import psycopg2
from psycopg2 import sql

# Replace these values with your database credentials
db_connection = {
    "dbname": "userdb",
    "user": "postgres",
    "password": "magzhan2005",
    "host": "localhost",
    "port": "5432"
}
# dbname='userdb', host='localhost', user="postgres"
def insert_data_from_excel(file_path):
    try:
        conn = psycopg2.connect(**db_connection)
        cursor = conn.cursor()
        # Read the Excel file into a DataFrame
        df = pd.read_excel(file_path)

        # Iterate through the rows of the DataFrame
        for _, row in df.iterrows():
            name = str(row[1])  # Convert to string
            description = str(row[2])  # Convert to string
            examples_termin = str(row[3])  # Convert to string
            # Skip if all three columns are empty
            if name == 'nan' and description == 'nan' and examples_termin == 'nan':
                continue
            print("\n" + "###########################" + "\n" + name + "\n" + description + "\n" + examples_termin + "\n" + "###########################")
            # Establish a database connection

            # Insert the data into the PostgreSQL table (replace 'your_table' with your actual table name)
            insert_query = sql.SQL("""
                INSERT INTO termin (name, description, examples, is_new)
                VALUES (%s, %s, %s, true)
            """)
            cursor.execute(insert_query, (name, description, examples_termin))
            
            # Commit the transaction and close the connection

    except Exception as e:
        print(f"An error occurred: {str(e)}")
    conn.commit()
    conn.close()

# Usage
file_path = "exe.xlsx"
insert_data_from_excel(file_path)
