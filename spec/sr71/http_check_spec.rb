require 'spec_helper'

describe Sr71::HttpCheck do
  describe "check" do
    it "makes a get request to the URL" do
      run_in_reactor(5) do
        server = StubServer.new(http_response("200 OK"), 0.25) { EM.stop }
        Sr71::HttpCheck.check("http://127.0.0.1:8081")
      end
    end
  end
end
