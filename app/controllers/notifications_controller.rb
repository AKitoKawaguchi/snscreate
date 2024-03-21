class NotificationsController < ApplicationController
    def show
        @notification = Notification.find_by(id:params[:id])
        @notification.update(checked: true)
    end
end
