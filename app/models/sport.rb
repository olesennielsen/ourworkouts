class Sport < ActiveRecord::Base
  attr_accessible :name
  
  has_and_belongs_to_many :groups
  
  validates :name, :presence => true
end
