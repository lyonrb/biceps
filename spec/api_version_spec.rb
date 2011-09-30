require 'spec_helper'
require 'action_controller/test_case'

ACTR = ActionController::TestRequest

describe Biceps::ApiVersion do
  before do
    @object = Biceps::ApiVersion
  end

  describe "without any appropriate Accept header" do
    before do
      @request =  ACTR.new({'HTTP_ACCEPT' => 'text/javascript'})
    end

    it "should never match" do
      refute @object.new(1).matches?(@request)
    end
  end

  describe "with an appropriate Accept header" do
    before do
      @request = ACTR.new({'HTTP_ACCEPT' => 'application/json, application/vnd.biceps;ver=1'})
    end

    it "should match v1" do
      assert @object.new(1).matches?(@request)
    end

    it "should not match v2" do
      refute @object.new(2).matches?(@request)
    end
  end

  describe "with an inappropriate application name" do
    # Even Chuck Norris can't access the api if the application name is inappropriate
    before do
      @request = ACTR.new('HTTP_ACCEPT' => 'application/json, application/vnd.chucknorris;ver=1')
    end

    it "should never match" do
      refute @object.new(1).matches?(@request)
    end
  end
end
