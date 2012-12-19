class Page < ActiveRecord::Base
  attr_accessible :user_id, :content, :title, :tag_list

  validates :title, :content, :presence => true

  belongs_to :user
  has_many :histories, :dependent => :destroy

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :tags

  default_scope order('created_at DESC')
end
