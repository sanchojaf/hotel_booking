module Spree
  class HotelsController < Spree::StoreController
    before_action :set_hotel, only: [:show] 

    def index      
      @q = {}
      @q[:latitude] = params['gmaps-output-latitude'] if params['gmaps-output-latitude'].present?
      @q[:longitud] = params['gmaps-output-longitud'] if params['gmaps-output-longitud'].present?
    end

    def show
    end
    
    private
      def set_hotel
        #@hotel = Spree::Hotel.find(params[:id])
      end

  end
end
