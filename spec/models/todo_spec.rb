require 'rails_helper'
require 'spec_helper'

describe TodosController, type: :controller do
  describe 'index' do
    it "starts empty" do
      get :index
      expect(JSON.parse(response.body).length).to eq 0
      expect(response.status).to eq 200
    end

    it 'finds todos once created' do
      todo = Todo.create description:'Get a job'
      todo = Todo.create description:'Get a better job'

      get :index
      data = JSON.parse(response.body)
      expect(data.length).to eq 2
      expect(response.status).to eq 200

      created = data[0]
      expect(created['description']).to eq 'Get a job'
      expect(created['is_done?']).to be false

      created = data[1]
      expect(created['description']).to eq 'Get a better job'
      expect(created['is_done?']).to be false
    end
  end
  
  describe 'create' do
    it 'creates a new todo, marked incomplete by default' do
      post :create, params: { todo: { description: 'Do this' } }
      expect(response.status).to eq 201

      expect(Todo.all.length).to eq 1
      created = Todo.last
      expect(created['description']).to eq 'Do this'
      expect(created['is_done?']).to be false
    end
    
    it 'can create an already-completed todo' do
      post :create, params: { todo: { description: 'Did this', is_done?: true } }
      expect(response.status).to eq 201

      created = Todo.last
      expect(created['description']).to eq 'Did this'
      expect(created['is_done?']).to be true    
    end

    xit 'returns with error 500 if a problem arises' do
      # TODO: How can I make the todo be invalid?
      expect(false).to be true
    end
  end

  describe 'update' do  
    before(:each) do
      todo = Todo.create(description:'Get a job')
      expect(Todo.last['is_done?']).to be false # sanity check
    end

    it 'can mark a todo as complete' do
      patch :update, params: {id: Todo.last.id, todo:{is_done?: true} }
      expect(response.status).to eq 200

      updated = Todo.last
      expect(updated['description']).to eq 'Get a job'
      expect(updated['is_done?']).to be true
    end

    it 'can rename a todo' do
      new_title = 'Get a job at Babylist'
      patch :update, params: {id: Todo.last.id, todo:{description: new_title} }
      expect(response.status).to eq 200

      updated = Todo.last
      expect(updated['description']).to eq new_title
      expect(updated['is_done?']).to be false
    end
    it 'responds with an error if the id is invalid' do
      delete :destroy, params: {id: 299}
      expect(response.status).to eq 404
    end
    xit 'returns with error 500 if a problem arises' do
      # TODO: How can I make the todo be invalid?
      expect(false).to be true
    end
  end

  describe 'delete' do
    it 'deletes a todo by id' do
      todo = Todo.create(description:'Drink poison')
      expect(Todo.all.length).to be 1
      delete :destroy, params: {id: Todo.last.id}
      expect(Todo.all.length).to be 0
      expect(response.status).to eq 204
    end

    it 'responds with an error if the id is invalid' do
      delete :destroy, params: {id: 299}
      expect(response.status).to eq 404
    end
  end
end
