require 'spec_helper'

describe Sr71::Configuration do
  describe "from_file" do
    it "reads configuration from a file" do
      config = Sr71::Configuration.from_file(TEST_CONFIG)

      config["google"].should_not be_nil
      config["google"]["url"].should == "http://www.google.com"
      config["google"]["interval"].should == 30

      config["example"].should_not be_nil
      config["example"]["url"].should == "http://www.example.com"
      config["example"]["interval"].should == 60
    end
  end
end
