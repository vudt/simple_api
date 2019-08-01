require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do

  let(:user) {FactoryBot.create :user}

  subject {user}

  describe "validations" do

    context "attributes valid" do
      it {is_expected.to be_valid}
    end

    context "email invalid" do
      before { subject.email = Faker::Name.name }
      it {is_expected.not_to be_valid}
    end

    context "password invalid" do
      before { subject.password = '' }
      it {is_expected.not_to be_valid}
    end

    context "password_confirmation invalid" do
      before { subject.password_confirmation = '' }
      it {is_expected.not_to be_valid}
    end

    context "password_confirmation is not match" do
      before { 
        subject.password = '1234566' 
        subject.password_confirmation = '12345667'
      }
      it {is_expected.not_to be_valid}
    end

    context "token invalid" do
      before { subject.authentication_token = nil }
      it {is_expected.not_to be_valid}
    end

    context "token unique" do
      before { subject.authentication_token = '12345' }
      # user = FactoryBot.create(:user, authentication_token: '12345')
      data = {
        email: Faker::Internet.email,
        password: "123456",
        password_confirmation: "123456",
        authentication_token: "12345"
      }
      it 'should raise error ActiveRecord::RecordInvalid' do
        expect { User.create!(data) }.to raise_error ActiveRecord::RecordInvalid
      end

    end
  end
end
