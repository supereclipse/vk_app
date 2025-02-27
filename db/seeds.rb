# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Student.destroy_all
Klass.destroy_all
School.destroy_all

# Создание школ
school1 = School.create!(name: 'Школа №1')
school2 = School.create!(name: 'Школа №2')

# Создание классов
klass1 = Klass.create!(number: 1, letter: 'А', school: school1)
klass2 = Klass.create!(number: 2, letter: 'Б', school: school1)
klass3 = Klass.create!(number: 1, letter: 'А', school: school2)
klass4 = Klass.create!(number: 2, letter: 'А', school: school2)

# Создание студентов
Student.create!(first_name: 'Иван', last_name: 'Иванов', surname: 'Иванович', klass: klass1, school: school1)
Student.create!(first_name: 'Мария', last_name: 'Петрова', surname: 'Петровна', klass: klass1, school: school1)
Student.create!(first_name: 'Алексей', last_name: 'Сидоров', surname: 'Игоревич', klass: klass2, school: school1)
Student.create!(first_name: 'Ольга', last_name: 'Кузнецова', surname: 'Олеговна', klass: klass3, school: school2)
Student.create!(first_name: 'Арсений', last_name: 'Кузьменков', surname: 'Васильевич', klass: klass4, school: school2)

puts "Данные успешно добавлены!"

