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
        def api_version
          Biceps::Parser.new(request).version
        end
      end
    end
  end
end
