# Хелпер (концерн) для аутентификации.
module AuthHelper
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
  end

  def authorize_request
    token = extract_token_from_header

    if token.present?
      decoded = decode_token(token)
      @current_user = find_user(decoded['student_id']) if decoded
    end

    render_unauthorized unless @current_user
  end

  private

  def extract_token_from_header
    request.headers['Authorization']&.split(' ')&.last
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base).first
  rescue JWT::DecodeError
    nil
  end

  def find_user(student_id)
    Student.find(student_id)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end

