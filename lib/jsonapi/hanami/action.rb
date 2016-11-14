require 'jsonapi/hanami/renderer'
require 'jsonapi/hanami/deserialization'

module JSONAPI
  module Hanami
    module Action
      def self.included(base)
        base.class_eval do
          include Renderer
          include Deserialization
        end
      end
    end
  end
end
