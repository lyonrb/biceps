module Biceps
  class Parser
    attr_accessor :request, :valid_versions

    def initialize(request, valid_versions=nil)
      @request = request
      @valid_versions = [valid_versions].flatten
    end

    def valid?
      valid_versions.include?(version)
    end

    def version
      if Biceps.force_test_version?
        Biceps.force_test_version
      else
        is_api_call?[1].to_i if is_api_call?
      end
    end

    private
    def is_api_call?
      request.accept.match(regex) if request.accept
    end

    def regex
      Regexp.new("application/vnd.#{app_name};ver=([0-9]+)")
    end

    def app_name
      Rails.application.class.to_s.split('::').first.underscore
    end
  end
end
