require 'swagger_helper'

RSpec.describe 'Students API', type: :request do
  path '/school/{school_id}/klass/{klass_id}/students' do
    get 'Вывести список студентов класса' do
      tags 'students', 'klasses'
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
end

