from app import app
from flaskext.mysql import MySQL

mysql = MySQL()

app.config['MYSQL_DATABASE_HOST'] = '10.255.140.4'
app.config['MYSQL_DATABASE_USER'] = 'remoteuser'
app.config['MYSQL_DATABASE_PASSWORD'] = '@Remote2022'
app.config['MYSQL_DATABASE_DB'] = 'quotes_db'
app.config['MYSQL_DATABASE_PORT'] = 33066
app.config['JSON_AS_ASCII'] = False

mysql.init_app(app)