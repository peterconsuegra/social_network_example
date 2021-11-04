class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  
  def self.last_comments
    
      Comment.find_by_sql("select *
      from comments 
      inner join users
      on comments.user_id = users.id ORDER BY comments.created_at DESC LIMIT 15")
 
  end
 
end
