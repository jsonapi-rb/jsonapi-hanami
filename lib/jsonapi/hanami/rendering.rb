require 'jsonapi/serializable'
require 'jsonapi/hanami/rendering/dsl'

module JSONAPI
  module Hanami
    module Rendering
      def self.included(base)
        base.class_eval do
          include JSONAPI::Hanami::Rendering::DSL

          after do
            _jsonapi_render if @_body.nil?
          end
        end
      end

      def _jsonapi_render
        if @_jsonapi.key?(:errors)
          _jsonapi_render_error
        else
          _jsonapi_render_success
        end
      end

      def _jsonapi_render_success
        self.format = :jsonapi if @format.nil?
        return unless @_jsonapi.key?(:data)
        self.body = JSONAPI::Serializable::SuccessRenderer.new.render(@_jsonapi[:data],
                                                           _jsonapi_params)
      end

      # NOTE(beauby): It might be worth factoring those methods out into a
      #   class.
      def _jsonapi_params
        # TODO(beauby): Inject global params (toplevel jsonapi, etc.).
        @_jsonapi.dup.merge!(expose: _jsonapi_exposures)
      end

      def _jsonapi_exposures
        { routes: routes }.merge!(exposures)
      end

      def _jsonapi_render_error
        document =
          JSONAPI::Serializable::ErrorsRenderer.new.render(@_jsonapi[:errors],
                                                      _jsonapi_error_params)
        self.status = _jsonapi_error_status unless @_status
        self.format = :jsonapi if @format.nil?
        self.body   = document
      end

      def _jsonapi_error_status
        # TODO(beauby): Set HTTP status code accordingly.
        400
      end

      def _jsonapi_error_params
        @_jsonapi
      end

      def _jsonapi_errors
        # TODO(beauby): Implement inferrence for Hanami::Validations.
        @_jsonapi[:errors]
      end
    end
  end
end
