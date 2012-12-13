FactoryGirl.define do
  factory :page do
    title     "This is a Test Title"
    author    "Johnny Test"
    content   "#A Title\r\n This is some test content that would be in the wiki page. ```ruby def some code ```"
  end
end