class Like < ApplicationRecord
    validates :user_id, {presence: true}
    validates :post_id, {presence: true}

    has_many :notifications,dependent: :destroy
    belongs_to :post
    belongs_to :user

    def post
        return Post.find_by(id:self.post_id)
    end

    def user
        return User.find_by(id:self.post.user.id)
    end

    def like_notification_by(current_user)
        notification = current_user.active_notifications.new(
          like_id:self.id,
          visited_id:self.user.id,
          action:"like"
        )

        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end
end
