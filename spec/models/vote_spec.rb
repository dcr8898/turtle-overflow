require 'rails_helper'

describe Vote do

  context "validations" do
    it { should validate_presence_of :user }
  end

  context "associations" do
    it { should belong_to :user }  
    it { should belong_to :voteable }  
  end




end