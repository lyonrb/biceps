require 'spec_helper'

describe Biceps::Parser do
  let(:request) { ACTR.new({'HTTP_ACCEPT' => 'application/json, application/vnd.biceps;ver=1'}) }

  describe "initialize" do
    it "should set the request" do
      assert_equal Biceps::Parser.new({:test => true}).request,
        {:test => true}
    end

    it "should set the valid versions list" do
      assert_equal Biceps::Parser.new({}, [1, 2]).valid_versions,
        [1, 2]
    end
  end

  describe "valid?" do
    it "should consider the version as valid" do
      assert Biceps::Parser.new(request, 1).valid?
    end

    it "should not consider the version as valid" do
      refute Biceps::Parser.new(request, 2).valid?
    end
  end

  describe "version" do
    it "should return the appropriate version" do
      assert_equal Biceps::Parser.new(request).version, 1
    end
  end
end
