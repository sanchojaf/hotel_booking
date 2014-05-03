class CreateSpreeRoomRateDetails < ActiveRecord::Migration
  def change
    create_table :spree_room_rate_details do |t|
      t.references :hotel_summary, index: true

# Room type code for the room.      
      t.string :room_type_code

# Code to the displayed rate. For Hotel Collect listings, special requirements such as AAA or AARP membership are determined via this or the previous element.
      t.string :rate_code

# Maximum number of guests allowed in the room returned.
      t.integer :max_room_occupancy

# Confirms the actual occupancy used to calculate the rate.
      t.integer :quoted_room_occupancy

# Minimum guest age allowed in the room
      t.integer :min_guest_age

# Description of the room associated with the roomTypeCode returned
      t.string :room_description

# ID for the promo offer returned, if any.
      t.string :promo_id

# Description for the promo returned, if any. Max of 255 chars will return.
      t.string :promo_description

#Extra details for the promo returned, if any.
      t.string :promo_detailText

#The number of bookable rooms remaining at the property. Use this value to create rules for urgency messaging to alert users to low availability on busy travel dates or at popular properties.

#If the value returns as 0, it does not indicate a lack of rooms at the property. The rules needed to calculate the value were simply not met - this value does not indicate absolute availability.
      t.integer :current_allotment

# For internal inventory reference only.
#|Only available inventories will return on standard requests.
      t.boolean :property_available

# For internal inventory reference only. Refer to cancellation policy for any specific restrictions.
      t.boolean :property_restricted

# Expedia's ID for the hotel. Use this value to map to a hotelId when cross-referencing to Expedia. A complete cross-reference file is also available in the database catalog.
      t.string :expedia_propertyId

# Key to the rate and parameters determining the rate.

# Every time search parameters are changed (guest count change, different dates of stay, adding children, etc) a new request must be sent to obtain a new value for this parameter.

# Returns in this location for minorRev=17 and below. If includeDetails=true was sent in the request under minorRev=22 or higher, this value will return within the Room object.
      t.string :rate_key

# Indicates explicitly if the reservation can be refunded or not after booking. Should also be indicated within the cancellation policy returned.
# Returns only with availability and minorRev=10 to 19.
      t.boolean :non_refundable


      t.timestamps
    end
  end
end
