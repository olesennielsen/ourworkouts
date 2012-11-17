class Sport < ActiveRecord::Base
  attr_accessible :name, :link
  
  has_and_belongs_to_many :groups
  
  validates :name, :presence => true
  validates :link, :presence => true
end
