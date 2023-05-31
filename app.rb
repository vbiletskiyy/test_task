require_relative 'database'
require_relative 'parse_csv'

Database.instance.create_tables
ParseCSV.insert_data
