require 'spec_helper'
require 'action_controller/test_case'

ACTR = ActionController::TestRequest

describe Biceps::ApiVersion do
  let(:object) { Biceps::ApiVersion }

  describe "with one version" do
    let(:request) { ACTR.new({'biceps.versions' => ['1']}) }

    it "should match" do
      assert object.new([1]).matches?(request)
      assert object.new(['beta', 1]).matches?(request)
    end

    it "should not match" do
      refute object.new([]).matches?(request)
      refute object.new([2]).matches?(request)
    end
  end

  describe "with multiple versions" do
    let(:request) { ACTR.new({'biceps.versions' => ['1', '2']}) }

    it "should match" do
      assert object.new([1]).matches?(request)
      assert object.new(['beta', 1]).matches?(request)
    end

    it "should not match" do
      refute object.new([]).matches?(request)
      refute object.new([3]).matches?(request)
    end
  end

  describe "with no versions" do
    let(:request) { ACTR.new({'biceps.versions' => []}) }

    it "should match" do
      assert object.new([]).matches?(request)
    end

    it "should not match" do
      refute object.new([2]).matches?(request)
    end
  end

  describe "without biceps.versions" do
    let(:request) { ACTR.new({}) }

    it "should match" do
      assert object.new([]).matches?(request)
    end

    it "should not match" do
      refute object.new([2]).matches?(request)
    end
  end
end
