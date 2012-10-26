module Sr71
  class HttpCheck
    def self.check(url, &block)
      http = EventMachine::HttpRequest.new(url).get
      http.callback { }
      http.errback { }
    end
  end
end
