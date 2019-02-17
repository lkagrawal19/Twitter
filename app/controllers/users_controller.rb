class UsersController < ApplicationController
  # Use Knock to make sure the current_user is authenticated before completing request.
  before_action :authenticate_user, only: %i[index current update]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :authorize,          only: [:update]

  # Method to create a new user using the safe params we setup.
  def create
    user = User.new(user_params)
    render json: { status: 200, msg: 'User was created.' } if user.save!
  end

  # Method to update a specific user. User will need to be authorized.
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { status: 200, msg: 'User details have been updated.' }
    end
  end

  # Method to delete a user, this method is only for admin accounts.
  def destroy
    user = User.find(params[:id])
    render json: { status: 200, msg: 'User has been deleted.' } if user.destroy
  end

  # Should work if the current_user is authenticated.
  def index
    render json: { status: 200, msg: 'Logged-in' }, status: 200
  end

  # Call this method to check if the user is logged-in.
  # If the user is logged-in we will return the user's information.
  def current
    current_user.update!(last_login: Time.now)
    render json: current_user
  end

  private

  # Setting up strict parameters for when we add accounts creation.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  # Adding a method to check if current_user can update itself.
  # This uses our UserModel method.
  def authorize
    return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
  end
end
