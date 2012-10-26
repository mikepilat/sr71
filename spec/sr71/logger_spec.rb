require 'spec_helper'

describe Sr71::Logger do
  describe "log" do
    it "logs a request as JSON" do
      output = capturing_stdout do
        Sr71::Logger.log({
          :response => "200 OK",
          :foo => "bar",
          :baz => "blah"
        })
      end

      output.should == "{ \"response\": \"200 OK\", \"foo\": \"bar\", \"baz\": \"blah\" }\n"
    end
  end
end
