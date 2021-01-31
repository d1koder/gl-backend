class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  #

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      # If your User model has a `to_token_payload` method, you should use that here
      auth_token = Knock::AuthToken.new payload: { sub: @user.id }
      render json: {username: @user.username, jwt: auth_token.token}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login 
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
        auth_token = Knock::AuthToken.new payload: {sub: @user.id}
        render json: {username: @user.username, jwt: auth_token.token}, status: 200
    else
        render json: {error: "Incorrect Username or Password"}, status: 404 

    end 
end 

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
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
      @user = User.find(params[:id])
    rescue
      render json: { error: "User not found" }, status: 404
    end
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :admin)
  end
end
