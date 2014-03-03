require 'spec_helper'
require 'action_controller/railtie'

class ApiController < ActionController::Base
  def foo_empty
    render :text => 'test with empty module'
  end
end
module Bar
  class ApiController < ActionController::Base

    def foo_bar
      render :text => 'test with bar module'
    end

    def foo_double
      render :text => 'test with double and module'
    end
  end
end

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

      api_version [1, nil] do
        get '/double' => lambda { |env| [200, {}, ['test double']] }
      end

      get '/test'   => lambda { |env| [200,{},['test']] }


      api_version 1, :module => '' do
        get '/foo_empty' => 'api#foo_empty'
      end
      api_version 1, :module => 'bar' do
        get '/foo_bar' => 'api#foo_bar'
      end

      api_version [1, 2] do
        get '/foo_double' => 'api#foo_double'
      end

    end
    @routes = @app.routes
  end

  test "routing" do

    get '/test'
    assert_equal 'test', @response.body

    get '/test', {}, { 'HTTP_ACCEPT' => "application/vnd.biceps;ver=1" }
    assert_equal 'test v1', @response.body

    get '/test', {}, { 'HTTP_ACCEPT' => "application/vnd.biceps;ver=2" }
    assert_equal 'test v2', @response.body
  end

  test "routing with double versions" do
    get '/double'
    assert_equal 'test double', @response.body

    get '/double', {}, { 'HTTP_ACCEPT' => "application/vnd.biceps;ver=1" }
    assert_equal 'test double', @response.body

    get '/double', {}, { 'HTTP_ACCEPT' => "application/vnd.biceps;ver=2" }
    assert_equal 404, @response.status
  end

  test "routing with specified module" do
    get '/foo_empty', {}, { 'HTTP_ACCEPT' => "application/vnd.biceps;ver=1" }
    assert_equal 'test with empty module', @response.body


    get '/foo_bar', {}, { 'HTTP_ACCEPT' => "application/vnd.biceps;ver=1" }
    assert_equal 'test with bar module', @response.body
  end
end
