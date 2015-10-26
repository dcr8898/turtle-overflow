require 'rails_helper'

describe Vote do

  context "validations" do
    it { should validate_presence_of :user }
    it { should allow_values(1, -1).for(:value) }
  end

  context "associations" do
    it { should belong_to :user }  
    it { should belong_to :voteable }  
    it "has many posts" do
      expect {
        vote = FactoryGirl.build :vote
        vote.save
      }.to change { Vote.count }.by(1)
    end
  end

  context "total_votes" do
    it 'should return the total votes on its voteable' do
      vote = FactoryGirl.build :vote
      expect(vote.total_votes).to eq(vote.voteable.votes.sum(:value))
    end
  end

  context "update_vote_count" do
    it 'should not change number in Vote table' do
      vote = FactoryGirl.build :vote
      vote.save
      expect {vote.update_vote_count }.to change { Vote.count }.by(0)
    end
  end

  context "has_voted?" do
    it 'should return false if user has already voted on voteable' do
      vote = FactoryGirl.build :vote
      expect(vote.has_voted?).to be false
      vote.save
      expect(vote.has_voted?).to be true
    end
  end
end
