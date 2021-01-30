Rails.application.routes.draw do
  resources :todos
  put '/todos/complete/:id', to: 'todos#complete'
end
