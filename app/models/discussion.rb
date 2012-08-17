class Discussion < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  attr_accessible :title
end
