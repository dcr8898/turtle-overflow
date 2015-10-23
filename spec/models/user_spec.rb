require 'rails_helper'

describe User do

  context "validations" do
    it { should validate_presence_of :user }
    it { should validate_presence_of :password }
  end

  context "associations" do
    it { should have_many :questions}
    it { should have_many :answers}
    it { should have_many :comments} 
    it { should have_many :votes}      
  end
end