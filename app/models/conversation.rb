class Conversation
  include Mongoid::Document

  field :subject
  embeds_many :messages

  accepts_nested_attributes_for :messages

  validates :subject, presence: true
  validates_associated :messages
end
