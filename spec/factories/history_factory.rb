FactoryGirl.define do
  factory :history do
    user
    page
    note              "MyString"
    current_content   "MyText"
    previous_content  "MyText"
  end
end
