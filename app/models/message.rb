class Message
  include Mongoid::Document
  field :body

  validates_presence_of :body
end
