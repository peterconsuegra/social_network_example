class UsersController < ApplicationController
  
  before_action :require_user_logged_in!
  before_action :set_user, only: [:edit, :update, :destroy]
  
    def profile
       @user = User.find_by(username: params[:username])
       return redirect_to root_path, notice: "User not found" if @user.nil?
       @current_user = Current.user
       @my_friends = @user.my_friends
       my_friends_ids = @my_friends.pluck(:target_id)
       @friends_suggestions = User.where.not(id: my_friends_ids).limit(7)  
       @my_posts_comments = @user.my_posts_comments
       @my_posts = @user.my_posts
       @last_comments = @user.my_last_comments

    end
    
    def feed
      @user = Current.user
      @current_user = @user
      @my_friends = @user.my_friends
      my_friends_ids = @my_friends.pluck(:target_id)
      @friends_suggestions = User.where.not(id: my_friends_ids).limit(7)  
      @last_posts_comments = Post.last_posts_comments
      @last_posts = Post.last_posts
      @last_comments = Comment.last_comments
    end
    
    def edit
      
    end
    
    def update
      if @user.update(user_params)
        redirect_to "/#{@user.username}", notice: "User was updated successfully"
      else
        redirect_to "/#{@user.username}", notice: "Error updating user info"
      end
    end
    
    def add_friend
      
      @friend = Friend.new
      @friend.target_id = params[:target_id]
      @friend.user_id = Current.user.id
      @friend.status = true
      @user = User.find(@friend.target_id)
       
     if @friend.save
         respond_to do |format|  ## Add this
           format.json { render json: @user, status: :ok}
         end   
      else
        respond_to do |format|  ## Add this
          format.json { render json: @friend, status: :error}
        end   
      end
      
    end
    
    
    def add_comment
      
      logger.debug ":class_name: "+params[:class_name]
      logger.debug ":post_id: "+params[:post_id]
      logger.debug ":content: "+params[:content]
      
       @comment = Comment.new
       @comment.commentable_type=params[:class_name]
       @comment.commentable_id=params[:post_id]
       @comment.content=params[:content]
       @comment.user_id = Current.user.id
      
      if @comment.save
          respond_to do |format|  ## Add this
            format.json { render json: {comment: @comment, user: Current.user}, status: :ok}
          end   
       else
         respond_to do |format|  ## Add this
           format.json { render json: @comment, status: :error}
         end   
       end
    end
    
    def add_post
      @post = Post.new
      @post.body = params[:post_body]
      @post.user_id = Current.user.id
      
      if @post.save
          respond_to do |format|  ## Add this
            format.json { render json: @post, status: :ok}
          end   
       else
         respond_to do |format|  ## Add this
           format.json { render json: @post, status: :error}
         end   
       end
    end
    
    private 
    
    def user_params
      params.require(:user).permit(:bio, :likes, :dislikes, :birth, :web)
    end
  
    def set_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: "Forbidden" unless @user.can_edit?
    end

end