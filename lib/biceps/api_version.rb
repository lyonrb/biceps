module Biceps
  class ApiVersion
    attr_accessor :version, :accept

    def initialize(version)
      @version = [version].flatten
      @version_matcher = {}
    end

    def matches?(request)
      @accept = request.accept
      valid_api_version?
    end


    private
    def valid_api_version?
      version.include?(request_version)
    end

    def request_version
      if Biceps.force_test_version?
        Biceps.force_test_version
      else
        api_version if is_api_call?
      end
    end

    def api_version
      version_matcher[1].to_i
    end

    def is_api_call?
      accept && version_matcher.present?
    end

    def version_matcher
      @version_matcher[accept] ||= accept.match(regex) if accept
    end

    def regex
      Regexp.new("application/vnd.#{app_name};ver=([0-9]+)")
    end

    def app_name
      Rails.application.class.to_s.split('::').first.underscore
    end
  end
end
