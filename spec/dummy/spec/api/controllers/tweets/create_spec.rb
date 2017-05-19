require 'spec_helper'
require_relative '../../../../apps/api/controllers/tweets/create'

describe Api::Controllers::Tweets::Create do
  let(:action) { Api::Controllers::Tweets::Create.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
