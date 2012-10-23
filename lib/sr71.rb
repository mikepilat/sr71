require "eventmachine"
require "em-http-request"

require "sr71/check"
require "sr71/configuration"
require "sr71/ticker"
require "sr71/version"

module Sr71
  class << self
    attr_accessor :checks
  end

  self.checks = []

  def self.configure(options)
    @config_file = options[:sr71_config]
    @config = Configuration.from_file(@config_file)
    @checks = @config.map do | (name, attributes) |
      Sr71::Check.new(attributes)
    end
  end

  def self.start!
    EM.run do
      Ticker.start!
    end
  end
end
