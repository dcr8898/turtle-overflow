class QuestionsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show, :unanswered]

  before_action :verify_ownership, only: [:update, :destroy]

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
      render 'questions/new'
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = @question.answer
    @answers = @question.unchosen_answers
    @comment = Comment.new
    @new_answer = Answer.new
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    tags_text = params[:question].delete('tags_text')
    @question = Question.find_by(id: params[:id])
    if @question.update(question_params)
      @question.add_tags(tags_text)
      redirect_to @question
    else
      flash.now.alert = @question.errors.full_messages.join(', ')
      render 'questions/edit'
    end
  end

  def unanswered
    @questions = Question.where("answer_id is ?", nil)
    render 'index'
  end

  def vote
    vote = current_user.votes.new(value: params[:value], voteable_id: params[:id], voteable_type: params[:type])
    if vote.save
      redirect_to :back, notice: "Vote accepted."
    elsif vote.has_voted?
      vote.existing_vote.update(value: vote.value)
      redirect_to :back, notice: "Vote updated."
    else
      redirect_to :back, alert: "Unable to vote on this."
    end
  end

  def destroy
    question = Question.find_by(id: params[:id])

    question.destroy
    flash[:notice] = "You've successfully deleted #{question.title}"
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def logged_in_user
    unless logged_in?
      flash[:notice] = "Please log in."
      redirect_to login_path
    end
  end

  def verify_ownership
    question = Question.find_by(id: params[:id])

    unless question.user == current_user
      flash[:notice] = "Action failed. You are not the owner of this question."
      redirect_to question
    end
  end
end
