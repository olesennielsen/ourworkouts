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
puts 'New user created: ' << user3.name

user.add_role :admin
user2.add_role :ordinary_user
user3.add_role :ordinary_user

user.groups << group
user2.groups << group
user3.groups << group

tip = WorkoutTip.create! :title => 'Workout alot', :tip_date => Date.today - 1, :body => 'Just workout a lot', :author => 'ourworkouts.com'
tip1 = WorkoutTip.create! :title => 'Workout even more', :tip_date => Date.today, :body => 'Just workout even more', :author => 'ourworkouts.com'
tip2 = WorkoutTip.create! :title => 'Workout even harder', :tip_date => Date.today + 1, :body => 'Just workout even harder', :author => 'ourworkouts.com'

event = Event.create! :title => 'Running', :start_time => DateTime.now, :end_time => DateTime.now, :organizer => 3, :group_id => 1
event2 = Event.create! :title => 'Biking', :start_time => DateTime.now + 2.days, :end_time => DateTime.now + 2.days, :organizer => 1, :group_id => 1
goal = Event.create! :title => '5x5-Stafet', :start_time => DateTime.now + 30.days, :end_time => DateTime.now + 30.days, :organizer => 2, :group_id => 1, :milestone => true

