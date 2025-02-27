class KlassController < ApplicationController
  def index
    @klasses = Klass.where(school_id: params[:school_id])
    render json: { data: @klasses }
  end
end
