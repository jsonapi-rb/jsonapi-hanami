module JSONAPI
  module Hanami
    module Rendering
      module DSL
        def data=(value)
          (@_jsonapi ||= {}).merge!(data: value)
        end

        def errors=(value)
          (@_jsonapi ||= {}).merge!(errors: value)
        end

        def include=(value)
          (@_jsonapi ||= {}).merge!(include: value)
        end

        def fields=(value)
          (@_jsonapi ||= {}).merge!(fields: value)
        end

        def meta=(value)
          (@_jsonapi ||= {}).merge!(meta: value)
        end

        def links=(value)
          (@_jsonapi ||= {}).merge!(links: value)
        end

        def jsonapi=(value)
          (@_jsonapi ||= {}).merge!(jsonapi: value)
        end
      end
    end
  end
end
