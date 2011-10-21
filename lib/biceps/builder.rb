module Biceps
  module Builder

    # instiantiate_for_api(User, params[:user]) == Constructor.new(User,params[:user], 1)
    def self.new(resource, params, version)
      begin
        constant = "Builders::#{resource}::V#{version}".constantize
        instance = constant.new(resource.new, params).resource
      rescue NameError
        #
        # The builder for that version is not defined
        # Use the model's internal initialize
        instance = resource.new params
      end

      instance
    end

    class Base
      attr_reader :resource, :params

      extend ActiveModel::Callbacks
      define_model_callbacks :initialize, :only => :after

      def initialize(resource, params)
        run_callbacks :initialize do
          @resource, @params = resource, params
        end
      end
    end
  end
end
