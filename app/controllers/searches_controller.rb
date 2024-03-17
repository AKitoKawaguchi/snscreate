class SearchesController < ApplicationController
    def user_search
        redirect_to("/searches/#{params[:user]}")
    end

    def usersearch
        @perfectusers = User.where(name:params[:name])
        @users = User.where("name LIKE?","%#{params[:name]}%")
        @particalusers = @users - @perfectusers
    end
end

