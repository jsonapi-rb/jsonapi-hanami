require 'jsonapi/hanami/deserialization'
require 'jsonapi/hanami/rendering'

module JSONAPI
  module Hanami
    module Action
      def self.included(base)
        base.class_eval do
          include Deserialization
          include Rendering
        end
      end
    end
  end
end
