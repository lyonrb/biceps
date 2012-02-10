module Biceps
  class ApiVersion
    attr_accessor :version, :accept

    def initialize(version)
      @version = [version].flatten
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
      is_api_call?[1].to_i if is_api_call?
    end

    def is_api_call?
      @is_api_call = accept.match(regex)
    end

    def regex
      Regexp.new("application/vnd.#{app_name};ver=([0-9]+)")
    end

    def app_name
      Rails.application.class.to_s.split('::').first.underscore
    end
  end
end
