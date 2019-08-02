require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe "index" do 
    it "return status 200" do 
      get :index
      expect(response).to have_http_status "200"
    end
  end	
end