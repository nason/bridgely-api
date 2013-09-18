require 'spec_helper'

describe "V1::Twilio" do
  describe "GET /v1_twilio" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get v1_twilio_path
      response.status.should be(200)
    end
  end
end
