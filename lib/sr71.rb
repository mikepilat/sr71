require "eventmachine"
require "em-http-request"

require "sr71/configuration"
require "sr71/http_check"
require "sr71/logger"
require "sr71/service"
require "sr71/ticker"
require "sr71/version"

module Sr71
  class << self
    attr_accessor :services
  end

  self.services = []

  def self.configure(options)
    @config_file = options[:sr71_config]
    @config = Configuration.from_file(@config_file)
    @services = @config.map do | (name, attributes) |
      Sr71::Service.new(attributes)
    end
  end

  def self.start!
    EM.run do
      Ticker.start!
    end
  end
end
