require 'jsonapi/deserializable'

module JSONAPI
  module Hanami
    module Deserialization
      REVERSE_MAPPING_KEY = 'jsonapi_deserializable.reverse_mapping'.freeze

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

          before do |params|
            resource = klass.new(params[:_jsonapi])
            params.env[REVERSE_MAPPING_KEY] = resource.reverse_mapping
            params[key.to_sym] = resource.to_hash
          end
        end
      end
    end
  end
end
