module Biceps
  class ApiVersion
    attr_accessor :version

    def initialize(version)
      @version = version
    end

    def matches?(request)
      Biceps::Parser.new(request, version).valid?
    end
  end
end
