class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_many :entries
  has_many :events, :through => :entries
  has_many :discussions
  has_many :discussion_messages
  has_many :event_messages
  has_many :authentications
  
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at, :group_id, :groups_attributes  
  accepts_nested_attributes_for :groups, :allow_destroy => true
  
  def self.reachable_users(user)
    groups = user.groups
    users = []
    groups.each do |group|
      group_users = group.users
      group_users.each do |group_user|
        unless group_user == user
          users.push(group_user)
        end
      end
    end
    return users
  end
  
  # The apply_omniauth method used to create the user, called from the authentications controller
  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
