module Spree
  class Measurement < ActiveRecord::Base
    belongs_to :user, class_name: "Spree::User"
    has_many :measures
  end
end
