require 'rails_helper'
require 'spec_helper'

describe TodosController, type: :controller do
  describe 'index' do
    it "starts empty" do
      get :index
      expect(JSON.parse(response.body).length).to eq 0
    end

    it 'finds a todo once created' do
      # can create and retreive
      todo = Todo.create description:'Get a job'
      get :index
      data = JSON.parse response.body
      expect(data.length).to eq 1
      created = data[0]
      expect(created['description']).to eq 'Get a job'
      expect(created['is_done?']).to be false

      # can create and retrieve another 
      todo = Todo.create description:'Get a better job'
      get :index
      data = JSON.parse response.body
      expect(data.length).to eq 2
    end
  end
  
  describe 'create' do
    it 'creates a new todo, marked incomplete by default' do
      post :create, params: { todo: { description: 'Do this' } }

      expect(Todo.all.length).to eq 1
      created = Todo.last
      expect(created['description']).to eq 'Do this'
      expect(created['is_done?']).to be false
    end
    
    it 'can create an already-completed todo' do
      post :create, params: { todo: { description: 'Did this', is_done?: true } }
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

      updated = Todo.last
      expect(updated['description']).to eq 'Get a job'
      expect(updated['is_done?']).to be true
    end

    it 'can rename a todo' do
      new_title = 'Get a job at Babylist'
      patch :update, params: {id: Todo.last.id, todo:{description: new_title} }

      updated = Todo.last
      expect(updated['description']).to eq new_title
      expect(updated['is_done?']).to be false
    end
  end

  describe 'delete' do
    it 'deletes a todo by id' do
      todo = Todo.create(description:'Drink poison')
      expect(Todo.all.length).to be 1
      delete :destroy, params: {id: Todo.last.id}
      expect(Todo.all.length).to be 0
    end
  end
end
