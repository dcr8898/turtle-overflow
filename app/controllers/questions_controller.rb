class QuestionsController < ApplicationController
  def index
    @questions = Question.most_voted
  end

  def show
    @question = Question.find(params[:id])
    @answer = @question.answer
    @answers = @question.answers.order('votes_count desc')
  end

end