class SearchesController < ApplicationController
    def user_search
        redirect_to("/searches/#{params[:user]}/user")
    end

    def usersearch
        @perfectusers = User.where(name:params[:name])
        @users = User.where("name LIKE?","%#{params[:name]}%")
        @particalusers = @users - @perfectusers
    end

    def post_search
        redirect_to("/searches/#{params[:post]}/post")
    end

    def postsearch
        @posts = Post.where("content LIKE?","%#{params[:post]}%")
    end
end

