class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :entries
  has_many :events, :through => :entries
  has_many :discussions
  has_many :discussion_messages
  has_many :event_messages
  
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
end
