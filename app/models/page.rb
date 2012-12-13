class Page < ActiveRecord::Base
  attr_accessible :author, :content, :title

  validates :title, :author, :content, :presence => true
end
