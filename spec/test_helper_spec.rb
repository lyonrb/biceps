require 'spec_helper'

describe "Test Helpers" do
  include Biceps::TestHelper

  describe "with api version" do
    mock_api_version(1)

    it "should have version 1 defined" do
      assert Biceps.force_test_version?
      assert 1, Biceps.force_test_version
    end
  end

  describe "without api version" do
    it "should not have any version defined" do
      refute Biceps.force_test_version?
    end
  end
end
