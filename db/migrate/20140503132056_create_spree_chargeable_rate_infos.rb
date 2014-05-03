class CreateSpreeChargeableRateInfos < ActiveRecord::Migration
  def change
    create_table :spree_chargeable_rate_infos do |t|
      t.references :rate_info, index: true

#  	The total of all nightly rates, taxes, and surcharges to be charged for the reservation. This is the total value that must be displayed to the customer and included in the booking request for an Expedia Collect property. 
      t.float :total

# The value from the TaxAndServiceFee attribute of the Surcharges array.
      t.float :surchargeTotal

# Total of all values in the nightlyRatesPerRoom array contained within this object.
      t.float :nightlyRateTotal

# Highest nightly rate of all rates returned (important for Hotel Collect )
      t.float :maxNightlyRate

# Currency code for the rates returned
      t.string :currencyCode

#  	Amount used to calculate partner commissions, in USD. Total of nightly rates less surchages.
      t.float :commissionableUsdTotal

#  	Average of all nightly rates with any promo values applied, without surcharges.  
      t.float :averageRate

# Average of all nightly rates without any promo values applied, without surcharges.Will return the same as previous value if no promos present.
      t.float :averageBaseRate



      t.timestamps
    end
  end
end
