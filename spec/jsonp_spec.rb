require 'spec_helper'
require 'json'


RMR = Rack::MockRequest
describe Biceps::Jsonp do
  let(:middleware) { Biceps::Jsonp }

  describe "when a callback parameter is provided" do
    it "should wrap the response body in the Javascript callback [default callback param]" do
      test_body = '{"bar":"foo"}'
      callback = 'foo'
      app = lambda { |env| [200, {'Content-Type' => 'application/json'}, [test_body]] }
      request = RMR.env_for("/", :params => "foo=bar&callback=#{callback}")
      body = middleware.new(app).call(request).last
      assert_equal body, ["#{callback}({'metadata': {\"status\":200}, 'data': #{test_body}})"]
    end

    it "should wrap the response body in the Javascript callback [custom callback param]" do
      test_body = '{"bar":"foo"}'
      callback = 'foo'
      app = lambda { |env| [200, {'Content-Type' => 'application/json'}, [test_body]] }
      request = RMR.env_for("/", :params => "foo=bar&whatever=#{callback}")
      body = middleware.new(app, :callback_param => 'whatever').call(request).last
      assert_equal body, ["#{callback}({'metadata': {\"status\":200}, 'data': #{test_body}})"]
    end

    it "should modify the content length to the correct value" do
      test_body = '{"bar":"foo"}'
      callback = 'foo'
      app = lambda { |env| [200, {'Content-Type' => 'application/json'}, [test_body]] }
      request = RMR.env_for("/", :params => "foo=bar&callback=#{callback}")
      headers = middleware.new(app).call(request)[1]
      assert_equal headers['Content-Length'], ((test_body.length + callback.length + 40).to_s) # 2 parentheses
    end

    it "should change the response Content-Type to application/javascript" do
      test_body = '{"bar":"foo"}'
      callback = 'foo'
      app = lambda { |env| [200, {'Content-Type' => 'application/json'}, [test_body]] }
      request = RMR.env_for("/", :params => "foo=bar&callback=#{callback}")
      headers = middleware.new(app).call(request)[1]
      assert_equal headers['Content-Type'], "application/javascript"
    end

    it "should not wrap content unless response is json" do
      test_body = '<html><body>Hello, World!</body></html>'
      callback = 'foo'
      app = lambda { |env| [200, {'Content-Type' => 'text/html'}, [test_body]] }
      request = RMR.env_for("/", :params => "foo=bar&callback=#{callback}")
      body = middleware.new(app).call(request).last
      assert_equal body, [test_body]
    end
  end

  it "should not change anything if no callback param is provided" do
    app = lambda { |env| [200, {'Content-Type' => 'application/json'}, ['{"bar":"foo"}']] }
    request = RMR.env_for("/", :params => "foo=bar")
    body = middleware.new(app).call(request).last
    assert_equal body.join, '{"bar":"foo"}'
  end

  it "should set the status when it's not 200" do
    test_body = '{"bar":"foo"}'
      callback = 'foo'
      app = lambda { |env| [404, {'Content-Type' => 'application/json'}, [test_body]] }
      request = RMR.env_for("/", :params => "foo=bar&callback=#{callback}")
      body = middleware.new(app).call(request).last
      assert_equal body, ["#{callback}({'metadata': {\"status\":404}, 'data': #{test_body}})"]
  end
end

