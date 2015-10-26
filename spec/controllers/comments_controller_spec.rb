require 'rails_helper'

describe CommentsController do

  let(:user) { FactoryGirl.create(:user)}
  let(:valid_attrs) { FactoryGirl.build(:comment).attributes }
  let(:invalid_attrs){ FactoryGirl.build(:comment, body:nil ).attributes }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe '#create' do

    it 'creates a comment from valid parameters' do
      expect do 
        if valid_attrs["commentable_type"] == "Question"
          post :create, { comment: valid_attrs, question_id: valid_attrs["commentable_id"] }
        else
          post :create, { comment: valid_attrs, answer_id: valid_attrs["commentable_id"] }
        end
      end.to change{Comment.count}.by(1)
    end

    it 'redirects after creating a message' do
      post :create, {comment:  valid_attrs, question_id: valid_attrs["commentable_id"] }
      expect(response).to redirect_to question_path(valid_attrs["commentable_id"], anchor: valid_attrs["commentable_id"])
    end

    it 'does not redirect on invalid parameters' do
      post :create, {comment: invalid_attrs, question_id: valid_attrs["commentable_id"] }
      expect(response).to redirect_to question_path(valid_attrs["commentable_id"], anchor: 'new_comment')    
    end

    it 'does not create a message if params invalid' do
      expect{post :create, {comment: invalid_attrs, question_id: valid_attrs["commentable_id"] }}.not_to change{Comment.count}
    end

  end

end