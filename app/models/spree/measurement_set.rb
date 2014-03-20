module Spree
  class MeasurementSet < ActiveRecord::Base
    belongs_to :seller, :class_name => "User"
    belongs_to :customer, :class_name => "User"
    has_many :measure_items, dependent: :destroy

    accepts_nested_attributes_for :measure_items, :allow_destroy => true

    #==========================================
    # State Machine

    state_machine :initial => :active do
      
      after_transition :on => :address, :do => :perform_address
      after_transition :on => :bust, :do => :perform_bust
      after_transition :on => :band, :do => :perform_band 
      after_transition :on => :confirm, :do => :perform_confirmation
      after_transition :on => :complete, :do => :perform_complete

    
      event :address do 
        transition [ :active, :address ] => :address
      end
      event :bust do 
        transition [ :active,  :address ] => :bust
      end
      event :band do 
        transition [ :active, :address, :bust ] => :band
      end
      event :confirm do
        transition [ :active,  :address, :bust, :band ] => :confirm
      end
      event :complete do
        transition [ :active,  :address, :bust, :band, :confirm ] => :completed
      end

    end

    #==========================================
    # Callbacks

    after_initialize do |measurement_set|
     unless measurement_set.measure_items
       # band = Measure.find_or_create_by_name( name: 'Band', min: 2 , max: 40) 
       # bust = Measure.find_or_create_by_name( name: 'Bust', min: 3 , max: 50) 
       # item_band = MeasureItem.create(measurement_set: measurement_set, measure: band, value: 0)
       # item_bust = MeasureItem.create(measurement_set: measurement_set, measure: bust, value: 0)  
       # measurement_set.customer = Spree::User.new()   
     end
    end

    #==========================================
    # Methods

    def prev
      case state
      when 'active' then return ''
      when 'address' then return 'active'
      when 'bust' then return 'address'
      when 'band' then return 'bust'
      when 'confirm' then return 'band'
      when 'completed' then return 'confirm'
      end   
      return false
    end

    def next
      case state
      when 'active' then return self.address!
      when 'address' then return self.bust!
      when 'bust' then return self.band!
      when 'band' then return self.confirm!
      when 'confirm' then return self.complete! 
      end   
      return false
    end



    def update_from_params(params)     

      attributes = {}
      attributes = params[:measurement_set] if params[:measurement_set].present?
      
      if attributes[:measure_item].present?              
        measure = Spree::Measure.find_by_name(params[:state].capitalize)
        measure_items.each do |measure_item|
          if measure_item.measure.id == measure.id
            return false unless measure_item.update_attributes(:value => attributes[:measure_item][:value])   
          end
        end
      end

      if attributes[:user].present?
        if attributes[:user][:password].blank?          
          gp = generate_password
          attributes[:user][:password] = gp
          attributes[:user][:password_confirmation] = gp
        end
     
        if self.customer
          return false unless self.customer.update_attributes user_set_params(params) 
        else
          user = Spree.user_class.new user_set_params(params)
          return false unless user.save
          self.customer = user                   
        end 
      end

      if attributes[:ship_address].present?

        if self.customer.ship_address
          return false unless self.customer.ship_address.update_attributes address_set_params(params) 
        else
          address = Spree::Address.new address_set_params(params)
          return false unless address.save
          self.customer.ship_address = address      
          self.customer.save            
        end 
      end
      
      return self.save
    end

  private

    def perform_address 
      self.update_attribute(:action_at, Time.now)
    end

    def perform_bust 
      self.update_attribute(:action_at, Time.now)
    end

    def perform_band 
      self.update_attribute(:action_at, Time.now)
    end

    def perform_confirmation 
      self.update_attribute(:confirmed_at, Time.now)
    end

    def perform_complete 
      self.update_attribute(:completed_at, Time.now)
    end

    def user_set_params(params)
      params.require(:measurement_set).require(:user).permit( :email, :password, :password_confirmation)
    end

    def address_set_params(params)
      params.require(:measurement_set).require(:ship_address).permit( :firstname, :lastname, :address1, :address2, :city, :country_id, :state_id, :zipcode, :phone )
    end

    def generate_password
      "123456"
    end

  end
end
