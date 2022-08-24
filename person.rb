require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'
class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'Unknown', parent_permission = 'true')
    super()
    @id = Random.rand(100..5000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
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
