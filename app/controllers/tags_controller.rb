class TagsController < ActionController::Base
  def index
    @tags = Tag.all.order(:text)
  end

  def show
    @tag = Tag.find_by(id: params[:id])
    @questions = @tag.questions
  end
end
