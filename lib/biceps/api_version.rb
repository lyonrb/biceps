module Biceps
  class ApiVersion
    attr_accessor :versions

    def initialize(versions)
      @versions = [versions].flatten.delete_if(&:nil?)
    end

    def matches?(request)
      vrequest = request_versions(request)
      return true if versions.empty? && vrequest.empty?

      versions.any? do |version|
        vrequest.include?(version.to_s)
      end
    end

    private
    def request_versions(request)
      request.env['biceps.versions'] || []
    end
  end
end
