require 'spec_helper'

describe AutomobilesController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index, format: :json
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "retrieves"
  end

  describe "GET 'update'" do
    it "creates or updates"
  end

  describe "GET 'destroy'" do
    it "deletes"
  end

end
