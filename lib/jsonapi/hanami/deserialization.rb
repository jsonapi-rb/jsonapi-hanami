require 'jsonapi/deserializable'

module JSONAPI
  module Hanami
    module Deserialization
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def deserializable_resource(key, options = {}, &block)
          _deserializable(key, options,
                          JSONAPI::Deserializable::Resource, &block)
        end

        def deserializable_relationship(key, options = {}, &block)
          _deserializable(key, options,
                          JSONAPI::Deserializable::Relationship, &block)
        end

        # @api private
        def _deserializable(key, options, fallback, &block)
          klass = options[:class] || Class.new(fallback, &block)
          use DeserializationMiddleware, key, klass
        end
      end

      class DeserializationMiddleware
        ROUTER_PARAMS = 'router.params'.freeze
        ROUTER_PARSED_BODY = 'router.parsed_body'.freeze
        JSONAPI_KEYS = [:data, :meta, :links, :jsonapi].freeze

        def initialize(app, key, klass)
          @app = app
          @deserializable_key = key
          @deserializable_class = klass
        end

        def call(env)
          body = env[ROUTER_PARSED_BODY]
          deserialized_hash = @deserializable_class.call(body)
          params = env[ROUTER_PARAMS]
          # TODO(beauby): Actually replace the request body upstream instead
          #   of hacking it here.
          params[:_jsonapi] = {}
          JSONAPI_KEYS.each do |key|
            params[:_jsonapi][key] = params.delete(key) if params.key?(key)
          end
          params[@deserializable_key] = deserialized_hash

          @app.call(env)
        end
      end
    end
  end
end
