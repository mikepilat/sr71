require 'spec_helper'

describe Sr71::Service do
  describe "needs_check?" do
    it "is true when the check interval has elapsed" do
      check = Sr71::Service.new("url" => "http://www.example.com", "interval" => 30)
      check.needs_check?.should be_true

      Time.stub(:now).and_return(15)
      check.needs_check?.should be_false
    end
  end

  describe "start_check" do
    it "makes an HTTP request to the url" do
      service = Sr71::Service.new("url" => "http://127.0.0.1:8081", "interval" => 30)
      Sr71::HttpCheck.should_receive(:check).with("http://127.0.0.1:8081")
      service.start_check
    end
  end
end
