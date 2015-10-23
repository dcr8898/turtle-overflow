require 'rails_helper'

describe Comment do

  context "validations" do
    it { should validate_presence_of :body }
    it { should validate_presence_of :user }
  end

  context "associations" do
    it { should belong_to :user}
    it { should belong_to :commentable}
    it { should have_many :votes} 
  end

end