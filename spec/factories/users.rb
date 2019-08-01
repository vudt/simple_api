require 'faker'
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    # email { Faker::Name.name }
    password {"123456"}
    password_confirmation {"123456"}
    # authentication_token { Faker::Code.imei }
    authentication_token { "123" }
  end
end