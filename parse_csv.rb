require 'pg'
require 'csv'
require_relative 'database'

class ParseCSV
  def self.insert_data
    conn = Database.instance.connection

    CSV.foreach('animals.csv', headers: true) do |row|
      species = row['species']
      age = row['age']
      sex = row['sex']

      conn.exec_params("INSERT INTO animals (species, age, sex) VALUES ($1, $2, $3)", [species, age, sex])
    end
  end
end
