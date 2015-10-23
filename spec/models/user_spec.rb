require 'rails_helper'

describe User do

  context "validations" do
    it { should validate_presence_of :username }
    it { should validate_presence_of :password }
    it { should have_secure_password }
  end

  context "associations" do
    it { should have_many :questions}
    it { should have_many :answers}
    it { should have_many :comments} 
    it { should have_many :votes}      
  end
end