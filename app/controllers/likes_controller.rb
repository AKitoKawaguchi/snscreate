class LikesController <ApplicationController
    def create
        @like = Like.new(
            user_id: @current_user.id,
            post_id: params[:post_id]
        )

        @like.save
        redirect_to(request.fullpath)
    end

    def destroy
        @like = Like.find_by(
            user_id: @current_user.id,
            post_id: params[:post_id]
        )

        @like.destroy
        redirect_to(request.fullpath)
    end
end