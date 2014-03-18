module Spree
  class Measure < ActiveRecord::Base
    belongs_to :measurement, class_name: "Spree::Measurement"
    validates :name, presence: true
    validates :min, presence: true
    validates :max, presence: true
  end
end
