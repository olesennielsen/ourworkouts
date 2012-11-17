# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sport1 = Sport.create! :name => 'Running', :link => 'http://upload.wikimedia.org/wikipedia/commons/8/8f/Athletics_pictogram.svg'
sport2 = Sport.create! :name => 'Cycling', :link => 'http://upload.wikimedia.org/wikipedia/commons/8/86/Cycling_%28road%29_pictogram.svg'

group = Group.create! :name => 'Olesen & Nielsen', :public => 'true', :description => 'Group at Olesen & Nielsen, the company behind ourworkouts.com, we love to exercise and do most of our workouts together at the company.'

group.sports << sport1
group.sports << sport2

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user2.name
user3 = User.create! :name => 'Third User', :email => 'user3@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
puts 'New user created: ' << user3.name

user.add_role :admin
GroupAdmin.create! :user_id => 1, :group_id => 1
user2.add_role :group_admin
GroupAdmin.create! :user_id => 2, :group_id => 1
user3.add_role :ordinary_user

user.groups << group
user2.groups << group
user3.groups << group

tip = WorkoutTip.create! :title => 'Workout alot', :tip_date => Date.today - 1, :body => 'Just workout a lot', :author => 'ourworkouts.com'
tip1 = WorkoutTip.create! :title => 'Workout even more', :tip_date => Date.today, :body => 'Just workout even more', :author => 'ourworkouts.com'
tip2 = WorkoutTip.create! :title => 'Workout even harder', :tip_date => Date.today + 1, :body => 'Just workout even harder', :author => 'ourworkouts.com'