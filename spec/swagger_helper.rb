# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1',
        description: 'API documentation for the Student Management System'
      },
      paths: {
        '/students' => {
          post: {
            tags: ['students'],
            summary: 'Регистрация нового студента',
            operationId: 'createStudent',
            security: [{ bearerAuth: [] }],
            requestBody: {
              description: 'Новый студент',
              required: true,
              content: {
                'application/json': {
                  schema: {
                    '$ref' => '#/components/schemas/Student'
                  }
                }
              }
            },
            responses: {
              '201': {
                description: 'Successful operation',
                headers: {
                  'X-Auth-Token': {
                    description: 'Токен для последующей авторизации',
                    schema: { type: :string },
                    example: '3525dcdddea774939652f7f11df6d7db10a9db35a5d758c64d600a00c1cc41be'
                  }
                },
                content: {
                  'application/json': {
                    schema: {
                      '$ref' => '#/components/schemas/Student'
                    }
                  }
                }
              },
              '405': {
                description: 'Invalid input'
              }
            }
          }
        },

        '/students/{user_id}' => {
          delete: {
            tags: ['students'],
            summary: 'Удалить студента',
            operationId: 'deleteStudent',
            security: [{ bearerAuth: [] }],
            parameters: [
              {
                name: 'user_id',
                in: 'path',
                required: true,
                description: 'ID студента',
                schema: {
                  type: 'integer',
                  format: 'int64'
                }
              }
            ],
            responses: {
              '204': {
                description: 'Студент успешно удалён'
              },
              '400': {
                description: 'Некорректный id студента'
              },
              '401': {
                description: 'Некорректная авторизация'
              }
            }
          }
        },

      '/school/{school_id}/klass' => {
        get: {
          tags: ['classes'],
          summary: 'Вывести список классов школы',
          operationId: 'getClassList',
          parameters: [
            {
              name: 'school_id',
              in: 'path',
              required: true,
              description: 'ID школы',
              schema: {
                type: 'integer',
                format: 'int32'
              }
            }
          ],
          responses: {
            '200': {
              description: 'Список классов',
              content: {
                'application/json': {
                  schema: {
                    type: 'object',
                    properties: {
                      data: {
                        type: 'array',
                        items: {
                          '$ref' => '#/components/schemas/Klass'
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }


      },
      servers: [
        { url: 'http://127.0.0.1:3000' },
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ],
      components: {
        schemas: {
          Student: {
            type: :object,
            properties: {
              first_name: { type: :string },
              last_name: { type: :string },
              surname: { type: :string },
              class_id: { type: :integer },
              school_id: { type: :integer }
            },
            required: ['first_name', 'last_name', 'surname', 'class_id', 'school_id']
          },
          Klass: {
            type: :object,
            required: ['id', 'number', 'letter', 'students_count'],
            properties: {
              id: {
                type: :integer,
                format: :int32,
                example: 10,
                readOnly: true
              },
              number: {
                type: :integer,
                format: :int32,
                example: 1,
                description: 'Цифра класса'
              },
              letter: {
                type: :string,
                example: 'Б',
                description: 'Буква класса'
              },
              students_count: {
                type: :integer,
                format: :int32,
                example: 32,
                readOnly: true,
                description: 'Количество учеников в классе'
              }
            }
          }
        },
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: 'JWT'
          }
        }
      },
      security: [{ bearerAuth: [] }]
    }
  }

  config.openapi_format = :yaml
end

