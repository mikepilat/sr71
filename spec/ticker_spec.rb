require 'spec_helper'

describe Sr71::Ticker do
  describe "start!" do
    it "schedules to run every tenth of a second" do
      EventMachine::PeriodicTimer.should_receive(:new).with(0.1, kind_of(Method))
      Sr71::Ticker.start!
    end
  end

  describe "tick" do
    it "calls start_check for each check" do
      check = Sr71::Check.new("url" => "http://www.example.com", "interval" => 30)
      Sr71.checks << check

      check.should_receive(:start_check)
      Sr71::Ticker.tick
    end

    it "does not call start_check if a check is not needed" do
      check = Sr71::Check.new("url" => "http://www.example.com", "interval" => 30)
      check.stub(:needs_check?).and_return(false)
      Sr71.checks << check

      check.should_receive(:start_check).never
      Sr71::Ticker.tick
    end
  end
end
