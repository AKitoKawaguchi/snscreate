class UsersController < ApplicationController
  before_action :ensure_user_id,{only:[:mypage,:delete]}
  before_action :delete_user_id,{only:[:mypage]}
  before_action :ensure_correct_user,{only:[:edit,:update,:train,:train_form,:delete]}
  before_action :ensure_train_user,{only:[:train_edit,:train_destroy,:recode_edit]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(
     name: params[:name],
     email: params[:email], 
     password: params[:password],
     image_name: "default.png")
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
    @comments = Post.where(user_id:params[:id]).where.not(tocomment: nil)
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

  def start
    if session[:user_id]
      redirect_to("/users/#{@current_user.id}")
    else
      redirect_to("/users/login_form")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      flash[:notice] = "ログインしました"
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      @error_message = "メールアドレスまたはパスワードが違います"
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

  def train
    @trainning_recodes = Trainrecode.where(user_id:params[:id],food:nil,sleep:nil)
    @food_recodes = Trainrecode.where(user_id:params[:id],trainnig:nil,sleep:nil)
    @sleep_recodes = Trainrecode.where(user_id:params[:id],food:nil,trainnig:nil)
    @user = User.find_by(id:params[:id])
  end

  def train_form
    if params[:type].to_i == 1
      @recode =Trainrecode.new(
        user_id: params[:id],
        trainnig: params[:content]
      )
    elsif params[:type].to_i == 2
      @recode = Trainrecode.new(
        user_id: params[:id],
        food: params[:content]
      )
    elsif params[:type].to_i == 3
      @recode = Trainrecode.new(
        user_id: params[:id],
        sleep: params[:content]
      )
    end
    @recode.save
    redirect_to("/users/#{@recode.user_id}/train")
  end

  def train_edit
    @recode = Trainrecode.find_by(id:params[:recode_id])
    if @content = @recode.trainnig
    elsif @content = @recode.food
    elsif @content = @recode.sleep
    end
  end

  def recode_edit
    @recode = Trainrecode.find_by(id:params[:recode_id])
    if @recode.trainnig
      @recode.trainnig = params[:recontent]
    elsif @recode.food
      @recode.food = params[:recontent]
    elsif @recode.sleep
      @recode.sleep = params[:recontent]
    end
    @recode.save
    redirect_to("/users/#{@recode.user_id}/train")
  end

  def train_destroy
    @recode = Trainrecode.find_by(id:params[:recode_id])
    @recode.destroy
    redirect_to("/users/#{@recode.user_id}/train")
  end

  def delete
  end

  def delete_decision
    @user = User.find_by(id:params[:user_id])
    Fav.destroy_by(follow:@user.id)
    Fav.destroy_by(follower:@user.id)
    @user.destroy
    session[:user_id] = nil
    redirect_to("/")
  end

  def ensure_user_id
    unless session[:user_id]
      flash[:notice] = "権限がありません"
      redirect_to("/login")
    end
  end

  def delete_user_id
    unless User.find_by(id:params[:id])
      redirect_to("/searches/#{params[:id]}/user")
    end
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/main/index")
    end
  end

  def ensure_train_user
    if @current_user.id != Trainrecode.find_by(id:params[:recode_id]).user_id
      flash[:notice] = "権限がありません"
      redirect_to("/main/index")
    end
  end
end
