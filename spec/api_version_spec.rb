require 'spec_helper'
require 'action_controller/test_case'

ACTR = ActionController::TestRequest

describe Biceps::ApiVersion do
  let(:object) { Biceps::ApiVersion }

  describe "without any appropriate Accept header" do
    let(:request) { ACTR.new({'HTTP_ACCEPT' => 'text/javascript'}) }

    it "should never match" do
      refute object.new(1).matches?(request)
    end

    it "should not match with an array" do
      refute object.new([2, 3]).matches?(request)
    end
  end

  describe "with an appropriate Accept header" do
    let(:request) { ACTR.new({'HTTP_ACCEPT' => 'application/json, application/vnd.biceps;ver=1'}) }

    it "should match v1" do
      assert object.new(1).matches?(request)
    end

    it "should not match v2" do
      refute object.new(2).matches?(request)
    end

    it "should match an array of 1, 2" do
      assert object.new([1, 2]).matches?(request)
    end

    it "should not match an array of 2, 3" do
      refute object.new([2, 3]).matches?(request)
    end
  end

  describe "with an inappropriate application name" do
    # Even Chuck Norris can't access the api if the application name is inappropriate
    let(:request) { ACTR.new('HTTP_ACCEPT' => 'application/json, application/vnd.chucknorris;ver=1') }

    it "should never match" do
      refute object.new(1).matches?(request)
    end
  end
end
