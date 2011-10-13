require 'spec_helper'

module Serializers
  module Hash

    class V1 < Biceps::Serializer

      def as_json(opts={})
        {:new_test => parent[:test]}
      end
    end
  end
end

describe Biceps::ModelVersioning do
  let(:resource) { {:test => true} }

  describe "without any api version" do
    it "should render using the normal behavior" do
      assert_equal responder(resource).send(:api_behavior, nil),
        [{:test => true}.to_json]
    end
  end

  describe "with an api version" do
    it "should render using the model's version behavior" do
      responder = responder(resource)
      responder.request.env['HTTP_ACCEPT'] = 'application/vnd.biceps;ver=1'

      assert_equal responder.send(:api_behavior, nil),
        [{:new_test => true}.to_json]
    end

    it "should not fail if there is no serializer for that version" do
      responder = responder(resource)
      responder.request.env['HTTP_ACCEPT'] = 'application/vnd.biceps;ver=2'

      assert_equal responder.send(:api_behavior, nil),
        [{:test => true}.to_json]
    end
  end

  def responder(resources, accept=nil)
    Biceps::TestResponder.new(
      Biceps::TestResponderController.new,
      [resources],
      {
        :default_response => lambda {
          raise ActionView::MissingTemplate.new([], "", [], "")
        }
      }
    )
  end
end
