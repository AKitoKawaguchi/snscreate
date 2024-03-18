class UsersController < ApplicationController
  before_action :ensure_user_id,{only:[:mypage]}
  before_action :ensure_correct_user,{only:[:edit,:update]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(
     name: params[:name],
     email: params[:email], 
     password: params[:password],
     image_name: "default_image.jpg")
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      render("users/new",status: 303)
    end
  end

  def mypage
    @user = User.find_by(id:params[:id])
    @likes = Like.where(user_id:params[:id])
    @comments = Post.where(user_id:params[:id],like: nil)
    @follow = Fav.where(follow:params[:id])
    @follower = Fav.where(follower:params[:id])
  end


  def edit
    @user = User.find_by(id:params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.profile = params[:profile]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
     end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name], email: params[:email], password: params[:password])
    if @user
      flash[:notice] = "ログインしました"
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      @error_message = "ユーザ名またはパスワードが違います"
      @name = params[:name]
      @email = params[:email]
      @password = params[:password]
      render("users/login_form",status: 303)
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_user_id
    unless session[:user_id]
      flash[:notice] = "権限がありません"
      redirect_to("/login")
    end
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/main/index")
    end
  end
end
