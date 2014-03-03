module Biceps
  class ApiVersion
    attr_accessor :versions

    def initialize(versions)
      @versions = [versions].flatten.delete_if(&:nil?)
    end

    def matches?(request)
      request_versions = request.env['biceps.versions']
      return true if versions.empty? && request_versions.empty?

      versions.any? do |version|
        request_versions.include?(version.to_s)
      end
    end
  end
end
