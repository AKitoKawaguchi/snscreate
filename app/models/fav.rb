class Fav < ApplicationRecord
    def follow_notification_by(current_user)
        notification = current_user.active_notifications.new(
          visited_id:self.follower,
          action:"follow"
        )
        notification.save if notification.valid?
    end

    def unfollow_notification_by(current_user)
        notification = Notification.find_by(
          visitor_id:current_user.id,
          visited_id:self.follower,
          action:"follow"
        )
        notification.destroy if notification.valid?
    end
end

