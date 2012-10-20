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
  def apply_facebook_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    self.name = omniauth['info']['name'] if name.blank?
    self.locale = omniauth['extra']['raw_info']['locale'] if locale.blank?
    self.add_role :group_admin
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
  end
  
  def apply_google_omniauth(omniauth)
    data = omniauth.info    
    self.email = data['email'] if email.blank?
    self.name = data['name'] if name.blank?
    self.add_role :group_admin
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def apply_linkedin_omniauth(omniauth)
    data = omniauth.info    
    self.email = data['email'] if email.blank?
    self.name = data['name'] if name.blank?
    self.add_role :group_admin
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  def self.find_organizer(id)
    return User.find(id)
  end
  
  def self.find_sender_receiver(id)
    return User.find(id)
  end
  
  def is_group_admin?
    group_admins = GroupAdmin.where(:user_id => self.id)
    not group_admins.empty?
  end  
end
