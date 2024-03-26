class Post < ApplicationRecord
    validates :user_id,{presence: true}
    has_many :likes, dependent: :destroy
    has_many :hashtag_posts, dependent: :destroy
    has_many :hashtags, through: :hashtag_posts
    has_many :notifications, class_name: "Notification", foreign_key: "comment_id", dependent: :destroy
    belongs_to :user

    def user
        return User.find_by(id:self.user_id)
    end

    def comment_notification_by(current_user)
        post = Post.find_by(id:self.tocomment)
        notification = current_user.active_notifications.new(
          comment_id:self.id,
          visited_id:post.user.id,
          action:"comment"
        )

        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end
end
