require 'rails_helper'

describe TagsController do
  describe "#index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns @tags" do
      get :index
      expect(assigns(:tags)).to eq(Tag.all)
    end

    it "renders the idnex template" do
      get :index
      expect(response).to render_template("index")
    end

  end

  describe "#show" do
  end
end
