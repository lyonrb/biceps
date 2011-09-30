require 'spec_helper'
require 'action_controller/test_case'

describe Biceps::ApiVersion do
  let(:object) { Biceps::ApiVersion }

  describe "without any appropriate Accept header" do
    let(:request) { ActionController::TestRequest.new({'HTTP_ACCEPT' => 'text/javascript'})}
    it "should never match" do
      object.new(1).matches?(request).should be_false
    end
  end

  describe "with an appropriate Accept header" do
    let(:request) { ActionController::TestRequest.new({'HTTP_ACCEPT' => 'application/json, application/vnd.biceps;ver=1'})}


    it "should match v1" do
      object.new(1).matches?(request).should be_true
    end

    it "should not match v2" do
      object.new(2).matches?(request).should be_false
    end
  end

  describe "with an inappropriate application name" do
    # Even Chuck Norris can't access the api if the application name is inappropriate
    let(:request) { ActionController::TestRequest.new('HTTP_ACCEPT' => 'application/json, application/vnd.chucknorris;ver=1')}

    it "should never match" do
      object.new(1).matches?(request).should be_false
    end
  end
end

