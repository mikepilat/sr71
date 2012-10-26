require 'json'

module Sr71
  class Logger
    def self.log(hash)
      puts JSON.generate(hash, :space => ' ', :object_nl => ' ')
    end
  end
end
