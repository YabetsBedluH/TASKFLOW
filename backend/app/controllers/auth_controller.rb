class AuthController < ApplicationController
  before_action :authorize, only: [:me]

  def register
    user = User.new(email: params[:email], password: params[:password])
    if user.save
      render json: { message: 'Registered successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  def me
    render json: @current_user.slice(:id ,:email)
  end
end
