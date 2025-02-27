class StudentsController < ApplicationController
  before_action :set_klass, only: [:index]

  def index
    students = @klass.students

    render json: { data: students }, status: :ok
  end

  def set_klass
    @klass ||= Klass.find(params[:klass_id])
  end
end
