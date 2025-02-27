require 'swagger_helper'

RSpec.describe 'Students API', type: :request do
  path '/school/{school_id}/klass/{klass_id}/students' do
    get 'Вывести список студентов класса' do
      tags 'students'
      produces 'application/json'
      parameter name: :school_id, in: :path, type: :integer, required: true, description: 'ID школы'
      parameter name: :klass_id, in: :path, type: :integer, required: true, description: 'ID класса'

      response '200', 'Список студентов' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref' => '#/components/schemas/Student'
                   }
                 }
               }

        let(:school) { School.create!(name: 'Школа №1') }
        let(:klass) { Klass.create!(number: 1, letter: 'А', school: school) }
        let!(:student) { Student.create!(first_name: 'Иван', last_name: 'Иванов', surname: 'Иванович', klass: klass, school: school) }
        let(:school_id) { school.id }
        let(:klass_id) { klass.id }

        run_test!
      end
    end
  end

  path '/students' do
    post 'Регистрация нового студента' do
      tags 'students'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :student, in: :body, required: true, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          surname: { type: :string },
          klass_id: { type: :integer },
          school_id: { type: :integer }
        },
        required: ['first_name', 'last_name', 'surname', 'klass_id', 'school_id']
      }

      response '201', 'Student created' do
        let(:student) { { first_name: 'Иван', last_name: 'Иванов', surname: 'Иванович', klass_id: klass.id, school_id: school.id } }
        let(:school) { School.create!(name: 'Школа №1') }
        let(:klass) { Klass.create!(number: 1, letter: 'А', school: school) }

        run_test!
      end

      response '405', 'Invalid input' do
        let(:student) { { first_name: 'Иван' } }
        run_test!
      end
    end
  end

  path '/students/{user_id}' do
    delete 'Удалить студента' do
      tags 'students'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer, required: true, description: 'ID студента'

      response '204', 'Студент успешно удалён' do
        let(:student) { Student.create!(first_name: 'Иван', last_name: 'Иванов', surname: 'Иванович', klass: klass, school: school) }
        let(:user_id) { student.id }

        run_test!
      end

      response '400', 'Некорректный id студента' do
        let(:user_id) { 99999 }
        run_test!
      end

      response '401', 'Некорректная авторизация' do
        let(:user_id) { student.id }
        before { allow_any_instance_of(ApplicationController).to receive(:authorize_request).and_return(nil) }

        run_test!
      end
    end
  end
end

