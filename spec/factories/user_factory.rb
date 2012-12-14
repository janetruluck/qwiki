FactoryGirl.define do
  factory :user do
    email                  'test@example.com'
    password               'password'
    password_confirmation  'password'
    first_name             'Johnny'
    last_name              'Test'
  end
end