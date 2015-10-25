class QuestionsController < ApplicationController

  def index
    @questions = Question.most_voted
  end

  def new
    @question = Question.new
  end

  def create
    tags_text = params[:question].delete('tags_text')
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      @question.add_tags(tags_text)
      redirect_to @question
    else
      flash.now.alert = @question.errors.full_messages.join(', ')
      render new_question_path
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = @question.answer
    @answers = @question.unchosen_answers
    @comment = Comment.new
    @new_answer = Answer.new
  end

  def unanswered
    @questions = Question.where("answer_id is ?", nil)
    render 'index'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

end
