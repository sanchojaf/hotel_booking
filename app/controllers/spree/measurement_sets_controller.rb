module Spree
  class MeasurementSetsController < Spree::StoreController
    before_action :set_measurement_set, only: [ :show, :edit, :update, :destroy]
    before_action :validate_state, only: [ :edit, :update ]

    def update
      if @measurement_set.update_from_params(params)  
        flash[:notice] = Spree.t('measurement_sets.action.success', number: @measurement_set.id)

        unless @measurement_set.next
          flash[:error] = @measurement_set.errors.full_messages.join("\n")
          puts "params error ////////////////////// #{@measurement_set.state}"
          redirect_to measurement_set_edit_path(@measurement_set.state) and return
        end
        if @measurement_set.completed?
          session[:measurement_set_id] = nil
          flash.notice = Spree.t(:measurement_set_processed_successfully)
          redirect_to completion_route
        else
          redirect_to spree.edit_measurement_set_path(@measurement_set)
        end

      else
        render :edit
      end
    end

    def edit       
    end

    def show
      # redirect_to root_url
    end
 
    def new 
      @measurement_set = MeasurementSet.new
    end


    def create
      @measurement_set = MeasurementSet.new() #measurement_set_params
      bust = Measure.find_or_create_by_name( name: 'Bust', min: 3 , max: 50) 
      band = Measure.find_or_create_by_name( name: 'Band', min: 2 , max: 40) 
      item_bust = MeasureItem.create(measurement_set: @measurement_set, measure: bust, value: 0)  
      item_band = MeasureItem.create(measurement_set: @measurement_set, measure: band, value: 0)
      #@measurement_set.customer = Spree::User.new()   
      if @measurement_set.save
        redirect_to spree.edit_measurement_set_path(@measurement_set)       
      else
        render action: 'new'      
      end
    end

  private
    def set_measurement_set
      @measurement_set = MeasurementSet.find(params[:id])
    end

    def validate_state
      if params[:state].present?
         @measurement_set.state = params[:state]
         @measurement_set.save
         #params[:state] = nil
      end
    end
    def completion_route
      spree.measurement_set_path(@measurement_set)
    end

  end

end
