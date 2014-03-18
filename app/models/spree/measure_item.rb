module Spree
  class MeasureItem < ActiveRecord::Base
    belongs_to :measurement_set, class_name: "Spree::MeasurementSet"
    belongs_to :measure, class_name: "Spree::Measure"

    validates :measurement_set, presence: true
    validates :measure, presence: true
    validates :value, presence: true
  end
end
