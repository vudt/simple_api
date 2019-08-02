require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do

  # let(:user) {FactoryBot.create :user}

  # subject {user}

  describe "User" do

    it "has a valid user" do 
      expect(FactoryBot.build(:user)).to be_valid
    end

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it "is invalid email" do 
      expect(FactoryBot.build(:user, email: Faker::Name.name)).not_to be_valid
    end

    it { is_expected.to validate_presence_of(:password) }

    it "is invalid password is not match" do 
      expect(FactoryBot.build(:user, password: '123456', password_confirmation: '1234566')).not_to be_valid
    end

    it { expect(FactoryBot.build(:user)).to validate_uniqueness_of(:authentication_token).case_insensitive }

    it { is_expected.to have_many(:posts).dependent(:destroy) }

    it "return username as a email" do 
      expect(FactoryBot.create(:user, email: 'test@gmail.com').username).to eq('test@gmail.com')
    end

    describe "filter email by string" do 
      before :each do 
        FactoryBot.create(:user, email: "test@gmail.com")
        FactoryBot.create(:user, email: "abc@gmail.com")
      end

      context "matching string" do 
        it "return result that match" do
          expect(User.search_by_string("test").first.email).to eq("test@gmail.com") 
        end
      end

      context "non-matching string" do 
        it "does not return result that match" do 
          expect(User.search_by_string("abc").first.email).not_to eq("test@gmail.com") 
        end
      end
    end
  end
end
