Spree::BaseHelper.module_eval do

  def head_url( options = {}  )
    url = "https://api.eancdn.com/ean-services/rs/hotel/v3/#{options[:api_method]}"
    key = ENV["EAN_API_KEY"]
    common_parameters = "cid=55505&minorRev=99&apiKey=#{key}&locale=en_US&currencyCode=USD"
    "#{url}?#{common_parameters}"   
  end

  def response_json( options = {} )
    data = data_json( options )
    result = nil
    result = case options[:api_method]
    when 'list' 
       data['HotelListResponse']['HotelList']['HotelSummary'] 
    when 'avail'
      data['HotelRoomAvailabilityResponse']['HotelRoomResponse']
    end    
    result
  end

 def data_json( options = {} )
    head = head_url(options)
    q = query_xml options     
    query_xml_uri = ERB::Util.url_encode q
    url_of_json_service = "#{head}&xml=#{query_xml_uri}"
    JSON.parse(open(url_of_json_service).read)
  end

  def query_xml( options = {} )
    default_values = {}
    default_values = default_values( options )

    tags = case options[:api_method]
    when 'list' 
      { :hotel_list_request => 
        { :city => "", 
          :state_province_code => "", 
          :country_code  => "", 
          :arrival_date  => "", 
          :departure_date => "",  
          :latitude => "",  
          :longitude => "", 
          :room_group =>  
            { :room => 
              { :number_of_adults => "", 
                :number_of_children => ""}},                  
          :number_of_results =>"" }}  

    when 'avail'      
      { :hotel_room_availability_request => 
        { :hotel_id => "", 
          :arrival_date  => "", 
          :departure_date => "", 
          :include_details => "", 
          :room_group =>  
            { :room => 
              { :number_of_adults => "", 
                :number_of_children => ""}}}}                           
    end
    node_xml( tags, default_values )
  end

  def default_values( options = {} )

    case options[:api_method]
    when 'list' 
      #options[:latitude] ||= "40.84706035607122"
      #options[:longitude] ||= "-74.00390625"
      options[:city] ||= "Seattle"
      options[:state_province_code] ||= "WA"
      options[:country_code] ||= "US"
      options[:arrival_date] ||= "5/22/2014"
      options[:departure_date] ||= "5/24/2014"
      options[:number_of_adults] ||= '2'
      options[:number_of_results] ||= '2'
    when 'avail'      
      options[:arrival_date] ||= "5/22/2014"
      options[:departure_date] ||= "5/24/2014"
      options[:number_of_adults] ||= '2'
      options[:include_details] ||= 'true'
    end

    options
  end

  def node_xml(tags, options = {})
    result = ""
    tags.each do |key, value| 
      node = key.to_s.camelize(:lower)
      result += "<#{node}>#{ node_xml(value, options ) }</#{node}>" unless value.blank?
      result += "<#{node}>#{ options[key] }</#{node}>" if value.blank? and options[key].present?
    end
    result   
  end



  def update_or_create_product( hotel )
    tax_hotel = Spree::TaxCategory.find_or_create_by_name!("Hotel")
    shipping_category = Spree::ShippingCategory.find_or_create_by_name!("Default")

    product_attrs = {
      :name => hotel['name'],
      :sku => hotel['hotelId'],
      :tax_category => tax_hotel,
      :shipping_category => shipping_category,
      :price => hotel['lowRate'],
      :description => hotel['shortDescription'],
      :available_on => Time.zone.now
    }

    product = Spree::Product.find_by_name(hotel['name']) || Spree::Product.new(:name => hotel['name'])
    product.update_attributes! product_attrs
    product.reload
    product.save!
    #update_or_create_variant product
    product
  end


  def update_or_create_variant( product )

    room_json(product.sku)
    type_room = Spree::OptionType.find_or_create_by_name!('room')
    
    variants = []
    @rooms.each do |room|
      next unless room.is_a?(Hash) 

      option_value_attrs = {
          :name => room['roomTypeDescription'],
          :presentation => room['roomTypeDescription'],
          :option_type => type_room
        }

      name = option_value_attrs[:name]
      option_value = Spree::OptionValue.find_by_name(name) || Spree::OptionValue.new(:name => name)
      option_value.update_attributes! option_value_attrs

      variants << {
          :product => product, 
          :option_values => [option_value],
          :sku => room['roomTypeCode'],
          :cost_price => 3 #room['RateInfos']['RateInfo']['ChargeableRateInfo']['@total'].to_f
        }
    end
    
    master = false
    variants.each do |variant_attrs|
      sku = variant_attrs[:sku]
      variant = Spree::Variant.find_by_sku(sku) || Spree::Variant.new(:sku => sku)
      variant.update_attributes! variant_attrs
      variant.save
    end

    variant_attrs = { 
      :sku => product.sku,
      :cost_price => product.price
    }
    product.master.update_attributes!(variant_attrs)

    product.save

  end


end
