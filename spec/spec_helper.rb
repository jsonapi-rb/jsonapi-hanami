# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require_relative 'dummy/config/environment'

RSpec.configure do |config|
  config.expose_dsl_globally = true
end

Dir.chdir('spec/dummy') do
  Hanami.boot
end
