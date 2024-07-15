class ApplicationController < ActionController::API

  private

  rescue_from Exception do |exception| 
    render_error(exception)
  end

  def get_exception_status_code(exception)
    status_number = 500

    error_classes_404 = [
      ActiveRecord::RecordNotFound,
      ActionController::RoutingError,
      AbstractController::ActionNotFound
    ]
    error_classes_500 = [
      NameError
    ]

    if error_classes_404.include?(exception.class)
      status_number = 404
    end

    return status_number.to_i
  end

  def render_error(exception_obj = Exception.new("Error occurred!"), options = {})
    
    if exception_obj.is_a?(Exception)
      error_msg = exception_obj.message
      Rails.logger.error exception_obj.message
      Rails.logger.error exception_obj.backtrace.join("\n")
    elsif exception_obj.is_a?(String)
      error_msg = exception_obj
    else
      error_msg = "Error occurred!"
    end

    render json: {error: error_msg},  status: get_exception_status_code(exception_obj)
  end

  def authorize_request
    token = request.headers['x-token']
    begin
      @decoded = JsonWebToken.decode(token)
      @current_user = User.find(@decoded["user_id"])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
  
end
