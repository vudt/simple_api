require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
	describe "index" do 
	  it "return status 200" do 
	  	get :index
	  	expect(response).to have_http_status "200"
	  end
	end

	describe "show" do 
	  it "record not found with id invalid, return status 404" do 
	  	get :show, params: { id: 'sdsd' }
	  	expect(response).to have_http_status "404"
	  end

	  it "record not found without headers, return status 404" do 
	  	@user = FactoryBot.create(:user)
	  	request.headers["Authorization"] = nil
	  	get :show, params: { id: @user.id }
	  	expect(response).to have_http_status "404"
	  end

	  it "has record valid, return status 200" do
	  	@user = FactoryBot.create(:user)
	  	request.headers["Authorization"] = @user.authentication_token
	  	get :show, params: { id: @user.id }
	  	expect(response).to have_http_status "200"
	  end 
	end

	describe "create" do 
	  it "has record valid" do 
      post :create, params: {
        email: Faker::Internet.email,
		  	password: "123456",
		  	password_confirmation: "123456"
      }
      expect(response.status).to eq(200)
	  end

	  it "invalid params email return status 422" do 
	  	post :create, params: {
        email: '',
        password: "123456",
        password_confirmation: "123456"
      }
      expect(response.status).to eq(422)
	  end
	end

	describe "update" do 
	  it "has record valid" do 
	  	@user = FactoryBot.create(:user)
	  	request.headers["Authorization"] = @user.authentication_token
	  	put :update, params: {
	      id: @user.id,
	      email: 'test@gmail.com' 
	    }
	    data = JSON.parse(response.body)
	    expect(response.status).to eq(200)
	    expect(data['email']).to eq('test@gmail.com')
	    expect(@user.email).to_not eq('test@gmail.com')
	  end

	  it "password is not match" do 
	  	@user = FactoryBot.create(:user)
	  	request.headers["Authorization"] = @user.authentication_token
	  	put :update, params: {
	      id: @user.id,
	      password: "1234567",
		    password_confirmation: "123456"
	    }
	    expect(response.status).to eq(422)
	  end

	  it "token is not valid" do 
	  	@user = FactoryBot.create(:user)
	  	request.headers["Authorization"] = 'loremipsum'
	  	put :update, params: {
	      id: @user.id,
	      password: "123456",
		  	password_confirmation: "123456"
	    }
	    expect(response.status).to eq(404)
	  end
	end

	describe "destroy" do
    it "destroy success" do
      2.times{ FactoryBot.create(:user) }
      user1 = User.first
      user2 = User.last
      request.headers["Authorization"] = user1.authentication_token
	    put :destroy, params: { id: user1.id}
	    expect(response.status).to eq(200)
      expect(User.count).to eq(1)
      expect(User.first.id).not_to eq(user1.id)
    end
	end
end