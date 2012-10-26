module Sr71
  class Ticker
    def self.start!
      @timer = EM::PeriodicTimer.new(0.1, method(:tick))
    end

    def self.tick
      Sr71.services.each do |service|
        service.start_check if service.needs_check?
      end
    end
  end
end
