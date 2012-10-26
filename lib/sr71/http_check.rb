module Sr71
  class HttpCheck
    def self.check(url)
      request = EventMachine::HttpRequest.new(url)

      start_time = Time.now
      http = request.get

      http.callback do
        end_time = Time.now
        Sr71::Logger.log({
          :type => "http_check",
          :start_time => start_time,
          :elapsed_time => end_time - start_time,
          :end_time => end_time,
          :url => url,
          :status_code => http.response_header.status
        })
      end

      http.errback do
        end_time = Time.now
        Sr71::Logger.log({
          :type => "http_check",
          :start_time => start_time,
          :elapsed_time => end_time - start_time,
          :end_time => end_time,
          :url => url,
          :error => http.error
        })
      end
    end
  end
end
