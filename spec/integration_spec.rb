require 'spec_helper'
require 'action_controller/railtie'

class Biceps::IntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @app = Biceps::Application

    @app.routes.draw do
      api_version 1 do
        get '/test' => lambda { |env| [200,{},['test v1']] }
      end

      api_version 2 do
        get '/test' => lambda { |env| [200,{},['test v2']] }
      end

      get '/test'   => lambda { |env| [200,{},['test']] }
    end
  end

  test "routing" do
    get '/test'
    assert_equal 'test', @response.body

    get '/test', {}, { 'HTTP_ACCEPT' => "application/vnd.biceps;ver=1" }
    assert_equal 'test v1', @response.body

    get '/test', {}, { 'HTTP_ACCEPT' => "application/vnd.biceps;ver=2" }
    assert_equal 'test v2', @response.body
  end
end
