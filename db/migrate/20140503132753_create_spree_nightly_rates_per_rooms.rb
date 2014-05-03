class CreateSpreeNightlyRatesPerRooms < ActiveRecord::Migration

# Details the rate for a single night within the span of the requested stay. Indicates the presence of a promo rate, the base rate, and the rate after the promo is applied (if applicable). Contains attributes only. 

  def change
    create_table :spree_nightly_rates_per_rooms do |t|
      t.references :chargeable_rate_info, index: true

# Indicates if a promo rate is applied for this night's rate.
      t.boolean :promo

#  	The nightly rate after the promo, if any, is applied.
      t.float :rate

# The nightly rate before the promo, if any, is applied.
      t.float :baseRate


      t.timestamps
    end
  end
end
