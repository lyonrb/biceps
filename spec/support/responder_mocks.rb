class Biceps::TestResponder < ActionController::Responder
  include Biceps::ModelVersioning
end

class Biceps::TestResponderController < ActionController::Base
  attr_accessor :limit, :params

  def initialize
    @params = {}
    @_response = ActionDispatch::Response.new
    @_action_has_layout = true
  end

  def formats
    [:json]
  end

  def request
    @request ||= ActionDispatch::Request.new({
      'REQUEST_METHOD' => 'GET',
      'REQUEST_URI' => 'http://test.host/foo'
    })
  end

  def responder
    Biceps::TestResponder
  end
end
