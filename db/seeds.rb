# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#recreate everythinh
#rake db:drop db:create db:migrate db:seed

require 'faker'

#seed users logic
User.destroy_all
def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end
(1..50).each do |i|
  u = User.new
  u.name = Faker::Name.first_name
  u.last_name = Faker::Name.last_name
  u.email = Faker::Internet.email
  u.username = u.name + u.last_name
  u.username = u.username.downcase
  u.username = u.username.gsub(/[^0-9a-z]/i, '')
  #password = random_password
  u.password = "123456789"
  u.password_confirmation = "123456789"
  u.bio = Faker::Movies::BackToTheFuture.quote
  u.likes = Faker::TvShows::Friends.quote 
  u.dislikes = Faker::TvShows::Friends.quote 
  u.birth = time_rand
  u.save!
  
end

#seed posts logic
Post.destroy_all
users = User.all
(1..10).each do |i|
  users.each do |user|
    p = Post.new
    p.user_id = user.id
    p.body = Faker::TvShows::Seinfeld.quote
    p.save!
  end
end

#seed friends logic
Friend.destroy_all
users = User.all
users.each do |user|
  friends = users.sample(10)
  friends.each do |friend|
    if friend.id != user.id
      f = Friend.new
      f.user_id = user.id
      f.target_id = friend.id
      f.status = true
      f.save!
    end
  end
  
end

#seed comments logic
Comment.destroy_all
posts = Post.all
users = User.all
posts.each do |post|
  talkers = users.sample(5)
  talkers.each do |user|
    comment = Comment.new
    comment.content = Faker::TvShows::Friends.quote 
    comment.user_id = user.id
    comment.commentable_type = "Post"
    comment.commentable_id = post.id
    comment.save!
  end
end
