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
      assert_kind_of Hash, Biceps::Builder.new(Hash, {}, nil)
    end

    it "should return the model if the version does not exists" do
      assert_kind_of Hash, Biceps::Builder.new(Hash, {}, 42)
    end

    it "should return the builder" do
      assert_kind_of Builders::Hash::V1, Biceps::Builder.new(Hash, {}, 1)
    end
  end

  describe "callbacks" do
    it "should execute the after initialize callback" do
      instance = Biceps::Builder.new(Hash, {}, 1)
      assert_equal({:test => true}, instance.resource)
    end
  end
end
