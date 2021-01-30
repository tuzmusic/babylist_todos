class TodosController < ApplicationController

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
    render json: todo.to_json, status: 200
  end

  def update
  
  end


  def todo_params
    params.require(:todo).permit :description, :is_done?
  end
end