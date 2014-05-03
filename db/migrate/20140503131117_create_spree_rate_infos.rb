class CreateSpreeRateInfos < ActiveRecord::Migration
  def change
    create_table :spree_rate_infos do |t|
      t.references :room_rate_detail, index: true

#  	ID for the promo offer returned, if any. Returned in RoomRateDetails below minorRev=20
      t.string :promoId

# Description for the promo returned, if any. Max of 255 chars will return. Returned in RoomRateDetails below minorRev=20
      t.string :promoDescription

# Extra details for the promo returned, if any. Returned in RoomRateDetails below minorRev=20
      t.string :promoDetailText

#  	The number of bookable rooms remaining at the property. Use this value to create rules for urgency messaging to alert users to low availability on busy travel dates or at popular properties.

# If the value returns as 0, it does not indicate a lack of rooms at the property. The rules needed to calculate the value were simply not met - this value does not indicate absolute availability.
# Returned in RoomRateDetails below minorRev=20
      t.integer :currentAllotment

# Hotel's cancellation policy for this room. Must display on individual room pages as well as any booking and booking confirmation pages.
# Available with minorRev=22 or higher. Returns only if includeDetails=true was sent in the request. 
      t.string :cancellationPolicy

#  	Indicates if the rate returned is prepaid via EAN or post-paid at the hotel. Either returns with a value of MerchantStandard for prepaid availability, or does not return at all for post-paid.
# Available with minorRev=18 or higher. Returned in the main body of the response below minorRev=20
      t.string :rateType

# Indicates explicitly if the reservation can be refunded or not after booking. Should also be indicated within the cancellation policy returned.
# Returns only with availability and minorRev=20 and above. Returned in RoomRateDetails below minorRev=20
      t.boolean :nonRefundable

#  	Indicates whether any promos returned are mobile-specific or standard promotions. Returns Mobile for mobile promotions and Standard for all others.
# In order to return mobile promotions, you must identify your mobile site or app via the proper customerUserAgent string.
# Available with minorRev=21 or higher. You must upgrade to the schema under minorRev=20 in order to use this element.
      t.string :promoType


      t.timestamps
    end
  end
end
