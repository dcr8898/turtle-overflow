require 'rails_helper'

describe TagsController do
  # seed test database with three tags
  before(:all) do
    3.times do
      tag = FactoryGirl.create(:tag)

      3.times do
        tag.questions << FactoryGirl.create(:question)
      end
    end
  end

  describe "#index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns @tags" do
      get :index
      expect(assigns(:tags)).to eq(Tag.all.order(:text))
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "#show" do
    it "has a 200 status code" do
      get :show, {id: 2}
      expect(response.status).to eq(200)
    end

    it "assigns @tag" do
      get :show, {id: 2}
      expect(assigns(:tag)).to eq(Tag.find(2))
    end

    it "assigns @questions" do
      get :show, {id: 2}
      expect(assigns(:questions)).to eq(Tag.find(2).questions)
    end

    it "renders the show template" do
      get :show, {id: 2}
      expect(response).to render_template("show")
    end
  end
end
