class ApplicationController < ActionController::Base
  before_action :authenticate_token
  rescue_from StandardError, with: :handle_internal_error

  private
  def authenticate_token
    valid_token = ENV['API_TOKEN']
    token = request.headers["Authorization"]&.split(' ')&.last

    unless token && ActiveSupport::SecurityUtils.secure_compare(token, valid_token)
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def handle_internal_error(exception)
    render json: { error: "Internal Server Error", message: exception.message }, status: :internal_server_error
  end
end