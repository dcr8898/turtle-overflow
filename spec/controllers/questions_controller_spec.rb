require 'rails_helper'

describe QuestionsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attrs) { FactoryGirl.build(:question).attributes }
  let(:invalid_attrs) { FactoryGirl.build(:question, body: nil).attributes }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  context "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "assigns questions to Question.all" do
      get :index
      expect(assigns(:questions)).to eq Question.most_voted
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  context "#new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context '#create' do
    it 'creates a question from valid parameters' do
      expect {
        post :create, { question: valid_attrs }
      }.to change { Question.count }.by(1)
    end

    it 'redirects after creating a question' do
      post :create, { question:  valid_attrs }
      expect(response).to redirect_to question_path(Question.last)
    end

    it 'does not create a question if params invalid' do
      expect {
        post :create, { question: invalid_attrs }
      }.not_to change{ Question.count }
    end

    it 'does not redirect on invalid parameters' do
      post :create, { question: invalid_attrs }
      expect(response).to render_template('questions/new')
    end
  end

  context "#edit" do
    let!(:question) { FactoryGirl.create(:question) }
    it "has a 200 status code" do
      get :edit, id: question.id
      expect(response.status).to eq(200)
    end

    it "renders the edit template" do
      get :edit, id: question.id
      expect(response).to render_template("edit")
    end
  end

  context '#update' do
    let!(:question) { FactoryGirl.create(:question) }
    it 'updates question with valid parameters' do
      expect {
        patch :update, id: question.id, question: { body: 'test' }
      }.to change { question.reload.body }.to('test')
    end

    it 'redirects after updating a question' do
      patch :update, id: question.id, question: { body: 'test' }
      expect(response).to redirect_to question_path(question.id)
    end

    it 'does not update a question if params invalid' do
      expect {
        patch :update, id: question.id, question: { body: nil }
      }.not_to change { question.reload.body }
    end

    it 'does not redirect on invalid parameters' do
      patch :update, id: question.id, question: { body: nil }
      expect(response).to render_template('questions/edit')
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
