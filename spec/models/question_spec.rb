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

  context "#add_tags" do
    it "parses valid string and adds corresponding tag objects" do
      expect {
        question.add_tags('test1, test2')
      }.to change { Tag.count }.by(2)
    end
    it "does not process empty string" do
      expect {
        question.add_tags('')
      }.not_to change { Tag.count }
    end
    it "does not process nil value" do
      expect {
        question.add_tags(nil)
      }.not_to change { Tag.count }
    end
  end

end
