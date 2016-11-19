# jsonapi-hanami
Hanami integration for [jsonapi-rb](https://github.com/jsonapi-rb/jsonapi-rb).

## Status

[![Gem Version](https://badge.fury.io/rb/jsonapi-hanami.svg)](https://badge.fury.io/rb/jsonapi-hanami)
[![Build Status](https://secure.travis-ci.org/jsonapi-rb/hanami.svg?branch=master)](http://travis-ci.org/jsonapi-rb/hanami?branch=master)
[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/jsonapi-rb/Lobby)

## Installation

Add the following to your application's Gemfile:
```ruby
gem 'jsonapi-hanami'
```
And then execute:
```
$ bundle
```
Or install it manually as:
```
$ gem install jsonapi-hanami
```

## Usage

```ruby
module API::Controllers::Posts
  class Create
    include API::Action
    include JSONAPI::Hanami::Action

    deserializable_resource :user, DeserializableCreatePost
    # or
    deserializable_resource :user do
      # ...
    end

    params do
      # ...
    end

    def call(params)
      unless params.valid?
        self.errors = params.errors
        return
      end

      repo = UserRepository.new
      user = repo.create(params[:user])

      self.data = user
      self.meta = { foo: 'bar' }
      self.links = { self: 'foo://bar' }
      self.jsonapi = { version: '1.0', meta: { foo: 'bar' } }
      # Also available:
      #  self.included = { posts: [:author, comments: [:author]] }
      #  self.fields = { posts: [:title, :date], users: [:name] }
    end
  end
end
```

## License

jsonapi-hanami is released under the [MIT License](http://www.opensource.org/licenses/MIT).
