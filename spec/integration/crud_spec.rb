require 'spec_helper'
require 'rack/test'

describe 'Tweets' do
  include Rack::Test::Methods

  def app
    Hanami.app
  end

  let(:headers) do
    { 'ACCEPT' => 'application/vnd.api+json' }
  end
  let(:author) do
    UserRepository.new.create(name: 'Lucas', email: 'lucas@jsonapi-rb.org')
  end

  it 'follows a simple CRUD scenario' do
    # Get empty tweets list
    get '/tweets', headers: headers
    expect(last_response).to be_success
    expect(last_response).to have_http_status(200)
    p last_response.body

    # Post first tweet
    params = {
      data: {
        type: 'tweets',
        attributes: {
          content: 'foo'
        },
        relationships: {
          author: {
            data: {
              id: author.id.to_s,
              type: 'users'
            }
          }
        }
      }
    }
    post '/tweets',
         params: params,
         as: :json,
         headers: headers.merge('CONTENT_TYPE' => 'application/vnd.api+json')
    expect(response).to be_success
    expect(response).to have_http_status(201)
    p last_response.body
  end
end
