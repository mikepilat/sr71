module Sr71
  class HttpCheck
    class ConnectionTimer
      attr_reader :connect_time
      def initialize(&block)
        @callback = block
      end

      def request(client, head, body)
        @callback.call
        [head, body]
      end

      def response(resp)
      end
    end

    def self.check(url)
      request = EventMachine::HttpRequest.new(url, {
        :connect_timeout    => 5,
        :inactivity_timeout => 30
      })

      connect_time = nil
      request.use ConnectionTimer do
        connect_time = Time.now
      end

      start_time = Time.now
      http = request.get

      http.callback do
        end_time = Time.now
        Sr71::Logger.log({
          :type => "http_check",
          :start_time => start_time,
          :connect_time => connect_time - start_time,
          :elapsed_time => end_time - start_time,
          :end_time => end_time.to_f,
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
          :end_time => end_time.to_f,
          :url => url,
          :error => http.error
        })
      end
    end
  end
end
