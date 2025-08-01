class ApplicationController < ActionController::API
  def authorize
    header = request.headers['Authorization']
    if header.present?
      token = header.split(' ').last
      begin
        decoded = JsonWebToken.decode(token)
        @current_user = User.find_by(id: decoded[:user_id])
        return render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
      rescue JWT::DecodeError, JWT::ExpiredSignature
        return render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Missing token' }, status: :unauthorized
    end
  end
end
