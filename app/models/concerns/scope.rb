module Scope
  extend ActiveSupport::Concern

  included do
    scope :create_recent, -> { order(created_at: :desc) }
  end
end
