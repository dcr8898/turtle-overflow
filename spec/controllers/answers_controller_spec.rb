require 'rails_helper'

describe AnswersController do

  let(:user) { FactoryGirl.create(:user)}
  let(:valid_attrs) { FactoryGirl.build(:answer).attributes }
  let(:invalid_attrs){ FactoryGirl.build(:answer, body:nil ).attributes }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#create' do

    it 'creates a answer from valid parameters' do
      expect do 
        post :create, {answer: valid_attrs, question_id: valid_attrs["question_id"] }
      end.to change{Answer.count}.by(1)
    end

    it 'redirects after creating a message' do
      post :create, {answer:  valid_attrs, question_id: valid_attrs["question_id"] }
      expect(response).to redirect_to question_path(valid_attrs["question_id"], anchor: valid_attrs["question_id"])
    end

    it 'does not redirect on invalid parameters' do
      post :create, {answer: invalid_attrs, question_id: valid_attrs["question_id"] }
      expect(response).to redirect_to question_path(valid_attrs["question_id"], anchor: 'new_answer')    
    end

    it 'does not create a message if params invalid' do
      expect{post :create, {answer: invalid_attrs, question_id: valid_attrs["question_id"] }}.not_to change{Answer.count}
    end

  end


end
