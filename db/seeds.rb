# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sport1 = Sport.create! :name => 'Running'
sport2 = Sport.create! :name => 'Orienteering'
sport3 = Sport.create! :name => 'Cycling'

group = Group.create! :name => 'Olesen & Nielsen', :public => 'true', :description => 'Group at Olesen & Nielsen, the company behind ourworkouts.com, we love to exercise and do most of our workouts together at the company.'

group.sports << sport1
group.sports << sport2
group.sports << sport3

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user2.name
user3 = User.create! :name => 'Third User', :email => 'user3@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user2.name
user4 = User.create! :email => 'hav@hav.com', :password => 'qwerty', :confirmed_at => Time.now.utc
user.add_role :admin
user.groups << group
user2.groups << group
user3.groups << group
