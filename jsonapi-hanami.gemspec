version = File.read(File.expand_path('../VERSION', __FILE__)).strip

Gem::Specification.new do |spec|
  spec.name          = 'jsonapi-hanami'
  spec.version       = version
  spec.author        = 'Lucas Hosseini'
  spec.email         = 'lucas.hosseini@gmail.com'
  spec.summary       = 'jsonapi-rb integrations for Hanami.'
  spec.description   = 'Efficient, convenient, non-intrusive JSONAPI ' \
                       'framework for Hanami.'
  spec.homepage      = 'https://github.com/jsonapi-rb/jsonapi-hanami'
  spec.license       = 'MIT'

  spec.files         = Dir['README.md', 'lib/**/*']
  spec.require_path  = 'lib'

  spec.add_dependency 'jsonapi-renderer', '~> 0.2.0'
  spec.add_dependency 'jsonapi-serializable', '~> 0.3.0'
  spec.add_dependency 'jsonapi-rb', '~> 0.5.0'

  spec.add_development_dependency 'rake',   '~> 11.3'
  spec.add_development_dependency 'rspec',  '~> 3.5'
  spec.add_development_dependency 'hanami', '~> 1.0'
  spec.add_development_dependency 'hanami-model', '~> 1.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'dotenv'
end
