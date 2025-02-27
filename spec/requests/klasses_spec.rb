# spec/requests/klass_spec.rb
require 'swagger_helper'

RSpec.describe 'Klass API', type: :request do
  path '/school/{school_id}/klass' do
    get 'Вывести список классов школыыы' do
      tags 'klass'
      produces 'application/json'
      parameter name: :school_id, in: :path, type: :integer, required: true, description: 'ID школы'

      response '200', 'Список классов' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     '$ref' => '#/components/schemas/Klass'
                   }
                 }
               }

        let(:school) { School.create!(name: 'Школа №1') }
        let!(:klass) { Klass.create!(number: 1, letter: 'А', school: school) }
        let(:school_id) { school.id }

        run_test!
      end
    end
  end
end
