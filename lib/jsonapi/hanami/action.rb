require 'jsonapi/hanami/renderer'
require 'jsonapi/hanami/deserializable'

module JSONAPI
  module Hanami
    module Action
      def self.included(base)
        base.class_eval do
          include Renderer
          include Deserializable
        end
      end
    end
  end
end
