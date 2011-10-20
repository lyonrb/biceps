module Biceps
  class Serializer
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml

    attr_accessor :parent
    delegate :respond_to?, :to => :parent

    def initialize(parent)
      @parent = parent
    end

    def method_missing(method, *args, &block)
      if parent.respond_to?(method)
        parent.send(method, *args, &block)
      else
        super
      end
    end
  end
end
