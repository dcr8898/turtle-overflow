class AnswersController < ApplicationController

  def create
    @answer = Answer.new(answer_params)
    @answer.user = User.last #current_user
    @answer.question = Question.find(params[:question_id])
    if @answer.save
      redirect_to question_path(@answer.question, anchor: @answer.id)
    else
      redirect_to question_path(@answer.question, anchor: 'new_answer', flash: {error: @answer.errors.full_messages.join(', ')})
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:body)
    end

end