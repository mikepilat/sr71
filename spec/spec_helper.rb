require 'sr71'
require 'rspec'

Dir.glob("#{File.expand_path('support', File.dirname(__FILE__))}/**/*.rb").each { |f| require f }

TEST_CONFIG = File.expand_path('support/test_config.yml', File.dirname(__FILE__))

def http_response(string)
  return <<-RESPONSE
HTTP/1.1 #{string}
Connection: close

OK
RESPONSE
end

def run_in_reactor(timeout = 1)
  Timeout::timeout(timeout) do
    EM.epoll
    EM.run do
      yield
    end
  end
rescue Timeout::Error
  fail 'Eventmachine was not stopped before the timeout expired'
end

def capturing_stdout(&block)
  old_stdout = $stdout
  $stdout = StringIO.new
  yield
  result = $stdout.string
  $stdout = old_stdout
  result
end
