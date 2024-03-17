class FavsController < ApplicationController
    def follow
        @user = User.find_by(id:params[:user_id])
        @fav = Fav.new(
            follow:@current_user.id,
            follower:params[:user_id]
        )
        @fav.save
        redirect_to("/users/#{@user.id}")
    end

    def unfollow
        @user = User.find_by(id:params[:user_id])
        @fav = Fav.find_by(
            follow:@current_user.id,
            follower:params[:user_id]
        )
        @fav.destroy
        redirect_to("/users/#{@user.id}")
    end
end