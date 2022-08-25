require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'
require '.rental'
class Person < Nameable
  attr_reader :id, :rentals
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission = 'true')
    super()
    @id = Random.rand(100..5000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    rental = Rental.new(date, self, book)
    rentals << rental unless rentals.includes?(rental)
  end

  private

  def of_age?
    @age >= 18
  end
end

person = Person.new(30, 'worashAbocherugnZewude')
p person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
p capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
p capitalized_trimmed_person.correct_name
