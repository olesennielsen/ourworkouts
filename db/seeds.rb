# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

group = Group.create! :name => 'heste'

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user2.name
user.add_role :admin
user.groups << group
user2.groups << group

direct_messages = DirectMessage.create!([{body: "besked 1", sender_id: 1, recipient_id: 2}, 
                                          {body: "svar til besked 1", sender_id: 2, recipient_id: 1},
                                          {body: "besked 2", sender_id: 2, recipient_id: 1}])