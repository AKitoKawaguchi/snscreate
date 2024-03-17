class Like < ApplicationRecord
    validates :user_id, {presence: true}
    validates :post_id, {presence: true}

    def post
        return Post.find_by(id:self.post_id)
    end
end
