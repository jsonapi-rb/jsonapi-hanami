require 'jsonapi/deserializable'

module JSONAPI
  module Hanami
    module Deserialization
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def deserializable_resource(key, options = {}, &block)
          _deserializable(key, JSONAPI::Deserializable::Resource,
                          options, &block)
        end

        def deserializable_relationship(key, options = {}, &block)
          _deserializable(key, JSONAPI::Deserializable::Relationship,
                          options, &block)
        end

        def _deserializable(key, base_class, options, &block)
          klass = options[:class] || Class.new(base_class, &block)
          use Deserialization, key, klass
        end
      end

      class Deserialization
        ROUTER_PARSED_BODY = 'router.parsed_body'.freeze

        def initialize(app, key, klass)
          @app = app
          @deserializable_key = key
          @deserializable_class = klass
        end

        def call(env)
          body = env[ROUTER_PARSED_BODY]
          parser.parse!(body)
          deserialized_hash = @deserializable_class.call(body)
          env[ROUTER_PARSED_BODY] = {
            @deserializable_key => deserialized_hash
          }

          @app.call(env)
        end
      end
    end
  end
end
