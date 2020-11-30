class UsersController < ApplicationController

  # POST /api/v1/register
  # params: name, email, password
  def register
    @user = User.create(user_params)
    
    if @user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end 
  end
  
  # POST /api/v1/login
  # params: email, password
  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    if user && user.authenticate(params[:password])
      auth_token = JsonWebToken.encode({ user_id: user.id })
      render json: { message: 'Login Successful!', auth_token: auth_token }, status: :ok
    else
      render json: { error: 'Invalid username / password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

end
