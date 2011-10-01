module Biceps
  class Jsonp
    attr_reader :app, :callback_param

    def initialize(app, options = {})
      @app = app
      @callback_param = options[:callback_param] || 'callback'
    end

    # Proxies the request to the application, stripping out the JSON-P callback
    # method and padding the response with the appropriate callback format.
    #
    # Changes nothing if no <tt>callback</tt> param is specified.
    #
    def call(env)
      Parser.new(self, env).perform
    end

    class Parser
      attr_reader :jsonp, :env, :request
      attr_accessor :status, :headers, :response

      delegate :callback_param, :to => :jsonp
      delegate :app, :to => :jsonp

      def initialize(jsonp, env)
        @jsonp, @env = jsonp, env
        @request = Rack::Request.new(@env)
        @status, @headers, @response = app.call(env)
      end

      def perform
        if callback && headers['Content-Type'] =~ /json/i
          @response = pad
          headers['Content-Length'] = response.first.length.to_s
          headers['Content-Type'] = 'application/javascript'
        end
        [status, headers, response]
      end

      private
      def callback
        @callback ||= request.params.delete(callback_param)
      end

      # Pads the response with the appropriate callback format according to the
      # JSON-P spec/requirements.
      #
      # The Rack response spec indicates that it should be enumerable. The method
      # of combining all of the data into a single string makes sense since JSON
      # is returned as a full string.
      #
      def pad(body = "")
        response.each {|s| body << s }
        ["#{callback}({'metadata': #{metadata}, 'data': #{body}})"]
      end

      def metadata
        # TODO : add all the non-core HTTP headers
        {
          "status" => status
        }.to_json
      end

    end
  end
end
