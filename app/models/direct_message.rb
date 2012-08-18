class DirectMessage < ActiveRecord::Base
  has_one :sender, :class_name => "User"
  has_one :recipient, :class_name => "User"
  
  attr_accessible :body, :sender_id, :recipient_id, :created_at
  
  def self.get_direct_messages(user)
    direct_messages = []
    
    sent_messages = DirectMessage.where(:sender_id => user).group_by(&:recipient_id)
    received_messages = DirectMessage.where(:recipient_id => user).group_by(&:sender_id)
    
    sent_messages.each do |recipient_id, direct_messages|
      tmp_messages = received_messages[recipient_id]
      tmp_messages.sort_by {|message| message.created_at}
      tmp_messages.each do |t_m|
        direct_messages.push(t_m)
      end
    end
    
    return direct_messages
     
  end
end
