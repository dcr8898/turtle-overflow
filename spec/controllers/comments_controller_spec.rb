require 'rails_helper'
require 'pry'

describe CommentsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:qc_valid_attrs) { FactoryGirl.build(:comment).attributes }
  let(:qc_invalid_attrs){ FactoryGirl.build(:comment, body:nil ).attributes }
  let(:ac_valid_attrs) { FactoryGirl.build(:answer_comment).attributes }
  let(:ac_invalid_attrs){ FactoryGirl.build(:answer_comment, body:nil ).attributes }
  let!(:comment) { FactoryGirl.create(:comment, user_id: user.id) }
  let!(:answer_comment) { FactoryGirl.create(:answer_comment, user_id: user.id) }

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

  context "#edit" do
    let!(:comment) { FactoryGirl.create(:comment) }
    it "has a 200 status code" do
      get :edit, id: comment.id
      expect(response.status).to eq(200)
    end

    it "renders the edit template" do
      get :edit, id: comment.id
      expect(response).to render_template("edit")
    end
  end

  context '#update' do

    it 'updates comment with valid parameters' do
      expect {
        patch :update, id: comment.id, comment: { body: 'test' }
      }.to change { comment.reload.body }.to('test')
    end

    it 'redirects after updating a question comment' do
      patch :update, id: comment.id, comment: { body: 'test' }
      expect(response).to redirect_to question_path(comment.commentable, anchor: comment.id)
    end

    it 'redirects after updating a answer comment' do
      patch :update, id: answer_comment.id, comment: { body: 'test' }
      expect(response).to redirect_to question_path(answer_comment.commentable.question_id, anchor: Comment.last.id)
    end

    it 'does not update a comment if params invalid' do
      expect {
        patch :update, id: comment.id, comment: { body: nil }
      }.not_to change { comment.reload.body }
    end

    it 'does not redirect on invalid parameters' do
      patch :update, id: comment.id, comment: { body: nil }
      expect(response).to render_template('comments/edit')
    end
  end


end
