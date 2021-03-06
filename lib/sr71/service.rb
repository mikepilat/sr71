module Sr71
  class Service
    def initialize(attrs = {})
      @url        = attrs["url"]
      @interval   = attrs["interval"]
      @last_check = 0
    end

    def needs_check?
      (@last_check + @interval) <= Time.now.to_f
    end

    def start_check
      @last_check = Time.now.to_f
      HttpCheck.check(@url)
    end
  end
end
