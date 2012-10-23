require "eventmachine"
require "em-http-request"

require "sr71/version"
require "sr71/configuration"

module Sr71
  def self.configure(options)
    @config_file = options[:sr71_config]
    @config = Configuration.from_file(@config_file)
    puts @config
  end
end
