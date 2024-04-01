class MainController < ApplicationController
  before_action :ensure_user_id,{only:[:index,:show,:create,:destroy,:reply,:hashtag]}
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id:params[:id])
    @user = User.find_by(id:@post.user_id)
    @comments = Post.where(tocomment:@post.id)
  end


  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id,
    )
    extract_hashtag_from_text(params[:content]).each do |tag|
      hashtag = Hashtag.find_or_create_by(hashname:tag.delete("#"))
      @post.hashtags << hashtag
    end

    if @post.save
      flash[:notice] = "投稿が完了しました"
      redirect_to("/main/index")
    else
      render("main/new",status: 303)
    end
  end

  def extract_hashtag_from_text(text)
    text.scan(/#\w+/).map.uniq
  end

  private :extract_hashtag_from_text

  def destroy
    @post = Post.find_by(id:params[:id])
    @like = Like.where(post_id:@post.id)
    @post.destroy
    @like.destroy_all
    redirect_to("/main/index")
  end


  def reply
    @post = Post.new(
      content: params[:comment],
      tocomment: params[:id],
      user_id: @current_user.id
    )
    extract_hashtag_from_text(params[:comment]).each do |tag|
      hashtag = Hashtag.find_or_create_by(hashname:tag.delete("#"))
      @post.hashtags << hashtag
    end
    @post.save
    @post.comment_notification_by(@current_user)
    redirect_to("/main/index")
  end

  def hashtag
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts
  end
  
  def ensure_user_id
    unless session[:user_id]
      flash[:notice] = "権限がありません"
      redirect_to("/login")
    end
  end
end
