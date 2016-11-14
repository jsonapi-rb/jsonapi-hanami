require 'jsonapi/renderer'
require 'jsonapi/serializable'
require 'jsonapi/hanami/rendering/dsl'

module JSONAPI
  module Hanami
    module Rendering
      def self.included(base)
        base.class_eval do
          include JSONAPI::Hanami::Rendering::DSL

          after do
            _render_jsonapi if @_body.nil?
          end
        end
      end

      def _render_jsonapi
        document = JSONAPI.render(_jsonapi_params)
        self.format = :jsonapi if @format.nil?
        self.status = _jsonapi_status unless @_status
        self.body   = document.empty? ? nil : document.to_json
      end

      def _jsonapi_status
        # TODO(beauby): Set HTTP status code accordingly.
        200
      end

      def _jsonapi_params
        # TODO(beauby): Inject global params (toplevel jsonapi, etc.).
        @_jsonapi.dup.tap do |hash|
          hash[:data]   = _jsonapi_resources if @_jsonapi.key?(:data)
          hash[:errors] = _jsonapi_errors    if @_jsonapi.key?(:errors)
        end
      end

      # TODO(beauby): Refactor inference into a ResourceBuilder class.
      def _jsonapi_resources
        data = @_jsonapi[:data]
        return data if data.nil? || Array(data).first.respond_to?(:as_jsonapi)

        if data.respond_to?(:each)
          data.map { |model| _jsonapi_resource_for(model) }
        else
          _jsonapi_resource_for(data)
        end
      end

      def _jsonapi_resource_for(model)
        klass  = _jsonapi_resource_inferer.call(model.class.name)
        params = _jsonapi_model_params
                 .merge!(exposures)
                 .merge!(model: model)

        klass.new(params)
      end

      def _jsonapi_resource_inferer
        JSONAPI::Serializable::Model::DEFAULT_RESOURCE_INFERER
      end

      def _jsonapi_model_params
        { routes: routes }
      end

      def _jsonapi_errors
        # TODO(beauby): Implement inferrence for Hanami::Validations.
        @_jsonapi[:errors]
      end
    end
  end
end
