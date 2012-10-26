require 'spec_helper'

describe Sr71::Ticker do
  describe "start!" do
    it "schedules to run every tenth of a second" do
      EventMachine::PeriodicTimer.should_receive(:new).with(0.1, kind_of(Method))
      Sr71::Ticker.start!
    end
  end

  describe "tick" do
    it "calls start_service for each service" do
      service = Sr71::Service.new("url" => "http://www.example.com", "interval" => 30)
      Sr71.services = [service]

      service.should_receive(:start_check)
      Sr71::Ticker.tick
    end

    it "does not call start_service if a service is not needed" do
      service = Sr71::Service.new("url" => "http://www.example.com", "interval" => 30)
      service.stub(:needs_check?).and_return(false)
      Sr71.services = [service]

      service.should_receive(:start_check).never
      Sr71::Ticker.tick
    end
  end
end
