require 'spec_helper'
require_relative '../../../../apps/api/controllers/tweets/index'

describe Api::Controllers::Tweets::Index do
  let(:action) { Api::Controllers::Tweets::Index.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
