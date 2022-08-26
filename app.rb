require './classroom'
require './student'
require './teacher'
require './book'
require './rental'

class App
  attr_accessor :persons, :books, :rentals

  def initialize
    @persons = []
    @books = []
    @rentals = []
    @classroom = Classroom.new('Class A')
  end

  def create_new_student(age, name, parent_permission)
    student = Student.new(@classroom, age, name, parent_permission)
    @persons << student
    puts 'Student created successfuly'
  end

  def create_new_teacher(specialization, age, name)
    teacher = Teacher.new(specialization, age, name)
    @persons << teacher
    puts 'Teacher saved successfuly'
  end

  def create_new_book(title, author)
    book = Book.new(title, author)
    @books << book
    puts 'Book saved successfuly'
  end

  def create_new_rental(date, person, book)
    rental = Rental.new(date, person, book)
    @rentals << rental
    puts 'Rental added successfuly'
  end

  def list_books
    puts 'No books list found!' if @books.length.zero?
    @books.each { |book| puts "Book Title: \"#{book.title}\", Book Author: #{book.author}" }
  end

  def list_persons
    puts 'No person list found' if @persons.length.zero?
    @persons.each do |person|
      puts "[#{person.class}] Name: #{person.name}, Age: #{person.age}, Id: #{person.id} "
    end
  end

  def get_rentals_by_person_id(person_id)
    person_rentals = @rentals.select { |rental| rental.person.id == person_id }
    person_rentals.each do |rental|
      puts " Book: #{rental.book.title}, Writen By: #{rental.book.author}, Date: #{rental.date}"
    end
  end
end
