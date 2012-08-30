class DirectMessage < ActiveRecord::Base
  has_one :sender, :class_name => "User"
  has_one :recipient, :class_name => "User"
  
  attr_accessible :body, :sender_id, :recipient_id, :created_at
  
  def self.get_direct_messages(user)
    direct_messages = Hash.new
    
    sent = DirectMessage.where(:sender_id => user).group_by(&:recipient_id)
    received = DirectMessage.where(:recipient_id => user).group_by(&:sender_id)
    
    if sent.size > received.size
      sent.each do |id, messages|        
        if received[id].nil?
          tmp = messages      
        else
          tmp = received[id] + messages
        end
        tmp = tmp.sort_by!(&:created_at)
        direct_messages[User.find(id)] = tmp
      end
    else
      received.each do |id, messages|        
        if sent[2].nil?
          tmp = messages
        else
          tmp = sent[id] + messages
        end       
        tmp = tmp.sort_by!(&:created_at)
        direct_messages[User.find(id)] = tmp
      end
    end
    
    return direct_messages     
  end
end
