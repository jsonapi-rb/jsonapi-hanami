module Api::Controllers::Tweets
  class Index
    include Api::Action
    include JSONAPI::Hanami::Action

    def call(params)
      repository = TweetRepository.new

      self.data = repository.all
    end
  end
end
