require 'jsonapi/deserializable'
require 'jsonapi/parser'

module JSONAPI
  module Hanami
    module Deserializable
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def deserializable_resource(key, klass = nil, &block)
          if klass.nil?
            klass = Class.new(JSONAPI::Deserializable::Resource, &block)
          end
          use DeserializableResource, key, klass
        end

        def deserializable_relationship(key, klass = nil, &block)
          if klass.nil?
            klass = Class.new(JSONAPI::Deserializable::Relationship, &block)
          end
          use DeserializableRelationship, key, klass
        end
      end

      class DeserializableMiddleware
        ROUTER_PARAMS = 'router.params'.freeze

        def initialize(app, key, klass)
          @app = app
          @deserializable_key = key
          @deserializable_class = klass
        end

        def call(env)
          env[ROUTER_PARAMS].tap do |body|
            parser.parse!(body)
            deserialized_hash = @deserializable_class.call(body)
            body.replace(@deserializable_key => deserialized_hash)
          end
          @app.call(env)
        end
      end

      class DeserializableResource < DeserializableMiddleware
        def parser
          JSONAPI::Parser::Resource
        end
      end

      class DeserializableRelationship < DeserializableMiddleware
        def parser
          JSONAPI::Parser::Relationship
        end
      end
    end
  end
end
