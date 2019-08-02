require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validation" do 
  	before :each do 
      @user = FactoryBot.create(:user)
    end

  	it { is_expected.to validate_presence_of(:title) }
  	it { is_expected.to validate_presence_of(:user_id) }
  	it { is_expected.to belong_to :user }

  	it "has a valid post" do 
  	  expect(FactoryBot.build(:post, user_id: @user.id)).to be_valid
  	end

  	it "user is not exist" do 
  	  expect(FactoryBot.build(:post, user_id: nil)).not_to be_valid
  	end
  end
end