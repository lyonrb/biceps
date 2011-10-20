ActionController::Base.class_eval do

  def initialize_for_api(resource, params)
    api_version = Biceps::Parser.new(request).version
    Biceps::Builder.new(resource, params, api_version)
  end
end
