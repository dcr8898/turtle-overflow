class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  end

  def show
    @user = User.find_by(id: params[:id])

    @user_questions = @user.questions.most_voted
    @user_answers = @user.answers.most_voted
    @user_comments = @user.comments.most_voted
  end
end
