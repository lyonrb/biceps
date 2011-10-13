module Biceps
  module ModelVersioning

    def self.included(klass)
      klass.class_eval do

        protected
        alias :old_api_behavior :api_behavior
        def api_behavior(error)
          if api_version
            begin
              constant = "Serializers::#{resource.class}::V#{api_version}".constantize
              @resource = constant.new(resource)
            rescue NameError
              #
              # The serializer for that version is not defined
              # Use the model's internal serialize
              #
            end
          end

          old_api_behavior(error)
        end

        private
        # TODO : refactor the routing constraint so we don't repeat the
        #regex in two different places
        def api_version
          app_name = Rails.application.class.to_s.split('::').first.underscore
          regex = Regexp.new("application/vnd.#{app_name};ver=([0-9]+)")

          match = request.accept.match(regex) if request.accept
          match[1].to_i if match
        end
      end
    end
  end
end
