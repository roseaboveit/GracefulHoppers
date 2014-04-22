# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unit do
    published false
    description "MyText"
    total_points 1
    image "MyText"
  end
end
