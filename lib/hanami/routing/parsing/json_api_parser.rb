require 'hanami/routing/parsing/parser'
require 'json'

module Hanami
  module Routing
    module Parsing
      class JsonApiParser < Parser
        def mime_types
          ['application/vnd.api+json']
        end

        def parse(body)
          hash = JSON.parse(body)

          { _jsonapi: hash }
        end
      end
    end
  end
end
