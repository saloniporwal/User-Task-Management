# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/:id
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { errors: " Something went wrong Please check the provided status: #{e.message}" }, status: 500
  end

  # PATCH /users/:id
  def update
    return unless @user.update(user_params)

    @user.save
    render json: { message: @user }, status: :ok
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy
      render json: { message: 'User has been successfully deleted.' }, status: :ok
    else
      render json: { error: 'Failed to delete user. Please try again.' }, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :email, :phone_number, :password, :password_confirmation, :status
    )
  end
end
