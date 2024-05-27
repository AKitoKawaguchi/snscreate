class NotificationsController < ApplicationController
    after_action :change, only:[:index]

    def show
        @notification = Notification.find_by(id:params[:id])
        if @notification.action == ("follow" || "like")
            if !(User.find_by(id:@notification.visitor_id))
                redirect_to("/notifications/nofound")
            else
                @notification.update(checked: true)
            end
        elsif @notification.action == "comment"
            if !(Post.find_by(id:@notification.comment.tocomment))
                redirect_to("/notifications/nofound")
            end
        end
    end

    def index
    end

    def change
        @notifications.each do |notification|
            notification.update(checked: true)
        end
    end
end
