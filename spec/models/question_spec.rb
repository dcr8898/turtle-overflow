require 'rails_helper'

describe Question do
  let(:question) { FactoryGirl.build :question }
  let(:tag) { FactoryGirl.create :tag }

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
    it "parses valid string and adds corresponding existing tag objects" do
      question.add_tags(tag.text)
      expect(question.tags).to include(tag)
    end
    it "parses valid string and adds corresponding new tag objects" do
      expect {
        question.add_tags('test1, test2')
      }.to change { Tag.count }.by(2)
    end
    it "clears question's tag collection when passed empty string" do
      question.add_tags('test1, test2')
      question.add_tags('')
      expect(question.tags).to be_empty
    end
    it "clears question's tag collection when passed nil" do
      question.add_tags('test1, test2')
      question.add_tags(nil)
      expect(question.tags).to be_empty
    end
  end

  context "#tags_text" do
    it "returns the value of question.tags.tags_text" do
      question.add_tags('test1, test2')
      expect(question.tags_text).to eq(question.tags.tags_text)
    end
  end

end
