class Post < ApplicationRecord
    validates :user_id,{presence: true}
    has_many :hashtag_posts, dependent: :destroy
    has_many :hashtags, through: :hashtag_posts

    def user
        return User.find_by(id:self.user_id)
    end
end
