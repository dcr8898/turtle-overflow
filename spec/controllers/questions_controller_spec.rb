require 'rails_helper'

describe QuestionsController do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attrs) { FactoryGirl.build(:question).attributes }
  let(:invalid_attrs) { FactoryGirl.build(:question, body:nil).attributes }

  context "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "assigns questions to all Question.all" do
      get :index
      expect(assigns(:questions)).to eq Question.most_voted
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  context "#show" do
    let(:question) { FactoryGirl.create :question}
    it "is successful" do
      get :show, :id => question.id
      expect(response).to be_success
    end

    it "assigns @question to the Category found by id " do
      get :show, :id => question.id
      expect(assigns(:question)).to eq question
    end

    it "renders the show template" do
      get :show, :id => question.id
      expect(response).to render_template("show")
    end
  end

  context "unanswered" do
    let(:question) { FactoryGirl.create :question}
    it "assigns @questions to have answer_id as nil" do
      get :unanswered, :id => question.id
      expect(assigns(:questions)).to eq Question.where("answer_id is ?", nil)
    end
  end
end
