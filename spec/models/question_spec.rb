require 'rails_helper'

describe Question do
  let(:question) { FactoryGirl.build :question }

  context "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :user }
  end

  context "associations" do
    it { should belong_to :user}
    it { should belong_to :answer}
    it { should have_many :answers} 
    it { should have_and_belong_to_many :tags}  
    it { should have_many :comments} 
    it { should have_many :votes}  
    it "has many answers" do
    expect {
      question.answers << FactoryGirl.build(:answer)
      }.to change { Question.count }.by(1)
    end
  end

  it "question should be unanswered by default" do
    expect (question.answer).should be_nil
  end
end