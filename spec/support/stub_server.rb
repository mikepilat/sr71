class StubServer
  attr_reader :request_count

  module Server
    attr_accessor :response, :delay, :callback

    def receive_data(data)
      EM.add_timer(@delay) do
        send_data @response
        close_connection_after_writing
        EM.stop
        callback.call
      end
    end
  end

  def initialize (response, delay = 0, port = 8081, host = "127.0.0.1", &block)
    @request_count = 0
    @sig = EventMachine::start_server(host, port, Server) do |s|
      @request_count += 1
      s.response = response
      s.delay = delay
      s.callback = block
    end
  end

  def stop
    EventMachine.stop_server @sig
    EM.stop
  end
end
