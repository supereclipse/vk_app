class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    token = extract_token_from_header
    decoded = decode_token(token)

    if decoded
      @current_user = find_user(decoded['student_id'])
    else
      render_unauthorized
    end
  end

  def extract_token_from_header
    request.headers['Authorization']&.split(' ')&.last
  end

  def find_user(student_id)
    Student.find(student_id)
  rescue ActiveRecord::RecordNotFound
    render_unauthorized
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base).first
  rescue JWT::DecodeError
    nil
  end
end

