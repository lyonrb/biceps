require 'spec_helper'

describe Biceps::Parser do
  let(:object) { Biceps::Parser }
  let(:request) { ACTR.new({'HTTP_ACCEPT' => 'application/json, application/vnd.biceps;ver=1'}) }

  describe "initialize" do
    it "should set the request" do
      assert_equal object.new({:test => true}).request,
        {:test => true}
    end

    it "should set the valid versions list" do
      assert_equal object.new({}, [1, 2]).valid_versions,
        [1, 2]
    end
  end

  describe "valid?" do
    it "should consider the version as valid" do
      assert object.new(request, 1).valid?
    end

    it "should not consider the version as valid" do
      refute object.new(request, 2).valid?
    end
  end

  describe "version" do
    it "should return the appropriate version" do
      assert_equal object.new(request).version, 1
    end
  end

  describe "with the test helper" do
    include Biceps::TestHelper

    describe "with an api version specified" do
      mock_api_version(42)

      it "should use the overriden api version" do
        assert object.new(request, 42).valid?
      end

      it "should not match the original version" do
        refute object.new(request, 1).valid?
      end
    end

    describe "without any api version specified" do
      it "should not use any overriden api version" do
        refute object.new(request, 42).valid?
      end

      it "should match the original version" do
        assert object.new(request, 1).valid?
      end
    end
  end
end
