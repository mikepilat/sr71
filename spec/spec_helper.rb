require 'sr71'

TEST_CONFIG = File.expand_path('support/test_config.yml', File.dirname(__FILE__))

def run_in_reactor
  around(:each) do |spec|
    EM.run do
      spec.run
      EM.stop
    end
  end
end
