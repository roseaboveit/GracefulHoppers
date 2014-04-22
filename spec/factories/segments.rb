# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :segment do
    lesson_id 1
    content_type "markdown"
    content "MyText"
    place_value 1
  end
end
