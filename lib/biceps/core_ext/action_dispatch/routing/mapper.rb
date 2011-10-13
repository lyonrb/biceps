require 'action_controller'
#
# Monkey Patching routes to add the `api_version` method
# This allows us to define both the namespace and the constraint all together
#
module ActionDispatch::Routing
  class Mapper

    def api_version(version, opts={})
      if opts[:module] && opts[:module].empty?
        scope_module = nil
      else
        scope_module = opts[:module] || "v#{version}"
      end

      scope :module => scope_module do
        constraints Biceps::ApiVersion.new(version) do
          yield if block_given?
        end
      end
    end
  end
end
