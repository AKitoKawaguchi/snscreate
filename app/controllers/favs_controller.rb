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

    def followlist
        @follows = Fav.where(follow:params[:id])
        @users = Array.new
        @follows.each do |follow|
            user = User.find_by(id:follow.follower)
            @users << user
        end
    end

    def followerlist
        @followers = Fav.where(follower:params[:id])
        @users = Array.new
        @followers.each do |follower|
            user = User.find_by(id:follower.follow)
            @users << user
        end
    end
end