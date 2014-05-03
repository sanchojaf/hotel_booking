class CreateSpreeHotelSummaries < ActiveRecord::Migration
  def change
    create_table :spree_hotel_summaries do |t|

# Name of the hotel
      t.string :name

# ID for the property. This same ID will be used in any subsequent room or reservation requests.
      t.integer :hotel_id

# Hotel street address
      t.string :address1

# Hotel city
      t.string :city

# Two character code for the state/province containing the specified city. Returns only for US, CA, and AU country codes.

# References:
# US State Codes
# Canadian Province/Territory Codes
# Australian Province/Territory Codes
      t.string :state_province_code

#Two character ISO-3166 code for the country the hotel is located in
      t.string :country_code

#Postal code for the hotel
      t.string :postal_code

# Airport code associated with the hotel
      t.string :airport_code

# Supplier of the hotel. This same supplier will be used to process any reservations placed.
# Use this element to determine proper text for pricing Expedia Collect and Hotel Collect listings.

# Values:
# E: Expedia Collect
# V: Venere (Hotel Collect )
# S: Sabre (Hotel Collect )
# W: Worldspan (Hotel Collect )
      t.string :supplier_type

# 	The category of the property returned.

# Values:
# 1: hotel
# 2: suite
# 3: resort
# 4: vacation rental/condo
# 5: bed & breakfast
# 6: all-inclusive 
      t.string :property_category

#Star rating of the hotel. A value of 0.0 or a blank value indicate none is available. For Hotel Collect , this value is determined by translating Sabre diamond ratings, which may not be available.
      t.float :hotel_raiting

# Returns for Hotel Collect only. Our collections department's assessment of how likely individual properties are to pay commissions and how quickly they pay them.
      t.integer :confidence_rating

# See details on hotel amenity masks
      t.integer :amenity_mask

# 	Short description text entered by the property. Truncated if entry exceeds 200 characters.
# For better performance, add an ellipsis (…) to the end of this value and set it to link to the property's room availability page.
      t.text :short_description

# 	General location as entered by the property, e.g. "Near Pike Place Market"
      t.string :location_description

# Lowest rate returned by the hotel in recent queries. This is a statistical figure and not necessarily a rate for current availability.
      t.string :low_rate

#  	Highest rate returned by the hotel in recent queries. This is a statistical figure and not necessarily a rate for current availability.
      t.string :high_rate

# 	Highest rate returned by the hotel in recent queries. This is a statistical figure and not necessarily a rate for current availability.

# Currency code of the high or low rates returned.
      t.string :rate_currency_code

#  Latitude coordinate for the hotel.
      t.float :latitude

# Longitude coordinate for the hotel.
      t.float :longitude

# 	The distance of the hotel from the originally specified origin coordinates, if that search method was used.
      t.float :proximity_distance

# 	Unit for the distance provided by proximityDistance. MI or KM.
      t.string :proximity_unit

# Indicates whether the property is within the originally specified city or in an expanded area, i.e. a major suburb or other nearby city.

#Expedia Collect hotels outside of the destination are grouped by distance from the original area, e.g. under 10 miles away, under 20 miles away, etc. Hotel Collect will always appear after any and all Expedia Collect results regardless of proximity.
      t.boolean :hotel_in_destination

#URL path of a thumbnail image of the property, if provided.

#Full URLs are not returned - append this value with http://images.travelnow.com, or your own image subdomain by setting up a CNAME with origin-images.travelnow.com as the destination. HTTPS with SSL is supported. 
      t.string :thumb_nail_url

# Deep link into the corresponding hotel page on your template, used if you are creating a hybrid site.

# Format returned is only compatible with legacy template accounts. If you have a Chameleon template account, the URL will return an error. Refer to the deep link formatting guide on the hybrid sites page to create deep links compatible with your template.

# These links can also be masked with a CNAME.
      t.string :deep_link

      t.timestamps

      t.timestamps
    end
  end
end
