require_relative 'database'

class Animal
  class << self
    def all
      conn = Database.instance.connection
      all_animals ||= conn.exec("SELECT * FROM animals").entries
      new(all_animals)
    end

    def monkeys
      all.monkeys
    end

    def males
      all.males
    end

    def age_less_than(age)
      all.age_less_than(age)
    end
  end

  def initialize(animals)
    @animals = animals
  end

  def monkeys
    self.class.new(filter_by_species('monkey'))
  end

  def males
    self.class.new(filter_by_sex('male'))
  end

  def age_less_than(age)
    self.class.new(filter_by_age_less_than(age))
  end

  def inspect
    @animals.inspect
  end

  private

  def filter_by_species(species)
    @animals.select { |animal| animal['species'] == species }
  end

  def filter_by_sex(sex)
    @animals.select { |animal| animal['sex'] == sex }
  end

  def filter_by_age_less_than(age)
    @animals.select { |animal| animal['age'].to_i <= age }
  end
end

p Animal.monkeys.age_less_than(5).males
