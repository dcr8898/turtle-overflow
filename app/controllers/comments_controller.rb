class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if params[:answer_id]
      @comment.commentable = Answer.find(params[:answer_id])
      if @comment.save
        redirect_to question_path(@comment.commentable.question_id, anchor: @comment.id)
      else
        redirect_to question_path(@comment.commentable.question_id, anchor: 'new_comment'), flash: { error: @comment.errors.full_messages.join(', ') }
      end
    else
      @comment.commentable = Question.find(params[:question_id])
      if @comment.save
        redirect_to question_path(@comment.commentable, anchor: @comment.id)
      else
        redirect_to question_path(@comment.commentable, anchor: 'new_comment'), flash: { error: @comment.errors.full_messages.join(', ') }
      end
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
    @commentable = @comment.commentable
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
      if @comment.commentable_type == "Answer"
        redirect_to question_path(@comment.commentable.question_id, anchor: @comment.id)
      else
        redirect_to question_path(@comment.commentable, anchor: @comment.id)
      end
    else
      flash.now.alert = @comment.errors.full_messages.join(', ')
      render 'comments/edit'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end