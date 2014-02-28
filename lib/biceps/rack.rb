module Biceps

  class Rack

    def initialize(app)
      @app = app
    end

    def call(env)
      env['biceps.versions'] = Array(api_versions(env['HTTP_ACCEPT']))
      @app.call(env)
    end

    private
    def api_versions(accept)
      versions_matcher(accept).flatten
    end

    def versions_matcher(accept)
      accept.scan(regex)
    end

    def regex
      Regexp.new("application/vnd.#{app_name};ver=([[:alnum:]]+)")
    end

    def app_name
      "biceps"
    end
  end
end
