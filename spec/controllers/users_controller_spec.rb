require 'rails_helper'

describe UsersController do
  let(:user) {FactoryGirl.create(:user)}

  describe "#show" do
    it "has a 200 status code" do
      get :show, {id: user.id}
      expect(response.status).to eq(200)
    end

    it "renders the show view" do
      get :show, {id: user.id}
      expect(response).to render_template("show")
    end
  end
end
