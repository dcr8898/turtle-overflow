require 'rails_helper'

describe Answer do

  context "validations" do
    it { should validate_presence_of :body }
    it { should validate_presence_of :user }
    it { should validate_presence_of :question }
  end

end