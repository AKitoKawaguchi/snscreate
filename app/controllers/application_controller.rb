class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        @current_user = User.find_by(id:session[:user_id])
        if @current_user
          notifications = @current_user.passive_notifications.all
          @notifications = notifications.where.not(visitor_id: @current_user.id)
        end
    end

end
