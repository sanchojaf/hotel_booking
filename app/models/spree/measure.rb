module Spree
  class Measure < ActiveRecord::Base
    belongs_to :measure_item
    validates :name, presence: true
    validates :min, presence: true
    validates :max, presence: true
  end
end
