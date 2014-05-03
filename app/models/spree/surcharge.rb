class Spree::Surcharge < ActiveRecord::Base
  belongs_to :chargeable_rate_info
end
