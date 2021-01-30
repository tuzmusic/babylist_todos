require 'rails_helper'
require 'spec_helper'

describe TodosController, type: :controller do
  it "starts empty" do
    get :index
    expect(JSON.parse(response.body).length).to eq(0)
  end
end
