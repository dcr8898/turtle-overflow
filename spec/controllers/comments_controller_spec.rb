require 'rails_helper'

describe CommentsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:qc_valid_attrs) { FactoryGirl.build(:comment).attributes }
  let(:qc_invalid_attrs){ FactoryGirl.build(:comment, body:nil ).attributes }
  let(:ac_valid_attrs) { FactoryGirl.build(:answer_comment).attributes }
  let(:ac_invalid_attrs){ FactoryGirl.build(:answer_comment, body:nil ).attributes }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#create' do

    it 'creates a question comment from valid parameters' do
      expect do
        post :create, { comment: qc_valid_attrs,
                        question_id: qc_valid_attrs["commentable_id"] }
      end.to change{Comment.count}.by(1)
    end
    it 'redirects after creating a question comment' do
        post :create, { comment: qc_valid_attrs,
                        question_id: qc_valid_attrs["commentable_id"] }
        expect(response).to redirect_to question_path(qc_valid_attrs["commentable_id"],
                                                      anchor: Comment.last.id)
    end
    it 'does not redirect on invalid parameters (question comment)' do
      post :create, {comment: qc_invalid_attrs,
                     question_id: qc_valid_attrs["commentable_id"] }
      expect(response).to redirect_to question_path(qc_valid_attrs["commentable_id"],
                                                    anchor: 'new_comment')
    end
    it 'does not create a message if params invalid (question comment)' do
      expect{
        post :create, {comment: qc_invalid_attrs,
                       question_id: qc_valid_attrs["commentable_id"] }
      }.not_to change{Comment.count}
    end

    it 'creates an answer comment from valid parameters' do
      expect do
        post :create, { comment: ac_valid_attrs,
                        answer_id: ac_valid_attrs["commentable_id"] }
      end.to change{Comment.count}.by(1)
    end
    it 'redirects after creating an answer comment' do
        post :create, { comment: ac_valid_attrs,
                        answer_id: ac_valid_attrs["commentable_id"] }
        expect(response).to redirect_to question_path(Answer.find(ac_valid_attrs["commentable_id"]).question,
                                                      anchor: Comment.last.id)
    end
    it 'does not redirect on invalid parameters (answer comment)' do
      post :create, {comment: ac_invalid_attrs,
                     answer_id: ac_valid_attrs["commentable_id"] }
      expect(response).to redirect_to question_path(Answer.find(ac_valid_attrs["commentable_id"]).question,
                                                    anchor: 'new_comment')
    end
    it 'does not create a message if params invalid (answer comment)' do
      expect{
        post :create, {comment: ac_invalid_attrs,
                       answer_id: ac_valid_attrs["commentable_id"] }
      }.not_to change{Comment.count}
    end

  end

end
