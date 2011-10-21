require 'spec_helper'

module Builders
  module Hash

    class V1 < Biceps::Builder::Base

      after_initialize :parse_params


      private
      def parse_params
        resource[:test] = true
      end
    end
  end
end

describe Biceps::Builder do

  describe "new" do
    it "should return the model if there is no api version" do
      assert_equal({}, Biceps::Builder.new(Hash, {}, nil))
    end

    it "should return the model if the version does not exists" do
      assert_equal({}, Biceps::Builder.new(Hash, {}, 42))
    end

    it "should return the builder" do
      assert_equal({:test => true}, Biceps::Builder.new(Hash, {}, 1))
    end
  end
end
