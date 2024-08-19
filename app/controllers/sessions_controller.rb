class Api::V1::SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    # POST /api/v1/login
    def create
      user = User.find_or_create_from_auth_hash(auth_hash)
      if user
        session[:user_id] = user.id
        render json: { user: user, message: 'Logged in successfully' }, status: :ok
      else
        render json: { error: 'Authentication failed' }, status: :unauthorized
      end
    end
  
    # DELETE /api/v1/logout
    def destroy
      session.delete(:user_id)
      render json: { message: 'Logged out successfully' }, status: :ok
    end
  
    private
  
    def auth_hash
      request.env['omniauth.auth']
    end
end