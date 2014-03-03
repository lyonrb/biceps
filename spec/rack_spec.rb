require 'spec_helper'

describe Biceps::Rack do
  let(:app) { lambda {|env| [200, [env['biceps.versions'].to_json]] } }
  subject   { Biceps::Rack.new(app) }

  describe "without appropriate accept header" do
    let(:env) { {'HTTP_ACCEPT' => 'text/javascript'} }

    it "should not specify any version" do
      response = subject.call(env).last
      assert ['[]'] == response, "expected empty versions. Got #{response}"
    end
  end

  describe "with an appropriate accept header" do
    let(:env) { {'HTTP_ACCEPT' => 'application/json, application/vnd.biceps;ver=1'} }

    it "should provide the version" do
      response = subject.call(env).last
      assert ['["1"]'] == response, "expected one version. Got #{response}"
    end
  end

  describe "with several api versions" do
    let(:env) { {'HTTP_ACCEPT' => 'application/json, application/vnd.biceps;ver=1, application/vnd.biceps;ver=beta'} }

    it "should provide the versions" do
      response = subject.call(env).last
      assert ['["1","beta"]'] == response, "expected two versions. Got #{response}"
    end
  end

  describe "with an inappropriate application name" do
    let(:env) { {'HTTP_ACCEPT' => 'application/json, application/vnd.chucknorris;ver=1'} }

    it "should not specify any version" do
      response = subject.call(env).last
      assert ['[]'] == response, "expected empty versions. Got #{response}"
    end
  end

  describe "with an other application name" do
    let(:env) { {'HTTP_ACCEPT' => 'application/json, application/vnd.example;ver=1'} }

    after do
      Biceps.app_name = nil
    end

    it "should work" do
      Biceps.app_name = 'example'
      response = subject.call(env).last
      assert ['["1"]'] == response, "expected one version. Got #{response}"
    end
  end
end
