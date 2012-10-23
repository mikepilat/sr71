require 'spec_helper'

describe Sr71::Check do
  describe "needs_check?" do
    it "is true when the check interval has elapsed" do
      check = Sr71::Check.new("url" => "http://www.example.com", "interval" => 30)
      check.needs_check?.should be_true

      Time.stub(:now).and_return(15)
      check.needs_check?.should be_false
    end
  end
end
