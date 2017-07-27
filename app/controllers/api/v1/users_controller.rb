class Api::V1::UsersController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: :create

  def create
    user = User.new user_params
    if user.save
      render json: {data: Api::V1::GenerateToken.perform(user)}, status: 201
    else
      render json: {errors: user.errors}, status: 400
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :password, :password_confirmation, :nickname
  end
end
