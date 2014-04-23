module Spree
  class HotelsController < Spree::StoreController

    def index      
      @q = {}
      @q[:latitude] = params['gmaps-output-latitude'] if params['gmaps-output-latitude'].present?
      @q[:longitud] = params['gmaps-output-longitud'] if params['gmaps-output-longitud'].present?
    end

  end
end
