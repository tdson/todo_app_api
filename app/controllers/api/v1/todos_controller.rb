class Api::V1::TodosController < ApplicationController
  before_action :load_todo, only: [:update, :destroy, :show]

  def index
    todos = current_user.todos.newest
    render json: {data: ActiveModel::Serializer::ArraySerializer.new(todos)}, status: 200
  end

  def show
    render json: {todo: TodoSerializer.new(@todo)}, status: 200
  end

  def create
    todo = current_user.todos.new todo_params
    if todo.save
      render json: {todo: TodoSerializer.new(todo)}, status: 201
    else
      render json: {errors: todo.errors}, status: 400
    end
  end

  def update
    if @todo.update todo_params
      render json: {todo: TodoSerializer.new(@todo)}, status: 202
    else
      render json: {errors: todo.errors}, status: 400
    end
  end

  def destroy
    if @todo.destroy
      render json: {message: "Deleted successfully"}, status: 200
    else
      render json: {error: "Cannot delete this todo. Try later!"}, status: 405
    end
  end

  private
  def todo_params
    params[:todo].merge! title: extract_title
    params.require(:todo).permit :title, :content
  end

  def extract_title
    "#{params[:todo][:content].first(27).strip}..."
  rescue
    "Untitled"
  end

  def load_todo
    @todo = current_user.todos.find_by id: params[:id]
    unless @todo
      render json: {errors: "Not found"}, status: 404
    end
  end
end
