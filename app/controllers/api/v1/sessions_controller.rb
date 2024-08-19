require 'httparty'

class Api::V1::SessionsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: :create

  # POST /api/v1/login
  def create
    token = params[:id_token]

    user_info = verify_google_token(token)
    if user_info
      user = User.find_or_create_by(email: user_info['email']) do |u|
        u.name = user_info['name']
        u.uid = user_info['sub']
        u.provider = 'google'
      end

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

  def verify_google_token(token)
    response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{token}")
    if response.code == 200
      JSON.parse(response.body)
    else
      nil
    end
  end
end
