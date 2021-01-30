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
      todo = Todo.create(description:'Get a job')
      get :index
      data = JSON.parse(response.body)
      expect(data.length).to eq 1
      created = data[0]
      expect(created['description']).to eq 'Get a job'
      expect(created['is_done?']).to be false

      # can create and retrieve another 
      todo = Todo.create(description:'Get a better job')
      get :index
      data = JSON.parse(response.body)
      expect(data.length).to eq 2
    end
  end
  
  describe 'create' do
    it 'creates a new todo' do
      post :create, params: { todo: { description: 'Do this' } }

      expect(Todo.all.length).to eq 1
      created = Todo.last
      expect(created['description']).to eq 'Do this'
      expect(created['is_done?']).to be false
    end

    xit 'returns with error 500 if a problem arises' do
      expect(false).to be false
    end
  end

  describe 'update' do  
    xit 'updates a todo' do
      todo = Todo.create(description:'Get a job')
      expect(Todo.all.length).to eq 1

      patch :update, params:{ todo: {id: 1, is_done?: true} }

      created = Todo.last
      expect(created['description']).to eq 'Get a job'
      expect(created['is_done?']).to be true
    end
  end
end
