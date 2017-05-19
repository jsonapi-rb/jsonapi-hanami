class SerializableTweet < JSONAPI::Serializable::Resource
  type :tweets

  attributes :contents

  belongs_to :author
end
