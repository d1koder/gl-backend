class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # If your User model has a `to_token_payload` method, you should use that here
      auth_token = Knock::AuthToken.new payload: { sub: @user.id }
      render json: { username: @user.username, jwt: auth_token.token }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      auth_token = Knock::AuthToken.new payload: { sub: @user.id }
      render json: { username: @user.username, jwt: auth_token.token }, status: 200
    else
      render json: { error: "Incorrect Username or Password" }, status: 404
    end
  end

  def find
    @user = User.find_by(email: params[:user][:email])
    if @user
      render json: @user
    else
      @errors = @errors.errors.full_messages
      render json: @errors
    end
  end

  def update
    @user.update(user_params)
    if @user.errors.any?
      render json: @user.errors, status: :unprocessable_entity
    else
      render json: @user, status: 201
    end
  end

  def destroy
    @user.delete
    render json: 204
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    begin
      @user = User.find_by(id: params[:id])
    rescue
      render json: { error: "User not found" }, status: 404
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :admin)
  end
end
