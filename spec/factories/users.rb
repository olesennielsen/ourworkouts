# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'
FactoryGirl.define do

  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password 'please'
    f.password_confirmation 'please'
    # required if the Devise Confirmable module is used
    f.confirmed_at Time.now
  end

  factory :invalid_user, parent: :user do |f|
    f.email nil
  end

end