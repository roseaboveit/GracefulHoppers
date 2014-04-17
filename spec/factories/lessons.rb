# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    title "MyString"
    unit_id 3
    association :unit
    description "MyText"
    path "vocation"
    points 1
  end
end
