require 'spec_helper'

describe Question do
  let(:question) do
    question = Question.new
    question.title
    question.body
    question.user
  end

  context "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_presence_of :user }
    it { should allow_value('shadi@devbootcamp.com').for(:title) }
    it { should_not allow_value('badlyFormattedEmail').for(:title) }
  end

  context "#name" do
    let(:user) { FactoryGirl.build :user, :email => "shadi@dev.com" }
    it "sets the name as the first part of the email" do
      user.save
      expect(user.reload.name).to eq "shadi"
    end
  end
end