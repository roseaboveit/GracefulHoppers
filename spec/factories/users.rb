# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    name "MyString"
    username "MyString"
    email 
    admin false
    unit 1
    description "MyText"
    twitter_uid "MyString"
    github_uid "MyString"
  end
end
