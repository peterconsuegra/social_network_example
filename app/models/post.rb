class Post < ApplicationRecord
  
  has_many :comments, as: :commentable
  
  belongs_to :user
  
  def self.last_posts
    
      Post.find_by_sql("select posts.id as post_id, posts.body, users.profile_pic_id, users.name, users.last_name, posts.created_at, users.username
      from posts 
      inner join users
      on posts.user_id = users.id ORDER BY posts.created_at DESC LIMIT 30")
 
  end
  
  
  def self.last_posts_comments 
    
    comments = Comment.find_by_sql("select users.profile_pic_id, comments.content, posts.id as post_id, users.username, users.name, users.last_name from posts 
    inner join comments on comments.commentable_id = posts.id 
    inner join users on comments.user_id = users.id 
    where comments.commentable_type='Post' ORDER BY posts.created_at DESC LIMIT 100")
    
    comments_hash = Hash.new
    comments.each do |comment|
      if comments_hash[comment.post_id].nil?
         comments_hash[comment.post_id] = []
         comments_hash[comment.post_id].push(comment)
       else
         comments_hash[comment.post_id].push(comment)
       end
    end
     comments_hash
  end
  
end
