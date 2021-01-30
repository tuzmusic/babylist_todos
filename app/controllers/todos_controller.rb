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
    if todo.valid?
      todo.save
    else
      render json: {error: 'Could not create your todo', status: 500}.to_json
    end
    render json: todo.to_json, status: 201
  end

  def update
    todo = Todo.find params[:id]
    # binding.pry
    todo.update todo_params
    if todo.valid?
      todo.save
    else
      render json: {error: 'Could not update your todo', status: 500}.to_json
    end
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
