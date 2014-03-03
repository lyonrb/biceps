module Biceps

  class Rack

    def initialize(app)
      @app = app
    end

    def call(env)
      if Biceps.force_test_version?
        versions = Biceps.force_test_version.map(&:to_s)
      else
        versions = Array(api_versions(env['HTTP_ACCEPT']))
      end

      env['biceps.versions'] = versions
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
      ::Biceps.app_name
    end
  end
end
