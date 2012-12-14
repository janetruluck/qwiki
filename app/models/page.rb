class Page < ActiveRecord::Base
  attr_accessible :user_id, :content, :title

  validates :title, :content, :presence => true

  belongs_to :user
  has_many :histories, :dependent => :destroy
end
