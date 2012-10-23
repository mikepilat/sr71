module Sr71
  class Ticker
    def self.start!
      @timer = EM::PeriodicTimer.new(0.1, method(:tick))
    end

    def self.tick
      Sr71.checks.each do |check|
        check.start_check if check.needs_check?
      end
    end
  end
end
