module Biceps
  class << self
    @@force_test_version = false

    def force_test_version=(version)
      @@force_test_version = version
    end

    def force_test_version
      @@force_test_version
    end

    def clean_test_version
      @@force_test_version = false
    end

    def force_test_version?
      !!@@force_test_version
    end
  end

  module TestHelper
    def self.included(base)
      base.class_eval do
        def self.mock_api_version(version)
          before do
            ::Biceps.force_test_version = version
          end

          after do
            ::Biceps.clean_test_version
          end
        end
      end
    end
  end

end
