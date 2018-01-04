class CommentsController < ApplicationController

  protect_from_forgery :except => ["create"]

  def create
    @comment = current_user.comments.build(comment_params)
    @consultation = @comment.consultation

    respond_to do |format|
      if @comment.save
        format.html { redirect_to consultation_path(@consultation) }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:consultation_id, :content)
  end
end
