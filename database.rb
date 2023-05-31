require 'pg'
require 'dotenv'

Dotenv.load

class Database
  attr_reader :connection

  def self.instance
    @instance ||= new
  end

  def initialize
    @connection = PG.connect(dbname: ENV['DBNAME'], user: ENV['USER'], password: ENV['PASSWORD'])
  end

  def create_tables
    connection.exec(<<~SQL)
      CREATE TABLE IF NOT EXISTS animals (
        id SERIAL PRIMARY KEY,
        species VARCHAR(50),
        age INTEGER,
        sex VARCHAR(10)
      );
    SQL
  end
end
