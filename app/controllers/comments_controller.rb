class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = User.last #current_user
    @comment.commentable = Question.find(params[:question_id])
    if @comment.save
      redirect_to question_path(@comment.commentable, anchor: @comment.id)
    else
      redirect_to question_path(@comment.commentable, anchor: 'new_comment', flash: {error: @comment.errors.full_messages.join(', ')})
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end