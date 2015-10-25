class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Successfully Registered. You are now logged in."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    @user_questions = @user.questions.most_voted
    @user_answers = @user.answers.most_voted
    @user_comments = @user.comments.most_voted
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
