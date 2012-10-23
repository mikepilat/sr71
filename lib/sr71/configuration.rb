require 'yaml'

module Sr71
  class Configuration
    def self.from_file(file)
      YAML.load_file(file)
    end
  end
end
