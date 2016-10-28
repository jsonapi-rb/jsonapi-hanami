require 'jsonapi/renderer'

module JSONAPI
  module Hanami
    module Renderer
      def jsonapi_render(resources, params = {})
        # TODO(beauby): Serializable inference with helpers injection.
        # TODO(beauby): Inject global params (toplevel jsonapi, etc.).
        JSONAPI::Renderer.new(resources, params).as_json
      end
    end
  end
end
