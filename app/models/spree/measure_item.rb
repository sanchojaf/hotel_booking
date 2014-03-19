module Spree
  class MeasureItem < ActiveRecord::Base
    belongs_to :measurement_set, class_name: "Spree::MeasurementSet"
    has_one :measure

    validates :measurement_set, presence: true
    validates :measure, presence: true
    validates :value, presence: true
  end
end
