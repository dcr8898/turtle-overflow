require 'rails_helper'

describe UsersController do
  describe "#show" do
    it "has a 200 status code" do
      get :show, {id: 1}
      expect(response.status).to eq(200)
    end

    it "renders the show view" do
      get :show, {id: 1}
      expect(response).to render_template("show")
    end
  end
end
