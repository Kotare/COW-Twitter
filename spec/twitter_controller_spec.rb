require 'spec_helper'
require 'uri'

describe "TwitterController" do

  describe "GET '/'" do

    before do
      get '/'
    end

    it "returns an HTTP status code of 200" do
      expect(last_response.status).to eq(200)
    end

    it  "renders the sign-in / sign-up view" do
      expect(last_response.body).to include("password")
    end

  end

  # describe "POST '/sign_in'" do
  # end

end