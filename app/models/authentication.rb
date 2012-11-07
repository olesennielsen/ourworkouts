class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :token, :uid, :user_id
  
  def self.authenticated?(user_id, provider)
    authentication = Authentication.where(:user_id => user_id, :provider => provider)
    if authentication.nil?
      return false
    else
      return true
    end
  end
  
  def self.number_of_authentications(user)
    return Authentication.where(:user_id => user).count
  end
end
