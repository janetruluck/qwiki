FactoryGirl.define do
  factory :page do
    user
    title     "This is a Test Title"
    content   "#A Title\r\n This is some test content that would be in the wiki page. ```ruby def some code ```"
  end
end