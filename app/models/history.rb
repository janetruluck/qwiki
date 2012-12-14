class History < ActiveRecord::Base
  attr_accessible :current_content, :note, :page_id, :previous_content, :user_id

  belongs_to :user
  belongs_to :page
end
