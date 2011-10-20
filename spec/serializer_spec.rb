require 'spec_helper'

describe Biceps::Serializer do

  describe "initialize" do
    it "should set the parent" do
      assert_equal Biceps::Serializer.new({:test => true}).parent,
        {:test => true}
    end
  end

  describe "respond_to" do
    it "should respond true if the parent method exists" do
      assert Biceps::Serializer.new({}).respond_to?(:each)
    end

    it "should respond false if the parent method does not exists" do
      refute Biceps::Serializer.new({}).respond_to?(:foo)
    end
  end

  describe "method_missing" do
    it "should raise NoMethodError if the parent method does not exists" do
      assert_raises NoMethodError do
        Biceps::Serializer.new({}).foo
      end
    end

    it "should succeed if the parent method exists" do
      Biceps::Serializer.new({:test => true}).each do |e|
        assert e
      end
    end
  end
end
