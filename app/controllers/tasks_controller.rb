class TasksController < ApplicationController
  before_action :authorize_request
  before_action :find_task, except: %i[create index]

  # GET /taks
  def index
    @tasks = Task.page(params[:page]).per(4) # 4 tasks per page
    render json: @tasks, status: :ok
  end

  # GET /tasks/:id
  def show
    render json: @task, status: :ok
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { errors: " Something went wrong Please check the provided status: #{e.message}" }, status: :internal_server_error
  end

  # PATCH /tasks/:id
  def update
    return unless @task.update(task_params)

    @task.save
    render json: { message: @task }, status: :ok
  end

  # DELETE /tasks/:id
  def destroy
    if @task.destroy
      render json: { message: 'task has been successfully deleted.' }, status: :ok
    else
      render json: { error: 'Failed to delete task. Please try again.' }, status: :unprocessable_entity
    end
  end

  private

  def find_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'task not found' }, status: :not_found
  end

  def task_params
    params.permit(
      :title, :description, :status, :due_date, :user_id
    )
  end
end
