require 'rails_helper'

describe Answer do

  context "validations" do
    it { should validate_presence_of :body }
    it { should validate_presence_of :user }
    it { should validate_presence_of :question }
  end

  context "associations" do
    it { should belong_to :user }
    it { should belong_to :question }
    it { should have_many :comments }
    it { should have_many :votes } 
  end

end