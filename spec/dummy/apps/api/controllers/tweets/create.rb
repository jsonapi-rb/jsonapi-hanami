module Api::Controllers::Tweets
  class Create
    include Api::Action
    include JSONAPI::Hanami::Action

    deserializable_resource :tweet

    params do
      required(:tweet).schema do
        required(:contents).filled(:str?, size?: 3..140)
      end
    end

    def call(params)
      if params.valid?
        repository = TweetRepository.new
        tweet = repository.create(params[:tweet])

        self.data   = tweet
        self.status = 201
      else
        self.errors = params.errors
        self.status = 422
      end
    end
  end
end
