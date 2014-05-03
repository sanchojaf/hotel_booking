class CreateSpreeSurcharges < ActiveRecord::Migration

#  	Details a single surcharge's amount and type. Contains attributes only.

  def change
    create_table :spree_surcharges do |t|
      t.references :chargeable_rate_info, index: true

# Amount of the specific surcharge
      t.float :amount 

# Name of the surcharge.
# Possible values:

  #  Tax
  #  ServiceFee
  #  ExtraPersonFee
  #  SalesTax
  #  HotelOccupancyTax
  #  TaxAndServiceFee
      t.string :surcharge_type

# Note: the salesTax and hotelOccupancyTax surcharge types must be displayed by state law in New York. Ensure you expect and capture these values to display as "Hotel Occupancy and Sales Tax" in the final price breakdown.


      t.timestamps
    end
  end
end
