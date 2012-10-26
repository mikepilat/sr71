require 'sr71'
require 'rspec'

Dir.glob("#{File.expand_path('support', File.dirname(__FILE__))}/**/*.rb").each { |f| require f }

TEST_CONFIG = File.expand_path('support/test_config.yml', File.dirname(__FILE__))

def http_response(string)
  return <<-HTTP
HTTP/1.1 #{string}
Connection: close

HTTP
end
