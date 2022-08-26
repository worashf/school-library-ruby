#!/usr/bin/env ruby
require './app'

class Main
  def menu_options
    puts ' '
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def add_new_person(app)
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    type = get.chomp.to_i
    puts 'Name: '
    name = get.chomp
    puts 'Age: '
    age = get.chomp.to_i
    if type == 1
      puts 'Has parent permission? [Y/N]: '
      parent_permission = get.chomp
      app.create_new_student(age, name, parent_permission: parent_permission.downcase == 'y')
    else
      puts 'Specialization: '
      specialization = gets.chomp
      app.create_new_teacher(specialization, age, name)
    end

    puts 'You choose invalid menu, Return to menu'
  end

  def add_book(app)
    puts 'Title: '
    title = get.chomp
    puts 'Author: '
    author = get.chomp
    app.create_new_book(title, author)
  end

  def list_all_books(app)
    app.list_books
  end

  def list_all_person(app)
    app.list_persons
  end

  def add_new_rental(app)
    puts 'Books is empity ' if app.books.length.zero?
    puts 'Person is empity' if app.get_persons.length.zero?
    puts 'Select a book from the following list by number: '

    app.list_books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end

    book_index = get.chomp.to_i
    book = app.books[book_index]

    puts 'Select person from the following list by number:'
    app.list_persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = get.chomp.to_i
    person = app.persons[person_index]

    puts 'Date:'
    date = get.chomp

    app.create_new_rental(date, person, book)
  end

  def list_rentals_by_id(app)
    puts 'Enter person id:'
    id = get.chomp.to_i
    app.list_rentals_by_person_id(id)
  end

  def menu(option, app)
    case option
    when 1
      list_all_books(app)
    when 2
      list_all_person(app)
    when 3
      add_new_person(app)
    when 4
      add_book(app)
    when 5
      add_new_rental(app)
    when 6
      list_rentals_by_id(app)
    end
  end

  def main
    app = App.new
    option = 0
    puts 'Welcome to School Library Rental App!'
    while option != 7
      menu_options
      option = gets.chomp.to_i
      if option >= 0 && option < 7
        menu(option, app)
      elsif option == 7
        puts 'Thanks for using this App!'
      else
        puts 'Invalid option'
      end
    end
  end
end

main_app = Main.new
main_app.main
