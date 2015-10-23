require 'rails_helper'

describe Tag do

  context "validations" do
    it { should validate_presence_of :text }
  end

  context "associations" do
    it { should have_and_belong_to_many :questions}  
  end
end