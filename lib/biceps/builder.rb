module Biceps
  module Builder

    # instiantiate_for_api(User, params[:user]) == Constructor.new(User,params[:user], 1)
    def self.new(resource, params, version)
      begin
        constant = "Builders::#{resource}::V#{version}".constantize
        instance = constant.new resource.new, params
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
      delegate    :respond_to?, :to => :resource

      extend ActiveModel::Callbacks
      define_model_callbacks :initialize, :only => :after

      def initialize(resource, params)
        run_callbacks :initialize do
          @resource, @params = resource, params
        end
      end

      def method_missing(method, *args, &block)
        if resource.respond_to?(method)
          resource.send(method, *args, &block)
        else
          super
        end
      end
    end
  end
end
