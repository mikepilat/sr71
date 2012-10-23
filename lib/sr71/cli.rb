require 'optparse'

module Sr71
  class CLI
    class Options
      def parse!(args)
        args, options = args.dup, {}

        options[:sr71_config] = '/etc/sr71.yml'

        opt_parser = OptionParser.new do |opts|
          opts.banner = "Usage: sr71 [options]"
          opts.on("-c", "--config=file", String, "SR71 configuration file") { |v| options[:sr71_config] = v }

          opts.separator ""

          opts.on("-d", "--daemon", "Make server run as a Daemon.") { options[:daemonize] = true }
          opts.on("-P","--pid=pid",String, "Specifies the PID file.",) { |v| options[:pid] = v }

          opts.separator ""

          opts.on("-h", "--help", "Show this help message.") { puts opts; exit }
        end

        opt_parser.parse! args

        options
      end
    end

    def start
      options = Options.new.parse!(ARGV)

      unless File.exists?(options[:sr71_config])
        puts "Could not find #{options[:sr71_config]}. Specify correct location with -c file"
        exit 1
      end

      Sr71.logger.level = Sr71::Logger::Level::DEBUG if options[:verbose]
      Sr71.config_dir = options[:config_dir]
    end
  end
end
