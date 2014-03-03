require 'spec_helper'

describe Biceps do

  after do
    Biceps.app_name = nil
  end

  describe "app_name" do
    it "should be biceps by default" do
      assert Biceps.app_name == 'biceps'
    end

    it "should be overridable" do
      Biceps.app_name = 'my_app'
      assert Biceps.app_name == 'my_app'
    end
  end
end
