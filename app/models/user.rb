class User < ApplicationRecord
  
  before_create :set_profile_pic_id
  
  has_many :twitter_accounts
  has_many :posts
  has_many :friends
  
  has_secure_password

  validates :email, presence: true
  validates :username, presence: true
  validates :name, presence: true
  validates :last_name, presence: true
  
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  
  def complete_name
    "#{self.name} #{self.last_name}"
  end
  
  def can_edit?
    if self.id == Current.user.id
      return true
    else
      return false
    end
  end
  
  def set_profile_pic_id
    array = [1,2,3,4,5,6,7,8]
    self.profile_pic_id = array.sample
  end
  
  def get_avatar
    "/avatars/avatar#{profile_pic_id}.png"
  end
  
  def my_friends
    User.find_by_sql("select *
from friends 
inner join users
on friends.target_id = users.id where friends.user_id=#{self.id}")
  end
  
  def my_posts
    Post.find_by_sql("select posts.id as post_id, posts.body, users.profile_pic_id, users.name, users.last_name, posts.created_at, users.username
    from posts 
    inner join users
    on posts.user_id = users.id where users.id=#{self.id} ORDER BY posts.created_at DESC LIMIT 20")
  end
  
  def my_posts_comments
    
    comments = Comment.find_by_sql("select users.profile_pic_id, comments.content, posts.id as post_id, users.username, users.name, users.last_name, comments.created_at from posts 
    inner join comments on comments.commentable_id = posts.id 
    inner join users on comments.user_id = users.id 
    where posts.user_id=#{self.id} and comments.commentable_type='Post' ORDER BY posts.created_at DESC LIMIT 100")
    
    comments_hash = Hash.new
    comments.each do |comment|
      if comments_hash[comment.post_id].nil?
         comments_hash[comment.post_id] = []
         comments_hash[comment.post_id].push(comment)
       else
         comments_hash[comment.post_id].push(comment)
       end
    end
    
     
     logger.debug "my_posts_comments:"
     logger.debug comments_hash
     
      comments_hash
     
  end
  
  
  def my_last_comments
    
      Comment.find_by_sql("select *
      from comments 
      inner join users
      on comments.user_id = users.id where users.id = #{self.id} ORDER BY comments.created_at DESC LIMIT 15")
 
  end

end
