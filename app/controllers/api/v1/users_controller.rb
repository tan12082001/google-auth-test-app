class Api::V1::UsersController < ApplicationController
    #GET /api/v1/users
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    #POST /api/v1/users
    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    #GET /api/v1/users/:id
    def show
        @user = User.find(params[:id])
        if @user
            render json: @user, status: :ok
        else
            render json: { error: "USer not Found" }, status: :not_found
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email)
    end
end
