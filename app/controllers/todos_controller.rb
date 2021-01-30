class TodosController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    render :status => 404
  end

  def index
    render json: Todo.all, status: 200
  end

  def create
    todo = Todo.create(todo_params)
    render json: todo.to_json, status: 201
  end

  def update
    todo = Todo.find params[:id]
    todo.update todo_params
    render json: todo.to_json, status: 200
  end
  
  def complete
    todo = Todo.find params[:id]
    todo.update({'is_done?': true})
    render json: todo.to_json, status: 200
  end

  def destroy
    todo  = Todo.find params[:id]
    todo.destroy
    return 204
  end
  

  def todo_params
    params.require(:todo).permit :description, :is_done?
  end
end
