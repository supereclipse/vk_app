class StudentsController < ApplicationController
  before_action :set_klass, only: [:index]
  before_action :set_student, only: [:destroy]
  skip_before_action :authorize_request, only: [:create]

  def index
    students = @klass.students

    render json: { data: students }, status: :ok
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      token = encode_token({ student_id: @student.id })

      response.headers['X-Auth-Token'] = token
      render json: @student, status: :created
    else
      render json: { error: @student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @student.destroy
      head :no_content
    else
      render json: { error: 'Не удалось удалить студента' }, status: :unprocessable_entity
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name, :surname, :klass_id, :school_id)
  end

  def set_klass
    @klass ||= Klass.find(params[:klass_id])
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
